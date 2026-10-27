# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 6/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-10-25 07:16:17] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-25 07:16:17] [INFO] Config FPW: (nao fornecido)
[2026-10-25 07:16:17] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-25 07:16:18] [INFO] Timeout: 300 segundos
[2026-10-25 07:16:18] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wlh0m2lt.prg
[2026-10-25 07:16:18] [INFO] Conteudo do wrapper:
[2026-10-25 07:16:18] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigopcgv', 'C:\4c\tasks\task695\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigopcgv', 'C:\4c\tasks\task695\logs\06_testForm.log'
QUIT

[2026-10-25 07:16:19] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wlh0m2lt.prg
[2026-10-25 07:16:19] [INFO] VFP output esperado em: C:\4c\tasks\task695\vfp_output.txt
[2026-10-25 07:16:19] [INFO] Executando Visual FoxPro 9...
[2026-10-25 07:16:20] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wlh0m2lt.prg
[2026-10-25 07:16:20] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wlh0m2lt.prg
[2026-10-25 07:16:21] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigopcgv
Inicio: 25/10/2026 07:16:21

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 25/10/2026 07:20:22
Duracao: 241 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-25 07:20:22] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-25 07:20:23] [INFO] VFP9 finalizado em 243.1071243 segundos
[2026-10-25 07:20:23] [INFO] Exit Code: 
[2026-10-25 07:20:24] [INFO] 
[2026-10-25 07:20:24] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-25 07:20:25] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wlh0m2lt.prg
[2026-10-25 07:20:25] [INFO] 
[2026-10-25 07:20:25] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-25 07:20:26] [INFO] * Auto-generated wrapper for parameters
[2026-10-25 07:20:26] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-25 07:20:27] [INFO] * Parameters: 'Formsigopcgv', 'C:\4c\tasks\task695\logs\06_testForm.log'
[2026-10-25 07:20:27] [INFO] 
[2026-10-25 07:20:27] [INFO] * Anti-dialog protections for unattended execution
[2026-10-25 07:20:28] [INFO] SET SAFETY OFF
[2026-10-25 07:20:28] [INFO] SET RESOURCE OFF
[2026-10-25 07:20:28] [INFO] SET TALK OFF
[2026-10-25 07:20:29] [INFO] SET NOTIFY OFF
[2026-10-25 07:20:29] [INFO] SYS(2335, 0)
[2026-10-25 07:20:29] [INFO] 
[2026-10-25 07:20:29] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigopcgv', 'C:\4c\tasks\task695\logs\06_testForm.log'
[2026-10-25 07:20:30] [INFO] QUIT
[2026-10-25 07:20:30] [INFO] 
[2026-10-25 07:20:30] [INFO] === Fim do Wrapper.prg ===
[2026-10-25 07:20:31] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgv.prg):
*==============================================================================
* Formsigopcgv.prg
* Form Pesquisa Global de Vendas (OPERACIONAL - consulta, nao CRUD)
* Migrado de SIGOPCGV.SCX
*
* Pilares:
*   UX   -> layout identico ao legado (PageFrame fld_principal: Consulta/Resultado)
*   BD   -> leitura via sigopcgvBO (SigCdCli + tabelas agregadas de saldo,
*           cheque, venda, estoque, pendencia, conserto, cartao, producao,
*           credito)
*   CODE -> arquitetura em camadas (FormBase / sigopcgvBO)
*
* Parametros de Init: par_oFormPai, par_cConta, par_cCpf, par_cTitulo
*   (equivalentes a loForm1, _Conta, _CPF, lcNomeFrm1 do Init legado)
*
* FASE 4/8 - Grades e botoes de acao. Entrega:
*
*   Pagina Consulta  : container Origem com os 5 criterios de pesquisa e o
*                      CommandGroup de navegacao (Cadastro / Movimento / Sair).
*   Pagina Resultado : PageFrame interno com as 10 abas do legado (na ordem de
*                      PageOrder - ver ConfigurarPageFrameResultado), as duas
*                      grades da aba Saldo (historico de conta corrente e
*                      saldo por moeda) carregadas de verdade pelo BO, o
*                      OptionGroup de navegacao entre as 10 abas, o filtro de
*                      periodo (cnt_periodo) e os CommandGroups Cadastro /
*                      Movimento / Voltar com a alternancia de visibilidade
*                      do legado (cmd_cadastro.Click / cmd_movimenta.Click /
*                      cmd_voltar.Click).
*
* Carga de dados: CarregarDados() -> sigopcgvBO.CarregarHistoricoSaldo(),
* que reproduz o trecho "Verificando Historicos / Verificando Saldo" do
* Processa() legado (SigMvCcr para dbHistorico; SigMvSlc + SigCdGcr +
* SigCdCli + SigClLcr, ou a soma do proprio dbHistorico quando ha periodo,
* para dbSaldo). Repintura num funil unico (AtualizarGradesSaldo - GO TOP +
* Refresh depois de trocar o ActivePage, regras #21 e #46).
*
* FASE 5/8 - Campos de dados das abas (parte 1). Entrega, por
* ConfigurarPaginaDados, o conteudo das abas que o Processa()/PCartao()/
* PEstoque() legado alimenta:
*
*   aba 2 Pendencias : grade TmpPar (6 colunas), grade de formas de pagamento
*                      crTmpTipos com CheckBox marcavel (os 4 handlers de
*                      toggle + FiltrarTipos), filtro de grupo, total das
*                      pendencias visiveis e os botoes Documento (abre o
*                      FormSigMvExp) e Listagem (SigReIpd).
*   aba 3 Cheques    : quatro grades (dbAberto / DbFollow / DbTitulo /
*                      dbDevolvido), filtro de grupo, os nove totais do pe da
*                      pagina (limite, a vencer, vencidos, devolvidos, saldo
*                      c/c, negociados, estoque, disponivel e total em aberto)
*                      e o follow-up / observacao da linha corrente.
*   aba 4 Cartao     : grade TmpCart (cartoes de credito em aberto).
*   aba 6 Estoque    : grade dbEstoque (produtos em poder do cliente) com
*                      filtro de grupo.
*
* Carga pelo BO: CarregarParametros (SigCdPam/SigCdGcr), CarregarPendencias
* (SigMvCcr + SigMvCab/SigMvPar/SigCdOpe/SigOpFp), CarregarCheques (SigChe +
* SigCqChm + SigCdOpt + SigCheh + SigMvCcr/SigOpOpe + SigClLcr/SigMvSlc/
* SigMvEst para os totais), CarregarCartoes (SigCdCrd) e CarregarEstoque
* (SigMvEst + SigCdEmp). Repintura num funil por aba, despachados por
* AtualizarAbaResultadoAtiva depois da troca de ActivePage (regras #21 e #46).
*
* FASE 6/8 - Campos de dados das abas (parte 2). Entrega, pelas mesmas
* ConfigurarPaginaDados/CarregarAbasResultado/AtualizarAbaResultadoAtiva, o
* conteudo das duas abas AUTOSSUFICIENTES que faltavam (cada uma com sua
* propria consulta ao banco, sem depender de outro bloco de cursores):
*
*   aba 9  H.Cheques : transcricao de mativahcheque()/GradeCheque.
*                      AfterRowColChange - grade geral de cheques da conta
*                      (dbCheqHist, Vencs exibido conforme a ultima
*                      movimentacao e Tipo colorido quando ha historico em
*                      SigCheh), e as duas grades de detalhe do cheque
*                      selecionado (dbCheqMovim de SigCqChm, dbCheqProrrog
*                      de SigChea) + follow-up (SigCheh.Hists), recarregadas
*                      a cada troca de linha (GradeHistChequeAfterRowColChange).
*   aba 10 Credito    : transcricao de mativacredito() - grade de lancamentos
*                      de SigFiCp pelo CPF/CGC pesquisado (normalizado para a
*                      mascara que a coluna Ccpfs grava), com os paineis de
*                      banco/valor/documento ligados por ControlSource direto
*                      (a troca de linha atualiza os campos sem codigo extra,
*                      igual ao legado) e o rotulo de situacao do cliente
*                      (SigCdCli.Situas + SigCdCst.Descrs).
*
* FASE 7/8 - Eventos principais dos botoes. Este form eh OPERACIONAL de
* CONSULTA: o legado herda de `form` (nao de `frmcadastro`), entao os
* "eventos principais" reais sao os botoes das fases 3/4 (Cadastro /
* Movimento / Voltar / MudaCli / MudaMov) mais, nesta fase:
*
*   BtnAlterarClick / BtnVisualizarClick : as duas pontas reais do
*       IIF(fChecaAcesso('SIGOPCGV','ALTERAR'), 'ALTERAR', 'CONSULTAR') do
*       cmd_cadastro.Click legado, num funil unico (AbrirVisaoCadastral):
*       mesma validacao de conta, mesma visao cadastral - muda so o modo
*       guardado no BO, que eh o que decide se a tela grava.
*   BtnIncluirClick / BtnExcluirClick : o legado NAO inclui nem exclui conta
*       nesta tela (grp_operacao sem botao para isso, pcEscolha so com
*       'CONSULTAR'/'ALTERAR'). Os handlers reproduzem a ausencia e apontam o
*       Cadastro de Clientes (SIGCDCLI -> FormCliente), em vez de inventar a
*       operacao (PILAR 1) - ver a nota do bloco "EVENTOS PRINCIPAIS".
*
*   cmd_4c_Imprime + cnt_4c_SelecionaImpCad / cnt_4c_SelecionaImpressao :
*       transcricao de Imprime.Click - abre o painel certo (SelecionaImpCad
*       na visao CADASTRO, SelecionaImpressao na visao MOVIMENTO - mesma
*       regra de Cmd_MudaCli.Visible do legado) centralizado e com o resto
*       da tela desabilitado (DesabilitarControlesImpressao /
*       RestaurarControlesImpressao - funil unico para os 6 botoes
*       Saida/Visualizar/Imprimir dos dois paineis).
*   ImpressaoCad()/Impressao() : os dois metodos de impressao do legado,
*       com os FRX SIGOPCGV.frx (Impressao) e SigReGcd.frx (ImpressaoCad)
*       copiados para app/reports. Impressao() monta o cursor agregado
*       TmpRelGv com uma secao por checkbox marcado; quatro delas (Chk_
*       MovPend/dbConserto, Chk_ResVenda/dbTotVendas, Chk_ProdAdq/dbProduto,
*       Chk_Producao/dbProduc) dependem das abas Vendas/Operacoes Pend./
*       Producao (PProduto() legado, que falta fazer - ver nota abaixo) e
*       ficam guardadas por USED(): entram em acao sozinhas quando essa fase
*       for feita, sem precisar tocar neste metodo de novo.
*   Chk_Impressora/Chk_Imp40 (impressao termica de 40 colunas): o legado
*       desvia para ImpTermica/ImpTermicad, que gravam bytes crus numa
*       impressora via Set Printer To Name() e dependem do array gaprinters
*       (populado no login do framework legado) e do FormSigOpIpb de
*       selecao de impressora - infraestrutura de hardware nunca portada.
*       Os dois metodos avisam com MsgAviso em vez de fingir sucesso.
*
* As tres abas restantes (5 Vendas, 7 Operacoes Pend., 8 Producao)
* continuam de fora: as tres sao alimentadas pelo MESMO PProduto() legado
* (~700 linhas, com o padrao de staging SigTempC/CidQuerys do framework
* Fortyus - equivalente ja usado no projeto em SigPrGl2BO/SigTempD) e por
* isso formam uma unidade que precisa de uma fase propria. O wrapper
* clsconta (cntConta) da visao cadastral tambem continua de fora.
*
* FASE 8/8 - Eventos auxiliares e consolidacao final. Este form eh
* OPERACIONAL de CONSULTA (ver nota da FASE 7/8) e NAO tem Page1=Lista/
* Page2=Dados, mas cada nome canonico de evento auxiliar TEM contraparte no
* legado - e eh ela que foi entregue aqui, com os funis das fases anteriores
* passando a entrar por esses metodos (regra #40):
*
*   FormParaBO()      -> os cinco criterios do container Origem (Conta / Nome
*                        / CPF / Conjuge / Telefone), o optFiltro e o periodo
*                        do cnt_periodo; CarregarDados() entra por ele.
*   BOParaForm()      -> o caminho inverso (preenchimento cruzado que o legado
*                        faz no fim de cada Valid de pesquisa);
*                        AtualizarCamposOrigem() entra por ele.
*   HabilitarCampos() -> a cascata de When dos criterios (Get_cpf.When,
*                        Get_dconta.When, GetConj.When, getTelefone.When,
*                        optFiltro.When), em ReadOnly para nao disputar o foco.
*   LimparCampos()    -> o Space(N) dos cinco campos do cmd_voltar.Click mais o
*                        LimparDados() do BO (implementado nesta fase: zera
*                        criterios, flags de controle e totais derivados).
*   CarregarLista()   -> funil de (re)carga da consulta (CarregarDados +
*                        CarregarAbasResultado, a sequencia do Processa()).
*   AjustarBotoesPorModo() -> os gates de acesso do Init legado (fChecaAcesso
*                        CADASTRO/MOVIMENTA, com o reposicionamento do
*                        grp_operacao) e o do par Cmd_MudaCli/Cmd_MudaMov mais
*                        IMPRIMIR no Imprime; AlternarPagina() e
*                        AjustarVisibilidadeResultado() entram por ele.
*   BtnBuscarClick()  -> dispara a consulta (cmd_movimenta.Click na Consulta;
*                        refaz a consulta corrente na pagina Resultado).
*   BtnSalvarClick()  -> o bloco "Deseja salvar as alteracoes?" que ABRE o
*                        cmd_voltar.Click legado (mValidaObj + mGravaDados do
*                        cntConta); BtnVoltarClick() entra por ele e aborta a
*                        saida quando a validacao do cadastro recusa.
*   BtnCancelarClick()/BtnEncerrarClick() -> cmd_cancela.Click ([ESC] Sair) e o
*                        ramo Automatico do cmd_voltar.Click (Release +
*                        poForm1.Enabled = .t.); BtnCancelarConsultaClick()
*                        ficou como alias do nome canonico.
*
* Tambem nesta fase: integracao com o menu (popMovimentos, bar "Pesquisa
* Global de Vendas" -> AbrirFormsigopcgv() em menu.prg, padrao canonico
* VARTYPE+Show() fora do TRY - CLAUDE.md regra #29) e auditoria final de
* consistencia (compilacao limpa de sigopcgvBO.prg/Formsigopcgv.prg/menu.prg
* e cruzamento de THIS.<metodo>() e THIS.this_oBusinessObject.<metodo>() do
* form contra as PROCEDURE/FUNCTION do form e do BO). config.prg carrega os
* dois arquivos automaticamente via ADIR (*BO.prg / operacionais\Form*.prg),
* sem necessidade de SET PROCEDURE manual.
*==============================================================================

DEFINE CLASS Formsigopcgv AS FormBase

    DataSession  = 2
    Height       = 600
    Width        = 1000
    AutoCenter   = .T.
    Caption      = "Pesquisa Global de Vendas"
    ShowWindow   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    WindowType   = 1
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2
    FontName     = "Verdana"
    FontSize     = 8
    ForeColor    = RGB(36, 84, 155)

    this_oBusinessObject = .NULL.
    this_cModoAtual       = ""
    this_lEmLookupOrigem  = .F.   && guarda de reentrancia (regra #37/#47) dos lookups da Origem

    *-- Visao corrente da pagina Resultado: "MOVIMENTO" mostra o PageFrame das
    *-- 10 abas + OptionGroup + filtro de periodo (cmd_movimenta.Click do
    *-- legado); "CADASTRO" mostra a visao cadastral da conta e esconde os tres
    *-- (cmd_cadastro.Click do legado).
    this_cModoResultado   = ""

    *-- Parametros recebidos em Init (equivalentes as PUBLIC vars do form legado)
    this_oFormPai      = .NULL.   && loForm1 - form chamador
    this_cContaInicial = ""       && _Conta  - conta pre-selecionada ao abrir
    this_cCpfInicial   = ""       && _CPF    - cpf/cgc pre-selecionado ao abrir

    *==========================================================================
    * Init - Recebe os parametros do legado e delega para FormBase.Init
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_oFormPai, par_cConta, par_cCpf, par_cTitulo

        THIS.this_oFormPai      = IIF(TYPE("par_oFormPai") = "O", par_oFormPai, .NULL.)
        THIS.this_cContaInicial = IIF(TYPE("par_cConta")   = "C", par_cConta,   "")
        THIS.this_cCpfInicial   = IIF(TYPE("par_cCpf")     = "C", par_cCpf,     "")

        IF TYPE("par_cTitulo") = "C" AND !EMPTY(par_cTitulo)
            THIS.Caption = par_cTitulo
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * Destroy - Libera Business Object e eventuais cursores abertos
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF !ISNULL(THIS.this_oBusinessObject)
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            *-- nao exibir erro no Destroy
        ENDTRY
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            THIS.this_oBusinessObject = CREATEOBJECT("sigopcgvBO")
            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Falha ao criar sigopcgvBO.", "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                            "o Com o Servidor de Banco de Dados...", ;
                            "Conex" + CHR(227) + "o")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Repassa para o Business Object os parametros recebidos no Init
                THIS.this_oBusinessObject.this_cConta = THIS.this_cContaInicial
                THIS.this_oBusinessObject.this_cCpf    = THIS.this_cCpfInicial

                *-- Cursores locais da aba Saldo (dbSaldo/dbHistorico) tem de
                *-- existir ANTES dos grids que os referenciam no ControlSource
                THIS.this_oBusinessObject.CriarCursoresLocais()

                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Visible = .T.

                *-- Entra pelo funil de troca de pagina (regra #40): eh ele que
                *-- repoe o modo e a altura do form (o Init legado abre a tela
                *-- com Height = 300, so a pagina Consulta a vista)
                THIS.AlternarPagina(1)

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria pgf_4c_Paginas (fld_principal do legado)
    *   Page1 = Consulta  (criterios de pesquisa)
    *   Page2 = Resultado (abas Saldo/Cheque/Vendas/Estoque/Pendencias/
    *                      Conserto/Cartao/Producao/H.Cheques/Credito)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top       = -33
            .Left      = -1
            .Width     = 1003
            .Height    = 635
            .PageCount = 2
            .TabStop   = .F.
            .Themes    = .F.
            .Visible   = .F.

            .Page1.Caption = "Consulta"
            .Page2.Caption = "Resultado"

            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF
        ENDWITH

        THIS.ConfigurarPaginaConsulta()
        THIS.ConfigurarPaginaResultado()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaConsulta - Page1: cabecalho (equivalente ao cntSombra
    * do legado), criterios de pesquisa (container Origem - ConfigurarOrigem)
    * e o CommandGroup de navegacao (grp_operacao - ConfigurarGrupoOperacao).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaConsulta()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        loc_oPg.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPg.cnt_4c_Cabecalho
            .Top         = 5
            .Left        = -1
            *-- Page nao expoe Width/Height em runtime (regra #9.2): a largura
            *-- da faixa vem do FORM, nao da Page
            .Width       = THIS.Width + 2
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .WordWrap  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .WordWrap  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH
        ENDWITH

        THIS.ConfigurarOrigem()
        THIS.ConfigurarGrupoOperacao()
    ENDPROC

    *==========================================================================
    * ConfigurarOrigem - Container "Origem" (criterios de pesquisa da conta):
    * Conta (codigo exato), Nome, CPF/CGC, Conjuge, Telefone + filtro
    * Iniciais/Qualquer Parte. Espelha SIGOPCGV.fld_principal.pag_consulta.Origem
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarOrigem()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        loc_oPg.AddObject("cnt_4c_Origem", "Container")
        WITH loc_oPg.cnt_4c_Origem
            .Top           = 89
            .Left          = 12
            .Width         = 702
            .Height        = 235
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        WITH loc_oPg.cnt_4c_Origem
            *-- Labels (classe say do legado - Alignment/Width so quando o dump declara)
            .AddObject("lbl_4c_Conta", "Label")
            WITH .lbl_4c_Conta
                .Top       = 5
                .Left      = 5
                .Width     = 115
                .Height    = 15
                .Alignment = 1
                .FontBold  = .T.
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Conta para Pesquisa"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LabelConta", "Label")
            WITH .lbl_4c_LabelConta
                .Top       = 30
                .Left      = 49
                .Width     = 60
                .Height    = 15
                .Alignment = 0
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Conta"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LabelCpf", "Label")
            WITH .lbl_4c_LabelCpf
                .Top       = 30
                .Left      = 135
                .Width     = 90
                .Height    = 15
                .Alignment = 0
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "CPF / CGC"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LabelDConta", "Label")
            WITH .lbl_4c_LabelDConta
                .Top       = 70
                .Left      = 49
                .Width     = 60
                .Height    = 15
                .Alignment = 0
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Nome"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LabelConjuge", "Label")
            WITH .lbl_4c_LabelConjuge
                .Top       = 70
                .Left      = 330
                .Width     = 130
                .Height    = 15
                .Alignment = 0
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Nome do C" + CHR(244) + "njuge"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LabelTelefone", "Label")
            WITH .lbl_4c_LabelTelefone
                .Top       = 109
                .Left      = 49
                .Width     = 80
                .Height    = 15
                .Alignment = 0
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Telefone"
                .Visible   = .T.
            ENDWITH

            *-- Campo Conta: codigo exato (Get_conta)
            .AddObject("txt_4c_Conta", "TextBox")
            WITH .txt_4c_Conta
                .Top               = 44
                .Left              = 49
                .Width             = 80
                .Height            = 21
                .Value             = ""
                .InputMask         = "XXXXXXXXXX"
                .MaxLength         = 10
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .BorderColor       = RGB(100, 100, 100)
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible           = .T.
            ENDWITH

            *-- Campo CPF/CGC: codigo exato validado (Get_cpf)
            .AddObject("txt_4c_Cpf", "TextBox")
            WITH .txt_4c_Cpf
                .Top               = 44
                .Left              = 134
                .Width             = 146
                .Height            = 21
                .Value             = ""
                .MaxLength         = 20
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .BorderColor       = RGB(100, 100, 100)
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible           = .T.
            ENDWITH

            *-- Filtro de pesquisa por Nome: Iniciais (prefixo) / Qualquer Parte (contem)
            .AddObject("obj_4c_OptFiltro", "OptionGroup")
            WITH .obj_4c_OptFiltro
                .Top         = 63
                .Left        = 82
                .Width       = 175
                .Height      = 19
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                WITH .Buttons(1)
                    .Caption   = "\<Iniciais"
                    .Top       = 5
                    .Left      = 5
                    .Width     = 50
                    .Height    = 15
                    .Style     = 0
                    .BackStyle = 0
                    .FontSize  = 8
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "\<Qualquer Parte"
                    .Top       = 5
                    .Left      = 62
                    .Width     = 91
                    .Height    = 15
                    .Style     = 0
                    .BackStyle = 0
                    .FontSize  = 8
                ENDWITH
                .Visible = .T.
            ENDWITH

            *-- Campo Nome: pesquisa por LIKE (Get_dconta)
            .AddObject("txt_4c_DConta", "TextBox")
            WITH .txt_4c_DConta
                .Top               = 84
                .Left              = 49
                .Width             = 278
                .Height            = 21
                .Value             = ""
                .MaxLength         = 40
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .BorderColor       = RGB(100, 100, 100)
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible           = .T.
            ENDWITH

            *-- Campo Conjuge: pesquisa por LIKE (GetConj)
            .AddObject("txt_4c_Conjuge", "TextBox")
            WITH .txt_4c_Conjuge
                .Top               = 84
                .Left              = 330
                .Width             = 338
                .Height            = 21
                .Value             = ""
                .MaxLength         = 40
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .BorderColor       = RGB(100, 100, 100)
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible           = .T.
            ENDWITH

            *-- Campo Telefone: pesquisa por LIKE (getTelefone)
            .AddObject("txt_4c_Telefone", "TextBox")
            WITH .txt_4c_Telefone
                .Top               = 123
                .Left              = 49
                .Width             = 115
                .Height            = 21
                .Value             = ""
                .MaxLength         = 40
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .BorderColor       = RGB(100, 100, 100)
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible           = .T.
            ENDWITH
        ENDWITH

        *-- Desabilita o filtro Iniciais/Qualquer Parte quando o form foi aberto
        *-- apenas para pesquisa por CPF (this_lSomenteCPF - equivalente a plCPF)
        loc_oPg.cnt_4c_Origem.obj_4c_OptFiltro.Enabled = !THIS.this_oBusinessObject.this_lSomenteCPF

        *-- Lookup ao SAIR do campo (LostFocus), nunca KeyPress (regra #47)
        BINDEVENT(loc_oPg.cnt_4c_Origem.txt_4c_Conta,    "LostFocus", THIS, "TxtContaLostFocus")
        BINDEVENT(loc_oPg.cnt_4c_Origem.txt_4c_DConta,   "LostFocus", THIS, "TxtDContaLostFocus")
        BINDEVENT(loc_oPg.cnt_4c_Origem.txt_4c_Cpf,      "LostFocus", THIS, "TxtCpfLostFocus")
        BINDEVENT(loc_oPg.cnt_4c_Origem.txt_4c_Conjuge,  "LostFocus", THIS, "TxtConjugeLostFocus")
        BINDEVENT(loc_oPg.cnt_4c_Origem.txt_4c_Telefone, "LostFocus", THIS, "TxtTelefoneLostFocus")
    ENDPROC

    *==========================================================================
    * ConfigurarGrupoOperacao - CommandGroup com os 3 botoes de navegacao da
    * pagina Consulta (grp_operacao do legado): Cadastro, Movimento e
    * [ESC] Sair.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrupoOperacao()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        loc_oPg.AddObject("cmg_4c_GrpOperacao", "CommandGroup")
        WITH loc_oPg.cmg_4c_GrpOperacao
            .Top         = 3
            .Left        = 769
            .Width       = 235
            .Height      = 85
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 1
            .BorderColor = RGB(136, 189, 188)
            .Themes      = .F.

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Caption    = "\<Cadastro"
                .ToolTipText = "Dados Cadastrais"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                IF FILE(gc_4c_CaminhoIcones + "geral_contatos_60.jpg")
                    .Picture = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
                ENDIF
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 80
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Caption    = "\<Movimento"
                .ToolTipText = "Movimenta" + CHR(231) + CHR(227) + "o"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                IF FILE(gc_4c_CaminhoIcones + "geral_pastas_60.jpg")
                    .Picture = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
                ENDIF
            ENDWITH

            WITH .Buttons(3)
                .Top        = 5
                .Left       = 155
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Cancel     = .T.
                .Caption    = "[ESC] Sair"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
                    .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                ENDIF
            ENDWITH

            .Visible = .T.
        ENDWITH

        BINDEVENT(loc_oPg.cmg_4c_GrpOperacao.Buttons(1), "Click", THIS, "BtnCadastroClick")
        BINDEVENT(loc_oPg.cmg_4c_GrpOperacao.Buttons(2), "Click", THIS, "BtnMovimentoClick")
        BINDEVENT(loc_oPg.cmg_4c_GrpOperacao.Buttons(3), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *==========================================================================
    * TxtContaLostFocus - Pesquisa por codigo exato da conta (Get_conta.Valid)
    *==========================================================================
    PROCEDURE TxtContaLostFocus()
        LOCAL loc_oPg, loc_cValor, loc_oErro

        IF THIS.this_lEmLookupOrigem
            RETURN
        ENDIF
        THIS.this_lEmLookupOrigem = .T.

        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Conta.Value)

            IF !EMPTY(loc_cValor)
                IF THIS.this_oBusinessObject.BuscarPorConta(loc_cValor)
                    THIS.AtualizarCamposOrigem()
                ELSE
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Pesquisa de Conta")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao pesquisar conta")
        ENDTRY

        THIS.this_lEmLookupOrigem = .F.
    ENDPROC

    *==========================================================================
    * TxtDContaLostFocus - Pesquisa por nome (Get_dconta.Valid). Com optFiltro
    * = 1 (Iniciais) usa prefixo "valor%"; com optFiltro = 2 (Qualquer Parte)
    * usa "%valor%". 1 resultado -> carrega direto; 2+ -> abre picker.
    *==========================================================================
    PROCEDURE TxtDContaLostFocus()
        LOCAL loc_oPg, loc_cValor, loc_cModo, loc_oErro

        IF THIS.this_lEmLookupOrigem
            RETURN
        ENDIF
        THIS.this_lEmLookupOrigem = .T.

        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_DConta.Value)

            IF !EMPTY(loc_cValor)
                loc_cModo = IIF(loc_oPg.obj_4c_OptFiltro.Value = 1, "INICIAIS", "QUALQUER")

                IF THIS.this_oBusinessObject.BuscarPorNome(loc_cValor, "cursor_4c_BuscaNome", loc_cModo)
                    THIS.SelecionarDaListaOrigem("cursor_4c_BuscaNome", "Nome do Cliente")
                ELSE
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Pesquisa por Nome")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao pesquisar por nome")
        ENDTRY

        THIS.this_lEmLookupOrigem = .F.
    ENDPROC

    *==========================================================================
    * TxtCpfLostFocus - Pesquisa por CPF/CGC validado (Get_cpf.Valid)
    *==========================================================================
    PROCEDURE TxtCpfLostFocus()
        LOCAL loc_oPg, loc_cValor, loc_oErro

        IF THIS.this_lEmLookupOrigem
            RETURN
        ENDIF
        THIS.this_lEmLookupOrigem = .T.

        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Cpf.Value)

            IF !EMPTY(loc_cValor)
                IF THIS.this_oBusinessObject.BuscarPorCpf(loc_cValor, "cursor_4c_BuscaCpf")
                    THIS.SelecionarDaListaOrigem("cursor_4c_BuscaCpf", "Cliente")
                ELSE
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Pesquisa por CPF / CGC")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao pesquisar por CPF/CGC")
        ENDTRY

        THIS.this_lEmLookupOrigem = .F.
    ENDPROC

    *==========================================================================
    * TxtConjugeLostFocus - Pesquisa pelo nome do conjuge (GetConj.Valid)
    *==========================================================================
    PROCEDURE TxtConjugeLostFocus()
        LOCAL loc_oPg, loc_cValor, loc_oErro

        IF THIS.this_lEmLookupOrigem
            RETURN
        ENDIF
        THIS.this_lEmLookupOrigem = .T.

        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Conjuge.Value)

            IF !EMPTY(loc_cValor)
                IF THIS.this_oBusinessObject.BuscarPorConjuge(loc_cValor, "cursor_4c_BuscaConjuge")
                    THIS.SelecionarDaListaOrigem("cursor_4c_BuscaConjuge", "Nome do C" + CHR(244) + "njuge")
                ELSE
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Pesquisa por C" + CHR(244) + "njuge")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao pesquisar por c" + CHR(244) + "njuge")
        ENDTRY

        THIS.this_lEmLookupOrigem = .F.
    ENDPROC

    *==========================================================================
    * TxtTelefoneLostFocus - Pesquisa pelo telefone (getTelefone.Valid)
    *==========================================================================
    PROCEDURE TxtTelefoneLostFocus()
        LOCAL loc_oPg, loc_cValor, loc_oErro

        IF THIS.this_lEmLookupOrigem
            RETURN
        ENDIF
        THIS.this_lEmLookupOrigem = .T.

        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Telefone.Value)

            IF !EMPTY(loc_cValor)
                IF THIS.this_oBusinessObject.BuscarPorTelefone(loc_cValor, "cursor_4c_BuscaTelefone")
                    THIS.SelecionarDaListaOrigem("cursor_4c_BuscaTelefone", "Telefone")
                ELSE
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Pesquisa por Telefone")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao pesquisar por telefone")
        ENDTRY

        THIS.this_lEmLookupOrigem = .F.
    ENDPROC

    *==========================================================================
    * SelecionarDaListaOrigem - Resolve um cursor com 1+ candidatos (Nome/CPF/
    * Conjuge/Telefone): com 1 resultado carrega direto; com mais de 1, abre o
    * picker (FormBuscaAuxiliar.DefinirCursor/Mostrar - Pattern A) para o
    * usuario escolher, e entao recarrega a conta completa por codigo exato.
    *==========================================================================
    PROTECTED PROCEDURE SelecionarDaListaOrigem(par_cCursor, par_cTitulo)
        LOCAL loc_oBusca, loc_cConta, loc_oErro, loc_lTemCursor

        *-- Sem RETURN dentro do TRY (regra #1): o guard vira flag
        TRY
            loc_lTemCursor = USED(par_cCursor)

            IF loc_lTemCursor
                IF RECCOUNT(par_cCursor) = 1
                    SELECT (par_cCursor)
                    GO TOP
                    loc_cConta = ALLTRIM(Iclis)
                    IF THIS.this_oBusinessObject.BuscarPorConta(loc_cConta)
                        THIS.AtualizarCamposOrigem()
                    ENDIF
                ELSE
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.DefinirCursor(par_cCursor, "Iclis", "Rclis", par_cTitulo)
                        IF loc_oBusca.Mostrar()
                            loc_cConta = loc_oBusca.cCodigoSelecionado
                            IF !EMPTY(loc_cConta) AND THIS.this_oBusinessObject.BuscarPorConta(loc_cConta)
                                THIS.AtualizarCamposOrigem()
                            ENDIF
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ENDIF

                IF USED(par_cCursor)
                    USE IN (par_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao selecionar registro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarCamposOrigem - Reflete no formulario os dados do cliente ja
    * localizados no Business Object (equivalente ao preenchimento cruzado
    * dos campos Conta/Nome/CPF/Conjuge/Telefone do legado apos qualquer
    * pesquisa bem-sucedida).
    *==========================================================================
    PROTECTED PROCEDURE AtualizarCamposOrigem()
        *-- Funil unico do caminho BO -> tela (ver BOParaForm): alem dos cinco
        *-- campos, ele devolve a opcao de filtro e o periodo e reaplica a
        *-- cascata de When dos criterios
        THIS.BOParaForm()
    ENDPROC

    *==========================================================================
    * ValidarContaSelecionada - Guard comum aos dois botoes de entrada na
    * pagina Resultado. No legado o Do Case que abre cmd_cadastro.Click e
    * cmd_movimenta.Click eh identico nos dois: conta vazia ou inexistente em
    * SigCdCli recusa a acao com "Conta de Estoque Invalida !!!" e devolve o
    * foco ao campo Conta. Fica num metodo unico porque o legado o tem UMA vez
    * (no Click do CommandGroup) e vale para todas as opcoes.
    *==========================================================================
    FUNCTION ValidarContaSelecionada()
        LOCAL loc_oCnt, loc_cConta, loc_lOk
        loc_lOk  = .F.
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem

        *-- Fonte UNICA eh o campo da tela, nunca a property guardada antes
        loc_cConta = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)

        IF EMPTY(loc_cConta)
            MsgAviso("Conta de Estoque Inv" + CHR(225) + "lida !!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oCnt.txt_4c_Conta.SetFocus()
        ELSE
            *-- "Ja resolvida" exige a DESCRICAO carregada, nao apenas o codigo
            *-- igual: o FormParaBO copia o codigo da tela para o BO, e sem esta
            *-- segunda condicao um codigo inexistente digitado depois de uma
            *-- consulta valida passaria sem conferencia no banco
            IF ALLTRIM(THIS.this_oBusinessObject.this_cConta) == loc_cConta AND ;
                    !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cDescConta))
                *-- Conta ja resolvida por uma das pesquisas da Origem
                loc_lOk = .T.
            ELSE
                IF THIS.this_oBusinessObject.BuscarPorConta(loc_cConta)
                    THIS.AtualizarCamposOrigem()
                    loc_lOk = .T.
                ELSE
                    MsgAviso("Conta de Estoque Inv" + CHR(225) + "lida !!!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oCnt.txt_4c_Conta.SetFocus()
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * BtnCadastroClick - cmd_cadastro.Click do grp_operacao da pagina Consulta:
    * valida a conta, carrega os dados e abre a pagina Resultado na visao
    * CADASTRO (sem o PageFrame das abas, sem OptionGroup e sem periodo).
    *==========================================================================
    PROCEDURE BtnCadastroClick()
        IF !THIS.ValidarContaSelecionada()
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_cEscolha = "ALTERAR"
        THIS.CarregarDados()
        THIS.AjustarVisibilidadeResultado("CADASTRO")
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnMovimentoClick - cmd_movimenta.Click do grp_operacao da pagina
    * Consulta: valida a conta, carrega os dados e abre a pagina Resultado na
    * visao MOVIMENTO (PageFrame das 10 abas + OptionGroup + periodo).
    *==========================================================================
    PROCEDURE BtnMovimentoClick()
        IF !THIS.ValidarContaSelecionada()
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_cEscolha = "CONSULTAR"
        THIS.CarregarDados()
        THIS.AjustarVisibilidadeResultado("MOVIMENTO")
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnCancelarConsultaClick - [ESC] Sair (ThisForm.Release do legado)
    *==========================================================================
    PROCEDURE BtnCancelarConsultaClick()
        *-- Mantido como alias do nome canonico: o Buttons(3) do grp_operacao
        *-- esta ligado a BtnCancelarClick, que eh quem tem o comportamento
        *-- (encerrar na Consulta, abandonar a consulta na pagina Resultado)
        THIS.BtnCancelarClick()
    ENDPROC

    *==========================================================================
    * EVENTOS PRINCIPAIS DOS BOTOES (FASE 7/8)
    *
    * O legado SIGOPCGV herda de `form` (nao de `frmcadastro`), por isso NAO
    * tem a barra CRUD de cinco botoes: o grp_operacao da pagina Consulta tem
    * tres (cmd_cadastro / cmd_movimenta / cmd_cancela) e o da pagina
    * Resultado tem um (cmd_voltar), mais Cmd_MudaCli / Cmd_MudaMov / Imprime.
    * A unica variavel de modo que ele usa eh pcEscolha, e ela so recebe dois
    * valores:
    *
    *   'ALTERAR'   - Cmd_MudaCli.Click e cmd_cadastro.Click quando
    *                 fChecaAcesso('SIGOPCGV','ALTERAR') devolve .T.; eh o
    *                 que libera a gravacao do cadastro no cmd_voltar.Click
    *                 ("Deseja salvar as alteracoes?" -> mValidaObj +
    *                 mGravaDados do cntConta).
    *   'CONSULTAR' - cmd_movimenta.Click, Cmd_MudaMov.Click e o MESMO
    *                 cmd_cadastro.Click quando o usuario nao tem o acesso.
    *
    * Dai o mapeamento abaixo: Alterar e Visualizar sao as duas pontas reais
    * desse IIF do legado - mesma entrada, mesma validacao de conta, mesma
    * visao cadastral; o que muda eh o modo, que decide se a tela grava.
    * Incluir e Excluir de conta NAO existem nesta tela: criar botao para eles
    * seria inventar funcionalidade que o legado nao tem (PILAR 1), entao os
    * dois handlers reproduzem a ausencia - dizem onde a operacao mora de
    * verdade (SIGCDCLI -> FormCliente) e devolvem o foco ao campo Conta.
    *==========================================================================

    *==========================================================================
    * PodeAlterarCadastro - fChecaAcesso('SIGOPCGV','ALTERAR') do legado.
    * PUBLIC: consultado pelos handlers e pelo harness de teste (regra #3).
    *==========================================================================
    FUNCTION PodeAlterarCadastro()
        LOCAL loc_lAcesso, loc_oErro
        loc_lAcesso = .T.

        TRY
            loc_lAcesso = fChecaAcesso("SIGOPCGV", "ALTERAR")
        CATCH TO loc_oErro
            *-- Regra #9: CATCH nunca silencioso. Sem a tabela de acesso
            *-- disponivel o legado tratava o usuario como SEM permissao,
            *-- isto eh, cai para 'CONSULTAR' (somente leitura).
            MsgAviso(loc_oErro.Message, ;
                "Verifica" + CHR(231) + CHR(227) + "o de acesso")
            loc_lAcesso = .F.
        ENDTRY

        RETURN loc_lAcesso
    ENDFUNC

    *==========================================================================
    * AbrirVisaoCadastral - funil UNICO do cmd_cadastro.Click legado, usado
    * pelos dois botoes que entram na visao cadastral (Alterar e Visualizar):
    * valida a conta ("Conta de Estoque Invalida !!!" do Do Case legado),
    * guarda o modo no BO, carrega a consulta e abre a pagina Resultado na
    * visao CADASTRO - exatamente a sequencia do legado.
    * PUBLIC: chamado pelos handlers e pelo harness de teste (regra #3).
    *==========================================================================
    FUNCTION AbrirVisaoCadastral(par_cEscolha)
        LOCAL loc_lOk, loc_cEscolha
        loc_lOk      = .F.
        loc_cEscolha = IIF(VARTYPE(par_cEscolha) = "C" AND !EMPTY(par_cEscolha), ;
            UPPER(ALLTRIM(par_cEscolha)), "CONSULTAR")

        IF THIS.ValidarContaSelecionada()
            THIS.this_oBusinessObject.this_cEscolha = loc_cEscolha
            THIS.CarregarDados()
            THIS.AjustarVisibilidadeResultado("CADASTRO")
            THIS.AlternarPagina(2)
            loc_lOk = .T.
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * FocarCampoConta - devolve o foco ao campo Conta da pagina Consulta
    * (This.Parent.Parent.Origem.Get_Conta.SetFocus do legado), so quando essa
    * pagina esta a vista. SetFocus falha com a pagina ainda nao pintada ou em
    * execucao sem interface, por isso vai guardado.
    * PUBLIC: chamado pelos handlers e pelo harness de teste (regra #3).
    *==========================================================================
    PROCEDURE FocarCampoConta()
        LOCAL loc_oErro

        TRY
            IF THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c_Conta.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            *-- pagina nao pintada / execucao sem interface: nao eh erro de
            *-- negocio (mesmo tratamento do SetFocus em AlternarPagina)
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - ponta 'ALTERAR' do cmd_cadastro.Click legado:
    *   ThisForm.pcEscolha = IIF(fChecaAcesso('SIGOPCGV','ALTERAR'),
    *                            'ALTERAR', 'CONSULTAR')
    * O legado NAO avisa quando falta o acesso - simplesmente abre a conta
    * somente para leitura -, entao aqui tambem nao se avisa.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cEscolha
        loc_cEscolha = IIF(THIS.PodeAlterarCadastro(), "ALTERAR", "CONSULTAR")
        THIS.AbrirVisaoCadastral(loc_cEscolha)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - ponta 'CONSULTAR' do mesmo cmd_cadastro.Click:
    * abre a conta na visao cadastral em modo somente leitura, que eh o que o
    * legado faz com quem nao tem o acesso de alteracao. Sem 'ALTERAR' no BO,
    * o cmd_voltar.Click nao oferece gravacao.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.AbrirVisaoCadastral("CONSULTAR")
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - o legado NAO inclui conta nesta tela (ver a nota do
    * bloco acima: pcEscolha so assume 'CONSULTAR'/'ALTERAR' e o grp_operacao
    * nao tem botao de inclusao). Reproduz a ausencia em vez de inventar a
    * operacao, informando onde ela mora de verdade.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        MsgAviso("Pesquisa Global de Vendas " + CHR(233) + " uma tela de " + ;
            "consulta: a inclus" + CHR(227) + "o de contas " + CHR(233) + ;
            " feita no Cadastro de Clientes.", THIS.Caption)
        THIS.FocarCampoConta()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - irmao do BtnIncluirClick: o legado tambem nao exclui
    * conta nesta tela. Reproduz a ausencia e aponta o Cadastro de Clientes.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        MsgAviso("Pesquisa Global de Vendas " + CHR(233) + " uma tela de " + ;
            "consulta: a exclus" + CHR(227) + "o de contas " + CHR(233) + ;
            " feita no Cadastro de Clientes.", THIS.Caption)
        THIS.FocarCampoConta()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaResultado - Page2 (pag_resultado do legado).
    *
    * ORDEM DE CRIACAO: o PageFrame das abas vem PRIMEIRO e as barras de
    * navegacao/acao DEPOIS, porque elas ficam por cima dele - o cnt_periodo
    * do legado esta em Top = 120..156 e o PageFrame em Top = 127, isto eh,
    * sobrepostos. Criar na ordem inversa faria o PageFrame cobrir o filtro
    * de periodo (mesmo raciocinio da regra #11).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaResultado()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2
        *-- Page NAO tem a propriedade Visible (quem controla a exibicao eh o
        *-- PageFrame, via ActivePage)

        THIS.ConfigurarPageFrameResultado()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarNavegacaoResultado()
        THIS.ConfigurarPeriodoResultado()
        THIS.ConfigurarBotoesResultado()
        THIS.ConfigurarPaineisImpressao()
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrameResultado - PageFrame interno "Result" (fld_principal.
    * pag_resultado.Result do legado): 10 abas, uma por assunto. Tabs = .F.
    * porque a navegacao eh feita pelo OptionGroup obj_4c_OptResultado, nao
    * por clique na aba.
    *
    * ORDEM DAS PAGINAS (regra #31): o legado navega com
    * "result.ActivePage = this.Value" (Optiongroup1.InteractiveChange), e
    * ActivePage eh o PageOrder, NAO a ordem de declaracao. No SCX legado as
    * paginas estao declaradas fora de ordem (Result.Page2 "Cheques" tem
    * PageOrder = 3, Page5 "Pendencias" tem PageOrder = 2, Page7 "Cartao" tem
    * PageOrder = 4, Page3 "Vendas" tem PageOrder = 5...). Aqui as 10 abas sao
    * declaradas JA na ordem de PageOrder do legado, de modo que
    * "ActivePage = Value" caia exatamente na mesma aba que o legado abre para
    * cada opcao do OptionGroup:
    *
    *   1 Saldo Conta Corrente   2 Pendencias Financeiras   3 Cheques
    *   4 Cartao                 5 Vendas                   6 Estoque
    *   7 Movimen. Pend.         8 Producao                  9 Hist. Cheques
    *  10 Credito
    *
    * Declarar em ordem de PageOrder (em vez de atribuir .PageOrder em runtime,
    * que no VFP9 reordena as demais paginas em cascata) deixa o default do
    * PageFrame igual ao PageOrder do legado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrameResultado()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        loc_oPg.AddObject("pgf_4c_Resultado", "PageFrame")
        WITH loc_oPg.pgf_4c_Resultado
            .Top           = 127
            .Left          = -1
            .Width         = 1003
            .Height        = 476
            .PageCount     = 10
            *-- SpecialEffect de PageFrame eh READ-ONLY em runtime: o legado
            *-- declara 2 no SCX, mas o VFP9 nao aceita a atribuicao aqui
            .Tabs          = .F.
            .Themes        = .F.
            .Visible       = .T.

            .Page1.FontName  = "Verdana"
            .Page1.FontSize  = 8
            .Page1.Caption   = "Saldo"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page1.ForeColor = RGB(36, 84, 155)

            .Page2.FontName  = "Tahoma"
            .Page2.FontSize  = 8
            .Page2.Caption   = "Pend" + CHR(234) + "ncias"
            .Page2.BackColor = RGB(255, 255, 255)
            .Page2.ForeColor = RGB(90, 90, 90)

            .Page3.FontName  = "Tahoma"
            .Page3.FontSize  = 8
            .Page3.Caption   = "Cheques"
            .Page3.BackColor = RGB(255, 255, 255)
            .Page3.ForeColor = RGB(90, 90, 90)

            .Page4.FontName  = "Tahoma"
            .Page4.FontSize  = 8
            .Page4.Caption   = "Cart" + CHR(227) + "o"
            .Page4.BackColor = RGB(255, 255, 255)
            .Page4.ForeColor = RGB(90, 90, 90)

            .Page5.FontName  = "Tahoma"
            .Page5.FontSize  = 8
            .Page5.Caption   = "Vendas"
            .Page5.BackColor = RGB(255, 255, 255)
            .Page5.ForeColor = RGB(90, 90, 90)

            .Page6.FontName  = "Tahoma"
            .Page6.FontSize  = 8
            .Page6.Caption   = "Estoque"
            .Page6.BackColor = RGB(255, 255, 255)
            .Page6.ForeColor = RGB(90, 90, 90)

            .Page7.FontName  = "Tahoma"
            .Page7.FontSize  = 8
            .Page7.Caption   = "Opera" + CHR(231) + CHR(245) + "es Pendentes"
            .Page7.BackColor = RGB(255, 255, 255)
            .Page7.ForeColor = RGB(90, 90, 90)

            .Page8.FontName  = "Tahoma"
            .Page8.FontSize  = 8
            .Page8.Caption   = "Produ" + CHR(231) + CHR(227) + "o"
            .Page8.BackColor = RGB(255, 255, 255)
            .Page8.ForeColor = RGB(90, 90, 90)

            .Page9.FontName  = "Tahoma"
            .Page9.FontSize  = 8
            .Page9.Caption   = "H.Cheques"
            .Page9.BackColor = RGB(255, 255, 255)
            .Page9.ForeColor = RGB(90, 90, 90)

            .Page10.FontName  = "Tahoma"
            .Page10.FontSize  = 8
            .Page10.Caption   = "Cr" + CHR(233) + "dito"
            .Page10.BackColor = RGB(255, 255, 255)
            .Page10.ForeColor = RGB(90, 90, 90)

            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                .Page1.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
                .Page2.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
                .Page3.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
                .Page4.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
                .Page5.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
                .Page6.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
                .Page7.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
                .Page8.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
                .Page9.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
                .Page10.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            .ActivePage = 1
        ENDWITH

        THIS.ConfigurarAbaSaldo()
    ENDPROC

    *==========================================================================
    * ConfigurarAbaSaldo - Grids da aba Saldo (Result.Saldo do legado):
    * grd_historico (historico de conta corrente) e grd_saldo (saldo por
    * moeda), ligados aos cursores locais dbHistorico/dbSaldo (criados em
    * CriarCursoresLocais). A populacao com os valores da conta pesquisada
    * ainda depende da porcao truncada do Processa() legado (ver comentario
    * de CriarCursoresLocais no BO) - fica para fase seguinte.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaSaldo()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page1

        loc_oPg.AddObject("lbl_4c_Historico", "Label")
        WITH loc_oPg.lbl_4c_Historico
            .Top       = 90
            .Left      = 11
            .Width     = 160
            .Height    = 15
            .Alignment = 0
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Hist" + CHR(243) + "rico Conta Corrente"
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("grd_4c_Historico", "Grid")
        WITH loc_oPg.grd_4c_Historico
            .Top           = 104
            .Left          = 11
            .Width         = 721
            .Height        = 292
            .FontName      = "Courier New"
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ReadOnly      = .T.
            .ScrollBars    = 2
            .RecordSource  = "dbHistorico"
            .ColumnCount   = 6
            .Themes        = .F.
            .Visible       = .T.

            .Columns(1).ControlSource      = "dbHistorico.emps"
            .Columns(1).Header1.Caption    = "Emp"
            .Columns(1).Width              = 31
            .Columns(1).ReadOnly           = .T.

            .Columns(2).ControlSource      = "dbHistorico.datas"
            .Columns(2).Header1.Caption    = "Data"
            .Columns(2).Width              = 80
            .Columns(2).ReadOnly           = .T.

            .Columns(3).ControlSource      = "dbHistorico.valors"
            .Columns(3).Header1.Caption    = "Valor"
            .Columns(3).Width              = 94
            .Columns(3).Format             = "9,999,999.99"
            .Columns(3).InputMask          = "9,999,999.99"
            .Columns(3).ReadOnly           = .T.

            .Columns(4).ControlSource      = "dbHistorico.opers"
            .Columns(4).Header1.Caption    = "O"
            .Columns(4).Width              = 18
            .Columns(4).ReadOnly           = .T.

            .Columns(5).ControlSource      = "dbHistorico.saldos"
            .Columns(5).Header1.Caption    = "Saldo"
            .Columns(5).Width              = 94
            .Columns(5).Alignment          = 3
            .Columns(5).Format             = "9,999,999.99"
            .Columns(5).InputMask          = "9,999,999.99"
            .Columns(5).ReadOnly           = .T.

            .Columns(6).ControlSource      = "dbHistorico.hists"
            .Columns(6).Header1.Caption    = "Hist" + CHR(243) + "rico"
            .Columns(6).Width              = 376
            .Columns(6).ReadOnly           = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_Saldo", "Label")
        WITH loc_oPg.lbl_4c_Saldo
            .Top       = 251
            .Left      = 747
            .Width     = 150
            .Height    = 15
            .Alignment = 0
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Saldo por Moeda"
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("grd_4c_Saldo", "Grid")
        WITH loc_oPg.grd_4c_Saldo
            .Top          = 265
            .Left         = 747
            .Width        = 242
            .Height       = 131
            .FontName     = "Courier New"
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .ReadOnly     = .T.
            .ScrollBars   = 2
            .RecordSource = "dbSaldo"
            .ColumnCount  = 3
            .Themes       = .F.
            .Visible      = .T.

            .Columns(1).ControlSource   = "dbSaldo.moedas"
            .Columns(1).Header1.Caption = "Moe"
            .Columns(1).Width           = 70
            .Columns(1).ReadOnly        = .T.

            .Columns(2).ControlSource   = "dbSaldo.saldos"
            .Columns(2).Header1.Caption = "Saldo"
            .Columns(2).Width           = 86
            .Columns(2).Format          = "9,999,999.99"
            .Columns(2).InputMask       = "9,999,999.99"
            .Columns(2).ReadOnly        = .T.

            .Columns(3).ControlSource   = "dbSaldo.SaldoConta"
            .Columns(3).Header1.Caption = "Dispon" + CHR(237) + "vel"
            .Columns(3).Width           = 86
            .Columns(3).Format          = "9,999,999.99"
            .Columns(3).InputMask       = "9,999,999.99"
            .Columns(3).ReadOnly        = .T.
        ENDWITH

        *-- Botao "Documento" (Anexa) do historico de conta corrente (Result.
        *-- Saldo.Anexa do legado): mesmo padrao icone-only do cmd_4c_AnexaPend
        *-- da aba Pendencias (regra do botao nunca desabilitado em runtime).
        loc_oPg.AddObject("cmd_4c_AnexaSaldo", "CommandButton")
        WITH loc_oPg.cmd_4c_AnexaSaldo
            .Top             = 407
            .Left            = 744
            .Width           = 40
            .Height          = 40
            .FontName        = "Verdana"
            .FontSize        = 8
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
            .ToolTipText     = "Documento"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_AnexaSaldo, "Click", THIS, "BtnAnexaSaldoClick")

        loc_oPg.grd_4c_Historico.Refresh()
        loc_oPg.grd_4c_Saldo.Refresh()
    ENDPROC

    *==========================================================================
    * ConfigurarNavegacaoResultado - OptionGroup de navegacao entre as 10 abas
    * da pagina Resultado (Optiongroup1 do legado, Top = 12 / Left = 44 /
    * 760x85, 10 botoes graficos de 75x75 lado a lado).
    *
    * O legado navega com "result.ActivePage = this.Value" - por isso as abas
    * foram declaradas na ordem de PageOrder (ver ConfigurarPageFrameResultado)
    * e aqui as legendas/icones/posicoes de cada opcao sao transcritas do dump
    * na MESMA ordem, para opcao N abrir a aba N.
    *
    * OptionGroup nao tem ForeColor (regra #33): a cor vai em cada Buttons(N).
    * Nenhum ButtonsValue eh atribuido - quem guarda a selecao eh o Value
    * do grupo (1..10), e valor nao-zero no botao marcaria todos de uma vez.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarNavegacaoResultado()
        LOCAL loc_oPg, loc_oOpt
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        loc_oPg.AddObject("obj_4c_OptResultado", "OptionGroup")
        loc_oOpt = loc_oPg.obj_4c_OptResultado

        WITH loc_oOpt
            .Top           = 12
            .Left          = 44
            .Width         = 760
            .Height        = 85
            .ButtonCount   = 10
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 0
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Opcao 1 - Saldo Conta Corrente (optSaldo)
        THIS.ConfigurarBotaoNavegacao(loc_oOpt, 1, 5, ;
            "Saldo Conta Corrente", "geral_nota_60.jpg", 7, 2, .T., "")

        *-- Opcao 2 - Pendencias Financeiras (optPendencia)
        THIS.ConfigurarBotaoNavegacao(loc_oOpt, 2, 80, ;
            "Pend" + CHR(234) + "ncias Financeiras", "geral_pendencia_60.jpg", 7, 2, .T., "")

        *-- Opcao 3 - Cheques (optCheque)
        THIS.ConfigurarBotaoNavegacao(loc_oOpt, 3, 155, ;
            "Cheques", "cheque.png", 0, 2, .T., "")

        *-- Opcao 4 - Cartao (optCartao)
        THIS.ConfigurarBotaoNavegacao(loc_oOpt, 4, 230, ;
            "Cart" + CHR(227) + "o", "cartao.png", 0, 0, .F., "")

        *-- Opcao 5 - Vendas (optVendas)
        THIS.ConfigurarBotaoNavegacao(loc_oOpt, 5, 305, ;
            "Vendas", "geral_pastas_60.jpg", 0, 0, .F., "")

        *-- Opcao 6 - Estoque (optEstoque)
        THIS.ConfigurarBotaoNavegacao(loc_oOpt, 6, 380, ;
            "Estoque", "geral_empilha_60.jpg", 0, 2, .T., "")

        *-- Opcao 7 - Movimentacoes Pend. (optOpPendente)
        THIS.ConfigurarBotaoNavegacao(loc_oOpt, 7, 455, ;
            "Movimen. Pendentes", "geral_pendencia_60.jpg", 7, 2, .T., ;
            "Movimenta" + CHR(231) + CHR(245) + "es Pendentes")

        *-- Opcao 8 - Producao (optProducao)
        THIS.ConfigurarBotaoNavegacao(loc_oOpt, 8, 530, ;
            "Produ" + CHR(231) + CHR(227) + "o", "geral_configuracao_60.jpg", 0, 0, .F., "")

        *-- Opcao 9 - Historico de Cheques (optHisCheque)
        THIS.ConfigurarBotaoNavegacao(loc_oOpt, 9, 605, ;
            "Hist" + CHR(243) + "rico de Cheques", "geral_sel_pasta_60.jpg", 7, 2, .T., "")

        *-- Opcao 10 - Credito (optCredito)
        THIS.ConfigurarBotaoNavegacao(loc_oOpt, 10, 680, ;
            "Cr" + CHR(233) + "dito", "geral_calculadora_60.jpg", 0, 0, .F., "")

        BINDEVENT(loc_oOpt, "InteractiveChange", THIS, "OptResultadoInteractiveChange")
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoNavegacao - Aplica a um Buttons(N) do OptionGroup de
    * navegacao as propriedades comuns a todas as 10 opcoes do legado (botao
    * grafico 75x75, Comic Sans MS 8 bold italic, cinza sobre branco, sem
    * tema) mais o que varia de uma para outra.
    *
    * par_oGrupo    : o OptionGroup (passado por referencia de objeto, para nao
    *                 aninhar WITH de AddObject - ver regra do WITH aninhado)
    * par_nIndice   : indice do botao (1..10)
    * par_nLeft     : Left do botao dentro do grupo
    * par_cCaption  : legenda transcrita do dump
    * par_cIcone    : arquivo em vbmp\
    * par_nPicPos   : PicturePosition (0 = default do dump, 7 = acima do texto)
    * par_nAlign    : Alignment (0 = default do dump, 2 = centralizado)
    * par_lWordWrap : WordWrap
    * par_cToolTip  : ToolTipText ("" quando o dump nao declara)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoNavegacao(par_oGrupo, par_nIndice, par_nLeft, ;
            par_cCaption, par_cIcone, par_nPicPos, par_nAlign, par_lWordWrap, par_cToolTip)

        WITH par_oGrupo.Buttons(par_nIndice)
            .Top        = 5
            .Left       = par_nLeft
            .Width      = 75
            .Height     = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Style      = 1
            .AutoSize   = .F.
            .WordWrap   = par_lWordWrap
            .Alignment  = par_nAlign
            .Caption    = par_cCaption
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.

            IF par_nPicPos > 0
                .PicturePosition = par_nPicPos
            ENDIF

            IF !EMPTY(par_cToolTip)
                .ToolTipText = par_cToolTip
            ENDIF

            IF FILE(gc_4c_CaminhoIcones + par_cIcone)
                .Picture = gc_4c_CaminhoIcones + par_cIcone
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPeriodoResultado - Filtro de periodo da pagina Resultado
    * (cnt_periodo do legado: Top = 120 / Left = -1 / 252x36, transparente).
    *
    * O periodo eh o que decide COMO o saldo eh calculado em
    * sigopcgvBO.CarregarHistoricoSaldo: em branco usa o consolidado de
    * SigMvSlc; preenchido limita o historico ao intervalo e soma o proprio
    * historico - exatamente o IF do Processa() legado.
    *
    * lbl_periodo/lbl_periodo_a sao da classe "say" (AutoSize = .T. no dump);
    * aqui vao com AutoSize = .F. + Width/Height transcritos, porque AutoSize
    * eh no-op em Label criado por AddObject (regra #23).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPeriodoResultado()
        LOCAL loc_oPg, loc_oCnt
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        loc_oPg.AddObject("cnt_4c_Periodo", "Container")
        loc_oCnt = loc_oPg.cnt_4c_Periodo

        WITH loc_oCnt
            .Top         = 120
            .Left        = -1
            .Width       = 252
            .Height      = 36
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oCnt.lbl_4c_Periodo
            .Top       = 10
            .Left      = 16
            .Width     = 48
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Per" + CHR(237) + "o\<do : "
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oCnt.txt_4c_DtInicial
            .Top           = 8
            .Left          = 66
            .Width         = 80
            .Height        = 21
            .Value         = {}
            .Format        = "K"
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_PeriodoAte", "Label")
        WITH loc_oCnt.lbl_4c_PeriodoAte
            .Top       = 10
            .Left      = 149
            .Width     = 10
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = CHR(224)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oCnt.txt_4c_DtFinal
            .Top           = 8
            .Left          = 160
            .Width         = 80
            .Height        = 21
            .Value         = {}
            .Format        = "K"
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- O legado recarrega a consulta no LostFocus da data final
        *-- (get_dt_final.LostFocus: ConsultaExecutada = .f. + Processa()).
        *-- LostFocus, nunca KeyPress (regra #47).
        BINDEVENT(loc_oCnt.txt_4c_DtInicial, "LostFocus", THIS, "DtPeriodoLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_DtFinal,   "LostFocus", THIS, "DtPeriodoLostFocus")
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesResultado - Barra de acao da pagina Resultado:
    *
    *   cmg_4c_MudaCli  (Cmd_MudaCli do legado) - troca para a visao CADASTRO
    *   cmg_4c_MudaMov  (Cmd_MudaMov do legado) - troca para a visao MOVIMENTO
    *   cmg_4c_Voltar   (grp_operacao do legado) - volta para a pagina Consulta
    *
    * Os tres sao CommandGroup de 1 botao, 85x85, transparentes, exatamente
    * como no dump. MudaCli e MudaMov ocupam o MESMO Left (794) de proposito:
    * no legado so um dos dois esta visivel a cada momento, e e' justamente o
    * clique em um que mostra o outro.
    *
    * lblSaldoCash/getSaldoCash acompanham a visao CADASTRO (o legado os
    * esconde em cmd_cadastro.Click e os mantem fora da visao MOVIMENTO).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesResultado()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        *-- Cmd_MudaCli: "Cadastro"
        loc_oPg.AddObject("cmg_4c_MudaCli", "CommandGroup")
        WITH loc_oPg.cmg_4c_MudaCli
            .Top           = 12
            .Left          = 794
            .Width         = 85
            .Height        = 85
            .ButtonCount   = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.

            WITH .Buttons(1)
                .Top         = 5
                .Left        = 5
                .Width       = 75
                .Height      = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Caption     = "\<Cadastro"
                .ToolTipText = "Dados Cadastrais"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                IF FILE(gc_4c_CaminhoIcones + "geral_contatos_60.jpg")
                    .Picture = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
                ENDIF
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- Cmd_MudaMov: "Movimento"
        loc_oPg.AddObject("cmg_4c_MudaMov", "CommandGroup")
        WITH loc_oPg.cmg_4c_MudaMov
            .Top           = 12
            .Left          = 794
            .Width         = 85
            .Height        = 85
            .ButtonCount   = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.

            WITH .Buttons(1)
                .Top         = 5
                .Left        = 5
                .Width       = 75
                .Height      = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Caption     = "\<Movimento"
                .ToolTipText = "Movimenta" + CHR(231) + CHR(227) + "o"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                IF FILE(gc_4c_CaminhoIcones + "geral_pastas_60.jpg")
                    .Picture = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
                ENDIF
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- grp_operacao da pagina Resultado: "Voltar"
        loc_oPg.AddObject("cmg_4c_Voltar", "CommandGroup")
        WITH loc_oPg.cmg_4c_Voltar
            .Top           = 12
            .Left          = 869
            .Width         = 85
            .Height        = 85
            .ButtonCount   = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 1
            .Themes        = .F.

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Cancel     = .T.
                .Caption    = "Voltar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                IF FILE(gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg")
                    .Picture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
                ENDIF
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- Saldo de cashback do cliente (lblSaldoCash / getSaldoCash)
        loc_oPg.AddObject("lbl_4c_SaldoCash", "Label")
        WITH loc_oPg.lbl_4c_SaldoCash
            .Top       = 97
            .Left      = 49
            .Width     = 59
            .Height    = 21
            .AutoSize  = .F.
            .Alignment = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 12
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Caption   = "Saldo: "
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_SaldoCash", "TextBox")
        WITH loc_oPg.txt_4c_SaldoCash
            .Top               = 96
            .Left              = 105
            .Width             = 100
            .Height            = 23
            .Value             = ""
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Enabled           = .F.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .Visible           = .F.
        ENDWITH

        BINDEVENT(loc_oPg.cmg_4c_MudaCli.Buttons(1), "Click", THIS, "BtnMudaCliClick")
        BINDEVENT(loc_oPg.cmg_4c_MudaMov.Buttons(1), "Click", THIS, "BtnMudaMovClick")
        BINDEVENT(loc_oPg.cmg_4c_Voltar.Buttons(1),  "Click", THIS, "BtnVoltarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarPaineisImpressao - Botao Imprime (pag_resultado.Imprime) e os
    * dois paineis modais de selecao de impressao do legado:
    *
    *   cnt_4c_SelecionaImpCad      (SelecionaImpCad)      - visao CADASTRO
    *   cnt_4c_SelecionaImpressao   (SelecionaImpress?o)   - visao MOVIMENTO
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaineisImpressao()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        loc_oPg.AddObject("cmd_4c_Imprime", "CommandButton")
        WITH loc_oPg.cmd_4c_Imprime
            .Top             = 134
            .Left            = 858
            .Width           = 137
            .Height          = 37
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .Caption         = "     \<Imprimir"
            .ToolTipText     = "Impress" + CHR(227) + "o"
            .PicturePosition = 1
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            IF FILE(gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg")
                .Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            ENDIF
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_Imprime, "Click", THIS, "BtnImprimeClick")

        THIS.ConfigurarPainelImpressaoCadastro(loc_oPg)
        THIS.ConfigurarPainelImpressaoMovimento(loc_oPg)
    ENDPROC

    *==========================================================================
    * ConfigurarPainelImpressaoCadastro - SelecionaImpCad do legado: painel
    * simples (5 checkboxes) usado quando Imprime eh acionado na visao
    * CADASTRO.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPainelImpressaoCadastro(par_oPg)
        LOCAL loc_oCnt
        par_oPg.AddObject("cnt_4c_SelecionaImpCad", "Container")
        loc_oCnt = par_oPg.cnt_4c_SelecionaImpCad

        WITH loc_oCnt
            .Top           = 213
            .Left          = 270
            .Width         = 458
            .Height        = 178
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF
            .Visible = .F.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCnt.lbl_4c_Titulo
            .Top       = 6
            .Left      = 5
            .Width     = 226
            .Height    = 17
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Impress" + CHR(227) + "o da Consulta (Cadastro)"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_Generico", "CheckBox")
        WITH loc_oCnt.chk_4c_Generico
            .Top       = 37
            .Left      = 18
            .Width     = 99
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Dados do Cliente"
            .Value     = 1
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_Pessoais", "CheckBox")
        WITH loc_oCnt.chk_4c_Pessoais
            .Top       = 61
            .Left      = 18
            .Width     = 92
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Dados Pessoais"
            .Value     = 1
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_Bancarias", "CheckBox")
        WITH loc_oCnt.chk_4c_Bancarias
            .Top       = 85
            .Left      = 18
            .Width     = 124
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Refer" + CHR(234) + "ncias Banc" + CHR(225) + "rias"
            .Value     = 1
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_Followup", "CheckBox")
        WITH loc_oCnt.chk_4c_Followup
            .Top       = 109
            .Left      = 18
            .Width     = 64
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Follow-up"
            .Value     = 1
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_Impressora", "CheckBox")
        WITH loc_oCnt.chk_4c_Impressora
            .Top       = 133
            .Left      = 18
            .Width     = 126
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Impressora 40 colunas"
            .Value     = 1
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Visualizar
            .Top             = 4
            .Left            = 231
            .Width           = 75
            .Height          = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .PicturePosition = 13
            .Caption         = "V" + CHR(237) + "deo"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            IF FILE(gc_4c_CaminhoIcones + "relatorio_video_26.jpg")
                .Picture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            ENDIF
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Imprimir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Imprimir
            .Top             = 4
            .Left            = 306
            .Width           = 75
            .Height          = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .WordWrap        = .F.
            .PicturePosition = 13
            .Caption         = " Impressora    "
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            IF FILE(gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg")
                .Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            ENDIF
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Saida", "CommandButton")
        WITH loc_oCnt.cmd_4c_Saida
            .Top        = 4
            .Left        = 379
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .Cancel      = .T.
            .Caption     = "Encerrar"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
                .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            ENDIF
            .Visible = .T.
        ENDWITH

        BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnImpCadVisualizarClick")
        BINDEVENT(loc_oCnt.cmd_4c_Imprimir,   "Click", THIS, "BtnImpCadImprimirClick")
        BINDEVENT(loc_oCnt.cmd_4c_Saida,      "Click", THIS, "BtnImpCadSaidaClick")
    ENDPROC

    *==========================================================================
    * ConfigurarPainelImpressaoMovimento - SelecionaImpress?o do legado:
    * painel completo (14 checkboxes + periodo de produtos adquiridos) usado
    * quando Imprime eh acionado na visao MOVIMENTO.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPainelImpressaoMovimento(par_oPg)
        LOCAL loc_oCnt, loc_oProd
        par_oPg.AddObject("cnt_4c_SelecionaImpressao", "Container")
        loc_oCnt = par_oPg.cnt_4c_SelecionaImpressao

        WITH loc_oCnt
            .Top           = 145
            .Left          = 295
            .Width         = 409
            .Height        = 315
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF
            .Visible = .F.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCnt.lbl_4c_Titulo
            .Top       = 12
            .Left      = 10
            .Width     = 132
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Impress" + CHR(227) + "o da Consulta"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_Saldo", "CheckBox")
        WITH loc_oCnt.chk_4c_Saldo
            .Top       = 88
            .Left      = 10
            .Width     = 137
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Saldo de Conta Corrente"
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_Limite", "CheckBox")
        WITH loc_oCnt.chk_4c_Limite
            .Top       = 112
            .Left      = 10
            .Width     = 98
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Limite de Cr" + CHR(233) + "dito"
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_ChqPend", "CheckBox")
        WITH loc_oCnt.chk_4c_ChqPend
            .Top       = 136
            .Left      = 10
            .Width     = 114
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cheques Pendentes"
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_ChqDev", "CheckBox")
        WITH loc_oCnt.chk_4c_ChqDev
            .Top       = 162
            .Left      = 10
            .Width     = 115
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cheques Devolvidos"
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_ChqDep", "CheckBox")
        WITH loc_oCnt.chk_4c_ChqDep
            .Top       = 185
            .Left      = 10
            .Width     = 122
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cheques Depositados"
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_Negociado", "CheckBox")
        WITH loc_oCnt.chk_4c_Negociado
            .Top       = 208
            .Left      = 10
            .Width     = 118
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cheques Negociados"
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_Cartao", "CheckBox")
        WITH loc_oCnt.chk_4c_Cartao
            .Top       = 229
            .Left      = 10
            .Width     = 109
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cart" + CHR(245) + "es em Aberto"
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_Pend", "CheckBox")
        WITH loc_oCnt.chk_4c_Pend
            .Top       = 250
            .Left      = 10
            .Width     = 72
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Pend" + CHR(234) + "ncias"
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_Estoque", "CheckBox")
        WITH loc_oCnt.chk_4c_Estoque
            .Top       = 271
            .Left      = 10
            .Width     = 111
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Estoque"
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_MovPend", "CheckBox")
        WITH loc_oCnt.chk_4c_MovPend
            .Top       = 135
            .Left      = 191
            .Width     = 146
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es Pendentes"
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_Imp40", "CheckBox")
        WITH loc_oCnt.chk_4c_Imp40
            .Top       = 159
            .Left      = 191
            .Width     = 126
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Impressora 40 colunas"
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_ResVenda", "CheckBox")
        WITH loc_oCnt.chk_4c_ResVenda
            .Top       = 183
            .Left      = 191
            .Width     = 130
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Resumo Mensal Vendas"
            .Value     = 1
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_ProdAdq", "CheckBox")
        WITH loc_oCnt.chk_4c_ProdAdq
            .Top       = 209
            .Left      = 191
            .Width     = 173
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Produtos Adquiridos Pelo Cliente"
            .Value     = 1
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_Producao", "CheckBox")
        WITH loc_oCnt.chk_4c_Producao
            .Top       = 232
            .Left      = 191
            .Width     = 180
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Produtos em Produ" + ;
                CHR(231) + CHR(227) + "o"
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("cnt_4c_ProdAdq", "Container")
        WITH loc_oCnt.cnt_4c_ProdAdq
            .Top           = 255
            .Left          = 199
            .Width         = 191
            .Height        = 47
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH
        loc_oProd = loc_oCnt.cnt_4c_ProdAdq

        loc_oProd.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oProd.lbl_4c_Titulo
            .Top       = 3
            .Left      = 6
            .Width     = 150
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Prod.Adquirido No Per" + CHR(237) + "odo de :"
            .Visible   = .T.
        ENDWITH

        loc_oProd.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oProd.txt_4c_DtInicial
            .Top           = 20
            .Left          = 7
            .Width         = 80
            .Height        = 23
            .Value         = {}
            .Format        = "K"
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oProd.AddObject("lbl_4c_PeriodoAte", "Label")
        WITH loc_oProd.lbl_4c_PeriodoAte
            .Top       = 23
            .Left      = 92
            .Width     = 10
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "a"
            .Visible   = .T.
        ENDWITH

        loc_oProd.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oProd.txt_4c_DtFinal
            .Top           = 20
            .Left          = 104
            .Width         = 80
            .Height        = 23
            .Value         = {}
            .Format        = "K"
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Visualizar
            .Top             = 4
            .Left            = 179
            .Width           = 75
            .Height          = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .WordWrap        = .F.
            .PicturePosition = 13
            .Caption         = "    V" + CHR(237) + "deo            "
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            IF FILE(gc_4c_CaminhoIcones + "relatorio_video_26.jpg")
                .Picture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            ENDIF
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Imprimir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Imprimir
            .Top             = 4
            .Left            = 254
            .Width           = 75
            .Height          = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .WordWrap        = .F.
            .PicturePosition = 13
            .Caption         = " Impressora    "
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            IF FILE(gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg")
                .Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            ENDIF
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Saida", "CommandButton")
        WITH loc_oCnt.cmd_4c_Saida
            .Top             = 4
            .Left            = 329
            .Width           = 75
            .Height          = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .Cancel          = .T.
            .PicturePosition = 13
            .Caption         = "Encerrar"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
                .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            ENDIF
            .Visible = .T.
        ENDWITH

        BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnImpMovVisualizarClick")
        BINDEVENT(loc_oCnt.cmd_4c_Imprimir,   "Click", THIS, "BtnImpMovImprimirClick")
        BINDEVENT(loc_oCnt.cmd_4c_Saida,      "Click", THIS, "BtnImpMovSaidaClick")
    ENDPROC

    *==========================================================================
    * BtnImprimeClick - Imprime.Click do legado: centraliza o painel de
    * impressao correto (SelecionaImpressao na visao MOVIMENTO,
    * SelecionaImpCad na visao CADASTRO - distincao por cmg_4c_MudaCli.
    * Visible, regra #40: so um dos dois MudaCli/MudaMov fica visivel por
    * vez, e MudaCli visivel = visao MOVIMENTO em curso) e desabilita o
    * resto da tela enquanto o painel esta aberto.
    *==========================================================================
    PROCEDURE BtnImprimeClick()
        LOCAL loc_oPg, loc_oPainel, loc_nLeft, loc_nTop

        loc_oPg = THIS.pgf_4c_Paginas.Page2
        loc_oPg.cmd_4c_Imprime.Enabled = .F.

        loc_oPainel = IIF(loc_oPg.cmg_4c_MudaCli.Visible, ;
            loc_oPg.cnt_4c_SelecionaImpressao, loc_oPg.cnt_4c_SelecionaImpCad)

        loc_nLeft = INT(THIS.Width - loc_oPainel.Width)
        loc_nLeft = IIF(loc_nLeft > 0, INT(loc_nLeft / 2), 0)
        loc_nTop  = INT(THIS.Height - loc_oPainel.Height)
        loc_nTop  = IIF(loc_nTop > 0, INT(loc_nTop / 2), 0)

        loc_oPainel.Left    = loc_nLeft
        loc_oPainel.Top     = loc_nTop
        loc_oPainel.Visible = .T.
        loc_oPainel.ZOrder(0)

        THIS.DesabilitarControlesImpressao()
    ENDPROC

    *==========================================================================
    * DesabilitarControlesImpressao / RestaurarControlesImpressao - bloco
    * repetido nos dois paineis (Saida/Visualizar/Imprimir) do legado para
    * travar/destravar o resto da tela enquanto o popup de impressao esta
    * aberto. cntConta (visao cadastral) ainda nao existe nesta migracao
    * (fica para a fase do wrapper clsconta) - guardado por PEMSTATUS.
    *==========================================================================
    PROTECTED PROCEDURE DesabilitarControlesImpressao()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        THIS.pgf_4c_Paginas.Page1.Enabled = .F.
        loc_oPg.pgf_4c_Resultado.Enabled  = .F.
        IF PEMSTATUS(loc_oPg, "cntConta", 5)
            loc_oPg.cntConta.Enabled = .F.
        ENDIF
        loc_oPg.cmg_4c_MudaMov.Enabled = .F.
        loc_oPg.cmg_4c_MudaCli.Enabled = .F.
        loc_oPg.cmg_4c_Voltar.Enabled  = .F.
    ENDPROC

    PROTECTED PROCEDURE RestaurarControlesImpressao()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        THIS.pgf_4c_Paginas.Page1.Enabled = .T.
        loc_oPg.pgf_4c_Resultado.Enabled  = .T.
        IF PEMSTATUS(loc_oPg, "cntConta", 5)
            loc_oPg.cntConta.Enabled = .T.
        ENDIF
        loc_oPg.cmg_4c_MudaMov.Enabled = .T.
        loc_oPg.cmg_4c_MudaCli.Enabled = .T.
        loc_oPg.cmg_4c_Voltar.Enabled  = .T.
        loc_oPg.cmd_4c_Imprime.Enabled = .T.
    ENDPROC

    *==========================================================================
    * BtnImpCadSaidaClick / BtnImpCadVisualizarClick / BtnImpCadImprimirClick
    * Saida/Visualizar/Imprimir.Click do SelecionaImpCad legado.
    *==========================================================================
    PROCEDURE BtnImpCadSaidaClick()
        THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpCad.Visible = .F.
        THIS.RestaurarControlesImpressao()
    ENDPROC

    PROCEDURE BtnImpCadVisualizarClick()
        LOCAL loc_oPnl
        loc_oPnl = THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpCad
        THIS.ImpressaoCad("V", loc_oPnl.chk_4c_Generico.Value = 1, ;
            loc_oPnl.chk_4c_Pessoais.Value = 1, loc_oPnl.chk_4c_Bancarias.Value = 1, ;
            loc_oPnl.chk_4c_Followup.Value = 1, loc_oPnl.chk_4c_Impressora.Value = 1)
        loc_oPnl.Visible = .F.
        THIS.RestaurarControlesImpressao()
    ENDPROC

    PROCEDURE BtnImpCadImprimirClick()
        LOCAL loc_oPnl
        loc_oPnl = THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpCad
        THIS.ImpressaoCad("I", loc_oPnl.chk_4c_Generico.Value = 1, ;
            loc_oPnl.chk_4c_Pessoais.Value = 1, loc_oPnl.chk_4c_Bancarias.Value = 1, ;
            loc_oPnl.chk_4c_Followup.Value = 1, loc_oPnl.chk_4c_Impressora.Value = 1)
        loc_oPnl.Visible = .F.
        THIS.RestaurarControlesImpressao()
    ENDPROC

    *==========================================================================
    * BtnImpMovSaidaClick / BtnImpMovVisualizarClick / BtnImpMovImprimirClick
    * Saida/Visualizar/Imprimir.Click do SelecionaImpress?o legado.
    *==========================================================================
    PROCEDURE BtnImpMovSaidaClick()
        THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpressao.Visible = .F.
        THIS.RestaurarControlesImpressao()
    ENDPROC

    PROCEDURE BtnImpMovVisualizarClick()
        LOCAL loc_oPnl
        loc_oPnl = THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpressao
        THIS.Impressao("V", loc_oPnl.chk_4c_Saldo.Value = 1, loc_oPnl.chk_4c_Limite.Value = 1, ;
            loc_oPnl.chk_4c_ChqPend.Value = 1, loc_oPnl.chk_4c_ChqDev.Value = 1, ;
            loc_oPnl.chk_4c_ChqDep.Value = 1, loc_oPnl.chk_4c_Cartao.Value = 1, ;
            loc_oPnl.chk_4c_Pend.Value = 1, loc_oPnl.chk_4c_MovPend.Value = 1, .F., ;
            loc_oPnl.chk_4c_Negociado.Value = 1, loc_oPnl.chk_4c_ResVenda.Value = 1, ;
            loc_oPnl.chk_4c_ProdAdq.Value = 1, loc_oPnl.chk_4c_Producao.Value = 1, ;
            loc_oPnl.chk_4c_Estoque.Value = 1)
        loc_oPnl.Visible = .F.
        THIS.RestaurarControlesImpressao()
    ENDPROC

    PROCEDURE BtnImpMovImprimirClick()
        LOCAL loc_oPnl
        loc_oPnl = THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpressao
        THIS.Impressao("I", loc_oPnl.chk_4c_Saldo.Value = 1, loc_oPnl.chk_4c_Limite.Value = 1, ;
            loc_oPnl.chk_4c_ChqPend.Value = 1, loc_oPnl.chk_4c_ChqDev.Value = 1, ;
            loc_oPnl.chk_4c_ChqDep.Value = 1, loc_oPnl.chk_4c_Cartao.Value = 1, ;
            loc_oPnl.chk_4c_Pend.Value = 1, loc_oPnl.chk_4c_MovPend.Value = 1, ;
            loc_oPnl.chk_4c_Imp40.Value = 1, loc_oPnl.chk_4c_Negociado.Value = 1, ;
            loc_oPnl.chk_4c_ResVenda.Value = 1, loc_oPnl.chk_4c_ProdAdq.Value = 1, ;
            loc_oPnl.chk_4c_Producao.Value = 1, loc_oPnl.chk_4c_Estoque.Value = 1)
        loc_oPnl.Visible = .F.
        THIS.RestaurarControlesImpressao()
    ENDPROC

    *==========================================================================
    * AlternarPagina - FUNIL de troca de pagina (regra #40). Alem de mudar o
    * ActivePage (DODEFAULT -> FormBase), repoe o modo corrente e a altura do
    * form, e repinta as grades quando a pagina Resultado fica visivel.
    *
    * Altura: o legado trabalha com a tela encolhida em 300 na pagina Consulta
    * (ThisForm.Height = 300 no proprio Init e no cmd_voltar.Click) e em 600
    * na pagina Resultado (cmd_cadastro.Click/cmd_movimenta.Click). Reproduzir
    * isso faz o relatorio de UI Fidelity acusar DIFERENCA de Height contra o
    * valor DECLARADO no SCX (600) - eh falso positivo conhecido do comparador,
    * que le o dump estatico e nao executa o Init legado.
    *
    * Limpeza dos campos: so na VOLTA da pagina Resultado (cmd_voltar.Click do
    * legado limpa Conta/Nome/CPF/Conjuge/Telefone). Na abertura da tela nao
    * se limpa nada, senao a conta recebida por parametro no Init seria
    * descartada.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lVoltando, loc_oCnt, loc_oErro

        loc_lVoltando = (par_nPagina = 1 AND THIS.this_cModoAtual == "RESULTADO")

        DODEFAULT(par_nPagina)

        DO CASE
            CASE par_nPagina = 1
                THIS.this_cModoAtual = "CONSULTA"

                IF THIS.Height <> 300
                    THIS.Height = 300
                ENDIF

                IF loc_lVoltando
                    *-- Limpeza dos cinco criterios + LimparDados do BO, num
                    *-- funil unico (LimparCampos) - o bloco do cmd_voltar.Click
                    loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
                    THIS.LimparCampos()

                    TRY
                        loc_oCnt.txt_4c_Conta.SetFocus()
                    CATCH TO loc_oErro
                        *-- SetFocus falha com a pagina ainda nao pintada ou em
                        *-- modo de teste automatizado: nao eh erro de negocio
                    ENDTRY
                ELSE
                    *-- Abertura da tela: nada a limpar (a conta pode ter vindo
                    *-- por parametro no Init), mas a cascata de When do legado
                    *-- precisa valer desde o primeiro desenho
                    THIS.HabilitarCampos(.T.)
                ENDIF

            CASE par_nPagina = 2
                THIS.this_cModoAtual = "RESULTADO"

                IF THIS.Height <> 600
                    THIS.Height = 600
                ENDIF

                *-- Repintar SO DEPOIS de a pagina estar a vista (regra #46):
                *-- Refresh em pagina oculta nao pinta
                THIS.AtualizarAbaResultadoAtiva()
        ENDCASE

        *-- Reabilitar/reesconder os botoes eh papel do FUNIL de troca de
        *-- pagina, nunca de cada botao que entra (regra #40): sem isto a barra
        *-- da pagina Resultado ficaria visivel sobre a Consulta e o Imprime
        *-- ignoraria o gate de acesso do legado
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *==========================================================================
    * CarregarDados - Carga da consulta (trecho de historico/saldo do
    * Processa() legado). Repassa ao BO o periodo digitado na tela e manda
    * popular dbHistorico/dbSaldo; em seguida repinta as grades.
    *
    * PUBLIC de proposito: eh chamado de fora da classe pelos botoes e pelo
    * harness de teste automatizado (regra #3).
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oCnt, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Criterios e periodo da tela -> BO num funil unico
                *-- (fonte unica eh o campo, nao a property)
                THIS.FormParaBO()

                loc_lSucesso = THIS.this_oBusinessObject.CarregarHistoricoSaldo()

                IF !loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Consulta de Saldo")
                ENDIF

                THIS.AtualizarGradesSaldo()

                *-- Abas alimentadas pelo mesmo Processa() legado (Pendencias,
                *-- Cheques) e pelos PCartao()/PEstoque() (Cartao, Estoque)
                THIS.CarregarAbasResultado()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Proc: " + loc_oErro.Procedure, "Erro ao carregar a consulta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarGradesSaldo - Funil UNICO de repintura das grades da aba Saldo
    * (regra #21a: popular o cursor nao repinta a grade - o legado sempre
    * fecha com "Go Top In <cursor>" + "<grid>.Refresh").
    *
    * Chamado no fim da carga E no AlternarPagina(2), DEPOIS da troca de
    * ActivePage, porque Refresh em pagina oculta nao pinta (regra #46).
    * PUBLIC: chamado de fora da classe (botoes e harness de teste).
    *==========================================================================
    PROCEDURE AtualizarGradesSaldo()
        LOCAL loc_oAba, loc_oErro, loc_lTemAbas

        *-- Sem RETURN dentro do TRY (regra #1): o guard vira flag
        TRY
            loc_lTemAbas = PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Resultado", 5)

            IF loc_lTemAbas
                loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page1

                IF USED("dbHistorico")
                    SELECT dbHistorico
                    GO TOP
                ENDIF
                IF USED("dbSaldo")
                    SELECT dbSaldo
                    GO TOP
                ENDIF

                IF PEMSTATUS(loc_oAba, "grd_4c_Historico", 5)
                    loc_oAba.grd_4c_Historico.Refresh()
                ENDIF
                IF PEMSTATUS(loc_oAba, "grd_4c_Saldo", 5)
                    loc_oAba.grd_4c_Saldo.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao atualizar as grades de saldo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarVisibilidadeResultado - Funil UNICO de visibilidade da pagina
    * Resultado, transcrito de cmd_cadastro.Click (Cmd_MudaCli) e de
    * cmd_movimenta.Click (Cmd_MudaMov) do legado. Nos dois metodos o legado
    * mexe exatamente no mesmo conjunto, em sentidos opostos:
    *
    *   visao CADASTRO  : Result/OptionGroup/cnt_periodo escondidos,
    *                     MudaCli escondido e MudaMov visivel
    *   visao MOVIMENTO : Result/OptionGroup/cnt_periodo visiveis,
    *                     MudaMov escondido e MudaCli visivel
    *
    * O par MudaCli/MudaMov nunca fica visivel ao mesmo tempo - os dois estao
    * no mesmo Left (794) no legado.
    *
    * PUBLIC: chamado de fora da classe (botoes da pagina Consulta e harness).
    *==========================================================================
    PROCEDURE AjustarVisibilidadeResultado(par_cModo)
        LOCAL loc_oPg, loc_lMovimento, loc_oErro

        loc_lMovimento = (UPPER(ALLTRIM(IIF(VARTYPE(par_cModo) = "C", par_cModo, ""))) == "MOVIMENTO")

        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2

            THIS.this_cModoResultado = IIF(loc_lMovimento, "MOVIMENTO", "CADASTRO")

            loc_oPg.pgf_4c_Resultado.Visible   = loc_lMovimento
            loc_oPg.pgf_4c_Resultado.Enabled   = loc_lMovimento

            loc_oPg.obj_4c_OptResultado.Visible = loc_lMovimento
            loc_oPg.obj_4c_OptResultado.Enabled = loc_lMovimento

            loc_oPg.cnt_4c_Periodo.Visible = loc_lMovimento
            loc_oPg.cnt_4c_Periodo.Enabled = loc_lMovimento

            *-- Visao CADASTRO oferece ir para MOVIMENTO, e vice-versa
            loc_oPg.cmg_4c_MudaMov.Visible = !loc_lMovimento
            loc_oPg.cmg_4c_MudaMov.Enabled = !loc_lMovimento

            loc_oPg.cmg_4c_MudaCli.Visible = loc_lMovimento
            loc_oPg.cmg_4c_MudaCli.Enabled = loc_lMovimento

            *-- Saldo de cashback acompanha a visao cadastral
            loc_oPg.lbl_4c_SaldoCash.Visible = !loc_lMovimento
            loc_oPg.txt_4c_SaldoCash.Visible = !loc_lMovimento

            IF loc_lMovimento
                *-- Abre na aba 1 (Saldo), como o legado faz com ResultPageToSet
                IF loc_oPg.obj_4c_OptResultado.Value < 1
                    loc_oPg.obj_4c_OptResultado.Value = 1
                ENDIF
                loc_oPg.pgf_4c_Resultado.ActivePage = loc_oPg.obj_4c_OptResultado.Value
                loc_oPg.pgf_4c_Resultado.Refresh()
            ENDIF

            loc_oPg.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao ajustar a p" + CHR(225) + "gina Resultado")
        ENDTRY

        *-- Imprime/MudaCli/MudaMov tambem dependem do ACESSO (fChecaAcesso
        *-- IMPRIMIR/CADASTRO/MOVIMENTA do legado): o gate fica num funil unico
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *==========================================================================
    * OptResultadoInteractiveChange - Optiongroup1.InteractiveChange do legado:
    *   result.ActivePage = this.Value  +  result.Refresh()
    * O Value do grupo eh 1..10 e, com as abas declaradas em ordem de
    * PageOrder, cai direto na aba correspondente. Value = 0 (nenhuma opcao
    * marcada, estado inicial do legado) nao troca de aba.
    *==========================================================================
    PROCEDURE OptResultadoInteractiveChange()
        LOCAL loc_oPg, loc_nOpcao, loc_oErro

        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page2
            loc_nOpcao = loc_oPg.obj_4c_OptResultado.Value

            IF BETWEEN(loc_nOpcao, 1, loc_oPg.pgf_4c_Resultado.PageCount)
                loc_oPg.pgf_4c_Resultado.ActivePage = loc_nOpcao
                loc_oPg.pgf_4c_Resultado.Refresh()

                *-- Repintura da aba que acabou de ficar a vista
                THIS.AtualizarAbaResultadoAtiva()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao trocar de aba")
        ENDTRY
    ENDPROC

    *==========================================================================
    * DtPeriodoLostFocus - Recarrega a consulta quando o periodo muda
    * (get_dt_final.LostFocus do legado: ConsultaExecutada = .f. + Processa()).
    * Nao faz nada enquanto a pagina Resultado nao estiver em uso, para nao
    * disparar consulta so por passar o foco pelos campos.
    *==========================================================================
    PROCEDURE DtPeriodoLostFocus()
        IF THIS.this_cModoAtual == "RESULTADO"
            THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
            THIS.CarregarDados()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnMudaCliClick - cmd_cadastro.Click do Cmd_MudaCli legado: troca a
    * pagina Resultado para a visao CADASTRO.
    *==========================================================================
    PROCEDURE BtnMudaCliClick()
        THIS.this_oBusinessObject.this_cEscolha = "ALTERAR"
        THIS.AjustarVisibilidadeResultado("CADASTRO")
    ENDPROC

    *==========================================================================
    * BtnMudaMovClick - cmd_movimenta.Click do Cmd_MudaMov legado: troca a
    * pagina Resultado para a visao MOVIMENTO.
    *==========================================================================
    PROCEDURE BtnMudaMovClick()
        THIS.this_oBusinessObject.this_cEscolha = "CONSULTAR"
        THIS.AjustarVisibilidadeResultado("MOVIMENTO")
        THIS.AtualizarGradesSaldo()
    ENDPROC

    *==========================================================================
    * BtnVoltarClick - cmd_voltar.Click do grp_operacao da pagina Resultado.
    * Com Automatico = .T. (tela aberta por outro form apenas para mostrar uma
    * conta) o legado FECHA e devolve o controle ao chamador; caso contrario
    * volta para a pagina Consulta, que eh o que o funil AlternarPagina(1) faz
    * (limpa os campos, encolhe a tela e devolve o foco ao campo Conta).
    *==========================================================================
    PROCEDURE BtnVoltarClick()
        *-- Bloco de gravacao que abre o cmd_voltar.Click legado: em modo
        *-- ALTERAR pergunta e grava o cadastro antes de sair, e mValidaObj()
        *-- recusando mantem a tela aberta (o "Return .f." do legado)
        IF !THIS.BtnSalvarClick()
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.this_lAutomatico
            THIS.BtnEncerrarClick()
        ELSE
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Funil dos CAMPOS DE DADOS da pagina Resultado,
    * isto eh, o conteudo de cada aba do PageFrame interno (Result do legado).
    *
    * A Fase 4 entregou a moldura (as 10 abas, o OptionGroup de navegacao, o
    * filtro de periodo e a barra Cadastro/Movimento/Voltar) mais o conteudo da
    * aba 1 (Saldo). Esta fase acrescenta o conteudo das abas alimentadas pelo
    * Processa()/PCartao()/PEstoque() do legado:
    *
    *   aba 2 Pendencias  - grade TmpPar + grade de formas de pagamento
    *                       (crTmpTipos, com CheckBox marcavel) + total
    *   aba 3 Cheques     - quatro grades (aberto / follow-up / titulos /
    *                       devolvidos) + os nove totais do pe da pagina
    *   aba 4 Cartao      - grade TmpCart (cartoes em aberto)
    *   aba 6 Estoque     - grade dbEstoque (produtos em poder do cliente)
    *
    * As abas 5 (Vendas), 7 (Operacoes Pend.), 8 (Producao), 9 (Historico
    * de Cheques) e 10 (Credito) sao alimentadas por PProduto()/PVenda()/
    * mAtivaHCheque()/mAtivaCredito() do legado - os quatro compartilham o mesmo
    * bloco de cursores (dbProduto/dbProdTodos/dbOperac/dbConserto/dbOpera/
    * dbProduc/dbItens) e por isso formam uma unidade, entregue na fase
    * seguinte junto com o wrapper clsconta e o bloco de impressao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarAbaPendencias()
        THIS.ConfigurarAbaCheques()
        THIS.ConfigurarAbaCartao()
        THIS.ConfigurarAbaEstoque()
        THIS.ConfigurarAbaHCheques()
        THIS.ConfigurarAbaCredito()
    ENDPROC

    *==========================================================================
    * ConfigurarAbaPendencias - Aba 2 (Result.Pendencias do legado):
    *
    *   Grd_Pendente -> grd_4c_Pendentes  (TmpPar, 6 colunas)
    *   grdTipos     -> grd_4c_TiposPend  (crTmpTipos, CheckBox marcavel)
    *   Cmb_Grupo    -> cbo_4c_GrupoPend  (filtro de grupo)
    *   getTotPends  -> txt_4c_TotPend    (total do que esta visivel na grade)
    *   Anexa        -> cmd_4c_AnexaPend  (abre o documento da pendencia)
    *   CmdImpPend   -> cmd_4c_ImpPend    (listagem SigReIpd)
    *
    * As colunas sao declaradas na ordem de ColumnOrder do dump (vencto, O,
    * valor, moeda, tipo, historico), que eh a ordem em que o legado as mostra.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaPendencias()
        LOCAL loc_oPg, loc_oGrid
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2

        loc_oPg.AddObject("shp_4c_Pendencias", "Shape")
        WITH loc_oPg.shp_4c_Pendencias
            .Top         = 42
            .Left        = 18
            .Width       = 735
            .Height      = 413
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_GrupoPend", "Label")
        WITH loc_oPg.lbl_4c_GrupoPend
            .Top       = 53
            .Left      = 42
            .Width     = 41
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo : "
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cbo_4c_GrupoPend", "ComboBox")
        WITH loc_oPg.cbo_4c_GrupoPend
            .Top           = 49
            .Left          = 85
            .Width         = 300
            .Height        = 24
            .Style         = 2
            .RowSourceType = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_FormaPagto", "Label")
        WITH loc_oPg.lbl_4c_FormaPagto
            .Top       = 41
            .Left      = 813
            .Width     = 70
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Forma Pagto:"
            .Visible   = .T.
        ENDWITH

        *-- Grade das pendencias (TmpPar)
        loc_oPg.AddObject("grd_4c_Pendentes", "Grid")
        loc_oGrid = loc_oPg.grd_4c_Pendentes
        WITH loc_oGrid
            .Top               = 77
            .Left              = 22
            .Width             = 725
            .Height            = 346
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .T.
            .ScrollBars        = 2
            .RecordSource      = "TmpPar"
            .ColumnCount       = 6
            .Themes            = .F.
            .Visible           = .T.

            *-- ColumnOrder 1 - vencimento (o legado nao sobrepoe a largura)
            .Columns(1).ControlSource   = "TmpPar.vencs"
            .Columns(1).Header1.Caption = "Vecto"
            .Columns(1).Movable         = .F.
            .Columns(1).Resizable       = .F.
            .Columns(1).ReadOnly        = .T.

            *-- ColumnOrder 2 - natureza do lancamento (sem cabecalho no legado)
            .Columns(2).ControlSource   = "TmpPar.Opers"
            .Columns(2).Header1.Caption = ""
            .Columns(2).Width           = 19
            .Columns(2).Movable         = .F.
            .Columns(2).Resizable       = .F.
            .Columns(2).ReadOnly        = .T.

            .Columns(3).ControlSource   = "TmpPar.Valos"
            .Columns(3).Header1.Caption = "Valor"
            .Columns(3).Width           = 77
            .Columns(3).Movable         = .F.
            .Columns(3).Resizable       = .F.
            .Columns(3).ReadOnly        = .T.

            .Columns(4).ControlSource   = "TmpPar.Moefpgs"
            .Columns(4).Header1.Caption = "Moe"
            .Columns(4).Width           = 30
            .Columns(4).Movable         = .F.
            .Columns(4).Resizable       = .F.
            .Columns(4).ReadOnly        = .T.

            .Columns(5).ControlSource   = "TmpPar.FPags"
            .Columns(5).Header1.Caption = "Tipo"
            .Columns(5).Width           = 100
            .Columns(5).Movable         = .F.
            .Columns(5).Resizable       = .F.
            .Columns(5).ReadOnly        = .T.

            .Columns(6).ControlSource   = "TmpPar.Hists"
            .Columns(6).Header1.Caption = "Hist" + CHR(243) + "rico"
            .Columns(6).Width           = 360
            .Columns(6).Movable         = .F.
            .Columns(6).Resizable       = .F.
            .Columns(6).ReadOnly        = .T.
        ENDWITH

        *-- Grade das formas de pagamento marcaveis (crTmpTipos). A coluna 1 eh
        *-- um CheckBox de verdade: Column.AddObject sozinho NAO exibe o
        *-- controle - precisa de CurrentControl, e de Sparse = .F. para
        *-- aparecer em TODAS as linhas (regra #18)
        loc_oPg.AddObject("grd_4c_TiposPend", "Grid")
        loc_oGrid = loc_oPg.grd_4c_TiposPend
        WITH loc_oGrid
            .Top               = 59
            .Left              = 812
            .Width             = 133
            .Height            = 105
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            .ReadOnly          = .F.
            .RecordSource      = "crTmpTipos"
            .ColumnCount       = 2
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH

        loc_oGrid.Columns(1).AddObject("chk_4c_TipoPend", "CheckBox")
        WITH loc_oGrid.Columns(1).chk_4c_TipoPend
            .Top       = 9
            .Left      = 2
            .Width     = 22
            .Height    = 17
            .FontName  = "Arial"
            .FontSize  = 8
            .Alignment = 0
            .Caption   = ""
            .ReadOnly  = .F.
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        WITH loc_oGrid
            .Columns(1).CurrentControl   = "chk_4c_TipoPend"
            .Columns(1).Sparse           = .F.
            .Columns(1).ControlSource    = "crTmpTipos.Listas"
            .Columns(1).Header1.Caption  = ""
            .Columns(1).Width            = 15
            .Columns(1).Movable          = .F.
            .Columns(1).Resizable        = .F.
            *-- Column.ReadOnly DEPOIS do Grid.ReadOnly (o do grid propaga)
            .Columns(1).ReadOnly         = .F.

            .Columns(2).ControlSource    = "crTmpTipos.fPags"
            .Columns(2).Header1.Caption  = "Tipos"
            .Columns(2).Width            = 95
            .Columns(2).FontName         = "Arial"
            .Columns(2).FontSize         = 8
            .Columns(2).Movable          = .F.
            .Columns(2).Resizable        = .F.
            .Columns(2).ReadOnly         = .T.
        ENDWITH

        *-- CheckBox de grade nao alterna pelo binding nativo: os quatro
        *-- handlers (Click/MouseDown suprimem o toggle padrao, MouseUp e
        *-- KeyPress alternam por codigo) sao obrigatorios
        BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "Click", ;
            THIS, "ChkTipoPendClick")
        BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "MouseDown", ;
            THIS, "ChkTipoPendMouseDown")
        BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "MouseUp", ;
            THIS, "ChkTipoPendMouseUp")
        BINDEVENT(loc_oGrid.Columns(1).chk_4c_TipoPend, "KeyPress", ;
            THIS, "ChkTipoPendKeyPress")

        *-- Total das pendencias visiveis (getTotPends)
        loc_oPg.AddObject("txt_4c_TotPend", "TextBox")
        WITH loc_oPg.txt_4c_TotPend
            .Top           = 427
            .Left          = 56
            .Width         = 150
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0
            .InputMask     = "999,999,999.99"
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Botao "Documento" (Anexa). Icone-only (Caption = ""): Picture +
        *-- DisabledPicture + Themes = .T. para o icone desenhar sempre, e o
        *-- botao NUNCA eh desabilitado em runtime - a condicao que o legado
        *-- usava para habilitar/desabilitar vive dentro do proprio handler.
        loc_oPg.AddObject("cmd_4c_AnexaPend", "CommandButton")
        WITH loc_oPg.cmd_4c_AnexaPend
            .Top             = 180
            .Left            = 835
            .Width           = 40
            .Height          = 40
            .FontName        = "Verdana"
            .FontSize        = 8
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
            .ToolTipText     = "Documento"
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH

        loc_oPg.AddObject("cmd_4c_ImpPend", "CommandButton")
        WITH loc_oPg.cmd_4c_ImpPend
            .Top             = 180
            .Left            = 875
            .Width           = 40
            .Height          = 40
            .FontName        = "Verdana"
            .FontSize        = 8
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_32.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_32.jpg"
            .ToolTipText     = "Listagem"
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg.cbo_4c_GrupoPend, "InteractiveChange", ;
            THIS, "CboGrupoPendInteractiveChange")
        BINDEVENT(loc_oPg.cmd_4c_AnexaPend, "Click", THIS, "BtnAnexaPendClick")
        BINDEVENT(loc_oPg.cmd_4c_ImpPend,   "Click", THIS, "BtnImpPendClick")
    ENDPROC

    *==========================================================================
    * ConfigurarAbaCheques - Aba 3 (Result.Cheque do legado). Tem quatro grades
    * e doze campos somente-leitura:
    *
    *   grd_che_aberto    -> grd_4c_ChequeAberto    (dbAberto)
    *   Grd_followup      -> grd_4c_ChequeFollowup  (DbFollow)
    *   Grd_titulo        -> grd_4c_ChequeTitulo    (DbTitulo)
    *   grd_che_devolvido -> grd_4c_ChequeDevolvido (dbDevolvido)
    *
    * Os Shapes sao as molduras dos quatro blocos (BackStyle = 0, so a borda) e
    * os dois quadradinhos de 14x14 sao a LEGENDA de cor da grade de cheques em
    * aberto: verde-claro = tem follow-up, vermelho = devolvido.
    *
    * Os campos de total sao somente-leitura no legado (When devolvendo .F.) -
    * aqui vao com ReadOnly = .T., que eh o equivalente sem BINDEVENT em "When".
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaCheques()
        LOCAL loc_oPg, loc_oGrid
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3

        *-- Molduras dos quatro blocos
        THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_ChequeAberto",      61,   8, 479, 129)
        THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_ChequeFollowup",    61, 494, 482, 129)
        THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_ChequeTitulo",     203,   8, 479, 108)
        THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_ChequeDevolvido",  203, 494, 393, 108)
        THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_HistDevolvido",    231, 888, 110,  45)
        THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_ContasReceber",    325, 493, 471, 119)
        THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_ObsNegociados",    325,   8, 479,  67)

        *-- Legenda de cor da grade de cheques em aberto
        loc_oPg.AddObject("shp_4c_LegendaDevolvido", "Shape")
        WITH loc_oPg.shp_4c_LegendaDevolvido
            .Top           = 65
            .Left          = 295
            .Width         = 14
            .Height        = 14
            .BackStyle     = 1
            .SpecialEffect = 0
            .BackColor     = RGB(255, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("shp_4c_LegendaFollowup", "Shape")
        WITH loc_oPg.shp_4c_LegendaFollowup
            .Top           = 65
            .Left          = 196
            .Width         = 14
            .Height        = 14
            .BackStyle     = 1
            .SpecialEffect = 0
            .BackColor     = RGB(220, 255, 220)
            .Visible       = .T.
        ENDWITH

        *-- Rotulos
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_GrupoCheque",  36,  16,  41, 15, "Grupo : ")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChequeAberto", 65,  11,  97, 15, ;
            "Cheques em Aberto")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChequeFollow", 65, 499, 100, 15, ;
            "FollowUp do Cheque")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_LegFollowup",  64, 211,  69, 15, ;
            "Com FollowUp")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_LegDevolvido", 64, 310,  49, 15, ;
            "Devolvido")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChequeTitulo", 204, 13, 148, 15, ;
            "Cheques Negociados ( titulos )")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChequeDevolv", 206, 499, 158, 15, ;
            "Hist" + CHR(243) + "rico de Cheques Devolvidos")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_HistChqDev",  234, 891, 75, 15, ;
            "Hist. Chq Dev -")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_MoedaHist",   234, 981, 15, 15, "R$")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ContasRec",   329, 508, 98, 15, ;
            "Contas a Receber - ")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_MoedaConta",  328, 608, 15, 15, "R$")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ObsNegoc",    327,  11, 109, 15, ;
            "Obs. Chq. Negociados")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_LimiteCred",  349, 520, 89, 15, ;
            "Limite de Cr" + CHR(233) + "dito :")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChqAVencer",  371, 531, 78, 15, ;
            "Chqs " + CHR(224) + " Vencer :")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChqVencidos", 393, 531, 78, 15, ;
            "Chqs Vencidos :")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChqDevolv",   417, 521, 88, 15, ;
            "Chqs Devolvidos :")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_SaldoCC",     371, 783, 56, 15, ;
            "Saldo C/C :")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_ChqNegoc",    351, 748, 91, 15, ;
            "Chqs Negociados :")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_VlEstoque",   393, 750, 89, 15, ;
            "Valor em Estoque:")
        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_LimiteDisp",  416, 752, 87, 15, ;
            "Limite Dispon" + CHR(237) + "vel :")

        *-- Filtro de grupo
        loc_oPg.AddObject("cbo_4c_GrupoCheque", "ComboBox")
        WITH loc_oPg.cbo_4c_GrupoCheque
            .Top           = 32
            .Left          = 59
            .Width         = 188
            .Height        = 24
            .Style         = 2
            .RowSourceType = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        *-- Cheques em aberto (dbAberto)
        loc_oPg.AddObject("grd_4c_ChequeAberto", "Grid")
        loc_oGrid = loc_oPg.grd_4c_ChequeAberto
        WITH loc_oGrid
            .Top          = 79
            .Left         = 11
            .Width        = 471
            .Height       = 86
            .FontName     = "Courier New"
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .ReadOnly     = .T.
            .Highlight    = .T.
            .HighlightRow = .T.
            .RowHeight    = 16
            .ScrollBars   = 2
            .RecordSource = "dbAberto"
            .ColumnCount  = 6
            .Themes       = .F.
            .Visible      = .T.

            .Columns(1).ControlSource   = "dbAberto.vencs"
            .Columns(1).Header1.Caption = "Vencimento"
            .Columns(1).Width           = 80
            .Columns(1).ReadOnly        = .T.

            .Columns(2).ControlSource   = "dbAberto.bancos"
            .Columns(2).Header1.Caption = "Bco."
            .Columns(2).Width           = 38
            .Columns(2).Alignment       = 1
            .Columns(2).ReadOnly        = .T.

            .Columns(3).ControlSource   = "dbAberto.agencias"
            .Columns(3).Header1.Caption = "Ag."
            .Columns(3).Width           = 45
            .Columns(3).Alignment       = 1
            .Columns(3).ReadOnly        = .T.

            .Columns(4).ControlSource   = "dbAberto.ncontas"
            .Columns(4).Header1.Caption = "Conta"
            .Columns(4).Width           = 100
            .Columns(4).ReadOnly        = .T.

            .Columns(5).ControlSource   = "dbAberto.ncheques"
            .Columns(5).Header1.Caption = "Cheque"
            .Columns(5).Width           = 65
            .Columns(5).Alignment       = 1
            .Columns(5).ReadOnly        = .T.

            .Columns(6).ControlSource   = "dbAberto.valors"
            .Columns(6).Header1.Caption = "Valor"
            .Columns(6).Width           = 115
            .Columns(6).ReadOnly        = .T.
        ENDWITH

        *-- Follow-up do cheque corrente (DbFollow)
        loc_oPg.AddObject("grd_4c_ChequeFollowup", "Grid")
        loc_oGrid = loc_oPg.grd_4c_ChequeFollowup
        WITH loc_oGrid
            .Top          = 79
            .Left         = 499
            .Width        = 471
            .Height       = 86
            .FontName     = "Courier New"
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .ReadOnly     = .T.
            .Highlight    = .T.
            .HighlightRow = .T.
            .RowHeight    = 16
            .ScrollBars   = 2
            .RecordSource = "DbFollow"
            .ColumnCount  = 2
            .Themes       = .F.
            .Visible      = .T.

            .Columns(1).ControlSource   = "DbFollow.Datas"
            .Columns(1).Header1.Caption = "Data"
            .Columns(1).Width           = 78
            .Columns(1).ReadOnly        = .T.

            .Columns(2).ControlSource   = "DbFollow.Hists"
            .Columns(2).Header1.Caption = "Hist" + CHR(243) + "rico"
            .Columns(2).Width           = 370
            .Columns(2).ReadOnly        = .T.
        ENDWITH

        *-- Cheques negociados / titulos (DbTitulo)
        loc_oPg.AddObject("grd_4c_ChequeTitulo", "Grid")
        loc_oGrid = loc_oPg.grd_4c_ChequeTitulo
        WITH loc_oGrid
            .Top          = 219
            .Left         = 11
            .Width        = 471
            .Height       = 86
            .FontName     = "Courier New"
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .ReadOnly     = .T.
            .Highlight    = .T.
            .HighlightRow = .T.
            .RowHeight    = 16
            .ScrollBars   = 2
            .RecordSource = "DbTitulo"
            .ColumnCount  = 6
            .Themes       = .F.
            .Visible      = .T.

            .Columns(1).ControlSource   = "DbTitulo.Titulos"
            .Columns(1).Header1.Caption = "Titulo"
            .Columns(1).Width           = 80
            .Columns(1).ReadOnly        = .T.

            .Columns(2).ControlSource   = "DbTitulo.Vencs"
            .Columns(2).Header1.Caption = "Vencto"
            .Columns(2).Width           = 80
            .Columns(2).ReadOnly        = .T.

            .Columns(3).ControlSource   = "DbTitulo.Valors"
            .Columns(3).Header1.Caption = "Valor"
            .Columns(3).Width           = 85
            .Columns(3).ReadOnly        = .T.

            .Columns(4).ControlSource   = "DbTitulo.ValPags"
            .Columns(4).Header1.Caption = "V.Pago"
            .Columns(4).Width           = 85
            .Columns(4).ReadOnly        = .T.

            .Columns(5).ControlSource   = "DbTitulo.Saldos"
            .Columns(5).Header1.Caption = "Saldo"
            .Columns(5).Width           = 80
            .Columns(5).ReadOnly        = .T.

            .Columns(6).ControlSource   = "DbTitulo.Moedas"
            .Columns(6).Header1.Caption = "Moe"
            .Columns(6).Width           = 28
            .Columns(6).ReadOnly        = .T.
        ENDWITH

        *-- Historico de cheques devolvidos (dbDevolvido)
        loc_oPg.AddObject("grd_4c_ChequeDevolvido", "Grid")
        loc_oGrid = loc_oPg.grd_4c_ChequeDevolvido
        WITH loc_oGrid
            .Top          = 220
            .Left         = 499
            .Width        = 386
            .Height       = 86
            .FontName     = "Courier New"
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .ReadOnly     = .T.
            .Highlight    = .T.
            .HighlightRow = .T.
            .RowHeight    = 16
            .ScrollBars   = 2
            .RecordSource = "dbDevolvido"
            .ColumnCount  = 6
            .Themes       = .F.
            .Visible      = .T.

            .Columns(1).ControlSource   = "dbDevolvido.vencs"
            .Columns(1).Header1.Caption = "Vencimento"
            .Columns(1).Width           = 80
            .Columns(1).ReadOnly        = .T.

            .Columns(2).ControlSource   = "dbDevolvido.bancos"
            .Columns(2).Header1.Caption = "Bco."
            .Columns(2).Width           = 31
            .Columns(2).Alignment       = 1
            .Columns(2).ReadOnly        = .T.

            .Columns(3).ControlSource   = "dbDevolvido.agencias"
            .Columns(3).Header1.Caption = "Ag."
            .Columns(3).Width           = 38
            .Columns(3).Alignment       = 1
            .Columns(3).ReadOnly        = .T.

            .Columns(4).ControlSource   = "dbDevolvido.ncontas"
            .Columns(4).Header1.Caption = "Conta"
            .Columns(4).Width           = 80
            .Columns(4).ReadOnly        = .T.

            .Columns(5).ControlSource   = "dbDevolvido.ncheques"
            .Columns(5).Header1.Caption = "Cheque"
            .Columns(5).Width           = 52
            .Columns(5).Alignment       = 1
            .Columns(5).ReadOnly        = .T.

            .Columns(6).ControlSource   = "dbDevolvido.valors"
            .Columns(6).Header1.Caption = "Valor"
            .Columns(6).Width           = 80
            .Columns(6).ReadOnly        = .T.
        ENDWITH

        *-- Campos somente-leitura: total da grade de aberto, historico de
        *-- devolvidos, observacao dos negociados e os oito totais do pe
        THIS.AdicionarTotalAba(loc_oPg, "txt_4c_TotChequeAberto", 164, 344, 117, 23, .T.)
        THIS.AdicionarTotalAba(loc_oPg, "txt_4c_TotDevolvido",    247, 890, 104, 24, .T.)
        THIS.AdicionarTotalAba(loc_oPg, "txt_4c_ObsNegoc1",       341,  11, 471, 23, .F.)
        THIS.AdicionarTotalAba(loc_oPg, "txt_4c_ObsNegoc2",       364,  11, 471, 23, .F.)
        THIS.AdicionarTotalAba(loc_oPg, "txt_4c_LimiteCred",      345, 611, 115, 23, .T.)
        THIS.AdicionarTotalAba(loc_oPg, "txt_4c_ChqAVencer",      367, 611, 115, 23, .T.)
        THIS.AdicionarTotalAba(loc_oPg, "txt_4c_ChqVencidos",     389, 611, 115, 23, .T.)
        THIS.AdicionarTotalAba(loc_oPg, "txt_4c_ChqDevolv",       411, 611, 115, 23, .T.)
        THIS.AdicionarTotalAba(loc_oPg, "txt_4c_ChqNegoc",        345, 841, 115, 23, .T.)
        THIS.AdicionarTotalAba(loc_oPg, "txt_4c_SaldoCC",         367, 841, 115, 23, .T.)
        THIS.AdicionarTotalAba(loc_oPg, "txt_4c_VlEstoque",       390, 841, 115, 23, .T.)
        THIS.AdicionarTotalAba(loc_oPg, "txt_4c_LimiteDisp",      413, 841, 115, 23, .T.)

        BINDEVENT(loc_oPg.cbo_4c_GrupoCheque, "InteractiveChange", ;
            THIS, "CboGrupoChequeInteractiveChange")
        BINDEVENT(loc_oPg.grd_4c_ChequeAberto, "AfterRowColChange", ;
            THIS, "GradeChequeAbertoAfterRowColChange")
        BINDEVENT(loc_oPg.grd_4c_ChequeTitulo, "AfterRowColChange", ;
            THIS, "GradeChequeTituloAfterRowColChange")
    ENDPROC

    *==========================================================================
    * ConfigurarAbaCartao - Aba 4 (Result.Cartao do legado): moldura, rotulo e
    * a grade dos cartoes de credito em aberto (TmpCart, 6 colunas na ordem de
    * ColumnOrder do dump).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaCartao()
        LOCAL loc_oPg, loc_oGrid
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page4

        THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_CartaoAberto", 56, 132, 735, 274)

        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_CartaoAberto", 57, 139, 93, 15, ;
            "Cart" + CHR(245) + "es em Aberto")

        loc_oPg.AddObject("grd_4c_Cartao", "Grid")
        loc_oGrid = loc_oPg.grd_4c_Cartao
        WITH loc_oGrid
            .Top          = 72
            .Left         = 137
            .Width        = 725
            .Height       = 254
            .FontName     = "Courier New"
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .ReadOnly     = .T.
            .Highlight    = .T.
            .HighlightRow = .T.
            .ScrollBars   = 2
            .RecordSource = "TmpCart"
            .ColumnCount  = 6
            .Themes       = .F.
            .Visible      = .T.

            .Columns(1).ControlSource   = "TmpCart.vencs"
            .Columns(1).Header1.Caption = "Vencimento"
            .Columns(1).Width           = 75
            .Columns(1).Alignment       = 0
            .Columns(1).ReadOnly        = .T.

            .Columns(2).ControlSource   = "TmpCart.fpags"
            .Columns(2).Header1.Caption = "Cart" + CHR(227) + "o"
            .Columns(2).Width           = 100
            .Columns(2).Alignment       = 0
            .Columns(2).ReadOnly        = .T.

            .Columns(3).ControlSource   = "TmpCart.nocreditos"
            .Columns(3).Header1.Caption = "Cr" + CHR(233) + "dito"
            .Columns(3).Width           = 80
            .Columns(3).Alignment       = 0
            .Columns(3).ReadOnly        = .T.

            .Columns(4).ControlSource   = "TmpCart.cartaos"
            .Columns(4).Header1.Caption = "N" + CHR(186) + " Cart" + CHR(227) + "o"
            .Columns(4).Width           = 120
            .Columns(4).Alignment       = 0
            .Columns(4).ReadOnly        = .T.

            .Columns(5).ControlSource   = "TmpCart.valos"
            .Columns(5).Header1.Caption = "Valor"
            .Columns(5).Width           = 110
            .Columns(5).Alignment       = 3
            .Columns(5).ReadOnly        = .T.

            .Columns(6).ControlSource   = "TmpCart.datas"
            .Columns(6).Header1.Caption = "Data"
            .Columns(6).Width           = 75
            .Columns(6).Alignment       = 0
            .Columns(6).ReadOnly        = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAbaEstoque - Aba 6 (Result.Estoque do legado): moldura, filtro
    * de grupo e a grade dos produtos em poder do cliente (dbEstoque).
    *
    * A terceira coluna ("Operacao") fica SEM ControlSource de proposito: no
    * dump legado ela tem ControlSource = "" (literal vazio) porque dbEstoque
    * nao tem coluna de operacao - eh uma coluna reservada, que o legado
    * tambem mostra vazia.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaEstoque()
        LOCAL loc_oPg, loc_oGrid
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page6

        THIS.AdicionarMolduraAba(loc_oPg, "shp_4c_EstoqueProduto", 86, 303, 392, 361)

        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_GrupoEstoque", 60, 307, 41, 15, "Grupo : ")

        loc_oPg.AddObject("cbo_4c_GrupoEstoque", "ComboBox")
        WITH loc_oPg.cbo_4c_GrupoEstoque
            .Top           = 56
            .Left          = 350
            .Width         = 300
            .Height        = 24
            .Style         = 2
            .RowSourceType = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("grd_4c_Estoque", "Grid")
        loc_oGrid = loc_oPg.grd_4c_Estoque
        WITH loc_oGrid
            .Top          = 92
            .Left         = 308
            .Width        = 381
            .Height       = 347
            .FontName     = "Courier New"
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .ReadOnly     = .T.
            .Highlight    = .T.
            .HighlightRow = .T.
            .ScrollBars   = 2
            .RecordSource = "dbEstoque"
            .ColumnCount  = 3
            .Themes       = .F.
            .Visible      = .T.

            .Columns(1).ControlSource   = "dbEstoque.cpros"
            .Columns(1).Header1.Caption = "Produto"
            .Columns(1).Width           = 108
            .Columns(1).Alignment       = 3
            .Columns(1).ReadOnly        = .T.

            .Columns(2).ControlSource   = "dbEstoque.sqtds"
            .Columns(2).Header1.Caption = "Qtde."
            .Columns(2).Width           = 100
            .Columns(2).Alignment       = 3
            .Columns(2).InputMask       = "999,999,999.99"
            .Columns(2).ReadOnly        = .T.

            .Columns(3).Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            .Columns(3).Width           = 150
            .Columns(3).Alignment       = 3
            .Columns(3).ReadOnly        = .T.
        ENDWITH

        BINDEVENT(loc_oPg.cbo_4c_GrupoEstoque, "InteractiveChange", ;
            THIS, "CboGrupoEstoqueInteractiveChange")
    ENDPROC

    *==========================================================================
    * ConfigurarAbaHCheques - Aba 9 (Result.hcheques do legado - "H.Cheques"):
    * tres grades (GradeCheque/GradeMovimenta/GradeProrrog) e o follow-up da
    * linha corrente, transcritas de mativahcheque()/GradeCheque.
    * AfterRowColChange.
    *
    * Cnt_Descricao e Cnt_periodo existem no dump (ambos Visible = .F.) mas o
    * legado nunca os preenche nem os usa no filtro (regra documentada em
    * CarregarHCheques do BO) - ficam aqui so por fidelidade estrutural,
    * ocultos, sem BINDEVENT.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaHCheques()
        LOCAL loc_oPg, loc_oGrid
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page9

        *-- GradeCheque (dbCheqHist) - historico de cheques da conta
        loc_oPg.AddObject("grd_4c_HistCheque", "Grid")
        loc_oGrid = loc_oPg.grd_4c_HistCheque
        WITH loc_oGrid
            .Top          = 57
            .Left         = 152
            .Width        = 696
            .Height       = 124
            .FontName     = "Courier New"
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .ReadOnly     = .T.
            .Highlight    = .T.
            .HighlightRow = .T.
            .ScrollBars   = 2
            .RecordSource = "dbCheqHist"
            .ColumnCount  = 11
            .Themes       = .F.
            .Visible      = .T.

            .Columns(1).ControlSource   = "dbCheqHist.Vencs"
            .Columns(1).Header1.Caption = "Vencimento"
            .Columns(1).Width           = 75
            .Columns(1).ReadOnly        = .T.

            .Columns(2).ControlSource   = "dbCheqHist.Bancos"
            .Columns(2).Header1.Caption = "Banco"
            .Columns(2).Width           = 50
            .Columns(2).ReadOnly        = .T.

            .Columns(3).ControlSource   = "dbCheqHist.Agencias"
            .Columns(3).Header1.Caption = "Agencia"
            .Columns(3).Width           = 55
            .Columns(3).ReadOnly        = .T.

            .Columns(4).ControlSource   = "dbCheqHist.NContas"
            .Columns(4).Header1.Caption = "Conta"
            .Columns(4).Width           = 70
            .Columns(4).ReadOnly        = .T.

            .Columns(5).ControlSource   = "dbCheqHist.NCheques"
            .Columns(5).Header1.Caption = "N" + CHR(186) + "mero"
            .Columns(5).Width           = 60
            .Columns(5).ReadOnly        = .T.

            .Columns(6).ControlSource   = "dbCheqHist.Valors"
            .Columns(6).Header1.Caption = "Valor"
            .Columns(6).Width           = 75
            .Columns(6).Alignment       = 3
            .Columns(6).InputMask       = "999,999,999.99"
            .Columns(6).ReadOnly        = .T.

            .Columns(7).ControlSource   = "dbCheqHist.GruCarts"
            .Columns(7).Header1.Caption = "Grupo Carteira"
            .Columns(7).Width           = 70
            .Columns(7).ReadOnly        = .T.

            .Columns(8).ControlSource   = "dbCheqHist.ConCarts"
            .Columns(8).Header1.Caption = "Conta Carteira"
            .Columns(8).Width           = 70
            .Columns(8).ReadOnly        = .T.

            .Columns(9).ControlSource   = "dbCheqHist.Emps"
            .Columns(9).Header1.Caption = "Emp"
            .Columns(9).Width           = 40
            .Columns(9).ReadOnly        = .T.

            .Columns(10).ControlSource   = "dbCheqHist.Numeros"
            .Columns(10).Header1.Caption = "Arquivo"
            .Columns(10).Width           = 60
            .Columns(10).ReadOnly        = .T.

            .Columns(11).ControlSource   = "dbCheqHist.DiasP"
            .Columns(11).Header1.Caption = "Dias Pag."
            .Columns(11).Width           = 55
            .Columns(11).Alignment       = 3
            .Columns(11).ReadOnly        = .T.

            *-- SetAll('DynamicForeColor'/'DynamicBackColor', ...) do legado:
            *-- cheque com historico (SigCheh - Tipo nao vazio) fica azul sobre
            *-- fundo verde-claro.
            .SetAll("DynamicForeColor", ;
                "IIF(!EMPTY(dbCheqHist.Tipo), RGB(0,0,255), RGB(0,0,0))", "Column")
            .SetAll("DynamicBackColor", ;
                "IIF(!EMPTY(dbCheqHist.Tipo), RGB(220,255,220), RGB(255,255,255))", "Column")
        ENDWITH

        *-- GradeMovimenta (dbCheqMovim) - movimentacao do cheque selecionado
        loc_oPg.AddObject("grd_4c_MovCheque", "Grid")
        loc_oGrid = loc_oPg.grd_4c_MovCheque
        WITH loc_oGrid
            .Top          = 182
            .Left         = 152
            .Width        = 696
            .Height       = 90
            .FontName     = "Courier New"
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .ReadOnly     = .T.
            .Highlight    = .T.
            .HighlightRow = .T.
            .ScrollBars   = 2
            .RecordSource = "dbCheqMovim"
            .ColumnCount  = 9
            .Themes       = .F.
            .Visible      = .T.

            .Columns(1).ControlSource   = "dbCheqMovim.Codigos"
            .Columns(1).Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            .Columns(1).Width           = 80
            .Columns(1).ReadOnly        = .T.

            .Columns(2).ControlSource   = "dbCheqMovim.Nalineas"
            .Columns(2).Header1.Caption = "Alinea"
            .Columns(2).Width           = 60
            .Columns(2).ReadOnly        = .T.

            .Columns(3).ControlSource   = "dbCheqMovim.Dtents"
            .Columns(3).Header1.Caption = "Entrada"
            .Columns(3).Width           = 80
            .Columns(3).ReadOnly        = .T.

            .Columns(4).ControlSource   = "dbCheqMovim.Gruorigs"
            .Columns(4).Header1.Caption = "Grupo/Origem"
            .Columns(4).Width           = 80
            .Columns(4).ReadOnly        = .T.

            .Columns(5).ControlSource   = "dbCheqMovim.Conorigs"
            .Columns(5).Header1.Caption = "Conta/Origem"
            .Columns(5).Width           = 80
            .Columns(5).ReadOnly        = .T.

            .Columns(6).ControlSource   = "dbCheqMovim.Grupos"
            .Columns(6).Header1.Caption = "Grupo/Destino"
            .Columns(6).Width           = 80
            .Columns(6).ReadOnly        = .T.

            .Columns(7).ControlSource   = "dbCheqMovim.Contas"
            .Columns(7).Header1.Caption = "Conta/Destino"
            .Columns(7).Width           = 80
            .Columns(7).ReadOnly        = .T.

            .Columns(8).ControlSource   = "dbCheqMovim.Numlotes"
            .Columns(8).Header1.Caption = "Lote"
            .Columns(8).Width           = 70
            .Columns(8).ReadOnly        = .T.

            .Columns(9).ControlSource   = "dbCheqMovim.Protocolos"
            .Columns(9).Header1.Caption = "Protocolo"
            .Columns(9).Width           = 86
            .Columns(9).ReadOnly        = .T.
        ENDWITH

        *-- GradeProrrog (dbCheqProrrog) - prorrogacoes do cheque selecionado
        loc_oPg.AddObject("grd_4c_ProrrogCheque", "Grid")
        loc_oGrid = loc_oPg.grd_4c_ProrrogCheque
        WITH loc_oGrid
            .Top          = 273
            .Left         = 735
            .Width        = 113
            .Height       = 84
            .FontName     = "Courier New"
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .ReadOnly     = .T.
            .Highlight    = .T.
            .HighlightRow = .T.
            .ScrollBars   = 2
            .RecordSource = "dbCheqProrrog"
            .ColumnCount  = 1
            .Themes       = .F.
            .Visible      = .T.

            .Columns(1).ControlSource   = "dbCheqProrrog.Vencs"
            .Columns(1).Header1.Caption = "Prorroga" + CHR(231) + CHR(245) + "es"
            .Columns(1).Width           = 108
            .Columns(1).ReadOnly        = .T.
        ENDWITH

        *-- Follow-up da linha corrente (Cnt_Followup.UltFollowup)
        loc_oPg.AddObject("cnt_4c_Followup", "Container")
        WITH loc_oPg.cnt_4c_Followup
            .Top       = 273
            .Left      = 151
            .Width     = 561
            .Height    = 43
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_Followup, "lbl_4c_Followup", 1, 8, 54, 15, "Follow_up:")
        loc_oPg.cnt_4c_Followup.AddObject("txt_4c_UltFollowup", "TextBox")
        WITH loc_oPg.cnt_4c_Followup.txt_4c_UltFollowup
            .Top           = 19
            .Left          = 5
            .Width         = 550
            .Height        = 20
            .Value         = ""
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Cnt_Descricao / Cnt_periodo - presentes no SCX, ocultos e nunca
        *-- escritos pelo legado (ver comentario de CarregarHCheques no BO);
        *-- ficam so por fidelidade estrutural, sem BINDEVENT.
        loc_oPg.AddObject("cnt_4c_DescricaoCheque", "Container")
        WITH loc_oPg.cnt_4c_DescricaoCheque
            .Top       = 319
            .Left      = 151
            .Width     = 457
            .Height    = 46
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH
        THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_DescricaoCheque, "lbl_4c_Origem", 4, 9, 46, 15, "Origem :")
        THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_DescricaoCheque, "lbl_4c_Destino", 24, 7, 48, 15, "Destino :")
        loc_oPg.cnt_4c_DescricaoCheque.AddObject("txt_4c_DescOrigem", "TextBox")
        WITH loc_oPg.cnt_4c_DescricaoCheque.txt_4c_DescOrigem
            .Top     = 3
            .Left    = 57
            .Width   = 386
            .Height  = 20
            .Value   = ""
            .Visible = .T.
        ENDWITH
        loc_oPg.cnt_4c_DescricaoCheque.AddObject("txt_4c_DescDestino", "TextBox")
        WITH loc_oPg.cnt_4c_DescricaoCheque.txt_4c_DescDestino
            .Top     = 22
            .Left    = 57
            .Width   = 386
            .Height  = 20
            .Value   = ""
            .Visible = .T.
        ENDWITH

        loc_oPg.AddObject("cnt_4c_PeriodoCheque", "Container")
        WITH loc_oPg.cnt_4c_PeriodoCheque
            .Top       = 368
            .Left      = 151
            .Width     = 280
            .Height    = 36
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH
        THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_PeriodoCheque, "lbl_4c_PeriodoCheque", 10, 26, 67, 15, "Vencimento : ")
        THIS.AdicionarRotuloAba(loc_oPg.cnt_4c_PeriodoCheque, "lbl_4c_PeriodoChequeA", 10, 180, 8, 15, "a")
        loc_oPg.cnt_4c_PeriodoCheque.AddObject("txt_4c_PeriodoCheqIni", "TextBox")
        WITH loc_oPg.cnt_4c_PeriodoCheque.txt_4c_PeriodoCheqIni
            .Top     = 6
            .Left    = 95
            .Width   = 80
            .Height  = 21
            .Value   = {}
            .Visible = .T.
        ENDWITH
        loc_oPg.cnt_4c_PeriodoCheque.AddObject("txt_4c_PeriodoCheqFim", "TextBox")
        WITH loc_oPg.cnt_4c_PeriodoCheque.txt_4c_PeriodoCheqFim
            .Top     = 6
            .Left    = 192
            .Width   = 80
            .Height  = 21
            .Value   = {}
            .Visible = .T.
        ENDWITH

        BINDEVENT(loc_oPg.grd_4c_HistCheque, "AfterRowColChange", ;
            THIS, "GradeHistChequeAfterRowColChange")
    ENDPROC

    *==========================================================================
    * ConfigurarAbaCredito - Aba 10 (Result.Credito do legado): PageFrame
    * PgCredito com a pagina Consultas (Cnt_banco/Cnt_Valor/Grade/Cnt_Docs) e
    * o rotulo de situacao (Label2), transcritos de mativacredito().
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaCredito()
        LOCAL loc_oPg, loc_oCns, loc_oGrid
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page10

        THIS.AdicionarRotuloAba(loc_oPg, "lbl_4c_SituacaoCredito", 53, 3, 996, 47, "CLIENTE")
        loc_oPg.lbl_4c_SituacaoCredito.FontName = "Tahoma"
        loc_oPg.lbl_4c_SituacaoCredito.FontSize = 10
        loc_oPg.lbl_4c_SituacaoCredito.FontBold = .T.
        loc_oPg.lbl_4c_SituacaoCredito.ForeColor = RGB(0, 0, 255)

        loc_oPg.AddObject("pgf_4c_Credito", "PageFrame")
        WITH loc_oPg.pgf_4c_Credito
            .Top       = 96
            .Left      = 0
            .Width     = 1003
            .Height    = 408
            .PageCount = 1
            .Tabs      = .F.
            .Themes    = .F.
            .Visible   = .T.
            .Page1.Caption = "Consultas"
        ENDWITH
        loc_oCns = loc_oPg.pgf_4c_Credito.Page1

        *-- Cnt_banco
        loc_oCns.AddObject("cnt_4c_CreditoBanco", "Container")
        WITH loc_oCns.cnt_4c_CreditoBanco
            .Top       = 273
            .Left      = 170
            .Width     = 479
            .Height    = 40
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Bco",   1, 6,   30, 15, "Bco")
        THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Age",   1, 43,  40, 15, "Ag" + CHR(234) + "ncia")
        THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Cta",   1, 95,  40, 15, "Conta")
        THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_NumI",  1, 173, 65, 15, "Num.Inicial")
        THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_NumF",  1, 265, 60, 15, "Num.Final")
        THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Serie", 1, 357, 40, 15, "S" + CHR(233) + "rie")
        THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_DtAb",  1, 408, 70, 15, "Dt Abertura")
        THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Dig1",  0, 238, 24, 17, "Dig.")
        THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoBanco, "lbl_4c_Dig2",  0, 327, 24, 17, "Dig.")

        WITH loc_oCns.cnt_4c_CreditoBanco
            .AddObject("txt_4c_CBancos", "TextBox")
            .txt_4c_CBancos.Top           = 13
            .txt_4c_CBancos.Left          = 3
            .txt_4c_CBancos.Width         = 36
            .txt_4c_CBancos.Height        = 23
            .txt_4c_CBancos.Value         = ""
            .txt_4c_CBancos.ControlSource = "dbCredito.Cbancos"
            .txt_4c_CBancos.Visible       = .T.

            .AddObject("txt_4c_CAgencias", "TextBox")
            .txt_4c_CAgencias.Top           = 13
            .txt_4c_CAgencias.Left          = 47
            .txt_4c_CAgencias.Width         = 38
            .txt_4c_CAgencias.Height        = 23
            .txt_4c_CAgencias.Value         = ""
            .txt_4c_CAgencias.ControlSource = "dbCredito.Cagencias"
            .txt_4c_CAgencias.Visible       = .T.

            .AddObject("txt_4c_CContas", "TextBox")
            .txt_4c_CContas.Top           = 13
            .txt_4c_CContas.Left          = 92
            .txt_4c_CContas.Width         = 80
            .txt_4c_CContas.Height        = 23
            .txt_4c_CContas.Value         = ""
            .txt_4c_CContas.ControlSource = "dbCredito.Ccontas"
            .txt_4c_CContas.Visible       = .T.

            .AddObject("txt_4c_CCheInis", "TextBox")
            .txt_4c_CCheInis.Top           = 13
            .txt_4c_CCheInis.Left          = 177
            .txt_4c_CCheInis.Width         = 52
            .txt_4c_CCheInis.Height        = 23
            .txt_4c_CCheInis.Value         = ""
            .txt_4c_CCheInis.ControlSource = "dbCredito.Ccheinis"
            .txt_4c_CCheInis.Visible       = .T.

            .AddObject("txt_4c_CDigInis", "TextBox")
            .txt_4c_CDigInis.Top           = 13
            .txt_4c_CDigInis.Left          = 240
            .txt_4c_CDigInis.Width         = 17
            .txt_4c_CDigInis.Height        = 23
            .txt_4c_CDigInis.Value         = ""
            .txt_4c_CDigInis.ControlSource = "dbCredito.Cdiginis"
            .txt_4c_CDigInis.Visible       = .T.

            .AddObject("txt_4c_CCheFins", "TextBox")
            .txt_4c_CCheFins.Top           = 13
            .txt_4c_CCheFins.Left          = 268
            .txt_4c_CCheFins.Width         = 52
            .txt_4c_CCheFins.Height        = 23
            .txt_4c_CCheFins.Value         = ""
            .txt_4c_CCheFins.ControlSource = "dbCredito.Cchefins"
            .txt_4c_CCheFins.Visible       = .T.

            .AddObject("txt_4c_CDigFins", "TextBox")
            .txt_4c_CDigFins.Top           = 13
            .txt_4c_CDigFins.Left          = 329
            .txt_4c_CDigFins.Width         = 17
            .txt_4c_CDigFins.Height        = 23
            .txt_4c_CDigFins.Value         = ""
            .txt_4c_CDigFins.ControlSource = "dbCredito.Cdigfins"
            .txt_4c_CDigFins.Visible       = .T.

            .AddObject("txt_4c_CSeries", "TextBox")
            .txt_4c_CSeries.Top           = 13
            .txt_4c_CSeries.Left          = 354
            .txt_4c_CSeries.Width         = 52
            .txt_4c_CSeries.Height        = 23
            .txt_4c_CSeries.Value         = ""
            .txt_4c_CSeries.ControlSource = "dbCredito.Cseries"
            .txt_4c_CSeries.Visible       = .T.

            .AddObject("txt_4c_CDAberts", "TextBox")
            .txt_4c_CDAberts.Top           = 13
            .txt_4c_CDAberts.Left          = 413
            .txt_4c_CDAberts.Width         = 59
            .txt_4c_CDAberts.Height        = 23
            .txt_4c_CDAberts.Value         = ""
            .txt_4c_CDAberts.ControlSource = "dbCredito.Cdaberts"
            .txt_4c_CDAberts.Visible       = .T.
        ENDWITH

        *-- Cnt_Valor
        loc_oCns.AddObject("cnt_4c_CreditoValor", "Container")
        WITH loc_oCns.cnt_4c_CreditoValor
            .Top       = 230
            .Left      = 170
            .Width     = 372
            .Height    = 40
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoValor, "lbl_4c_ValorCredito", 0, 166, 39, 17, "Valor")
        THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoValor, "lbl_4c_DtVenc",       0, 272, 83, 15, "Data Vencimento")
        THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoValor, "lbl_4c_CpfCredito",   0, 11,  43, 15, "C.P.F. : ")
        WITH loc_oCns.cnt_4c_CreditoValor
            .AddObject("txt_4c_NrCpf", "TextBox")
            .txt_4c_NrCpf.Top           = 12
            .txt_4c_NrCpf.Left          = 8
            .txt_4c_NrCpf.Width         = 150
            .txt_4c_NrCpf.Height        = 23
            .txt_4c_NrCpf.Value         = ""
            .txt_4c_NrCpf.ControlSource = "dbCredito.Ccpfs"
            .txt_4c_NrCpf.Visible       = .T.

            .AddObject("txt_4c_Valor", "TextBox")
            .txt_4c_Valor.Top           = 12
            .txt_4c_Valor.Left          = 166
            .txt_4c_Valor.Width         = 108
            .txt_4c_Valor.Height        = 23
            .txt_4c_Valor.Value         = 0
            .txt_4c_Valor.ControlSource = "dbCredito.Nvalors"
            .txt_4c_Valor.InputMask     = "999,999,999.99"
            .txt_4c_Valor.Visible       = .T.

            .AddObject("txt_4c_DtVenc", "TextBox")
            .txt_4c_DtVenc.Top           = 12
            .txt_4c_DtVenc.Left          = 281
            .txt_4c_DtVenc.Width         = 80
            .txt_4c_DtVenc.Height        = 23
            .txt_4c_DtVenc.Value         = {}
            .txt_4c_DtVenc.ControlSource = "dbCredito.Dvencs"
            .txt_4c_DtVenc.Visible       = .T.
        ENDWITH

        *-- Grade (crSigFiCp)
        loc_oCns.AddObject("grd_4c_Credito", "Grid")
        loc_oGrid = loc_oCns.grd_4c_Credito
        WITH loc_oGrid
            .Top          = 45
            .Left         = 170
            .Width        = 658
            .Height       = 182
            .FontName     = "Courier New"
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .ReadOnly     = .T.
            .Highlight    = .T.
            .HighlightRow = .T.
            .ScrollBars   = 2
            .RecordSource = "dbCredito"
            .ColumnCount  = 6
            .Themes       = .F.
            .Visible      = .T.

            .Columns(1).ControlSource = "dbCredito.Tipos"
            .Columns(1).Header1.Caption = ""
            .Columns(1).Width = 30
            .Columns(1).ReadOnly = .T.

            .Columns(2).ControlSource = "dbCredito.Usuars"
            .Columns(2).Header1.Caption = "Usu" + CHR(225) + "rio"
            .Columns(2).Width = 100
            .Columns(2).ReadOnly = .T.

            .Columns(3).ControlSource = "dbCredito.Emps"
            .Columns(3).Header1.Caption = "Emp"
            .Columns(3).Width = 50
            .Columns(3).ReadOnly = .T.

            .Columns(4).ControlSource = "dbCredito.Datas"
            .Columns(4).Header1.Caption = "Data / Hora"
            .Columns(4).Width = 120
            .Columns(4).ReadOnly = .T.

            .Columns(5).ControlSource = "dbCredito.Dopes"
            .Columns(5).Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            .Columns(5).Width = 160
            .Columns(5).ReadOnly = .T.

            .Columns(6).ControlSource = "dbCredito.Numes"
            .Columns(6).Header1.Caption = "No. Oper"
            .Columns(6).Width = 100
            .Columns(6).ReadOnly = .T.
        ENDWITH

        *-- Cnt_Docs
        loc_oCns.AddObject("cnt_4c_CreditoDocs", "Container")
        WITH loc_oCns.cnt_4c_CreditoDocs
            .Top       = 230
            .Left      = 545
            .Width     = 185
            .Height    = 40
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoDocs, "lbl_4c_TipoDocto", 1, 11, 53, 15, "Tipo Docto")
        THIS.AdicionarRotuloAba(loc_oCns.cnt_4c_CreditoDocs, "lbl_4c_DataDocto", 1, 97, 25, 15, "Data")
        WITH loc_oCns.cnt_4c_CreditoDocs
            .AddObject("obj_4c_OptDocs", "OptionGroup")
            WITH .obj_4c_OptDocs
                .Top           = 15
                .Left          = 5
                .Width         = 89
                .Height        = 25
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .ControlSource = "dbCredito.NChkDocs"
                WITH .Buttons(1)
                    .Caption   = "RG"
                    .Top       = 5
                    .Left      = 5
                    .BackStyle = 0
                    .FontSize  = 8
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "CNH"
                    .Top       = 5
                    .Left      = 45
                    .Height    = 15
                    .BackStyle = 0
                    .FontSize  = 8
                ENDWITH
                .Visible = .T.
            ENDWITH

            .AddObject("txt_4c_DataDoc", "TextBox")
            WITH .txt_4c_DataDoc
                .Top           = 14
                .Left          = 95
                .Width         = 85
                .Height        = 23
                .Value         = {}
                .ControlSource = "dbCredito.TdDocs"
                .Visible       = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * AdicionarMolduraAba - Shape de moldura (os "Shape" das abas do legado:
    * BackStyle = 0, so a borda cinza). Fabrica usada pelas abas acima para nao
    * repetir o mesmo bloco de nove propriedades em cada moldura.
    *==========================================================================
    PROTECTED PROCEDURE AdicionarMolduraAba(par_oPagina, par_cNome, ;
            par_nTop, par_nLeft, par_nWidth, par_nHeight)

        par_oPagina.AddObject(par_cNome, "Shape")

        *-- Membro alcancado por NOME: EVALUATE na leitura (regra #15/#34)
        WITH EVALUATE("par_oPagina." + par_cNome)
            .Top         = par_nTop
            .Left        = par_nLeft
            .Width       = par_nWidth
            .Height      = par_nHeight
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * AdicionarRotuloAba - Label de dados das abas. ForeColor RGB(90,90,90) (a
    * classe "say" do legado nao declara cor; branco ficaria invisivel sobre a
    * textura clara da Page - regra #12) e AutoSize = .F. com a Width/Height do
    * dump (regra #23: AutoSize eh no-op em Label criado por AddObject).
    *==========================================================================
    PROTECTED PROCEDURE AdicionarRotuloAba(par_oPagina, par_cNome, ;
            par_nTop, par_nLeft, par_nWidth, par_nHeight, par_cCaption)

        par_oPagina.AddObject(par_cNome, "Label")

        WITH EVALUATE("par_oPagina." + par_cNome)
            .Top       = par_nTop
            .Left      = par_nLeft
            .Width     = par_nWidth
            .Height    = par_nHeight
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = par_cCaption
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * AdicionarTotalAba - TextBox somente-leitura de total/observacao das abas
    * (os fwget com "When -> RETURN .F." do legado). par_lNumerico diz se o
    * campo mostra valor (InputMask "999,999,999.99", como no dump) ou texto.
    *==========================================================================
    PROTECTED PROCEDURE AdicionarTotalAba(par_oPagina, par_cNome, ;
            par_nTop, par_nLeft, par_nWidth, par_nHeight, par_lNumerico)

        par_oPagina.AddObject(par_cNome, "TextBox")

        WITH EVALUATE("par_oPagina." + par_cNome)
            .Top           = par_nTop
            .Left          = par_nLeft
            .Width         = par_nWidth
            .Height        = par_nHeight
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Visible       = .T.

            IF par_lNumerico
                .Value     = 0
                .InputMask = "999,999,999.99"
            ELSE
                .Value     = ""
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * PreencherComboGrupo - Popula o ComboBox "Grupo :" de uma aba com os
    * grupos presentes no cursor de resultado, no formato do legado
    * ("<codigo com 10> - <descricao>"), e deixa o primeiro selecionado.
    *
    * Equivale ao efeito acumulado das chamadas a Carrega_Combo() que o legado
    * faz dentro do SCAN de carga. PUBLIC: chamado pelos funis de carga e pelo
    * harness de teste.
    *==========================================================================
    PROCEDURE PreencherComboGrupo(par_oCombo, par_cCursorOrigem)
        LOCAL loc_nGrupos, loc_oErro

        TRY
            IF VARTYPE(par_oCombo) = "O"
                par_oCombo.Clear()

                loc_nGrupos = THIS.this_oBusinessObject.CarregarGruposCursor( ;
                    par_cCursorOrigem, "cursor_4c_GruposAba")

                IF loc_nGrupos > 0 AND USED("cursor_4c_GruposAba")
                    SELECT cursor_4c_GruposAba
                    SCAN
                        par_oCombo.AddItem( ;
                            PADR(ALLTRIM(TratarNulo(cursor_4c_GruposAba.Codigos, "")), 10) + ;
                            " - " + ALLTRIM(TratarNulo(cursor_4c_GruposAba.Descrs, "")))
                    ENDSCAN

                    IF par_oCombo.ListCount > 0
                        par_oCombo.ListIndex = 1
                    ENDIF
                ENDIF

                IF USED("cursor_4c_GruposAba")
                    USE IN cursor_4c_GruposAba
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao montar o filtro de grupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FiltrarPorGrupo - Aplica em <cursor> o filtro de grupo escolhido no
    * combo, exatamente como o "Set Key To Left(.Value,10)" do legado. O tag de
    * UMA coluna (Grupos) eh usado de proposito: chave parcial sobre indice
    * composto nao casa com SET EXACT ON.
    *
    * Combo vazio (nenhum grupo carregado) limpa o filtro, para a grade nao
    * ficar vazia sem motivo.
    *==========================================================================
    PROTECTED PROCEDURE FiltrarPorGrupo(par_cCursor, par_cValorCombo)
        LOCAL loc_cGrupo

        IF !USED(par_cCursor)
            RETURN
        ENDIF

        loc_cGrupo = LEFT(IIF(VARTYPE(par_cValorCombo) = "C", par_cValorCombo, ""), 10)

        SELECT (par_cCursor)
        SET ORDER TO TAG Grupos
        IF EMPTY(loc_cGrupo)
            SET KEY TO
        ELSE
            SET KEY TO loc_cGrupo
        ENDIF
        GO TOP
    ENDPROC

    *==========================================================================
    * AtualizarAbaResultadoAtiva - Despachante UNICO de repintura da pagina
    * Resultado: chama o funil da aba que esta a vista.
    *
    * Existe para que os DOIS caminhos que deixam a aba visivel - a troca de
    * pagina (AlternarPagina(2)) e a troca de aba (OptResultadoInteractiveChange)
    * - repintem exatamente a mesma coisa. Refresh em pagina oculta nao pinta
    * (regra #46), por isso o despachante eh sempre chamado DEPOIS de o
    * ActivePage ja estar trocado.
    *
    * As abas 5, 7, 8, 9 e 10 (Vendas, Operacoes Pend., Producao, Historico
    * de Cheques e Credito) ganham o seu CASE junto com o conteudo delas, na
    * fase seguinte.
    * PUBLIC: chamado de fora (botoes e harness de teste).
    *==========================================================================
    PROCEDURE AtualizarAbaResultadoAtiva()
        LOCAL loc_nAba, loc_oErro

        TRY
            loc_nAba = 0
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Resultado", 5)
                loc_nAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.ActivePage
            ENDIF

            DO CASE
                CASE loc_nAba = 1
                    THIS.AtualizarGradesSaldo()
                CASE loc_nAba = 2
                    THIS.AtualizarGradePendencias()
                CASE loc_nAba = 3
                    THIS.AtualizarGradesCheques()
                CASE loc_nAba = 4
                    THIS.AtualizarGradeCartao()
                CASE loc_nAba = 6
                    THIS.AtualizarGradeEstoque()
                CASE loc_nAba = 9
                    THIS.AtualizarGradeHCheques()
                CASE loc_nAba = 10
                    THIS.AtualizarGradeCredito()
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao atualizar a aba de resultado")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarGradePendencias - Funil UNICO de repintura da aba Pendencias
    * (regra #21a: popular cursor nao repinta a grade). Reaplica o filtro de
    * grupo, recalcula o total e so entao da GO TOP + Refresh.
    * PUBLIC: chamado de fora (botoes, combo e harness de teste).
    *==========================================================================
    PROCEDURE AtualizarGradePendencias()
        LOCAL loc_oAba, loc_oErro

        TRY
            IF THIS.AbaResultadoDisponivel(2)
                loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2

                THIS.FiltrarPorGrupo("TmpPar", loc_oAba.cbo_4c_GrupoPend.Value)
                THIS.FiltrarTipos()

                IF USED("crTmpTipos")
                    GO TOP IN crTmpTipos
                ENDIF

                loc_oAba.grd_4c_TiposPend.Refresh()
                loc_oAba.grd_4c_Pendentes.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao atualizar a grade de pend" + CHR(234) + "ncias")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FiltrarTipos - FiltraTipos() do legado: monta o filtro de TmpPar com as
    * formas de pagamento MARCADAS em crTmpTipos e atualiza o total.
    *
    * Nenhuma forma marcada deixa a grade vazia de proposito ("Set Filter To
    * 0=1" no legado) - eh o que diz ao usuario que o filtro excluiu tudo.
    * O filtro de grupo (SET KEY) e o de tipos (SET FILTER) sao independentes e
    * convivem, como no legado.
    * PUBLIC: chamado pelos handlers do CheckBox e pelo harness de teste.
    *==========================================================================
    PROCEDURE FiltrarTipos()
        LOCAL loc_cTipos, loc_oAba, loc_oErro

        TRY
            IF USED("TmpPar") AND USED("crTmpTipos")
                loc_cTipos = ""

                SELECT crTmpTipos
                GO TOP
                SCAN
                    IF TratarNulo(crTmpTipos.Listas, 0) = 1
                        loc_cTipos = loc_cTipos + ;
                            IIF(EMPTY(loc_cTipos), "fPags = ", " OR fPags = ") + ;
                            CHR(39) + ALLTRIM(TratarNulo(crTmpTipos.fPags, "")) + CHR(39)
                    ENDIF
                ENDSCAN
                GO TOP IN crTmpTipos

                SELECT TmpPar
                IF EMPTY(loc_cTipos)
                    SET FILTER TO 0 = 1
                ELSE
                    SET FILTER TO &loc_cTipos.
                ENDIF
                LOCATE

                IF THIS.AbaResultadoDisponivel(2)
                    loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2
                    loc_oAba.txt_4c_TotPend.Value = THIS.this_oBusinessObject.TotalPendencias()
                    loc_oAba.txt_4c_TotPend.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao filtrar as formas de pagamento")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ChkTipoPendKeyPress - Alterna a marca da forma de pagamento por TECLADO
    * (Enter/Espaco), como o KeyPress do Check1 do legado. O NODEFAULT suprime
    * o toggle nativo para o valor nao ser alternado duas vezes.
    * PUBLIC: alvo de BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE ChkTipoPendKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32) AND USED("crTmpTipos") AND !EOF("crTmpTipos")
            REPLACE crTmpTipos.Listas ;
                WITH IIF(TratarNulo(crTmpTipos.Listas, 0) = 0, 1, 0) IN crTmpTipos

            IF THIS.AbaResultadoDisponivel(2)
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2.grd_4c_TiposPend.Refresh()
            ENDIF

            THIS.FiltrarTipos()
            THIS.AtualizarGradePendencias()
            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * ChkTipoPendMouseUp - Alterna a marca por CLIQUE, delegando ao mesmo
    * handler do teclado (MouseUp do Check1 legado: This.KeyPress(13,0)).
    *==========================================================================
    PROCEDURE ChkTipoPendMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.ChkTipoPendKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    *==========================================================================
    * ChkTipoPendMouseDown - Suprime o toggle nativo do CheckBox (NoDefault do
    * MouseDown legado): quem alterna o valor eh o MouseUp/KeyPress.
    *==========================================================================
    PROCEDURE ChkTipoPendMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    *==========================================================================
    * ChkTipoPendClick - Suprime o Click nativo (NoDefault do Click legado),
    * pela mesma razao do MouseDown.
    *==========================================================================
    PROCEDURE ChkTipoPendClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * CboGrupoPendInteractiveChange - Cmb_Grupo.InteractiveChange da aba
    * Pendencias: aplica o filtro de grupo, recalcula o total e repinta.
    *==========================================================================
    PROCEDURE CboGrupoPendInteractiveChange()
        THIS.AtualizarGradePendencias()
    ENDPROC

    *==========================================================================
    * BtnAnexaPendClick - Anexa.Click da aba Pendencias: abre o documento da
    * pendencia selecionada (FormSigMvExp, o SigMvExp do legado).
    *
    * A condicao que o legado usava para HABILITAR o botao (linha valida, com
    * Dopes e Numes) vive aqui dentro: botao icone-only desabilitado em runtime
    * perde o icone, por isso ele fica sempre ativo e avisa quando a linha
    * corrente nao tem documento.
    *==========================================================================
    PROCEDURE BtnAnexaPendClick()
        LOCAL loc_oForm, loc_oErro

        IF !USED("TmpPar") OR EOF("TmpPar") OR ;
           EMPTY(TratarNulo(TmpPar.dopes, "")) OR TratarNulo(TmpPar.numes, 0) = 0
            MsgAviso("Selecione uma pend" + CHR(234) + "ncia com documento para " + ;
                "consultar.", "Documento")
            RETURN
        ENDIF

        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigMvExp", ;
                ALLTRIM(TmpPar.dopes), "C", TmpPar.numes, ALLTRIM(TmpPar.emps), .T.)
        CATCH TO loc_oErro
            MostrarErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir o " + ;
                "documento:" + CHR(13) + loc_oErro.Message, "Documento")
            loc_oForm = .NULL.
        ENDTRY

        *-- Show() de form modal FORA do TRY (regra #29)
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAnexaSaldoClick - Anexa.Click da aba Saldo (Result.Saldo.Anexa do
    * legado): abre o documento do lancamento corrente do historico de conta
    * corrente, mesmo padrao do BtnAnexaPendClick, lendo de dbHistorico.
    *==========================================================================
    PROCEDURE BtnAnexaSaldoClick()
        LOCAL loc_oForm, loc_oErro

        IF !USED("dbHistorico") OR EOF("dbHistorico") OR ;
           EMPTY(TratarNulo(dbHistorico.dopes, "")) OR TratarNulo(dbHistorico.numes, 0) = 0
            MsgAviso("Selecione um lan" + CHR(231) + "amento com documento para " + ;
                "consultar.", "Documento")
            RETURN
        ENDIF

        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigMvExp", ;
                ALLTRIM(dbHistorico.dopes), "C", dbHistorico.numes, ALLTRIM(dbHistorico.emps), .T.)
        CATCH TO loc_oErro
            MostrarErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir o " + ;
                "documento:" + CHR(13) + loc_oErro.Message, "Documento")
            loc_oForm = .NULL.
        ENDTRY

        *-- Show() de form modal FORA do TRY (regra #29)
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnImpPendClick - CmdImpPend.Click da aba Pendencias: listagem das
    * pendencias visiveis (Report Form SigReIpd do legado).
    *
    * O cursor crImpPend tem a MESMA estrutura que o legado monta antes do
    * REPORT FORM, e o relatorio roda pelo helper canonico de impressao
    * (isolamento de locale + guard de FRX ausente + restauracao do menu).
    *==========================================================================
    PROCEDURE BtnImpPendClick()
        LOCAL loc_cConta, loc_cNome, loc_cGrupo, loc_nTotal, loc_oAba
        LOCAL loc_lTemLinha, loc_oErro

        TRY
            IF !USED("TmpPar")
                MsgAviso("Nenhuma pend" + CHR(234) + "ncia a listar.", "Listagem")
            ELSE
                loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2
                loc_cGrupo = "G" + LEFT(loc_oAba.cbo_4c_GrupoPend.Value, 10)
                loc_cConta = ALLTRIM(THIS.this_oBusinessObject.this_cConta)
                loc_cNome  = ALLTRIM(THIS.this_oBusinessObject.this_cDescConta)
                loc_nTotal = THIS.this_oBusinessObject.TotalPendencias()

                IF USED("crImpPend")
                    USE IN crImpPend
                ENDIF
                CREATE CURSOR crImpPend (Tipo N(1), EmpDopNums C(29), Conta C(10), ;
                    rClis C(40), Emps C(3), Dopes C(20), Numes N(6), Grupo C(10), ;
                    Datas D, cPros C(14), dPros C(40), Qtds N(9,3), cUnis C(3), ;
                    Units N(11,2), Totas N(11,2), TotGeral N(13,2), Grupos C(40))

                loc_lTemLinha = .F.
                SELECT TmpPar
                GO TOP
                SCAN
                    INSERT INTO crImpPend ;
                        (Tipo, Conta, rClis, Emps, Dopes, Numes, Grupo, Datas, ;
                         dPros, Totas, TotGeral, Grupos) ;
                        VALUES ;
                        (0, loc_cConta, LEFT(loc_cNome, 40), ;
                         TratarNulo(TmpPar.emps, ""), ;
                         TratarNulo(TmpPar.dopes, ""), ;
                         TratarNulo(TmpPar.numes, 0), ;
                         TratarNulo(TmpPar.grupos, ""), ;
                         ConverterParaData(TmpPar.vencs), ;
                         LEFT(TratarNulo(TmpPar.hists, ""), 40), ;
                         TratarNulo(TmpPar.valos, 0), ;
                         loc_nTotal, ;
                         LEFT(loc_cGrupo, 40))
                    loc_lTemLinha = .T.
                ENDSCAN
                GO TOP IN TmpPar

                IF !loc_lTemLinha
                    MsgAviso("Nenhuma pend" + CHR(234) + "ncia a listar.", "Listagem")
                ELSE
                    SELECT crImpPend
                    GO TOP
                    THIS.ImprimirListagem("SigReIpd", "crImpPend")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao listar as pend" + CHR(234) + "ncias")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ImprimirListagem - Helper canonico de REPORT FORM: resolve o caminho do
    * FRX em gc_4c_CaminhoReports, avisa quando o arquivo nao existe (em vez de
    * estourar sem dizer qual), isola o locale (SET POINT/SEPARATOR/
    * REPORTBEHAVIOR, que os FRX Fortyus exigem para nao imprimir "*****" nos
    * numericos) e restaura o menu, que o preview do VFP9 corrompe.
    *==========================================================================
    PROTECTED PROCEDURE ImprimirListagem(par_cRelatorioBase, par_cCursorDados)
        LOCAL loc_cFrx, loc_cPonto, loc_cSeparador, loc_nBehavior, loc_oErro

        loc_cFrx = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF !FILE(loc_cFrx)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o encontrado:" + CHR(13) + loc_cFrx, "Listagem")
            RETURN
        ENDIF

        IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
            MsgAviso("Nenhum registro encontrado com os filtros informados.", "Listagem")
            RETURN
        ENDIF

        loc_cPonto     = SET("Point")
        loc_cSeparador = SET("Separator")
        loc_nBehavior  = SET("REPORTBEHAVIOR")

        TRY
            SET POINT TO "."
            SET SEPARATOR TO ","
            SET REPORTBEHAVIOR 80

            SELECT (par_cCursorDados)
            GO TOP

            REPORT FORM (loc_cFrx) TO PRINTER PROMPT PREVIEW
        CATCH TO loc_oErro
            MostrarErro("Erro ao gerar a listagem:" + CHR(13) + loc_oErro.Message, ;
                "Listagem")
        FINALLY
            SET POINT TO loc_cPonto
            SET SEPARATOR TO loc_cSeparador
            SET REPORTBEHAVIOR loc_nBehavior
        ENDTRY

        *-- O preview do VFP9 corrompe _MSYSMENU: devolver o menu do sistema
        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
                popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH TO loc_oErro
            *-- Menu ausente (form aberto fora do menu principal ou em teste)
            *-- nao eh erro de negocio
        ENDTRY
    ENDPROC

    *==========================================================================
    * ImpressaoCad - ImpressaoCad() do legado: monta _varRB/_varH (os dois
    * memos que o SigReGcd.frx exibe nos blocos de Referencias Bancarias e
    * Follow-up - os nomes NAO levam o prefixo loc_ de proposito, porque o
    * FRX resolve essas expressoes pelo nome literal, igual ao contrato de
    * alias/campo de FRX da regra do projeto) e dispara o relatorio pelo
    * cursor crCli (copia de SigCdCli pela conta pesquisada).
    *
    * par_lTermica (Chk_Impressora - "40 colunas"): o legado desvia para
    * ImpTermicad() quando a saida eh impressora direta - uma rotina que
    * grava bytes crus numa impressora termica via Set Printer To Name(),
    * dependente do array gaprinters (populado no login do framework
    * legado, nunca portado) e do FormSigOpIpb de selecao de impressora.
    * Sem essa infraestrutura de hardware o caminho correto eh avisar, nao
    * fingir sucesso silencioso.
    *==========================================================================
    PROTECTED PROCEDURE ImpressaoCad(par_cSaida, par_lGenerico, par_lPessoais, ;
            par_lBancarias, par_lFollowup, par_lTermica)
        LOCAL loc_cConta, loc_cSQL, loc_oErro
        LOCAL _varRB, _varH

        *-- Guard de parametro FORA do TRY: com o RETURN dentro do bloco ele
        *-- violaria a regra #1 (nunca RETURN dentro de TRY/CATCH), e aqui nao
        *-- ha o que proteger - a condicao le apenas os parametros recebidos
        IF par_lTermica AND par_cSaida != "V"
            MsgAviso("Impress" + CHR(227) + "o em impressora t" + CHR(233) + ;
                "rmica de 40 colunas n" + CHR(227) + "o est" + CHR(225) + ;
                " dispon" + CHR(237) + "vel neste sistema." + CHR(13) + ;
                "Use a op" + CHR(231) + CHR(227) + "o V" + CHR(237) + "deo ou " + ;
                "desmarque " + CHR(34) + "Impressora 40 colunas" + CHR(34) + ".", ;
                "Impress" + CHR(227) + "o")
            RETURN
        ENDIF

        TRY
            loc_cConta = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c_Conta.Value)

            _varRB = ""
            _varH  = ""

            IF par_lBancarias
                IF USED("crSigCdCeb")
                    USE IN crSigCdCeb
                ENDIF
                loc_cSQL = "SELECT nbancos, bancos, nagencias, agencias, btels, ramals" + ;
                    " FROM SigCdCeb WHERE iclis = " + EscaparSQL(loc_cConta)
                SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCeb")

                IF USED("crSigCdCeb")
                    SELECT crSigCdCeb
                    IF EOF()
                        _varRB = "N" + CHR(227) + "o Constam Refer" + CHR(234) + ;
                            "ncias Bancarias Referentes ao Cliente!"
                    ELSE
                        SCAN
                            _varRB = _varRB + TratarNulo(nbancos, "") + " " + ;
                                LEFT(TratarNulo(bancos, ""), 22) + " " + ;
                                TratarNulo(nagencias, "") + " " + ;
                                LEFT(TratarNulo(agencias, ""), 22) + " " + ;
                                TratarNulo(btels, "") + " " + TratarNulo(ramals, "")
                        ENDSCAN
                    ENDIF
                    USE IN crSigCdCeb
                ENDIF
            ENDIF

            IF par_lFollowup
                IF USED("crSigCdClh")
                    USE IN crSigCdClh
                ENDIF
                loc_cSQL = "SELECT datas, hists FROM SigCdClh WHERE iclis = " + ;
                    EscaparSQL(loc_cConta)
                SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdClh")

                IF USED("crSigCdClh")
                    SELECT crSigCdClh
                    IF EOF()
                        _varH = "N" + CHR(227) + "o Constam Follow-up Referentes ao Cliente!"
                    ELSE
                        SCAN
                            _varH = _varH + TTOC(ConverterParaData(datas)) + " " + ;
                                TratarNulo(hists, "")
                        ENDSCAN
                    ENDIF
                    USE IN crSigCdClh
                ENDIF
            ENDIF

            IF USED("crCli")
                USE IN crCli
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
            SQLEXEC(gnConnHandle, loc_cSQL, "crCli")

            THIS.ImprimirListagem("SigReGcd", "crCli")

            IF USED("crSigCdCeb")
                USE IN crSigCdCeb
            ENDIF
            IF USED("crSigCdClh")
                USE IN crSigCdClh
            ENDIF
            IF USED("crCli")
                USE IN crCli
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao imprimir a ficha cadastral")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Impressao - Impressao() do legado: monta o cursor agregado TmpRelGv
    * (uma secao por tipo de informacao marcada no painel SelecionaImpressao)
    * e dispara o relatorio SIGOPCGV.frx.
    *
    * Movimentacoes Pend. (dbConserto), Resumo de Vendas (dbTotVendas),
    * Produtos Adquiridos (dbProduto) e Producao (dbProduc) sao alimentados
    * pelo PProduto() legado - as abas Vendas/Operacoes Pend./Producao
    * (ver cabecalho do arquivo) ainda nao existem nesta migracao, entao os
    * cursores correspondentes nunca sao criados; os quatro blocos abaixo
    * ficam guardados por USED() e simplesmente nao contribuem linha nenhuma
    * ate essa fase ser feita - nenhum outro ajuste sera necessario aqui.
    *
    * par_lTermica: mesma ressalva de ImpressaoCad - sem a fila de
    * impressoras do legado (gaprinters/SigOpIbo), o caminho termico vira
    * aviso em vez de ficar calado.
    *==========================================================================
    PROTECTED PROCEDURE Impressao(par_cSaida, par_lSaldo, par_lLimite, ;
            par_lChequePend, par_lChequeDev, par_lChequeDep, par_lCartao, ;
            par_lPend, par_lOper, par_lTermica, par_lChqNeg, par_lResVenda, ;
            par_lProdutos, par_lProducao, par_lEstoque)
        LOCAL loc_cConta, loc_cSQL, loc_nValTipo, loc_cCabTipo, loc_oErro
        LOCAL loc_dDtIni, loc_dDtFim

        *-- Guard de parametro FORA do TRY (regra #1, igual ao ImpressaoCad)
        IF par_lTermica AND par_cSaida != "V"
            MsgAviso("Impress" + CHR(227) + "o em impressora t" + CHR(233) + ;
                "rmica de 40 colunas n" + CHR(227) + "o est" + CHR(225) + ;
                " dispon" + CHR(237) + "vel neste sistema." + CHR(13) + ;
                "Use a op" + CHR(231) + CHR(227) + "o V" + CHR(237) + "deo ou " + ;
                "desmarque " + CHR(34) + "Impressora 40 colunas" + CHR(34) + ".", ;
                "Impress" + CHR(227) + "o")
            RETURN
        ENDIF

        TRY
            loc_cConta = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c_Conta.Value)

            IF USED("TmpRelGv")
                USE IN TmpRelGv
            ENDIF
            CREATE CURSOR TmpRelGv (ValTipo N(3), CabTipo C(70), Grupo C(10), ;
                Valor N(12,2), Moeda C(3), Data D, Descricao C(50), Observa C(76), ;
                Opers C(1), ValoPg N(12,2), Saldo N(12,2), Cpros C(14), DPros C(40), ;
                Numes N(6), Dopes C(20), PrazoEnts D, Fase C(10), Qtds N(9,2), ;
                Nenvs N(10), Nops N(10), xPer N(6,2), Emps C(3), Pesos N(9,2), ;
                Cbars N(14), Reffs C(40), Colecoes C(10), Anos C(4), Meses C(2))
            INDEX ON STR(ValTipo, 3) + Anos + Meses + Grupo TAG ValGrupo

            IF USED("TmpTotal")
                USE IN TmpTotal
            ENDIF
            CREATE CURSOR TmpTotal (Moeda C(3), Valor N(12,2))
            INDEX ON Moeda TAG Moeda

            *-- (1) Saldo de Conta Corrente
            IF par_lSaldo
                loc_nValTipo = 1
                loc_cCabTipo = "Saldos de Conta Corrente"
                IF USED("dbSaldo")
                    SELECT dbSaldo
                    GO TOP
                    IF !EOF()
                        SCAN
                            INSERT INTO TmpRelGv (CabTipo, ValTipo, Grupo, Valor, Moeda) ;
                                VALUES (loc_cCabTipo, loc_nValTipo, dbSaldo.grupos, ;
                                    dbSaldo.saldos, dbSaldo.moedas)
                        ENDSCAN
                    ELSE
                        INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
                            VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
                                "o tem Saldo...")
                    ENDIF
                ENDIF
            ENDIF

            *-- (2) Limite de Credito
            IF par_lLimite
                loc_nValTipo = 2
                loc_cCabTipo = "Limite de Cr" + CHR(233) + "dito"
                IF USED("crTmpLCrDi")
                    USE IN crTmpLCrDi
                ENDIF
                loc_cSQL = "SELECT Grupos, LimCres, Moedas FROM SigClLcr" + ;
                    " WHERE Contas = " + EscaparSQL(loc_cConta)
                SQLEXEC(gnConnHandle, loc_cSQL, "crTmpLCrDi")

                IF !USED("crTmpLCrDi") OR RECCOUNT("crTmpLCrDi") = 0
                    INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
                        VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
                            "o tem Limite de Cr" + CHR(233) + "dito...")
                ELSE
                    SELECT crTmpLCrDi
                    SCAN
                        INSERT INTO TmpRelGv (CabTipo, ValTipo, Grupo, Valor, Moeda) ;
                            VALUES (loc_cCabTipo, loc_nValTipo, crTmpLCrDi.Grupos, ;
                                crTmpLCrDi.LimCres, crTmpLCrDi.Moedas)
                    ENDSCAN
                ENDIF
                IF USED("crTmpLCrDi")
                    USE IN crTmpLCrDi
                ENDIF
            ENDIF

            *-- (3) Cheques Pend.
            IF par_lChequePend
                loc_nValTipo = 3
                loc_cCabTipo = "Cheques Pendentes"
                IF USED("dbAberto")
                    SELECT dbAberto
                    GO TOP
                    IF !EOF()
                        SCAN
                            INSERT INTO TmpRelGv (CabTipo, ValTipo, Data, Valor, Descricao) ;
                                VALUES (loc_cCabTipo, loc_nValTipo, dbAberto.vencs, ;
                                    dbAberto.valors, ;
                                    ALLTRIM(dbAberto.bancos) + "." + ;
                                    ALLTRIM(dbAberto.agencias) + "." + ;
                                    ALLTRIM(dbAberto.ncontas) + "." + ;
                                    ALLTRIM(dbAberto.ncheques))

                            IF USED("crSigCheh")
                                USE IN crSigCheh
                            ENDIF
                            loc_cSQL = "SELECT datas, hists FROM SigCheh" + ;
                                " WHERE nums = " + EscaparSQL(ALLTRIM(dbAberto.nums))
                            SQLEXEC(gnConnHandle, loc_cSQL, "crSigCheh")

                            IF USED("crSigCheh") AND RECCOUNT("crSigCheh") > 0
                                SELECT crSigCheh
                                INDEX ON DTOS(datas) TAG Datas
                                GO BOTTOM
                                REPLACE TmpRelGv.Observa WITH TratarNulo(crSigCheh.hists, "")
                            ENDIF
                            IF USED("crSigCheh")
                                USE IN crSigCheh
                            ENDIF
                        ENDSCAN
                    ELSE
                        INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
                            VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
                                "o tem Cheques Pendentes...")
                    ENDIF
                ENDIF
            ENDIF

            *-- (4) Cheques Devolvidos
            IF par_lChequeDev
                loc_nValTipo = 4
                loc_cCabTipo = "Cheques Devolvidos"
                IF USED("dbDevolvido")
                    SELECT dbDevolvido
                    GO TOP
                    IF !EOF()
                        SCAN
                            INSERT INTO TmpRelGv (CabTipo, ValTipo, Data, Valor, Descricao) ;
                                VALUES (loc_cCabTipo, loc_nValTipo, dbDevolvido.vencs, ;
                                    dbDevolvido.valors, ;
                                    ALLTRIM(dbDevolvido.bancos) + "." + ;
                                    ALLTRIM(dbDevolvido.agencias) + "." + ;
                                    ALLTRIM(dbDevolvido.ncontas) + "." + ;
                                    ALLTRIM(dbDevolvido.ncheques))
                        ENDSCAN
                    ELSE
                        INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
                            VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
                                "o tem Cheques Devolvidos...")
                    ENDIF
                ENDIF
            ENDIF

            *-- (5) Cheques Depositados
            IF par_lChequeDep
                loc_nValTipo = 5
                loc_cCabTipo = "Cheques Depositados"
                IF USED("crTmpChe")
                    USE IN crTmpChe
                ENDIF
                loc_cSQL = "SELECT * FROM SigChe WHERE Iclis = " + EscaparSQL(loc_cConta) + ;
                    " AND Umovs = " + EscaparSQL("DEP" + CHR(211) + "SITO")
                SQLEXEC(gnConnHandle, loc_cSQL, "crTmpChe")

                IF !USED("crTmpChe") OR RECCOUNT("crTmpChe") = 0
                    INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
                        VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
                            "o tem Cheques Depositados...")
                ELSE
                    SELECT crTmpChe
                    SCAN
                        INSERT INTO TmpRelGv (CabTipo, ValTipo, Data, Valor, Descricao) ;
                            VALUES (loc_cCabTipo, loc_nValTipo, crTmpChe.vencs, ;
                                crTmpChe.valors, ;
                                ALLTRIM(crTmpChe.bancos) + "." + ;
                                ALLTRIM(crTmpChe.agencias) + "." + ;
                                ALLTRIM(crTmpChe.ncontas) + "." + ;
                                ALLTRIM(crTmpChe.ncheques))
                    ENDSCAN
                ENDIF
                IF USED("crTmpChe")
                    USE IN crTmpChe
                ENDIF
            ENDIF

            *-- (9) Cartoes Pend.
            IF par_lCartao
                loc_nValTipo = 9
                loc_cCabTipo = "Cart" + CHR(245) + "es Pendentes"
                IF USED("TmpCart")
                    SELECT TmpCart
                    GO TOP
                    IF !EOF()
                        SCAN
                            INSERT INTO TmpRelGv (CabTipo, ValTipo, Data, Valor, Descricao) ;
                                VALUES (loc_cCabTipo, loc_nValTipo, TmpCart.vencs, ;
                                    TmpCart.valos, ;
                                    ALLTRIM(TmpCart.fpags) + " ( " + ;
                                    ALLTRIM(TmpCart.cartaos) + " ) - " + ;
                                    ALLTRIM(TmpCart.nocreditos))
                        ENDSCAN
                    ELSE
                        INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
                            VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
                                "o tem Cart" + CHR(245) + "es Pendentes...")
                    ENDIF
                ENDIF
            ENDIF

            *-- (7) Pendencias
            IF par_lPend
                loc_nValTipo = 7
                loc_cCabTipo = "Pend" + CHR(234) + "ncias"
                IF USED("TmpPar")
                    SELECT TmpPar
                    GO TOP
                    IF !EOF()
                        SCAN
                            INSERT INTO TmpRelGv (CabTipo, ValTipo, Data, Valor, ;
                                    Descricao, Moeda, Opers) ;
                                VALUES (loc_cCabTipo, loc_nValTipo, TmpPar.vencs, ;
                                    TmpPar.valos, TmpPar.hists, TmpPar.moefpgs, TmpPar.opers)

                            IF !SEEK(TmpPar.moefpgs, "TmpTotal")
                                INSERT INTO TmpTotal (Moeda) VALUES (TmpPar.moefpgs)
                            ENDIF
                            REPLACE TmpTotal.Valor WITH TmpTotal.Valor + ;
                                (TmpPar.valos * IIF(TmpPar.opers = "C", -1, 1))
                        ENDSCAN

                        IF !par_lTermica OR par_cSaida == "V"
                            SELECT TmpTotal
                            SCAN
                                INSERT INTO TmpRelGv (ValTipo, Valor, Moeda) ;
                                    VALUES (loc_nValTipo, TmpTotal.Valor, TmpTotal.Moeda)
                            ENDSCAN
                        ENDIF
                    ELSE
                        INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
                            VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
                                "o tem Pendencias...")
                    ENDIF
                ENDIF
            ENDIF

            *-- (8) Operacoes Pend. - depende da aba Conserto (dbConserto),
            *-- que so existe quando a fase do PProduto() for feita (ver
            *-- cabecalho do arquivo); o bloco entra em acao sozinho quando o
            *-- cursor passar a existir.
            IF par_lOper
                loc_nValTipo = 8
                loc_cCabTipo = "Opera" + CHR(231) + CHR(245) + "es Pendentes"
                IF USED("dbConserto")
                    SELECT dbConserto
                    GO TOP
                    IF !EOF()
                        SCAN
                            INSERT INTO TmpRelGv (CabTipo, ValTipo, Data, Descricao) ;
                                VALUES (loc_cCabTipo, loc_nValTipo, dbConserto.datas, ;
                                    ALLTRIM(dbConserto.emps) + ALLTRIM(dbConserto.dopes) + ;
                                    " - " + ALLTRIM(dbConserto.mascnum) + " (" + ;
                                    ALLTRIM(dbConserto.status) + ")")
                        ENDSCAN
                    ELSE
                        INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
                            VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
                                "o tem Opera" + CHR(231) + CHR(245) + "es Pendentes...")
                    ENDIF
                ENDIF
            ENDIF

            *-- (6) Cheques Negociados
            IF par_lChqNeg
                loc_nValTipo = 6
                loc_cCabTipo = "Cheques Negociados"
                IF USED("dbTitulo")
                    SELECT dbTitulo
                    GO TOP
                    IF !EOF()
                        SCAN
                            INSERT INTO TmpRelGv (CabTipo, ValTipo, Grupo, Data, Valor, ;
                                    ValoPg, Saldo, Moeda, Observa) ;
                                VALUES (loc_cCabTipo, loc_nValTipo, dbTitulo.titulos, ;
                                    dbTitulo.vencs, dbTitulo.valors, dbTitulo.valpags, ;
                                    dbTitulo.saldos, dbTitulo.moedas, ;
                                    TratarNulo(dbTitulo.hists, ""))
                        ENDSCAN
                    ELSE
                        INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
                            VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
                                "o tem Cheques Negociados...")
                    ENDIF
                ENDIF
            ENDIF

            *-- (10) Resumo de Vendas - depende da aba Vendas (dbTotVendas),
            *-- mesma pendencia do bloco (8).
            IF par_lResVenda
                loc_nValTipo = 10
                loc_cCabTipo = "Resumo de Vendas"
                IF USED("dbTotVendas")
                    SELECT dbTotVendas
                    GO TOP
                    IF !EOF()
                        SCAN
                            INSERT INTO TmpRelGv (CabTipo, ValTipo, Grupo, Moeda, Valor, ;
                                    ValoPg, Anos, Meses) ;
                                VALUES (loc_cCabTipo, loc_nValTipo, dbTotVendas.mesanos, ;
                                    dbTotVendas.moedas, dbTotVendas.totals, ;
                                    dbTotVendas.vrmovs, dbTotVendas.anos, dbTotVendas.meses)
                        ENDSCAN
                    ELSE
                        INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
                            VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
                                "o tem Resumo de Vendas...")
                    ENDIF
                ENDIF
            ENDIF

            *-- (11) Produtos Adquiridos - depende da aba Vendas (dbProduto),
            *-- mesma pendencia do bloco (8).
            IF par_lProdutos
                loc_nValTipo = 11
                IF USED("dbProduto")
                    LOCAL loc_oPnlProd
                    loc_oPnlProd = THIS.pgf_4c_Paginas.Page2.cnt_4c_SelecionaImpressao.cnt_4c_ProdAdq
                    loc_dDtIni = ConverterParaData(loc_oPnlProd.txt_4c_DtInicial.Value)
                    loc_dDtFim = ConverterParaData(loc_oPnlProd.txt_4c_DtFinal.Value)
                    loc_cCabTipo = "Produtos Adquiridos Pelo Cliente: " + ;
                        DTOC(loc_dDtIni) + " - " + DTOC(loc_dDtFim)

                    SELECT dbProduto
                    GO TOP
                    IF !EOF()
                        SCAN FOR BETWEEN(dbProduto.datas, loc_dDtIni, loc_dDtFim)
                            IF USED("crTmpPro")
                                USE IN crTmpPro
                            ENDIF
                            loc_cSQL = "SELECT cpros, reffs, colecoes FROM SigCdPro" + ;
                                " WHERE cpros = " + EscaparSQL(dbProduto.cpros)
                            SQLEXEC(gnConnHandle, loc_cSQL, "crTmpPro")

                            INSERT INTO TmpRelGv (CabTipo, ValTipo, Cpros, DPros, Qtds, ;
                                    Opers, Emps, Dopes, Numes, Data, Valor, ValoPg, Saldo, ;
                                    Pesos, Cbars, Reffs, Colecoes) ;
                                VALUES (loc_cCabTipo, loc_nValTipo, dbProduto.cpros, ;
                                    dbProduto.dpros, dbProduto.qtds, dbProduto.opers, ;
                                    dbProduto.emps, dbProduto.dopes, ;
                                    VAL(dbProduto.mascnum), dbProduto.datas, ;
                                    dbProduto.totas, dbProduto.origtotas, ;
                                    dbProduto.bastotas, dbProduto.pesos, ;
                                    dbProduto.codbarras, ;
                                    IIF(USED("crTmpPro"), ;
                                        TratarNulo(crTmpPro.reffs, ""), ""), ;
                                    IIF(USED("crTmpPro"), ;
                                        TratarNulo(crTmpPro.colecoes, ""), ""))

                            IF USED("crTmpPro")
                                USE IN crTmpPro
                            ENDIF
                        ENDSCAN
                    ELSE
                        INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
                            VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
                                "o Tem Produtos Adquiridos...")
                    ENDIF
                ENDIF
            ENDIF

            *-- (12) Posicao de Produtos em Producao - depende das abas Vendas
            *-- (dbProduc) e Operacoes Pend. (dbConserto), mesma
            *-- pendencia do bloco (8).
            IF par_lProducao
                loc_nValTipo = 12
                loc_cCabTipo = "Posi" + CHR(231) + CHR(227) + "o de Produtos Em Produ" + ;
                    CHR(231) + CHR(227) + "o"
                IF USED("dbProduc")
                    SELECT dbProduc
                    SET ORDER TO Nenvs
                    GO TOP
                    IF !EOF()
                        SCAN
                            IF USED("dbConserto")
                                = SEEK(dbProduc.emps + dbProduc.dopes + ;
                                    STR(dbProduc.numes, 6), "dbConserto", "EmpDopNum")
                            ENDIF
                            INSERT INTO TmpRelGv (CabTipo, ValTipo, Dopes, Numes, Data, ;
                                    PrazoEnts, Cpros, Fase, Qtds, Nenvs, Nops, xPer) ;
                                VALUES (loc_cCabTipo, loc_nValTipo, dbProduc.dopes, ;
                                    dbProduc.numes, ;
                                    IIF(USED("dbConserto"), dbConserto.datas, {}), ;
                                    IIF(USED("dbConserto"), dbConserto.prazoents, {}), ;
                                    dbProduc.cpros, dbProduc.fase, dbProduc.qtde, ;
                                    dbProduc.nenvs, dbProduc.nops, dbProduc.xper)
                        ENDSCAN
                    ELSE
                        INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
                            VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
                                "o Tem Produtos em Produ" + CHR(231) + CHR(227) + "o...")
                    ENDIF
                ENDIF
            ENDIF

            *-- (13) Posicao de Estoque
            IF par_lEstoque
                loc_nValTipo = 13
                loc_cCabTipo = "Posi" + CHR(231) + CHR(227) + "o de Estoque "
                IF USED("dbEstoque")
                    SELECT dbEstoque
                    SET ORDER TO Grupos
                    GO TOP
                    IF !EOF()
                        SCAN
                            INSERT INTO TmpRelGv (CabTipo, ValTipo, Grupo, Cpros, Qtds) ;
                                VALUES (loc_cCabTipo, loc_nValTipo, dbEstoque.grupos, ;
                                    dbEstoque.cpros, dbEstoque.sqtds)
                        ENDSCAN
                    ELSE
                        INSERT INTO TmpRelGv (CabTipo, ValTipo, Observa) ;
                            VALUES (loc_cCabTipo, loc_nValTipo, "Conta n" + CHR(227) + ;
                                "o Tem Produtos em Estoque...")
                    ENDIF
                ENDIF
            ENDIF

            *-- Mesmo guard do legado: sem nenhuma linha, nao ha o que
            *-- mostrar (regra #50 - avisar, nao abrir relatorio vazio)
            SELECT TmpRelGv
            GO TOP
            IF EOF()
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para imprimir...", ;
                    "Impress" + CHR(227) + "o")
            ELSE
                THIS.ImprimirListagem("SIGOPCGV", "TmpRelGv")
            ENDIF

            IF USED("TmpRelGv")
                USE IN TmpRelGv
            ENDIF
            IF USED("TmpTotal")
                USE IN TmpTotal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao gerar a impress" + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarGradesCheques - Funil UNICO de repintura da aba Cheques: aplica
    * o filtro de grupo nas duas grades filtraveis, espelha os totais do BO nos
    * campos somente-leitura e repinta as quatro grades.
    * PUBLIC: chamado de fora (combo, carga e harness de teste).
    *==========================================================================
    PROCEDURE AtualizarGradesCheques()
        LOCAL loc_oAba, loc_oErro

        TRY
            IF THIS.AbaResultadoDisponivel(3)
                loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3

                THIS.FiltrarPorGrupo("dbAberto",    loc_oAba.cbo_4c_GrupoCheque.Value)
                THIS.FiltrarPorGrupo("dbDevolvido", loc_oAba.cbo_4c_GrupoCheque.Value)

                IF USED("DbTitulo")
                    GO TOP IN DbTitulo
                ENDIF
                IF USED("DbFollow")
                    GO TOP IN DbFollow
                ENDIF

                THIS.PreencherTotaisCheques()

                loc_oAba.grd_4c_ChequeAberto.Refresh()
                loc_oAba.grd_4c_ChequeFollowup.Refresh()
                loc_oAba.grd_4c_ChequeTitulo.Refresh()
                loc_oAba.grd_4c_ChequeDevolvido.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao atualizar as grades de cheques")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PreencherTotaisCheques - Espelha nos campos somente-leitura da aba
    * Cheques os totais calculados pelo BO (o fim do Processa() legado), mais o
    * total da grade de devolvidos, que o legado recalcula a cada troca de
    * grupo no Cmb_Grupo.InteractiveChange.
    *
    * "Limite Disponivel" sai em VERMELHO quando negativo e AZUL quando
    * positivo, como no legado.
    *==========================================================================
    PROCEDURE PreencherTotaisCheques()
        LOCAL loc_oAba, loc_oBO, loc_nTotDev, loc_cMoeda, loc_oErro

        TRY
            IF THIS.AbaResultadoDisponivel(3) AND VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3
                loc_oBO  = THIS.this_oBusinessObject

                loc_oAba.txt_4c_LimiteCred.Value  = loc_oBO.this_nLimiteCredito
                loc_oAba.txt_4c_ChqAVencer.Value  = loc_oBO.this_nChequesAVencer
                loc_oAba.txt_4c_ChqVencidos.Value = loc_oBO.this_nChequesVencidos
                loc_oAba.txt_4c_ChqDevolv.Value   = loc_oBO.this_nChequesDevolvidos
                loc_oAba.txt_4c_SaldoCC.Value     = loc_oBO.this_nSaldoContaCorrente
                loc_oAba.txt_4c_ChqNegoc.Value    = loc_oBO.this_nChequesNegociados
                loc_oAba.txt_4c_VlEstoque.Value   = loc_oBO.this_nValorEstoque
                loc_oAba.txt_4c_LimiteDisp.Value  = loc_oBO.this_nLimiteDisponivel

                loc_oAba.txt_4c_LimiteDisp.ForeColor = ;
                    IIF(loc_oBO.this_nLimiteDisponivel < 0, RGB(255, 0, 0), RGB(0, 0, 255))

                loc_oAba.txt_4c_TotChequeAberto.Value = loc_oBO.this_nTotalChequeAberto

                *-- Total dos devolvidos VISIVEIS (respeita o filtro de grupo)
                loc_nTotDev = 0
                IF USED("dbDevolvido")
                    SELECT dbDevolvido
                    SUM dbDevolvido.valors TO loc_nTotDev
                    GO TOP IN dbDevolvido
                ENDIF
                loc_oAba.txt_4c_TotDevolvido.Value = loc_nTotDev

                *-- Moeda do limite de credito nos dois rotulos "R$" do legado
                loc_cMoeda = ALLTRIM(loc_oBO.this_cMoedaPadrao)
                IF !EMPTY(loc_cMoeda)
                    loc_oAba.lbl_4c_MoedaConta.Caption = loc_cMoeda
                    loc_oAba.lbl_4c_MoedaHist.Caption  = loc_cMoeda
                ENDIF

                loc_oAba.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao exibir os totais de cheques")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CboGrupoChequeInteractiveChange - Cmb_Grupo.InteractiveChange da aba
    * Cheques: refaz o filtro de grupo, os totais e a repintura.
    *==========================================================================
    PROCEDURE CboGrupoChequeInteractiveChange()
        THIS.AtualizarGradesCheques()
    ENDPROC

    *==========================================================================
    * GradeChequeAbertoAfterRowColChange - grd_che_aberto.AfterRowColChange do
    * legado: o follow-up exibido eh o do cheque da linha corrente.
    *
    * Sem filtro de coluna de proposito: aqui o AfterRowColChange eh usado para
    * carregar o DETALHE da linha corrente (uso correto do evento), nao para
    * validar celula.
    *==========================================================================
    PROCEDURE GradeChequeAbertoAfterRowColChange(par_nColIndex)
        LOCAL loc_oAba, loc_oErro

        TRY
            IF USED("DbFollow") AND USED("dbAberto") AND THIS.AbaResultadoDisponivel(3)
                loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3

                SELECT DbFollow
                SET ORDER TO TAG Nums
                IF EOF("dbAberto") OR EMPTY(TratarNulo(dbAberto.Nums, ""))
                    SET KEY TO
                ELSE
                    SET KEY TO PADR(ALLTRIM(dbAberto.Nums), 8)
                ENDIF
                GO TOP

                loc_oAba.grd_4c_ChequeFollowup.Refresh()
                SELECT dbAberto
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao exibir o follow-up do cheque")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeChequeTituloAfterRowColChange - Grd_titulo.AfterRowColChange do
    * legado: a observacao do titulo corrente vai para os dois campos de
    * observacao (o legado parte o historico de 40 em duas metades de 20).
    *==========================================================================
    PROCEDURE GradeChequeTituloAfterRowColChange(par_nColIndex)
        LOCAL loc_oAba, loc_cHists, loc_oErro

        TRY
            IF USED("DbTitulo") AND THIS.AbaResultadoDisponivel(3)
                loc_oAba   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3
                loc_cHists = IIF(EOF("DbTitulo"), "", TratarNulo(DbTitulo.Hists, ""))

                loc_oAba.txt_4c_ObsNegoc1.Value = LEFT(loc_cHists, 20)
                loc_oAba.txt_4c_ObsNegoc2.Value = RIGHT(loc_cHists, 20)
                loc_oAba.txt_4c_ObsNegoc1.Refresh()
                loc_oAba.txt_4c_ObsNegoc2.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao exibir a observa" + CHR(231) + CHR(227) + "o do t" + ;
                CHR(237) + "tulo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarGradeCartao - Funil UNICO de repintura da aba Cartao.
    * PUBLIC: chamado de fora (carga e harness de teste).
    *==========================================================================
    PROCEDURE AtualizarGradeCartao()
        LOCAL loc_oErro

        TRY
            IF THIS.AbaResultadoDisponivel(4)
                IF USED("TmpCart")
                    GO TOP IN TmpCart
                ENDIF
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page4.grd_4c_Cartao.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao atualizar a grade de cart" + CHR(245) + "es")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarGradeEstoque - Funil UNICO de repintura da aba Estoque: aplica o
    * filtro de grupo e repinta.
    * PUBLIC: chamado de fora (combo, carga e harness de teste).
    *==========================================================================
    PROCEDURE AtualizarGradeEstoque()
        LOCAL loc_oAba, loc_oErro

        TRY
            IF THIS.AbaResultadoDisponivel(6)
                loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page6
                THIS.FiltrarPorGrupo("dbEstoque", loc_oAba.cbo_4c_GrupoEstoque.Value)
                loc_oAba.grd_4c_Estoque.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao atualizar a grade de estoque")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CboGrupoEstoqueInteractiveChange - Cmb_Grupo.InteractiveChange da aba
    * Estoque.
    *==========================================================================
    PROCEDURE CboGrupoEstoqueInteractiveChange()
        THIS.AtualizarGradeEstoque()
    ENDPROC

    *==========================================================================
    * AtualizarGradeHCheques - Funil UNICO de repintura da aba H.Cheques
    * (regra #21a). GO TOP nos tres cursores + Refresh das tres grades.
    * PUBLIC: chamado de fora (carga, grid e harness de teste).
    *==========================================================================
    PROCEDURE AtualizarGradeHCheques()
        LOCAL loc_oAba, loc_oErro

        TRY
            IF THIS.AbaResultadoDisponivel(9)
                loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page9

                IF USED("dbCheqHist")
                    SELECT dbCheqHist
                    GO TOP
                ENDIF
                IF USED("dbCheqMovim")
                    SELECT dbCheqMovim
                    GO TOP
                ENDIF
                IF USED("dbCheqProrrog")
                    SELECT dbCheqProrrog
                    GO TOP
                ENDIF

                loc_oAba.grd_4c_HistCheque.Refresh()
                loc_oAba.grd_4c_MovCheque.Refresh()
                loc_oAba.grd_4c_ProrrogCheque.Refresh()

                loc_oAba.cnt_4c_Followup.txt_4c_UltFollowup.Value = ;
                    TratarNulo(THIS.this_oBusinessObject.this_cFollowUpCheque, "")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao atualizar a grade de hist" + CHR(243) + "rico de cheques")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeHistChequeAfterRowColChange - Transcricao do AfterRowColChange da
    * GradeCheque do legado (aba H.Cheques): ao mudar de linha, recarrega a
    * movimentacao/prorrogacoes/follow-up do cheque agora selecionado e
    * atualiza o Caption do form com o cliente da conta (todas as linhas desta
    * grade pertencem a mesma conta pesquisada - this_cDescConta/this_cCpf ja
    * carregados, sem precisar reconsultar SigCdCli a cada linha).
    * PUBLIC: ligado via BINDEVENT.
    *==========================================================================
    PROCEDURE GradeHistChequeAfterRowColChange(par_nColIndex)
        LOCAL loc_oAba, loc_oBO, loc_cNums, loc_oErro

        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) = "O" AND USED("dbCheqHist") AND RECCOUNT("dbCheqHist") > 0
                loc_cNums = ALLTRIM(dbCheqHist.Nums)

                IF !EMPTY(loc_cNums)
                    THIS.Caption = "Hist" + CHR(243) + "rico de Cheques de: " + ;
                        ALLTRIM(loc_oBO.this_cConta) + " - " + ;
                        ALLTRIM(loc_oBO.this_cDescConta) + " / " + ALLTRIM(loc_oBO.this_cCpf)

                    loc_oBO.CarregarMovimentoCheque(loc_cNums)

                    IF THIS.AbaResultadoDisponivel(9)
                        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page9

                        SELECT dbCheqMovim
                        GO TOP
                        loc_oAba.grd_4c_MovCheque.Refresh()

                        SELECT dbCheqProrrog
                        GO TOP
                        loc_oAba.grd_4c_ProrrogCheque.Refresh()

                        loc_oAba.cnt_4c_Followup.txt_4c_UltFollowup.Value = ;
                            TratarNulo(loc_oBO.this_cFollowUpCheque, "")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao atualizar a movimenta" + CHR(231) + CHR(227) + "o do cheque")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarGradeCredito - Funil UNICO de repintura da aba Credito: GO TOP
    * + Refresh da grade e o rotulo colorido de situacao do cliente (Label2 do
    * legado - vermelho quando SigCdCli.Situas = "*", azul nos demais casos).
    * PUBLIC: chamado de fora (carga e harness de teste).
    *==========================================================================
    PROCEDURE AtualizarGradeCredito()
        LOCAL loc_oAba, loc_oBO, loc_oErro

        TRY
            IF THIS.AbaResultadoDisponivel(10)
                loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page10
                loc_oBO  = THIS.this_oBusinessObject

                IF USED("dbCredito")
                    SELECT dbCredito
                    GO TOP
                ENDIF

                loc_oAba.pgf_4c_Credito.Page1.grd_4c_Credito.Refresh()

                IF VARTYPE(loc_oBO) = "O"
                    loc_oAba.lbl_4c_SituacaoCredito.Caption = ;
                        IIF(EMPTY(loc_oBO.this_cLabelSituacaoCredito), ;
                            "CLIENTE", ALLTRIM(loc_oBO.this_cLabelSituacaoCredito))
                    loc_oAba.lbl_4c_SituacaoCredito.ForeColor = ;
                        IIF(loc_oBO.this_lSituacaoVermelha, RGB(255, 0, 0), RGB(0, 0, 255))
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao atualizar a grade de cr" + CHR(233) + "dito")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbaResultadoDisponivel - .T. quando a aba N da pagina Resultado ja esta
    * montada. As repinturas sao chamadas tambem durante a carga, antes de a
    * fase de montagem terminar - por isso o guard, que evita "object is not
    * found" sem precisar de TRY vazio em cada chamador.
    *==========================================================================
    PROTECTED FUNCTION AbaResultadoDisponivel(par_nAba)
        LOCAL loc_lDisponivel, loc_oPg
        loc_lDisponivel = .F.

        IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            loc_oPg = THIS.pgf_4c_Paginas.Page2
            IF PEMSTATUS(loc_oPg, "pgf_4c_Resultado", 5)
                IF BETWEEN(par_nAba, 1, loc_oPg.pgf_4c_Resultado.PageCount)
                    *-- A pagina existe; falta saber se o conteudo dela foi criado
                    loc_lDisponivel = (loc_oPg.pgf_4c_Resultado.Pages(par_nAba).ControlCount > 0)
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lDisponivel
    ENDFUNC

    *==========================================================================
    * CarregarAbasResultado - Carga das abas desta fase (Pendencias, Cheques,
    * Cartao e Estoque), no mesmo encadeamento do Processa()/PCartao()/
    * PEstoque() legado: le os parametros do sistema, popula os cursores pelo
    * BO, monta os combos de grupo com os grupos que apareceram e repinta cada
    * grade pelo seu funil.
    * PUBLIC: chamado por CarregarDados e pelo harness de teste.
    *==========================================================================
    PROCEDURE CarregarAbasResultado()
        LOCAL loc_oBO, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_oBO = THIS.this_oBusinessObject

                *-- Parametros (grupo padrao, moedas, tipo de preco, flags de
                *-- limite) - de quem dependem os totais da aba Cheques
                loc_oBO.CarregarParametros()

                *-- Pendencias
                IF loc_oBO.CarregarPendencias()
                    IF THIS.AbaResultadoDisponivel(2)
                        THIS.PreencherComboGrupo( ;
                            THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page2.cbo_4c_GrupoPend, ;
                            "TmpPar")
                    ENDIF
                    THIS.AtualizarGradePendencias()
                ELSE
                    IF !EMPTY(loc_oBO.this_cMensagemErro)
                        MsgAviso(loc_oBO.this_cMensagemErro, "Pend" + CHR(234) + "ncias")
                    ENDIF
                ENDIF

                *-- Cheques
                IF loc_oBO.CarregarCheques()
                    IF THIS.AbaResultadoDisponivel(3)
                        THIS.PreencherComboGrupo( ;
                            THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page3.cbo_4c_GrupoCheque, ;
                            "dbAberto")
                    ENDIF
                    THIS.AtualizarGradesCheques()
                ELSE
                    IF !EMPTY(loc_oBO.this_cMensagemErro)
                        MsgAviso(loc_oBO.this_cMensagemErro, "Cheques")
                    ENDIF
                ENDIF

                *-- Cartoes
                IF loc_oBO.CarregarCartoes()
                    THIS.AtualizarGradeCartao()
                ELSE
                    IF !EMPTY(loc_oBO.this_cMensagemErro)
                        MsgAviso(loc_oBO.this_cMensagemErro, "Cart" + CHR(245) + "es")
                    ENDIF
                ENDIF

                *-- Estoque
                IF loc_oBO.CarregarEstoque()
                    IF THIS.AbaResultadoDisponivel(6)
                        THIS.PreencherComboGrupo( ;
                            THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultado.Page6.cbo_4c_GrupoEstoque, ;
                            "dbEstoque")
                    ENDIF
                    THIS.AtualizarGradeEstoque()
                ELSE
                    IF !EMPTY(loc_oBO.this_cMensagemErro)
                        MsgAviso(loc_oBO.this_cMensagemErro, "Estoque")
                    ENDIF
                ENDIF

                *-- H.Cheques
                IF loc_oBO.CarregarHCheques()
                    THIS.AtualizarGradeHCheques()
                ELSE
                    IF !EMPTY(loc_oBO.this_cMensagemErro)
                        MsgAviso(loc_oBO.this_cMensagemErro, "Hist" + CHR(243) + "rico de Cheques")
                    ENDIF
                ENDIF

                *-- Credito
                IF loc_oBO.CarregarCredito()
                    THIS.AtualizarGradeCredito()
                ELSE
                    IF !EMPTY(loc_oBO.this_cMensagemErro)
                        MsgAviso(loc_oBO.this_cMensagemErro, "Cr" + CHR(233) + "dito")
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Proc: " + loc_oErro.Procedure, "Erro ao carregar as abas de resultado")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC



    *==========================================================================
    *                   FASE 8/8 - EVENTOS AUXILIARES
    *
    * Os nomes canonicos abaixo nao sao decoracao: cada um recebeu o bloco do
    * legado que faz aquele papel nesta tela, e os metodos das fases anteriores
    * passaram a entrar por eles (funil unico, regra #40).
    *
    *   FormParaBO / BOParaForm  -> os cinco criterios do container Origem
    *                               (Conta / Nome / CPF / Conjuge / Telefone),
    *                               o optFiltro e o periodo do cnt_periodo.
    *   HabilitarCampos          -> a cascata de When do legado nos criterios
    *                               (Get_cpf.When, Get_dconta.When,
    *                               GetConj.When, getTelefone.When,
    *                               optFiltro.When).
    *   LimparCampos             -> o Space(N) dos cinco campos no
    *                               cmd_voltar.Click mais o LimparDados do BO.
    *   AjustarBotoesPorModo     -> os gates de acesso do Init legado
    *                               (fChecaAcesso CADASTRO/MOVIMENTA) e do par
    *                               Cmd_MudaCli/Cmd_MudaMov (mais IMPRIMIR no
    *                               Imprime), aplicados conforme a pagina e a
    *                               visao correntes.
    *   CarregarLista            -> funil de (re)carga da consulta.
    *   BtnBuscarClick           -> dispara/refaz a consulta.
    *   BtnSalvarClick           -> o bloco "Deseja salvar as alteracoes?" do
    *                               cmd_voltar.Click (mValidaObj + mGravaDados).
    *   BtnCancelarClick /
    *   BtnEncerrarClick         -> cmd_cancela.Click ([ESC] Sair).
    *==========================================================================

    *==========================================================================
    * FormParaBO - Leva para o Business Object TODO criterio que a tela possui:
    * os cinco campos do container Origem, a opcao de filtro de nome
    * (optFiltro) e o periodo da pagina Resultado. Fonte UNICA eh o controle,
    * nunca a property guardada numa consulta anterior.
    *
    * Os dois primeiros campos (Conta e Nome) tambem sao SAIDA das pesquisas da
    * Origem - BuscarPorConta/BuscarPorNome/... resolvem o cliente e
    * AtualizarCamposOrigem devolve o valor resolvido para o controle -, entao
    * reescreve-los aqui eh idempotente no caminho normal. Por isso o guard de
    * ValidarContaSelecionada exige, alem da igualdade do codigo, que o BO
    * tenha a DESCRICAO carregada: so assim "conta ja resolvida" significa
    * resolvida no banco, e nao apenas copiada da tela.
    *
    * PUBLIC: chamado por CarregarDados e pelo harness de teste (regra #3).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_oBO, loc_oCnt, loc_oPer, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_oBO = THIS.this_oBusinessObject

                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Origem", 5)
                    loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem

                    loc_oBO.this_cConta     = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
                    loc_oBO.this_cDescConta = ALLTRIM(loc_oCnt.txt_4c_DConta.Value)
                    loc_oBO.this_cCpf       = ALLTRIM(loc_oCnt.txt_4c_Cpf.Value)
                    loc_oBO.this_cConjuge   = ALLTRIM(loc_oCnt.txt_4c_Conjuge.Value)
                    loc_oBO.this_cTelefone  = ALLTRIM(loc_oCnt.txt_4c_Telefone.Value)

                    *-- optFiltro tem ControlSource NUMERICO de 2 opcoes: o
                    *-- valor gravado eh o INDICE 1-based (1 = Iniciais,
                    *-- 2 = Qualquer Parte), nunca 0/1 logico
                    loc_oBO.this_nOpcaoFiltro = loc_oCnt.obj_4c_OptFiltro.Value
                ENDIF

                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_Periodo", 5)
                    loc_oPer = THIS.pgf_4c_Paginas.Page2.cnt_4c_Periodo

                    *-- ConverterParaData (nao TTOD): o TextBox nasce com {}
                    *-- (DATE) e a coluna do banco chega como DATETIME (regra #16)
                    loc_oBO.this_dDataInicial = ;
                        ConverterParaData(loc_oPer.txt_4c_DtInicial.Value)
                    loc_oBO.this_dDataFinal = ;
                        ConverterParaData(loc_oPer.txt_4c_DtFinal.Value)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Proc: " + loc_oErro.Procedure, ;
                "Erro ao transferir os crit" + CHR(233) + "rios para o Business Object")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - Caminho inverso do FormParaBO: devolve aos controles o que o
    * Business Object carregou (equivalente ao preenchimento cruzado dos campos
    * Conta/Nome/CPF/Conjuge/Telefone que o legado faz no fim de cada Valid de
    * pesquisa bem-sucedida).
    *
    * optFiltro so eh reescrito com indice valido (1..ButtonCount): o BO nasce
    * com this_nOpcaoFiltro = 0 e atribuir 0 a um OptionGroup 1-based
    * desmarcaria as duas opcoes.
    *
    * PUBLIC: chamado por AtualizarCamposOrigem e pelo harness de teste.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oCnt, loc_oPer, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_oBO = THIS.this_oBusinessObject

                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Origem", 5)
                    loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem

                    loc_oCnt.txt_4c_Conta.Value    = loc_oBO.this_cConta
                    loc_oCnt.txt_4c_DConta.Value   = loc_oBO.this_cDescConta
                    loc_oCnt.txt_4c_Cpf.Value      = loc_oBO.this_cCpf
                    loc_oCnt.txt_4c_Conjuge.Value  = loc_oBO.this_cConjuge
                    loc_oCnt.txt_4c_Telefone.Value = loc_oBO.this_cTelefone

                    IF BETWEEN(loc_oBO.this_nOpcaoFiltro, 1, ;
                            loc_oCnt.obj_4c_OptFiltro.ButtonCount)
                        loc_oCnt.obj_4c_OptFiltro.Value = loc_oBO.this_nOpcaoFiltro
                    ENDIF

                    loc_oCnt.Refresh()
                ENDIF

                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_Periodo", 5)
                    loc_oPer = THIS.pgf_4c_Paginas.Page2.cnt_4c_Periodo
                    loc_oPer.txt_4c_DtInicial.Value = loc_oBO.this_dDataInicial
                    loc_oPer.txt_4c_DtFinal.Value   = loc_oBO.this_dDataFinal
                ENDIF

                *-- Criterio novo na tela muda a cascata de When do legado
                THIS.HabilitarCampos(.T.)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Proc: " + loc_oErro.Procedure, ;
                "Erro ao exibir os dados do cliente")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Cascata de When dos criterios da Origem, transcrita
    * campo a campo do dump legado:
    *
    *   Get_conta.When    -> .T. (sempre digitavel)
    *   Get_cpf.When      -> Empty(Get_Conta)
    *   Get_dconta.When   -> Empty(Get_Conta) And Empty(Get_Cpf) And !plCPF
    *   GetConj.When      -> Empty(Get_Conta) And Empty(Get_Cpf) And
    *                        Empty(Get_DConta) And !plCPF
    *   getTelefone.When  -> Empty(Get_Conta) And Empty(Get_Cpf) And
    *                        Empty(Get_DConta) And Empty(getConj)
    *   optFiltro.When    -> !plCPF
    *
    * Usa ReadOnly nos TextBox (e nao Enabled): o When legado bloqueia a
    * DIGITACAO e mantem o texto legivel - exatamente o que ReadOnly faz -, e
    * ReadOnly pode ser trocado durante o LostFocus do proprio campo sem
    * disputar o foco corrente. O OptionGroup nao tem ReadOnly, e a regra dele
    * depende apenas de plCPF (que nao muda no meio da digitacao), por isso
    * continua em Enabled.
    *
    * par_lHabilitar = .F. tranca TODOS os criterios de uma vez (usado quando a
    * tela esta com um painel modal aberto por cima); omitido ou .T. aplica a
    * cascata do legado. PUBLIC: chamado pelos funis e pelo harness de teste.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oCnt, loc_lLiberar, loc_lSoCpf, loc_oErro
        LOCAL loc_lTemConta, loc_lTemCpf, loc_lTemNome, loc_lTemConjuge

        loc_lLiberar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        TRY
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Origem", 5)
                loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem

                loc_lSoCpf = .F.
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    loc_lSoCpf = THIS.this_oBusinessObject.this_lSomenteCPF
                ENDIF

                loc_lTemConta   = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
                loc_lTemCpf     = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Cpf.Value))
                loc_lTemNome    = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_DConta.Value))
                loc_lTemConjuge = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conjuge.Value))

                loc_oCnt.txt_4c_Conta.ReadOnly = !loc_lLiberar

                loc_oCnt.txt_4c_Cpf.ReadOnly = ;
                    !(loc_lLiberar AND !loc_lTemConta)

                loc_oCnt.txt_4c_DConta.ReadOnly = ;
                    !(loc_lLiberar AND !loc_lTemConta AND !loc_lTemCpf AND !loc_lSoCpf)

                loc_oCnt.txt_4c_Conjuge.ReadOnly = ;
                    !(loc_lLiberar AND !loc_lTemConta AND !loc_lTemCpf AND ;
                      !loc_lTemNome AND !loc_lSoCpf)

                loc_oCnt.txt_4c_Telefone.ReadOnly = ;
                    !(loc_lLiberar AND !loc_lTemConta AND !loc_lTemCpf AND ;
                      !loc_lTemNome AND !loc_lTemConjuge)

                loc_oCnt.obj_4c_OptFiltro.Enabled = (loc_lLiberar AND !loc_lSoCpf)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Proc: " + loc_oErro.Procedure, ;
                "Erro ao habilitar os crit" + CHR(233) + "rios de pesquisa")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Bloco de limpeza do cmd_voltar.Click legado:
    *
    *   .Get_conta.Value    = Space(10)
    *   .Get_dconta.Value   = Space(50)
    *   .Get_cpf.Value      = Space(20)
    *   .GetConj.Value      = Space(40)
    *   .getTelefone.Value  = Space(15)
    *   .Refresh
    *
    * mais o LimparDados do BO (que zera os criterios, os flags de controle da
    * consulta e os totais derivados - sem isso a tela mostraria os numeros da
    * conta anterior) e a reaplicacao da cascata de When, que volta a liberar
    * os cinco campos agora que estao vazios.
    *
    * O periodo NAO eh limpo: o legado tambem o preserva entre consultas.
    * PUBLIC: chamado por AlternarPagina e pelo harness de teste.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oCnt, loc_oErro

        TRY
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Origem", 5)
                loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem

                loc_oCnt.txt_4c_Conta.Value    = ""
                loc_oCnt.txt_4c_DConta.Value   = ""
                loc_oCnt.txt_4c_Cpf.Value      = ""
                loc_oCnt.txt_4c_Conjuge.Value  = ""
                loc_oCnt.txt_4c_Telefone.Value = ""
                loc_oCnt.Refresh()
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.LimparDados()
            ENDIF

            THIS.HabilitarCampos(.T.)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Proc: " + loc_oErro.Procedure, ;
                "Erro ao limpar os crit" + CHR(233) + "rios de pesquisa")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Gates de acesso do legado, num funil unico.
    *
    * Pagina Consulta (Init legado):
    *   If Not fChecaAcesso('SIGOPCGV','CADASTRO')  -> Cmd_Cadastro invisivel
    *   If !fChecaAcesso('SIGOPCGV','MOVIMENTA')    -> Cmd_Movimenta invisivel
    *   (Cmd_Cancela nunca depende de acesso)
    *
    * Pagina Resultado (cmd_cadastro.Click do Cmd_MudaCli e cmd_movimenta.Click
    * do Cmd_MudaMov):
    *   .Imprime.Visible = fChecaAcesso('SIGOPCGV','IMPRIMIR')
    *   visao MOVIMENTO  -> MudaCli visivel se fChecaAcesso(...,'CADASTRO')
    *   visao CADASTRO   -> MudaMov visivel se fChecaAcesso(...,'MOVIMENTA')
    *   (o par nunca fica visivel junto - os dois estao no mesmo Left no SCX)
    *
    * O legado tambem reposiciona o grp_operacao quando esconde um botao
    * (Cmd_Movimenta.Left - 81, Width - 81, Left + 81): isso vai junto, para a
    * barra nao ficar com um buraco no lugar do botao escondido.
    *
    * PUBLIC: chamado por AlternarPagina, por AjustarVisibilidadeResultado e
    * pelo harness de teste (regra #3).
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_oGrp, loc_oErro
        LOCAL loc_lCadastro, loc_lMovimenta, loc_lImprimir
        LOCAL loc_lResultado, loc_lVisaoMov, loc_nLargura, loc_nLeft

        TRY
            loc_lCadastro  = fChecaAcesso("SIGOPCGV", "CADASTRO")
            loc_lMovimenta = fChecaAcesso("SIGOPCGV", "MOVIMENTA")
            loc_lImprimir  = fChecaAcesso("SIGOPCGV", "IMPRIMIR")

            loc_lResultado = (THIS.this_cModoAtual == "RESULTADO")
            loc_lVisaoMov  = (THIS.this_cModoResultado == "MOVIMENTO")

            *-- Pagina Consulta
            loc_oPg1 = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPg1, "cmg_4c_GrpOperacao", 5)
                loc_oGrp = loc_oPg1.cmg_4c_GrpOperacao

                loc_oGrp.Buttons(1).Visible = loc_lCadastro
                loc_oGrp.Buttons(1).Enabled = loc_lCadastro
                loc_oGrp.Buttons(2).Visible = loc_lMovimenta
                loc_oGrp.Buttons(2).Enabled = loc_lMovimenta
                loc_oGrp.Buttons(3).Visible = .T.
                loc_oGrp.Buttons(3).Enabled = .T.

                *-- Fecha o buraco deixado por botao escondido (o legado move os
                *-- botoes restantes 81px para a esquerda e encolhe o grupo)
                loc_nLargura = 235
                loc_nLeft    = 769

                IF !loc_lCadastro
                    loc_oGrp.Buttons(2).Left = 5
                    loc_oGrp.Buttons(3).Left = 80
                    loc_nLargura = loc_nLargura - 81
                    loc_nLeft    = loc_nLeft + 81
                ENDIF

                IF !loc_lMovimenta
                    loc_oGrp.Buttons(3).Left = IIF(loc_lCadastro, 80, 5)
                    loc_nLargura = loc_nLargura - 81
                    loc_nLeft    = loc_nLeft + 81
                ENDIF

                loc_oGrp.Width = loc_nLargura
                loc_oGrp.Left  = loc_nLeft
            ENDIF

            *-- Pagina Resultado
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "cmd_4c_Imprime", 5)
                loc_oPg2.cmd_4c_Imprime.Visible = (loc_lResultado AND loc_lImprimir)
                loc_oPg2.cmd_4c_Imprime.Enabled = loc_oPg2.cmd_4c_Imprime.Visible
            ENDIF

            IF PEMSTATUS(loc_oPg2, "cmg_4c_MudaCli", 5)
                loc_oPg2.cmg_4c_MudaCli.Visible = ;
                    (loc_lResultado AND loc_lVisaoMov AND loc_lCadastro)
                loc_oPg2.cmg_4c_MudaCli.Enabled = loc_oPg2.cmg_4c_MudaCli.Visible
            ENDIF

            IF PEMSTATUS(loc_oPg2, "cmg_4c_MudaMov", 5)
                loc_oPg2.cmg_4c_MudaMov.Visible = ;
                    (loc_lResultado AND !loc_lVisaoMov AND loc_lMovimenta)
                loc_oPg2.cmg_4c_MudaMov.Enabled = loc_oPg2.cmg_4c_MudaMov.Visible
            ENDIF

            IF PEMSTATUS(loc_oPg2, "cmg_4c_Voltar", 5)
                loc_oPg2.cmg_4c_Voltar.Visible = loc_lResultado
                loc_oPg2.cmg_4c_Voltar.Enabled = loc_lResultado
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Proc: " + loc_oErro.Procedure, ;
                "Erro ao ajustar os bot" + CHR(245) + "es")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Funil de (re)carga da consulta. Nesta tela a "lista" sao
    * as grades das abas da pagina Resultado, e quem as popula eh o
    * CarregarDados (historico/saldo) somado ao CarregarAbasResultado
    * (pendencias, cheques, cartoes, estoque, historico de cheques e credito),
    * que ele ja encadeia - exatamente a sequencia do Processa() legado.
    * PUBLIC: chamado pelos botoes e pelo harness de teste (regra #3).
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Dispara a consulta. Na pagina Consulta eh a entrada do
    * cmd_movimenta.Click legado (valida a conta, carrega e abre a pagina
    * Resultado na visao MOVIMENTO); com a pagina Resultado ja aberta, refaz a
    * consulta da conta corrente - o mesmo que o legado faz no
    * get_dt_final.LostFocus (ConsultaExecutada = .f. + Processa()).
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        IF THIS.this_cModoAtual == "RESULTADO"
            THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
            THIS.CarregarLista()
            THIS.AtualizarAbaResultadoAtiva()
        ELSE
            THIS.BtnMovimentoClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Bloco de gravacao do cmd_voltar.Click legado:
    *
    *   IF ThisForm.pcEscolha = 'ALTERAR'
    *       IF MessageBox('Deseja salvar as alteracoes?',32+4,...) = 6
    *           IF thisform...CntConta.mvalidaobj() < 1
    *               RETURN .f.
    *           endif
    *           thisform...CntConta.mgravadados()
    *       ENDIF
    *   ENDIF
    *
    * Retorna .F. SO quando a saida deve ser abortada (a validacao do cadastro
    * recusou): fora do modo ALTERAR, ou com o usuario respondendo Nao, o
    * legado simplesmente segue - por isso .T. nos dois casos.
    *
    * A gravacao em si eh do wrapper cadastral da conta (cntConta), por onde o
    * legado edita o cliente; sem ele na tela a alteracao se faz pelo Cadastro
    * de Clientes, e o metodo diz isso em vez de devolver sucesso falso.
    *
    * PUBLIC: chamado por BtnVoltarClick e pelo harness de teste (regra #3).
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lProsseguir, loc_oPg, loc_nValida, loc_oErro

        *-- Fora de ALTERAR nao ha o que gravar e a saida segue normalmente
        IF !(UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cEscolha)) == "ALTERAR")
            RETURN .T.
        ENDIF

        IF !MsgConfirma("Deseja salvar as altera" + CHR(231) + CHR(245) + "es?", ;
                "Altera" + CHR(231) + CHR(227) + "o de Cliente")
            RETURN .T.
        ENDIF

        loc_oPg = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPg, "cntConta", 5)
            MsgAviso("A altera" + CHR(231) + CHR(227) + "o dos dados cadastrais " + ;
                "desta conta se faz pelo Cadastro de Clientes.", THIS.Caption)
            RETURN .F.
        ENDIF

        loc_lProsseguir = .T.

        TRY
            *-- mValidaObj() < 1 recusa a gravacao e mantem a tela aberta
            loc_nValida = loc_oPg.cntConta.mValidaObj()

            IF VARTYPE(loc_nValida) = "N" AND loc_nValida < 1
                loc_lProsseguir = .F.
            ELSE
                loc_oPg.cntConta.mGravaDados()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Proc: " + loc_oErro.Procedure, ;
                "Erro ao gravar a altera" + CHR(231) + CHR(227) + "o do cliente")
            loc_lProsseguir = .F.
        ENDTRY

        RETURN loc_lProsseguir
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - cmd_cancela.Click do grp_operacao legado ("[ESC] Sair",
    * Cancel = .T., Click = ThisForm.Release). Com a pagina Resultado aberta o
    * Cancelar ABANDONA a consulta sem passar pela gravacao (quem oferece
    * gravar eh o Voltar, via BtnSalvarClick) e devolve a tela para a Consulta;
    * na pagina Consulta ele encerra, como no legado.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        IF THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.this_oBusinessObject.this_cEscolha = "CONSULTAR"
            THIS.AlternarPagina(1)
        ELSE
            THIS.BtnEncerrarClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha a tela devolvendo o controle ao form chamador,
    * como o legado faz no ramo Automatico do cmd_voltar.Click
    * (ThisForm.Release + poForm1.Enabled = .t.).
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        IF VARTYPE(THIS.this_oFormPai) = "O" AND !THIS.this_oFormPai.Enabled
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        THIS.Release()
    ENDPROC
ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopcgvBO.prg):
*==============================================================================
* SIGOPCGVBO.PRG
* Business Object para Pesquisa Global de Vendas (SIGOPCGV)
*
* Entidade central da consulta : SigCdCli (conta pesquisada)
* Chave Primaria da entidade   : iclis char(10)
*
* Nota: Form OPERACIONAL de CONSULTA (nao CRUD) - agrega dados de saldo,
*       cheques, vendas, estoque, pendencias, conserto, cartao, producao e
*       credito de uma conta/cliente, lidos de varias tabelas (SigCdCli,
*       SigCdCrd, SigMvEst, SigMvCab, SigCdOpe, SigCdCeb, SigCdmp, SigSyImp,
*       SigCdAcG, entre outras). O comportamento padrao de Inserir/
*       Atualizar/ExecutarExclusao herdado de BusinessBase ja eh o correto.
*==============================================================================

DEFINE CLASS sigopcgvBO AS BusinessBase

    *-- Criterios de pesquisa (pagina Consulta / Origem)
    this_cConta             = ""    && iclis digitado p/ pesquisa (Get_Conta)
    this_cDescConta         = ""    && nome do cliente (Get_DConta / rclis)
    this_cCpf               = ""    && cpf ou cgc digitado (Get_Cpf)
    this_cConjuge           = ""    && nome do conjuge (GetConj)
    this_cTelefone          = ""    && telefone digitado (getTelefone)
    this_nOpcaoFiltro       = 0     && optFiltro.Value - tipo de filtro de pesquisa
    this_lSomenteCPF        = .F.   && ThisForm.plCPF - restringe pesquisa a CPF

    *-- Criterios de pesquisa (Envelope/O.P. - paginas Vendas e Producao)
    this_cEnvelope          = ""    && numero do envelope/O.P. (Get_Envelope -> Nenvs)
    this_cOperacao          = ""    && numero da operacao (Get_Op -> Nops)

    *-- Periodo de consulta (paginas Saldo/Cheque/hcheques)
    this_dDataInicial       = {}    && get_dt_inicial
    this_dDataFinal         = {}    && get_dt_final

    *-- Vendedor / usuario corrente
    this_cVendedor          = ""    && ThisForm.UsuVendedor

    *-- Flags de controle de fluxo da consulta (equivalentes as PUBLIC vars do form legado)
    this_cEscolha           = ""    && ThisForm.pcEscolha ("CONSULTAR"/"ALTERAR")
    this_lConsultaExecutada = .F.   && ThisForm.ConsultaExecutada
    this_lAutomatico        = .F.   && ThisForm.Automatico
    this_lOkProduto         = .F.   && ThisForm.OkProduto
    this_lOkEstoque         = .F.   && ThisForm.OkEstoque
    this_lOkCartao          = .F.   && ThisForm.OkCartao
    this_nGradeSel          = 0     && ThisForm.GradeSel (1=grid Produto, 2=grid Operacoes)
    this_cUltimoProduto     = ""    && ThisForm.UltProduto

    *-- Flags de criterio dos totais (regra #21 - condicoes ao redor do SCAN/SUM)
    this_lSubTotalSubn      = .F.   && ChkSubn
    this_lSubTotalPagos     = .F.   && ChkPagos
    this_lSubTotalBxParcs   = .F.   && ChkBxParcs

    *-- Grupo padrao do cliente (crSigCdPam.grpadclis)
    this_cGrupoPadrao       = ""

    *-- Dados do cliente localizado pela pesquisa (SigCdCli)
    this_cGrupoCliente      = ""    && grupos     char(10) - grupo do cliente
    this_nClienteInativo    = 0     && Inativas   numeric(1,0) - cliente inativo

    *-- Parametros do sistema (SigCdPam) lidos em CarregarParametros - o legado
    *-- os le dos cursores globais crSigCdPam/crSigCdGcr, que o sistema novo nao
    *-- pre-carrega no startup (ver nota em CarregarParametros).
    this_cMoedaPadrao       = ""    && SigCdPam.moedaps  - moeda do limite de credito
    this_cMoedaLimEstoque   = ""    && SigCdPam.moelimes - moeda do limite de estoque
    this_nTipoPreco         = 0     && SigCdPam.tpprecos - 1 = preco de venda, 2 = custo
    this_lChqLimitaCredito  = .F.   && SigCdPam.chqlcreds - cheque consome o limite
    this_nGrupoLimCredito   = 0     && SigCdGcr.limcres   - grupo controla limite de credito
    this_nGrupoLimEstoque   = 0     && SigCdGcr.limestoqs - grupo controla limite de estoque

    *-- Totais da aba Cheques (os 9 campos somente-leitura que o Processa()
    *-- legado atribui no fim: Get_LCred, Get_ChqAv, Get_ChqVc, Get_ChqDv,
    *-- Get_SaldoCc, Get_ChqNeg, Get_Dispon, Get_VlEstoque e Fwget3)
    this_nLimiteCredito     = 0     && _Limite  - limite de credito do cliente
    this_nChequesAVencer    = 0     && _ChqAv   - cheques com vencimento >= hoje
    this_nChequesVencidos   = 0     && _ChqVc   - cheques com vencimento < hoje
    this_nChequesDevolvidos = 0     && _ChqDv   - cheques marcados como devolvidos
    this_nSaldoContaCorrente = 0    && _Saldo   - saldo consolidado de SigMvSlc
    this_nChequesNegociados = 0     && _ChqNeg  - saldo dos titulos (cheques negociados)
    this_nLimiteDisponivel  = 0     && _Disp    - limite - saldo - negociados - estoque
    this_nValorEstoque      = 0     && _VlEstq  - valor do estoque em poder do cliente
    this_nTotalChequeAberto = 0     && lnVal    - soma de dbAberto.valors
    this_nTotalDevolvido    = 0     && _TotDev  - soma de dbDevolvido.valors

    *-- Aba H.Cheques (mativahcheque legado)
    this_cFollowUpCheque    = ""    && Cnt_Followup.UltFollowup - ultimo historico (SigCheh.Hists)

    *-- Aba Credito (mativacredito legado)
    this_cLabelSituacaoCredito = "" && Label2.Caption - descricao da situacao (SigCdCst.Descrs)
    this_lSituacaoVermelha     = .F. && Label2.ForeColor - .T. quando SigCdCli.Situas = "*"

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCli"
            THIS.this_cCampoChave = "iclis"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigopcgvBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - BusinessBase deixa este metodo para a subclasse ("Subclasses
    * devem limpar suas propriedades especificas"): aqui ele zera os CRITERIOS
    * de pesquisa e o resultado derivado deles, que eh o que o cmd_voltar.Click
    * legado faz ao devolver a tela para a pagina Consulta (Space(10) em
    * Get_conta, Space(50) em Get_dconta, Space(20) em Get_cpf, Space(40) em
    * GetConj e Space(15) em getTelefone) somado aos flags de controle do
    * Processa()/PCartao()/PEstoque() (ConsultaExecutada / OkProduto /
    * OkEstoque / OkCartao), que o legado reposiciona a cada nova consulta.
    *
    * NAO zera o que veio de PARAMETRO/sessao e vale para a tela inteira:
    * this_lSomenteCPF (plCPF), this_lAutomatico (Automatico) e this_cVendedor
    * (UsuVendedor, resolvido uma vez pelo ChecaSenha) - limpa-los faria a
    * proxima pesquisa perder a restricao recebida na abertura.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        *-- Criterios de pesquisa (container Origem do legado)
        THIS.this_cConta       = ""
        THIS.this_cDescConta   = ""
        THIS.this_cCpf         = ""
        THIS.this_cConjuge     = ""
        THIS.this_cTelefone    = ""
        THIS.this_nOpcaoFiltro = 1

        *-- Criterios do bloco Producao (Envelope / O.P.)
        THIS.this_cEnvelope  = ""
        THIS.this_cOperacao  = ""

        *-- Dados do cliente localizado
        THIS.this_cGrupoCliente   = ""
        THIS.this_nClienteInativo = 0

        *-- Flags de controle da consulta
        THIS.this_cEscolha           = ""
        THIS.this_lConsultaExecutada = .F.
        THIS.this_lOkProduto         = .F.
        THIS.this_lOkEstoque         = .F.
        THIS.this_lOkCartao          = .F.
        THIS.this_nGradeSel          = 0
        THIS.this_cUltimoProduto     = ""

        *-- Totais derivados (pe da aba Cheques) - sem isso a tela mostraria
        *-- os numeros da conta ANTERIOR enquanto a nova consulta nao roda
        THIS.this_nLimiteCredito      = 0
        THIS.this_nChequesAVencer     = 0
        THIS.this_nChequesVencidos    = 0
        THIS.this_nChequesDevolvidos  = 0
        THIS.this_nSaldoContaCorrente = 0
        THIS.this_nChequesNegociados  = 0
        THIS.this_nLimiteDisponivel   = 0
        THIS.this_nValorEstoque       = 0
        THIS.this_nTotalChequeAberto  = 0
        THIS.this_nTotalDevolvido     = 0

        *-- Textos derivados do cliente localizado
        THIS.this_cFollowUpCheque       = ""
        THIS.this_cLabelSituacaoCredito = ""
        THIS.this_lSituacaoVermelha     = .F.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria (iclis) do cliente
    * localizado pela pesquisa, para uso em RegistrarAuditoria.
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cConta)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades do cliente localizado a
    * partir de um cursor de pesquisa (SigCdCli). As diversas pesquisas do
    * legado (por conta, nome, cpf/cgc, conjuge, telefone) devolvem subconjuntos
    * diferentes de colunas - cada coluna opcional eh conferida com TYPE()
    * antes de ser lida, para nao estourar "Variable X is not found" quando a
    * query de origem nao a selecionou.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- Sempre presentes (toda pesquisa devolve a identificacao da conta)
                THIS.this_cConta       = TratarNulo(iclis, "C")
                THIS.this_cDescConta   = TratarNulo(rclis, "C")
                THIS.this_cCpf         = TratarNulo(cpfs, "C")

                *-- Opcionais - dependem de qual Valid/pesquisa gerou o cursor
                IF TYPE(par_cAliasCursor + ".conjuges") != "U"
                    THIS.this_cConjuge = TratarNulo(conjuges, "C")
                ENDIF

                IF TYPE(par_cAliasCursor + ".tel1s") != "U"
                    THIS.this_cTelefone = TratarNulo(tel1s, "C")
                ENDIF

                IF TYPE(par_cAliasCursor + ".grupos") != "U"
                    THIS.this_cGrupoCliente = TratarNulo(grupos, "C")
                ENDIF

                IF TYPE(par_cAliasCursor + ".inativas") != "U"
                    THIS.this_nClienteInativo = TratarNulo(inativas, "N")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "sigopcgvBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarPorConta - Localiza o cliente pelo codigo exato da conta (iclis).
    * Equivalente ao Get_conta.Valid do legado (sem o auto-load de fAcessoContas
    * - a busca eh por codigo EXATO; o picker de nao-encontrado eh resolvido
    * no Form, via FormBuscaAuxiliar/BuscarPorNome).
    *==========================================================================
    FUNCTION BuscarPorConta(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cConta) != "C" OR EMPTY(ALLTRIM(par_cConta))
            THIS.this_cMensagemErro = "Informe a conta para pesquisa."
            RETURN .F.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel."
            ELSE
                loc_cSQL = "SELECT Iclis, Rclis, Cpfs, Conjuges, Tel1s, Grupos, Inativas" + ;
                    " FROM SigCdCli WHERE Iclis = " + EscaparSQL(ALLTRIM(par_cConta))

                IF USED("cursor_4c_BuscaConta")
                    USE IN cursor_4c_BuscaConta
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

                IF loc_nResultado >= 0
                    IF RECCOUNT("cursor_4c_BuscaConta") > 0
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_BuscaConta")
                    ELSE
                        THIS.this_cMensagemErro = "Conta de Estoque Inv" + CHR(225) + "lida."
                    ENDIF

                    IF USED("cursor_4c_BuscaConta")
                        USE IN cursor_4c_BuscaConta
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao pesquisar a conta:" + CHR(13) + CapturarErroSQL()
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao pesquisar a conta: " + loException.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarPorNome - Localiza clientes cujo nome/razao social CONTENHA o
    * texto digitado (Get_dconta.Valid do legado: Rclis Like '%texto%').
    * Popula par_cCursorDestino com a lista de candidatos (1 ou mais linhas) -
    * a escolha de qual conta usar eh feita pelo Form (picker), que em seguida
    * chama BuscarPorConta()/CarregarDoCursor() com a linha escolhida.
    *==========================================================================
    FUNCTION BuscarPorNome(par_cNome, par_cCursorDestino, par_cModoFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cFiltro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cNome) != "C" OR EMPTY(ALLTRIM(par_cNome))
            THIS.this_cMensagemErro = "Informe o nome para pesquisa."
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDestino) != "C" OR EMPTY(par_cCursorDestino)
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cModoFiltro) != "C"
            par_cModoFiltro = "QUALQUER"
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel."
            ELSE
                *-- optFiltro = Iniciais (prefixo "valor%") ou Qualquer Parte (contem "%valor%")
                IF UPPER(par_cModoFiltro) = "INICIAIS"
                    loc_cFiltro = ALLTRIM(par_cNome) + "%"
                ELSE
                    loc_cFiltro = "%" + ALLTRIM(par_cNome) + "%"
                ENDIF

                loc_cSQL = "SELECT Rclis, Iclis, Cpfs, Conjuges, Inativas" + ;
                    " FROM SigCdCli WHERE Rclis LIKE " + EscaparSQL(loc_cFiltro) + ;
                    " ORDER BY Rclis"

                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

                IF loc_nResultado >= 0
                    IF RECCOUNT(par_cCursorDestino) > 0
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Nenhum cliente encontrado com esse nome."
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao pesquisar por nome:" + CHR(13) + CapturarErroSQL()
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao pesquisar por nome: " + loException.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarPorCpf - Localiza o cliente pelo CPF/CGC digitado (Get_cpf.Valid
    * do legado). Valida o formato (CPF=11 digitos, CNPJ=14) com ValidarCPF/
    * ValidarCNPJ de validators.prg antes de pesquisar, e compara contra a
    * coluna Cpfs MASCARADA (igual ao TransForm do legado), pois eh assim que
    * o valor fica gravado em SigCdCli.Cpfs.
    *==========================================================================
    FUNCTION BuscarPorCpf(par_cCpf, par_cCursorDestino)
        LOCAL loc_cNumeros, loc_cMascarado, loc_lValido, loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cCpf) != "C" OR EMPTY(ALLTRIM(par_cCpf))
            THIS.this_cMensagemErro = "Informe o CPF ou CGC para pesquisa."
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDestino) != "C" OR EMPTY(par_cCursorDestino)
            RETURN .F.
        ENDIF

        loc_cNumeros = SomenteNumeros(par_cCpf)
        loc_lValido  = .F.

        DO CASE
            CASE LEN(loc_cNumeros) = 11
                loc_lValido    = ValidarCPF(loc_cNumeros)
                loc_cMascarado = FormatarCPF(loc_cNumeros)
            CASE LEN(loc_cNumeros) = 14
                loc_lValido    = ValidarCNPJ(loc_cNumeros)
                loc_cMascarado = FormatarCNPJ(loc_cNumeros)
            OTHERWISE
                loc_lValido    = .F.
        ENDCASE

        IF !loc_lValido
            THIS.this_cMensagemErro = "CPF / CGC Incorreto."
            RETURN .F.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel."
            ELSE
                loc_cSQL = "SELECT Iclis, Rclis, Cpfs, Conjuges, Tel1s, Grupos, Inativas" + ;
                    " FROM SigCdCli WHERE Cpfs = " + EscaparSQL(loc_cMascarado)

                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

                IF loc_nResultado >= 0
                    IF RECCOUNT(par_cCursorDestino) > 0
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "CPF / CGC n" + CHR(227) + "o encontrado."
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao pesquisar por CPF/CGC:" + CHR(13) + CapturarErroSQL()
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao pesquisar por CPF/CGC: " + loException.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarPorConjuge - Localiza clientes pelo nome do conjuge, contendo o
    * texto digitado (GetConj.Valid do legado: Conjuges Like '%texto%').
    *==========================================================================
    FUNCTION BuscarPorConjuge(par_cConjuge, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cFiltro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cConjuge) != "C" OR EMPTY(ALLTRIM(par_cConjuge))
            THIS.this_cMensagemErro = "Informe o nome do c" + CHR(244) + "njuge para pesquisa."
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDestino) != "C" OR EMPTY(par_cCursorDestino)
            RETURN .F.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel."
            ELSE
                loc_cFiltro = "%" + ALLTRIM(par_cConjuge) + "%"

                loc_cSQL = "SELECT Conjuges, Tel1s, Grupos, Iclis, Rclis, Cpfs" + ;
                    " FROM SigCdCli WHERE Conjuges LIKE " + EscaparSQL(loc_cFiltro) + ;
                    " ORDER BY Conjuges"

                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

                IF loc_nResultado >= 0
                    IF RECCOUNT(par_cCursorDestino) > 0
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Nenhum cliente encontrado com esse c" + CHR(244) + "njuge."
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao pesquisar por c" + CHR(244) + "njuge:" + CHR(13) + CapturarErroSQL()
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao pesquisar por c" + CHR(244) + "njuge: " + loException.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarPorTelefone - Localiza clientes pelo telefone, contendo o texto
    * digitado (getTelefone.Valid do legado: Tel1s Like '%texto%').
    *==========================================================================
    FUNCTION BuscarPorTelefone(par_cTelefone, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cFiltro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cTelefone) != "C" OR EMPTY(ALLTRIM(par_cTelefone))
            THIS.this_cMensagemErro = "Informe o telefone para pesquisa."
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDestino) != "C" OR EMPTY(par_cCursorDestino)
            RETURN .F.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel."
            ELSE
                loc_cFiltro = "%" + ALLTRIM(par_cTelefone) + "%"

                loc_cSQL = "SELECT Tel1s, Conjuges, Grupos, Iclis, Rclis, Cpfs" + ;
                    " FROM SigCdCli WHERE Tel1s LIKE " + EscaparSQL(loc_cFiltro) + ;
                    " ORDER BY Tel1s"

                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

                IF loc_nResultado >= 0
                    IF RECCOUNT(par_cCursorDestino) > 0
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Nenhum cliente encontrado com esse telefone."
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao pesquisar por telefone:" + CHR(13) + CapturarErroSQL()
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao pesquisar por telefone: " + loException.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CriarCursoresLocais - Recria os cursores locais usados pela aba Saldo
    * (dbSaldo/dbHistorico do Init legado - "executa os parametros set
    * iniciais" / "Cursor de saldos da conta" / "Cursor de historico de conta
    * corrente"). Sao cursores de TRABALHO (nao SQL pass-through), por isso
    * precisam ser RECRIADOS (nao so ZAP) a cada pesquisa de conta - o legado
    * tambem os recria no Init, nunca reaproveita o cursor da conta anterior.
    *
    * Cursores criados aqui, e quem os popula:
    *   dbSaldo / dbHistorico             -> CarregarHistoricoSaldo
    *   TmpPar / crTmpTipos               -> CarregarPendencias
    *   dbAberto / dbDevolvido / DbFollow / DbTitulo -> CarregarCheques
    *   TmpCart                           -> CarregarCartoes
    *   dbEstoque                         -> CarregarEstoque
    *
    * Os cursores das abas Vendas / Operacoes em Aberto / Producao / Historico
    * de Cheques / Credito (dbProduto, dbProdTodos, dbOperac, dbConserto,
    * dbOpera, dbProduc, dbItens, dbEstIte, dbTotVendas) entram junto com o
    * conteudo dessas abas, na fase seguinte.
    *==========================================================================
    FUNCTION CriarCursoresLocais()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("dbSaldo")
                USE IN dbSaldo
            ENDIF
            CREATE CURSOR dbSaldo (grupos C(10), moedas C(3), saldos N(12,3), SaldoConta N(12,3))
            SELECT dbSaldo
            INDEX ON grupos + moedas TAG GruMoe
            APPEND BLANK

            IF USED("dbHistorico")
                USE IN dbHistorico
            ENDIF
            CREATE CURSOR dbHistorico (emps C(3), grupos C(10), datas D, valors N(12,2), ;
                opers C(1), saldos N(16,3), hists C(40), hist2s C(40), moedas C(3), ;
                dopes C(20), numes N(6))
            SELECT dbHistorico
            INDEX ON grupos + moedas TAG GruMoe

            *-- Cursor dos valores a receber (aba Pendencias)
            IF USED("TmpPar")
                USE IN TmpPar
            ENDIF
            CREATE CURSOR TmpPar (grupos C(10), vencs D NULL, emps C(3), fpags C(15), ;
                valos N(12,2), moefpgs C(3), hists C(50), dopes C(20), numes N(6), opers C(1))
            SELECT TmpPar
            INDEX ON grupos + opers + DTOS(vencs) TAG GruVencs
            *-- Tag de UMA coluna para o SET KEY do filtro de grupo: chave
            *-- parcial sobre indice composto nao casa com SET EXACT ON (ver
            *-- a regra de INDEX composto + chave parcial no CLAUDE.md)
            INDEX ON grupos TAG Grupos
            SET ORDER TO GruVencs
            APPEND BLANK

            *-- Formas de pagamento marcaveis da aba Pendencias (grdTipos)
            IF USED("crTmpTipos")
                USE IN crTmpTipos
            ENDIF
            CREATE CURSOR crTmpTipos (Listas N(1), fPags C(12))
            SELECT crTmpTipos
            INDEX ON fPags TAG fPags

            *-- Cheques em aberto (aba Cheques)
            IF USED("dbAberto")
                USE IN dbAberto
            ENDIF
            CREATE CURSOR dbAberto (grupos C(10), vencs D, bancos C(3), agencias C(4), ;
                ncheques C(6), valors N(12,2), ncontas C(10), Flags L, Nums C(8), Devolvidos C(1))
            SELECT dbAberto
            INDEX ON grupos + DTOS(vencs) TAG Vencimento
            INDEX ON grupos + DTOS(vencs) DESC TAG VencVal
            INDEX ON grupos TAG Grupos
            SET ORDER TO VencVal
            APPEND BLANK

            *-- Cheques devolvidos (aba Cheques)
            IF USED("dbDevolvido")
                USE IN dbDevolvido
            ENDIF
            CREATE CURSOR dbDevolvido (grupos C(10), vencs D, bancos C(3), agencias C(4), ;
                ncheques C(6), valors N(12,2), ncontas C(10), numincdevs N(2))
            SELECT dbDevolvido
            INDEX ON grupos + DTOS(vencs) DESC TAG VencVal
            INDEX ON bancos + agencias + ncontas + ncheques TAG Cheque
            INDEX ON grupos TAG Grupos
            SET ORDER TO VencVal
            APPEND BLANK

            *-- Follow-up do cheque selecionado (aba Cheques)
            IF USED("DbFollow")
                USE IN DbFollow
            ENDIF
            CREATE CURSOR DbFollow (Nums C(8), Datas D, Hists C(76) NULL)
            SELECT DbFollow
            INDEX ON Nums + DTOS(Datas) TAG NumData
            INDEX ON Nums TAG Nums
            SET ORDER TO NumData

            *-- Titulos / cheques negociados (aba Cheques)
            IF USED("DbTitulo")
                USE IN DbTitulo
            ENDIF
            CREATE CURSOR DbTitulo (Grupos C(10), Titulos C(10), Vencs D, Valors N(12,2), ;
                ValPags N(12,2), Saldos N(12,2), Hists C(26), Moedas C(3))
            SELECT DbTitulo
            INDEX ON Titulos TAG Titulos

            *-- Cartoes de credito em aberto (aba Cartao)
            IF USED("TmpCart")
                USE IN TmpCart
            ENDIF
            CREATE CURSOR TmpCart (grupos C(10), cartaos C(20), datas D, fpags C(12), ;
                valos N(12,2), nocreditos C(10), vencs D)
            SELECT TmpCart
            APPEND BLANK

            *-- Produtos em poder do cliente (aba Estoque)
            IF USED("dbEstoque")
                USE IN dbEstoque
            ENDIF
            CREATE CURSOR dbEstoque (grupos C(10), cpros C(14), sqtds N(10,3))
            SELECT dbEstoque
            INDEX ON grupos TAG Grupos
            APPEND BLANK

            *-- Historico de cheques da conta (aba H.Cheques - GradeCheque)
            IF USED("dbCheqHist")
                USE IN dbCheqHist
            ENDIF
            CREATE CURSOR dbCheqHist (Emps C(3), Vencs D NULL, Bancos C(3), Agencias C(4), ;
                NContas C(10), NCheques C(6), Valors N(11,2), GruCarts C(10), ConCarts C(10), ;
                Numeros C(6), DiasP N(6), Tipo C(8), Nums C(8))
            SELECT dbCheqHist
            INDEX ON Vencs TAG Venc

            *-- Movimentacao do cheque selecionado em dbCheqHist (GradeMovimenta)
            IF USED("dbCheqMovim")
                USE IN dbCheqMovim
            ENDIF
            CREATE CURSOR dbCheqMovim (Codigos C(15), Nalineas N(3), Dtents D NULL, ;
                Gruorigs C(10), Conorigs C(10), Grupos C(10), Contas C(10), Numlotes N(8), ;
                Protocolos C(8))
            SELECT dbCheqMovim

            *-- Prorrogacoes do cheque selecionado (GradeProrrog)
            IF USED("dbCheqProrrog")
                USE IN dbCheqProrrog
            ENDIF
            CREATE CURSOR dbCheqProrrog (Vencs D NULL, PJuros N(5,2), VJuros N(8,2), ;
                Usuars C(30), Motivo C(30))
            SELECT dbCheqProrrog

            *-- Lancamentos de credito/cobranca da conta, por CPF (aba Credito)
            IF USED("dbCredito")
                USE IN dbCredito
            ENDIF
            CREATE CURSOR dbCredito (Tipos C(1), Usuars C(10), Emps C(3), Datas D NULL, ;
                Dopes C(20), Numes N(6), Ccpfs C(20), Nvalors N(15,2), Dvencs D NULL, ;
                Cbancos C(3), Cagencias C(4), Ccontas C(15), Ccheinis C(6), Cdiginis C(1), ;
                Cchefins C(6), Cdigfins C(1), Cseries C(6), Cdaberts C(7), NChkDocs N(1), ;
                TdDocs D NULL)
            SELECT dbCredito

            loc_lSucesso = .T.
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao criar cursores locais: " + loException.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarHistoricoSaldo - Popula os cursores locais da aba Saldo com os
    * dados da conta localizada, reproduzindo o trecho de "Verificando
    * Historicos" / "Verificando Saldo" do Processa() legado:
    *
    *   dbHistorico <- Select * From SigMvCcr Where contas = <conta>
    *                  [And Datas between <ini> and <fim>]  (periodo opcional)
    *
    *   dbSaldo     <- com o periodo EM BRANCO: saldo consolidado de SigMvSlc
    *                  com descricao do grupo (SigCdGcr), nome do cliente
    *                  (SigCdCli) e limite de credito (SigClLcr), de onde sai
    *                  o SaldoConta = (LimCres - saldos) quando ha limite;
    *                  com o periodo PREENCHIDO: soma por grupo/moeda do
    *                  proprio dbHistorico (Valors com sinal por opers),
    *                  exatamente como o legado - nesse ramo o legado NAO
    *                  calcula SaldoConta, que portanto fica zerado.
    *
    * Os dois cursores sao ZAPeados e repopulados (nunca fechados/recriados),
    * para preservar RecordSource/ControlSource/Header/Width dos grids ligados
    * a eles. Quem exibe eh o Form (AtualizarGradesSaldo - GO TOP + Refresh).
    *==========================================================================
    FUNCTION CarregarHistoricoSaldo()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cConta, loc_lTemPeriodo
        LOCAL loc_dIni, loc_dFim, loc_nLinhas
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cConta = ALLTRIM(THIS.this_cConta)
        IF EMPTY(loc_cConta)
            THIS.this_cMensagemErro = "Conta de Estoque Inv" + CHR(225) + "lida."
            RETURN .F.
        ENDIF

        IF !USED("dbHistorico") OR !USED("dbSaldo")
            IF !THIS.CriarCursoresLocais()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel."
            ELSE
                loc_dIni = ConverterParaData(THIS.this_dDataInicial)
                loc_dFim = ConverterParaData(THIS.this_dDataFinal)
                loc_lTemPeriodo = (!EMPTY(loc_dIni) AND !EMPTY(loc_dFim))

                *-- 1) Historico de conta corrente (SigMvCcr)
                SELECT dbHistorico
                ZAP

                loc_cSQL = "SELECT Emps, Grupos, Datas, Valors, Opers, Saldos," + ;
                    " Hists, Hist2s, Moedas, Dopes, Numes" + ;
                    " FROM SigMvCcr" + ;
                    " WHERE Contas = " + EscaparSQL(loc_cConta)

                IF loc_lTemPeriodo
                    loc_cSQL = loc_cSQL + ;
                        " AND Datas BETWEEN " + FormatarDataSQL(DTOT(loc_dIni)) + ;
                        " AND " + FormatarDataSQL(DTOT(loc_dFim) + 86399)
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY Datas, Emps"

                IF USED("cursor_4c_MvCcr")
                    IF CURSORGETPROP("Buffering", "cursor_4c_MvCcr") > 1
                        TABLEREVERT(.T., "cursor_4c_MvCcr")
                    ENDIF
                    USE IN cursor_4c_MvCcr
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcr")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao carregar o hist" + CHR(243) + ;
                        "rico de conta corrente:" + CHR(13) + CapturarErroSQL()
                ELSE
                    SELECT cursor_4c_MvCcr
                    SCAN
                        INSERT INTO dbHistorico ;
                            (emps, grupos, datas, valors, opers, saldos, hists, ;
                             hist2s, moedas, dopes, numes) ;
                            VALUES ;
                            (TratarNulo(cursor_4c_MvCcr.Emps, ""), ;
                             TratarNulo(cursor_4c_MvCcr.Grupos, ""), ;
                             ConverterParaData(cursor_4c_MvCcr.Datas), ;
                             TratarNulo(cursor_4c_MvCcr.Valors, 0), ;
                             TratarNulo(cursor_4c_MvCcr.Opers, ""), ;
                             TratarNulo(cursor_4c_MvCcr.Saldos, 0), ;
                             LEFT(TratarNulo(cursor_4c_MvCcr.Hists, ""), 40), ;
                             LEFT(TratarNulo(cursor_4c_MvCcr.Hist2s, ""), 40), ;
                             TratarNulo(cursor_4c_MvCcr.Moedas, ""), ;
                             TratarNulo(cursor_4c_MvCcr.Dopes, ""), ;
                             TratarNulo(cursor_4c_MvCcr.Numes, 0))
                    ENDSCAN

                    IF USED("cursor_4c_MvCcr")
                        USE IN cursor_4c_MvCcr
                    ENDIF

                    *-- 2) Saldo por grupo/moeda
                    SELECT dbSaldo
                    ZAP
                    loc_nLinhas = 0

                    IF loc_lTemPeriodo
                        *-- Periodo informado: soma do proprio historico carregado
                        IF USED("cursor_4c_SaldoTmp")
                            USE IN cursor_4c_SaldoTmp
                        ENDIF
                        SELECT grupos, moedas, ;
                               SUM(valors * IIF(opers = "D", 1, -1)) AS saldos ;
                            FROM dbHistorico ;
                            GROUP BY grupos, moedas ;
                            INTO CURSOR cursor_4c_SaldoTmp READWRITE

                        SELECT cursor_4c_SaldoTmp
                        SCAN
                            INSERT INTO dbSaldo (grupos, moedas, saldos) ;
                                VALUES (cursor_4c_SaldoTmp.grupos, ;
                                        cursor_4c_SaldoTmp.moedas, ;
                                        cursor_4c_SaldoTmp.saldos)
                            loc_nLinhas = loc_nLinhas + 1
                        ENDSCAN

                        IF USED("cursor_4c_SaldoTmp")
                            USE IN cursor_4c_SaldoTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        *-- Sem periodo: saldo consolidado de SigMvSlc + limite de credito
                        loc_cSQL = "SELECT a.Grupos, c.Descrs, a.Contas, b.Rclis," + ;
                            " a.Moedas, a.Saldos, ISNULL(d.LimCres, 0) AS LimCres," + ;
                            " CASE WHEN ISNULL(d.LimCres, 0) > 0" + ;
                            " THEN (ISNULL(d.LimCres, 0) - a.Saldos)" + ;
                            " ELSE a.Saldos END AS SaldoConta" + ;
                            " FROM SigMvSlc a" + ;
                            " JOIN SigCdCli b ON a.Contas = b.Iclis" + ;
                            " JOIN SigCdGcr c ON a.Grupos = c.Codigos" + ;
                            " LEFT JOIN SigClLcr d ON a.Contas = d.Contas" + ;
                            " WHERE a.Contas = " + EscaparSQL(loc_cConta) + ;
                            " ORDER BY a.Grupos, a.Contas"

                        IF USED("cursor_4c_SaldoTmp")
                            IF CURSORGETPROP("Buffering", "cursor_4c_SaldoTmp") > 1
                                TABLEREVERT(.T., "cursor_4c_SaldoTmp")
                            ENDIF
                            USE IN cursor_4c_SaldoTmp
                        ENDIF

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SaldoTmp")

                        IF loc_nResultado < 0
                            THIS.this_cMensagemErro = "Erro ao carregar o saldo da conta:" + ;
                                CHR(13) + CapturarErroSQL()
                        ELSE
                            SELECT cursor_4c_SaldoTmp
                            SCAN
                                INSERT INTO dbSaldo (grupos, moedas, saldos, SaldoConta) ;
                                    VALUES (TratarNulo(cursor_4c_SaldoTmp.Grupos, ""), ;
                                            TratarNulo(cursor_4c_SaldoTmp.Moedas, ""), ;
                                            TratarNulo(cursor_4c_SaldoTmp.Saldos, 0), ;
                                            TratarNulo(cursor_4c_SaldoTmp.SaldoConta, 0))
                                loc_nLinhas = loc_nLinhas + 1
                            ENDSCAN

                            IF USED("cursor_4c_SaldoTmp")
                                USE IN cursor_4c_SaldoTmp
                            ENDIF
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF

                    *-- O legado zera dbSaldo quando nenhum grupo entrou na lista
                    *-- (Cmb_Grupo.ListCount = 0): sem grupo nao ha saldo a exibir.
                    IF loc_lSucesso AND loc_nLinhas = 0
                        SELECT dbSaldo
                        ZAP
                    ENDIF

                    THIS.this_lConsultaExecutada = loc_lSucesso
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar hist" + CHR(243) + "rico/saldo: " + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarParametros - Le os parametros do sistema que as abas Pendencias /
    * Cheques / Estoque usam para decidir o que calcular.
    *
    * O legado le esses valores de CURSORES GLOBAIS (crSigCdPam / crSigCdGcr)
    * que o startup Fortyus pre-carregava no login. O sistema novo nao faz esse
    * pre-load, entao cada BO que depende deles le a tabela direto (mesmo
    * tratamento dado a crSigCdPam em outros forms migrados):
    *
    *   SigCdPam.grpadclis -> grupo padrao de clientes (this_cGrupoPadrao)
    *   SigCdPam.moedaps   -> moeda do limite de credito (converte os saldos)
    *   SigCdPam.moelimes  -> moeda do limite de estoque
    *   SigCdPam.tpprecos  -> 1 = avalia estoque a preco de venda, 2 = a custo
    *   SigCdPam.chqlcreds -> cheque em carteira consome o limite disponivel
    *   SigCdGcr.limcres   -> o grupo controla limite de credito
    *   SigCdGcr.limestoqs -> o grupo controla limite de estoque
    *
    * SigCdPam eh tabela de parametro de UMA linha - nao leva WHERE.
    *==========================================================================
    FUNCTION CarregarParametros()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF

                loc_cSQL = "SELECT grpadclis, moedaps, moelimes, tpprecos, chqlcreds" + ;
                    " FROM SigCdPam"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Configura" + CHR(231) + CHR(227) + ;
                        "o de Par" + CHR(226) + "metros do Sistema n" + CHR(227) + ;
                        "o Encontrada:" + CHR(13) + CapturarErroSQL()
                ELSE
                    IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                        SELECT cursor_4c_Pam
                        GO TOP
                        THIS.this_cGrupoPadrao      = ALLTRIM(TratarNulo(cursor_4c_Pam.grpadclis, ""))
                        THIS.this_cMoedaPadrao      = ALLTRIM(TratarNulo(cursor_4c_Pam.moedaps, ""))
                        THIS.this_cMoedaLimEstoque  = ALLTRIM(TratarNulo(cursor_4c_Pam.moelimes, ""))
                        THIS.this_nTipoPreco        = TratarNulo(cursor_4c_Pam.tpprecos, 0)
                        THIS.this_lChqLimitaCredito = ConverterParaLogico(cursor_4c_Pam.chqlcreds)
                    ENDIF

                    IF USED("cursor_4c_Pam")
                        USE IN cursor_4c_Pam
                    ENDIF

                    *-- Flags do GRUPO padrao (SigCdGcr): eh ele que decide se
                    *-- existe controle de limite de credito e de estoque
                    THIS.this_nGrupoLimCredito = 0
                    THIS.this_nGrupoLimEstoque = 0

                    IF !EMPTY(THIS.this_cGrupoPadrao)
                        IF USED("cursor_4c_Gcr")
                            USE IN cursor_4c_Gcr
                        ENDIF

                        loc_cSQL = "SELECT limcres, limestoqs FROM SigCdGcr" + ;
                            " WHERE codigos = " + EscaparSQL(THIS.this_cGrupoPadrao)

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gcr")

                        IF loc_nResultado >= 0 AND USED("cursor_4c_Gcr")
                            IF RECCOUNT("cursor_4c_Gcr") > 0
                                SELECT cursor_4c_Gcr
                                GO TOP
                                THIS.this_nGrupoLimCredito = TratarNulo(cursor_4c_Gcr.limcres, 0)
                                THIS.this_nGrupoLimEstoque = TratarNulo(cursor_4c_Gcr.limestoqs, 0)
                            ENDIF
                            USE IN cursor_4c_Gcr
                        ENDIF
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar os par" + CHR(226) + "metros:" + ;
                CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterCotacao - Cotacao da moeda na data informada (SigCdCot), usada para
    * converter saldo / cheque / estoque para a moeda do limite de credito.
    *
    * Substitui fBuscarCotacao()/CarregarCambio() do Framework legado, que nao
    * foram portados. Sem cotacao cadastrada devolve 1 (nao converte), que eh
    * exatamente o que o legado faz quando o Seek em crSigCdCot falha.
    *==========================================================================
    FUNCTION ObterCotacao(par_cMoeda, par_dData)
        LOCAL loc_cSQL, loc_nResultado, loc_nCotacao, loc_dData, loc_cMoeda
        loc_nCotacao = 1

        loc_cMoeda = ALLTRIM(IIF(VARTYPE(par_cMoeda) = "C", par_cMoeda, ""))
        loc_dData  = ConverterParaData(par_dData)
        IF EMPTY(loc_dData)
            loc_dData = DATE()
        ENDIF

        IF EMPTY(loc_cMoeda) OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN loc_nCotacao
        ENDIF

        TRY
            IF USED("cursor_4c_Cot")
                USE IN cursor_4c_Cot
            ENDIF

            loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot" + ;
                " WHERE cmoes = " + EscaparSQL(loc_cMoeda) + ;
                " AND datas <= " + FormatarDataSQL(DTOT(loc_dData) + 86399) + ;
                " ORDER BY datas DESC, horas DESC"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cot")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Cot")
                IF RECCOUNT("cursor_4c_Cot") > 0
                    SELECT cursor_4c_Cot
                    GO TOP
                    IF TratarNulo(cursor_4c_Cot.valos, 0) <> 0
                        loc_nCotacao = TratarNulo(cursor_4c_Cot.valos, 0)
                    ENDIF
                ENDIF
                USE IN cursor_4c_Cot
            ENDIF
        CATCH TO loException
            *-- Cotacao ausente nao interrompe a consulta: segue sem converter
            loc_nCotacao = 1
        ENDTRY

        RETURN loc_nCotacao
    ENDFUNC

    *==========================================================================
    * CarregarGruposCursor - Lista os grupos presentes num cursor de resultado,
    * com a descricao de SigCdGcr, para popular o ComboBox "Grupo :" da aba.
    *
    * Equivale ao Carrega_Combo() do legado, que a cada registro inserido no
    * cursor acrescentava "<grupo> - <descrs>" ao combo da aba e PULAVA o grupo
    * com SigCdGcr.blqcongvs = 1 (grupo bloqueado para a consulta global de
    * vendas). A descricao vem de SigCdGcr pelo mesmo caminho que os outros BOs
    * migrados usam no lugar de fAcessoContab(Usuar, "C", <grupo>).
    *
    * Par: par_cCursorOrigem  - cursor de resultado que tem a coluna "grupos"
    *      par_cCursorDestino - cursor de saida (Codigos, Descrs)
    * Ret: numero de grupos devolvidos
    *==========================================================================
    FUNCTION CarregarGruposCursor(par_cCursorOrigem, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_nGrupos, loc_cLista
        LOCAL loc_cOrigem, loc_cDestino
        loc_nGrupos = 0

        loc_cOrigem  = IIF(VARTYPE(par_cCursorOrigem) = "C", ALLTRIM(par_cCursorOrigem), "")
        loc_cDestino = IIF(VARTYPE(par_cCursorDestino) = "C", ALLTRIM(par_cCursorDestino), "")

        IF EMPTY(loc_cOrigem) OR EMPTY(loc_cDestino) OR !USED(loc_cOrigem)
            RETURN 0
        ENDIF

        TRY
            *-- Grupos distintos do cursor, em lista para o IN do SQL Server
            IF USED("cursor_4c_GrpTmp")
                USE IN cursor_4c_GrpTmp
            ENDIF
            SELECT DISTINCT grupos ;
                FROM (loc_cOrigem) ;
                WHERE !EMPTY(grupos) ;
                INTO CURSOR cursor_4c_GrpTmp READWRITE

            loc_cLista = ""
            SELECT cursor_4c_GrpTmp
            SCAN
                loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ", ") + ;
                    EscaparSQL(ALLTRIM(cursor_4c_GrpTmp.grupos))
            ENDSCAN

            IF USED("cursor_4c_GrpTmp")
                USE IN cursor_4c_GrpTmp
            ENDIF

            IF USED(loc_cDestino)
                USE IN (loc_cDestino)
            ENDIF

            IF EMPTY(loc_cLista) OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                CREATE CURSOR (loc_cDestino) (Codigos C(10), Descrs C(40))
            ELSE
                loc_cSQL = "SELECT codigos AS Codigos, descrs AS Descrs" + ;
                    " FROM SigCdGcr" + ;
                    " WHERE codigos IN (" + loc_cLista + ")" + ;
                    " AND ISNULL(blqcongvs, 0) <> 1" + ;
                    " ORDER BY codigos"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cDestino)

                IF loc_nResultado < 0
                    CREATE CURSOR (loc_cDestino) (Codigos C(10), Descrs C(40))
                ENDIF
            ENDIF

            IF USED(loc_cDestino)
                loc_nGrupos = RECCOUNT(loc_cDestino)
                SELECT (loc_cDestino)
                GO TOP
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar os grupos:" + CHR(13) + ;
                loException.Message
            loc_nGrupos = 0
        ENDTRY

        RETURN loc_nGrupos
    ENDFUNC

    *==========================================================================
    * CarregarPendencias - Popula TmpPar (grade da aba Pendencias) e crTmpTipos
    * (grade de formas de pagamento marcaveis), reproduzindo os dois trechos do
    * Processa() legado que alimentam essa aba:
    *
    *   (1) "Verificando Historicos" - pendencias de CONTA CORRENTE:
    *       varre SigMvCcr da conta e, para cada lancamento que passa o guard do
    *       legado (Nopers <> 0, Tipos em {" ","X"} e - quando tem Dopes+Numes -
    *       Tipos = "X"), insere o saldo em aberto (Valors - Valpags > 0) com a
    *       forma de pagamento fixa "C/Corrente".
    *
    *   (2) "Verificando Historicos (Origem/Destino)" - parcelas de movimento:
    *       SigMvCab + SigMvPar das operacoes da conta (como origem OU destino),
    *       restritas as operacoes que controlam valor em aberto e parcelas
    *       (SigCdOpe.ValPends = 1 e Parcs = 1) e as formas de pagamento que
    *       controlam valor em aberto e nao estao fora da consulta global
    *       (SigOpFp.ValPends = 1 e LisConGv <> 2). O legado monta esse recorte
    *       com um SELECT local sobre tres cursores; aqui o mesmo recorte vai
    *       para o SQL Server, onde as tres tabelas vivem.
    *
    *       O ramo "forma de pagamento do tipo cheque" (SigOpFp.Infos = "C") do
    *       legado so aceita a parcela quando o cheque correspondente esta numa
    *       operacao de DEBITO (SigCdOpt.Tipos = "DB") - transcrito aqui como o
    *       EXISTS sobre SigChe + SigCdOpt.
    *
    *       O grupo da pendencia depende do sentido da operacao: SigCdOpe.COpers
    *       = 1 significa que a conta eh o DESTINO (grupo = Grupods, Opers "D");
    *       caso contrario a conta eh a ORIGEM (grupo = Grupoos, Opers "C").
    *
    *   (3) "Monta grade dos tipos para escolher filtro": as formas de pagamento
    *       distintas que sobraram em TmpPar entram em crTmpTipos JA MARCADAS
    *       (Listas = 1), como no legado.
    *
    * Os cursores sao ZAPeados e repopulados (nunca fechados/recriados), para
    * preservar RecordSource/ControlSource/Header/Width das grades ligadas a
    * eles. Quem exibe eh o Form (AtualizarGradePendencias).
    *==========================================================================
    FUNCTION CarregarPendencias()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cConta, loc_lTemPeriodo
        LOCAL loc_dIni, loc_dFim, loc_nValos, loc_cGrupo, loc_cOpers, loc_cHists
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cConta = ALLTRIM(THIS.this_cConta)
        IF EMPTY(loc_cConta)
            THIS.this_cMensagemErro = "Conta de Estoque Inv" + CHR(225) + "lida."
            RETURN .F.
        ENDIF

        IF !USED("TmpPar") OR !USED("crTmpTipos")
            IF !THIS.CriarCursoresLocais()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                loc_dIni = ConverterParaData(THIS.this_dDataInicial)
                loc_dFim = ConverterParaData(THIS.this_dDataFinal)
                loc_lTemPeriodo = (!EMPTY(loc_dIni) AND !EMPTY(loc_dFim))

                SELECT TmpPar
                ZAP
                SELECT crTmpTipos
                ZAP

                *-- (1) Pendencias de conta corrente (SigMvCcr)
                loc_cSQL = "SELECT Emps, Grupos, Vencs, Valors, Valpags, Moedas," + ;
                    " Hists, Opers, Nopers, Tipos, Dopes, Numes" + ;
                    " FROM SigMvCcr" + ;
                    " WHERE Contas = " + EscaparSQL(loc_cConta)

                IF loc_lTemPeriodo
                    loc_cSQL = loc_cSQL + ;
                        " AND Datas BETWEEN " + FormatarDataSQL(DTOT(loc_dIni)) + ;
                        " AND " + FormatarDataSQL(DTOT(loc_dFim) + 86399)
                ENDIF

                IF USED("cursor_4c_PendCcr")
                    IF CURSORGETPROP("Buffering", "cursor_4c_PendCcr") > 1
                        TABLEREVERT(.T., "cursor_4c_PendCcr")
                    ENDIF
                    USE IN cursor_4c_PendCcr
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PendCcr")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao carregar as pend" + CHR(234) + ;
                        "ncias de conta corrente:" + CHR(13) + CapturarErroSQL()
                ELSE
                    SELECT cursor_4c_PendCcr
                    SCAN
                        *-- Guard do legado: lancamento sem operacao, de tipo
                        *-- diferente de " "/"X", ou com documento e tipo <> "X"
                        *-- nao gera pendencia
                        IF TratarNulo(cursor_4c_PendCcr.Nopers, 0) = 0 OR ;
                           !INLIST(TratarNulo(cursor_4c_PendCcr.Tipos, " "), " ", "X") OR ;
                           (!EMPTY(TratarNulo(cursor_4c_PendCcr.Dopes, "")) AND ;
                            TratarNulo(cursor_4c_PendCcr.Numes, 0) <> 0 AND ;
                            TratarNulo(cursor_4c_PendCcr.Tipos, " ") <> "X")
                            LOOP
                        ENDIF

                        loc_nValos = TratarNulo(cursor_4c_PendCcr.Valors, 0) - ;
                                     TratarNulo(cursor_4c_PendCcr.Valpags, 0)

                        IF loc_nValos > 0
                            INSERT INTO TmpPar ;
                                (emps, grupos, vencs, fpags, valos, moefpgs, hists, opers) ;
                                VALUES ;
                                (TratarNulo(cursor_4c_PendCcr.Emps, ""), ;
                                 TratarNulo(cursor_4c_PendCcr.Grupos, ""), ;
                                 ConverterParaData(cursor_4c_PendCcr.Vencs), ;
                                 "C/Corrente", ;
                                 loc_nValos, ;
                                 TratarNulo(cursor_4c_PendCcr.Moedas, ""), ;
                                 LEFT(TratarNulo(cursor_4c_PendCcr.Hists, ""), 50), ;
                                 TratarNulo(cursor_4c_PendCcr.Opers, ""))
                        ENDIF
                    ENDSCAN

                    IF USED("cursor_4c_PendCcr")
                        USE IN cursor_4c_PendCcr
                    ENDIF

                    *-- (2) Parcelas de movimento (origem/destino)
                    loc_cSQL = "SELECT a.Grupods, a.Contads, a.Grupoos, a.Contaos," + ;
                        " c.Emps, c.Dopes, c.Numes, c.Vencs, c.Fpags, c.Moefpgs," + ;
                        " c.Valos, c.Vpags, b.COpers" + ;
                        " FROM SigMvCab a" + ;
                        " JOIN SigMvPar c ON a.EmpDopNums = c.EmpDopNums" + ;
                        " JOIN SigCdOpe b ON c.Dopes = b.Dopes" + ;
                        " JOIN SigOpFp d ON c.Fpags = d.Fpags" + ;
                        " WHERE c.Pagos = '1'" + ;
                        " AND b.ValPends = 1 AND b.Parcs = 1" + ;
                        " AND d.ValPends = 1 AND ISNULL(d.LisConGv, 0) <> 2" + ;
                        " AND (a.Contads = " + EscaparSQL(loc_cConta) + ;
                        " OR a.Contaos = " + EscaparSQL(loc_cConta) + ")" + ;
                        " AND (ISNULL(d.Infos, '') <> 'C'" + ;
                        " OR EXISTS (SELECT 1 FROM SigChe e" + ;
                        " JOIN SigCdOpt f ON e.Umovs = f.Operacaos" + ;
                        " WHERE e.Bancos = c.Bancos AND e.Agencias = c.Agencias" + ;
                        " AND e.NContas = c.Contas AND e.NCheques = c.Numeros" + ;
                        " AND f.Tipos = 'DB'))"

                    IF loc_lTemPeriodo
                        loc_cSQL = loc_cSQL + ;
                            " AND a.Datas BETWEEN " + FormatarDataSQL(DTOT(loc_dIni)) + ;
                            " AND " + FormatarDataSQL(DTOT(loc_dFim) + 86399)
                    ENDIF

                    IF USED("cursor_4c_PendPar")
                        IF CURSORGETPROP("Buffering", "cursor_4c_PendPar") > 1
                            TABLEREVERT(.T., "cursor_4c_PendPar")
                        ENDIF
                        USE IN cursor_4c_PendPar
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PendPar")

                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Erro ao carregar as pend" + CHR(234) + ;
                            "ncias de movimento:" + CHR(13) + CapturarErroSQL()
                    ELSE
                        SELECT cursor_4c_PendPar
                        SCAN
                            *-- Sentido da operacao: COpers = 1 -> a conta eh o
                            *-- DESTINO; caso contrario eh a ORIGEM. O legado
                            *-- descarta a linha quando o lado correspondente
                            *-- nao eh a conta pesquisada.
                            IF TratarNulo(cursor_4c_PendPar.COpers, 0) = 1
                                loc_cGrupo = TratarNulo(cursor_4c_PendPar.Grupods, "")
                                loc_cOpers = "D"
                                IF ALLTRIM(TratarNulo(cursor_4c_PendPar.Contads, "")) != loc_cConta
                                    LOOP
                                ENDIF
                            ELSE
                                loc_cGrupo = TratarNulo(cursor_4c_PendPar.Grupoos, "")
                                loc_cOpers = "C"
                                IF ALLTRIM(TratarNulo(cursor_4c_PendPar.Contaos, "")) != loc_cConta
                                    LOOP
                                ENDIF
                            ENDIF

                            loc_nValos = TratarNulo(cursor_4c_PendPar.Valos, 0) - ;
                                         TratarNulo(cursor_4c_PendPar.Vpags, 0)

                            IF loc_nValos > 0
                                loc_cHists = TratarNulo(cursor_4c_PendPar.Emps, "") + ;
                                    ALLTRIM(TratarNulo(cursor_4c_PendPar.Dopes, "")) + " - " + ;
                                    ALLTRIM(fGerMascara(TratarNulo(cursor_4c_PendPar.Numes, 0)))

                                INSERT INTO TmpPar ;
                                    (emps, grupos, vencs, fpags, valos, moefpgs, ;
                                     hists, opers, dopes, numes) ;
                                    VALUES ;
                                    (TratarNulo(cursor_4c_PendPar.Emps, ""), ;
                                     loc_cGrupo, ;
                                     ConverterParaData(cursor_4c_PendPar.Vencs), ;
                                     LEFT(TratarNulo(cursor_4c_PendPar.Fpags, ""), 15), ;
                                     loc_nValos, ;
                                     TratarNulo(cursor_4c_PendPar.Moefpgs, ""), ;
                                     LEFT(loc_cHists, 50), ;
                                     loc_cOpers, ;
                                     TratarNulo(cursor_4c_PendPar.Dopes, ""), ;
                                     TratarNulo(cursor_4c_PendPar.Numes, 0))
                            ENDIF
                        ENDSCAN

                        IF USED("cursor_4c_PendPar")
                            USE IN cursor_4c_PendPar
                        ENDIF

                        *-- (3) Formas de pagamento presentes, JA marcadas
                        IF USED("cursor_4c_TiposTmp")
                            USE IN cursor_4c_TiposTmp
                        ENDIF
                        SELECT DISTINCT fpags ;
                            FROM TmpPar ;
                            WHERE !EMPTY(fpags) ;
                            INTO CURSOR cursor_4c_TiposTmp READWRITE

                        SELECT cursor_4c_TiposTmp
                        SCAN
                            INSERT INTO crTmpTipos (Listas, fPags) ;
                                VALUES (1, LEFT(cursor_4c_TiposTmp.fpags, 12))
                        ENDSCAN

                        IF USED("cursor_4c_TiposTmp")
                            USE IN cursor_4c_TiposTmp
                        ENDIF

                        SELECT TmpPar
                        GO TOP
                        SELECT crTmpTipos
                        GO TOP

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar as pend" + CHR(234) + "ncias:" + ;
                CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * TotalPendencias - Soma de TmpPar.valos respeitando o filtro corrente da
    * grade (getTotPends do legado, alimentado no Cmb_Grupo.InteractiveChange e
    * no FiltraTipos()). Percorre o cursor JA filtrado, por isso soma o que esta
    * visivel na grade - que eh o comportamento do legado.
    *==========================================================================
    FUNCTION TotalPendencias()
        LOCAL loc_nSoma, loc_nRegistro
        loc_nSoma = 0

        IF !USED("TmpPar")
            RETURN 0
        ENDIF

        TRY
            SELECT TmpPar
            loc_nRegistro = IIF(RECCOUNT("TmpPar") > 0, RECNO("TmpPar"), 0)
            SCAN
                loc_nSoma = loc_nSoma + TratarNulo(TmpPar.valos, 0)
            ENDSCAN
            *-- SCAN deixa o ponteiro em EOF: repor para a grade nao perder a
            *-- linha corrente
            IF loc_nRegistro > 0 AND loc_nRegistro <= RECCOUNT("TmpPar")
                GO (loc_nRegistro) IN TmpPar
            ELSE
                GO TOP IN TmpPar
            ENDIF
        CATCH TO loException
            loc_nSoma = 0
        ENDTRY

        RETURN loc_nSoma
    ENDFUNC

    *==========================================================================
    * CarregarCheques - Popula as quatro grades da aba Cheques e os nove
    * totais somente-leitura do pe da pagina, reproduzindo o trecho de cheques
    * do Processa() legado:
    *
    *   dbAberto    <- SigChe + SigCqChm + SigCdOpt, cheques do cliente em
    *                  operacao de DEBITO que nao esta fora da consulta global
    *                  (SigCdOpt.Tipos = "DB" e Congvs <> "N")
    *   DbFollow    <- SigCheh dos cheques carregados (historico/follow-up); o
    *                  cheque que tem follow-up fica com dbAberto.Flags = .T.,
    *                  como no legado
    *   dbDevolvido <- SigChe + SigCqChm + SigCdOpt com Devolvidos = "S",
    *                  agrupando reincidencia do MESMO cheque em numincdevs
    *   DbTitulo    <- SigMvCcr + SigOpOpe (titulos de cheque negociado)
    *
    * Totais (so calculados quando o grupo controla limite de credito -
    * SigCdGcr.limcres = 1, exatamente como o legado):
    *   this_nLimiteCredito      SigClLcr.limcres convertido para a moeda padrao
    *   this_nSaldoContaCorrente soma de SigMvSlc convertida
    *   this_nChequesNegociados  soma de DbTitulo.Saldos convertida
    *   this_nChequesAVencer     cheques com vencimento >= hoje
    *   this_nChequesVencidos    cheques com vencimento < hoje
    *   this_nChequesDevolvidos  cheques marcados como devolvidos
    *   this_nValorEstoque       valor do estoque em poder do cliente (quando o
    *                            grupo controla limite de estoque)
    *   this_nLimiteDisponivel   limite - saldo - negociados - estoque (e menos
    *                            os cheques em carteira quando chqlcreds esta
    *                            ligado)
    *   this_nTotalChequeAberto  soma de dbAberto.valors (Fwget3 do legado)
    *==========================================================================
    FUNCTION CarregarCheques()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cConta, loc_lTemPeriodo
        LOCAL loc_dIni, loc_dFim, loc_cGrupo, loc_cListaNums, loc_cChave
        LOCAL loc_cMoeLim, loc_nCotLim, loc_nCotSal, loc_nLimite, loc_nSaldo
        LOCAL loc_nChqNeg, loc_nDisp, loc_nChequeC, loc_nChequeP
        LOCAL loc_nChqAv, loc_nChqVc, loc_nChqDv, loc_nVlEstq, loc_nValorItem
        LOCAL loc_cMoeItem, loc_nTotAberto, loc_nTotDevolv
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cConta = ALLTRIM(THIS.this_cConta)
        IF EMPTY(loc_cConta)
            THIS.this_cMensagemErro = "Conta de Estoque Inv" + CHR(225) + "lida."
            RETURN .F.
        ENDIF

        IF !USED("dbAberto") OR !USED("dbDevolvido") OR !USED("DbFollow") OR !USED("DbTitulo")
            IF !THIS.CriarCursoresLocais()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF EMPTY(THIS.this_cGrupoPadrao)
                    THIS.CarregarParametros()
                ENDIF
                loc_cGrupo = ALLTRIM(THIS.this_cGrupoPadrao)

                loc_dIni = ConverterParaData(THIS.this_dDataInicial)
                loc_dFim = ConverterParaData(THIS.this_dDataFinal)
                loc_lTemPeriodo = (!EMPTY(loc_dIni) AND !EMPTY(loc_dFim))

                SELECT dbAberto
                ZAP
                SELECT dbDevolvido
                ZAP
                SELECT DbFollow
                ZAP
                SELECT DbTitulo
                ZAP

                STORE 0 TO THIS.this_nLimiteCredito, THIS.this_nChequesAVencer, ;
                    THIS.this_nChequesVencidos, THIS.this_nChequesDevolvidos, ;
                    THIS.this_nSaldoContaCorrente, THIS.this_nChequesNegociados, ;
                    THIS.this_nLimiteDisponivel, THIS.this_nValorEstoque, ;
                    THIS.this_nTotalChequeAberto, THIS.this_nTotalDevolvido

                *-- (1) Cheques em aberto
                loc_cSQL = "SELECT a.Vencs, a.Bancos, a.Agencias, a.NContas," + ;
                    " a.NCheques, a.Valors, a.Nums, b.Devolvidos" + ;
                    " FROM SigChe a" + ;
                    " JOIN SigCdOpt b ON a.Umovs = b.Operacaos" + ;
                    " JOIN SigCqChm c ON a.Nums = c.Nums" + ;
                    " WHERE a.Iclis = " + EscaparSQL(loc_cConta) + ;
                    " AND b.Tipos = 'DB' AND ISNULL(b.Congvs, '') <> 'N'"

                IF loc_lTemPeriodo
                    loc_cSQL = loc_cSQL + ;
                        " AND a.Datas BETWEEN " + FormatarDataSQL(DTOT(loc_dIni)) + ;
                        " AND " + FormatarDataSQL(DTOT(loc_dFim) + 86399)
                ENDIF

                IF USED("cursor_4c_CheAbe")
                    IF CURSORGETPROP("Buffering", "cursor_4c_CheAbe") > 1
                        TABLEREVERT(.T., "cursor_4c_CheAbe")
                    ENDIF
                    USE IN cursor_4c_CheAbe
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheAbe")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao carregar os cheques em aberto:" + ;
                        CHR(13) + CapturarErroSQL()
                ELSE
                    loc_cListaNums = ""

                    SELECT cursor_4c_CheAbe
                    SCAN
                        INSERT INTO dbAberto ;
                            (grupos, vencs, bancos, agencias, ncontas, ncheques, ;
                             valors, Nums, Devolvidos) ;
                            VALUES ;
                            (loc_cGrupo, ;
                             ConverterParaData(cursor_4c_CheAbe.Vencs), ;
                             TratarNulo(cursor_4c_CheAbe.Bancos, ""), ;
                             TratarNulo(cursor_4c_CheAbe.Agencias, ""), ;
                             TratarNulo(cursor_4c_CheAbe.NContas, ""), ;
                             TratarNulo(cursor_4c_CheAbe.NCheques, ""), ;
                             TratarNulo(cursor_4c_CheAbe.Valors, 0), ;
                             TratarNulo(cursor_4c_CheAbe.Nums, ""), ;
                             TratarNulo(cursor_4c_CheAbe.Devolvidos, ""))

                        IF !EMPTY(TratarNulo(cursor_4c_CheAbe.Nums, ""))
                            loc_cListaNums = loc_cListaNums + ;
                                IIF(EMPTY(loc_cListaNums), "", ", ") + ;
                                EscaparSQL(ALLTRIM(cursor_4c_CheAbe.Nums))
                        ENDIF
                    ENDSCAN

                    IF USED("cursor_4c_CheAbe")
                        USE IN cursor_4c_CheAbe
                    ENDIF

                    *-- (2) Follow-up dos cheques carregados (SigCheh). O legado
                    *-- consulta cheque a cheque; aqui a lista de numeros vai em
                    *-- UMA consulta, com o mesmo efeito (inclusive a marca
                    *-- dbAberto.Flags no cheque que tem historico).
                    IF !EMPTY(loc_cListaNums)
                        IF USED("cursor_4c_CheHis")
                            IF CURSORGETPROP("Buffering", "cursor_4c_CheHis") > 1
                                TABLEREVERT(.T., "cursor_4c_CheHis")
                            ENDIF
                            USE IN cursor_4c_CheHis
                        ENDIF

                        loc_cSQL = "SELECT Nums, Datas, Hists FROM SigCheh" + ;
                            " WHERE Nums IN (" + loc_cListaNums + ")" + ;
                            " ORDER BY Nums, Datas"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheHis")

                        IF loc_nResultado >= 0 AND USED("cursor_4c_CheHis")
                            SELECT cursor_4c_CheHis
                            SCAN
                                INSERT INTO DbFollow (Nums, Datas, Hists) ;
                                    VALUES ;
                                    (TratarNulo(cursor_4c_CheHis.Nums, ""), ;
                                     ConverterParaData(cursor_4c_CheHis.Datas), ;
                                     LEFT(TratarNulo(cursor_4c_CheHis.Hists, ""), 76))

                                SELECT dbAberto
                                LOCATE FOR ALLTRIM(dbAberto.Nums) == ;
                                    ALLTRIM(TratarNulo(cursor_4c_CheHis.Nums, ""))
                                IF FOUND("dbAberto")
                                    REPLACE dbAberto.Flags WITH .T. IN dbAberto
                                ENDIF
                                SELECT cursor_4c_CheHis
                            ENDSCAN

                            USE IN cursor_4c_CheHis
                        ENDIF
                    ENDIF

                    *-- (3) Cheques devolvidos
                    loc_cSQL = "SELECT a.Vencs, a.Bancos, a.Agencias, a.NContas," + ;
                        " a.NCheques, a.Valors, a.Nums, a.Grclis" + ;
                        " FROM SigChe a" + ;
                        " JOIN SigCqChm b ON a.Nums = b.Nums" + ;
                        " JOIN SigCdOpt c ON b.Codigos = c.Operacaos" + ;
                        " WHERE a.Iclis = " + EscaparSQL(loc_cConta) + ;
                        " AND c.Devolvidos = 'S'"

                    IF loc_lTemPeriodo
                        loc_cSQL = loc_cSQL + ;
                            " AND a.Datas BETWEEN " + FormatarDataSQL(DTOT(loc_dIni)) + ;
                            " AND " + FormatarDataSQL(DTOT(loc_dFim) + 86399)
                    ENDIF

                    IF USED("cursor_4c_CheDev")
                        IF CURSORGETPROP("Buffering", "cursor_4c_CheDev") > 1
                            TABLEREVERT(.T., "cursor_4c_CheDev")
                        ENDIF
                        USE IN cursor_4c_CheDev
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheDev")

                    IF loc_nResultado >= 0 AND USED("cursor_4c_CheDev")
                        SELECT cursor_4c_CheDev
                        SCAN
                            *-- Chave POSICIONAL do indice Cheque (regra #42): as
                            *-- quatro partes vao PADR na largura da coluna do
                            *-- cursor - 3 + 4 + 10 + 6
                            loc_cChave = ;
                                PADR(TratarNulo(cursor_4c_CheDev.Bancos, ""), 3) + ;
                                PADR(TratarNulo(cursor_4c_CheDev.Agencias, ""), 4) + ;
                                PADR(TratarNulo(cursor_4c_CheDev.NContas, ""), 10) + ;
                                PADR(TratarNulo(cursor_4c_CheDev.NCheques, ""), 6)

                            IF SEEK(loc_cChave, "dbDevolvido", "Cheque")
                                REPLACE dbDevolvido.numincdevs ;
                                    WITH dbDevolvido.numincdevs + 1 IN dbDevolvido
                            ELSE
                                INSERT INTO dbDevolvido ;
                                    (grupos, vencs, bancos, agencias, ncontas, ;
                                     ncheques, valors, numincdevs) ;
                                    VALUES ;
                                    (TratarNulo(cursor_4c_CheDev.Grclis, ""), ;
                                     ConverterParaData(cursor_4c_CheDev.Vencs), ;
                                     TratarNulo(cursor_4c_CheDev.Bancos, ""), ;
                                     TratarNulo(cursor_4c_CheDev.Agencias, ""), ;
                                     TratarNulo(cursor_4c_CheDev.NContas, ""), ;
                                     TratarNulo(cursor_4c_CheDev.NCheques, ""), ;
                                     TratarNulo(cursor_4c_CheDev.Valors, 0), ;
                                     1)
                            ENDIF
                            SELECT cursor_4c_CheDev
                        ENDSCAN

                        USE IN cursor_4c_CheDev
                    ENDIF

                    *-- (4) Titulos (cheques negociados)
                    loc_cSQL = "SELECT a.Grupos, a.Titulos, a.Vencs, a.Valors," + ;
                        " a.Valpags, a.Moedas, a.Hist2s AS Hists," + ;
                        " (a.Valors - a.ValPags) AS Saldos" + ;
                        " FROM SigMvCcr a" + ;
                        " JOIN SigOpOpe b ON a.Dopcs = b.Dopes" + ;
                        " WHERE b.Congvs = 1" + ;
                        " AND a.Contems = " + EscaparSQL(loc_cConta) + ;
                        " AND a.Opers = LEFT(b.Opers, 1)" + ;
                        " AND a.Pagos = '1' AND a.Tipos = ' '"

                    IF USED("cursor_4c_Titulos")
                        IF CURSORGETPROP("Buffering", "cursor_4c_Titulos") > 1
                            TABLEREVERT(.T., "cursor_4c_Titulos")
                        ENDIF
                        USE IN cursor_4c_Titulos
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Titulos")

                    IF loc_nResultado >= 0 AND USED("cursor_4c_Titulos")
                        SELECT cursor_4c_Titulos
                        SCAN
                            INSERT INTO DbTitulo ;
                                (Grupos, Titulos, Vencs, Valors, ValPags, Saldos, ;
                                 Hists, Moedas) ;
                                VALUES ;
                                (TratarNulo(cursor_4c_Titulos.Grupos, ""), ;
                                 TratarNulo(cursor_4c_Titulos.Titulos, ""), ;
                                 ConverterParaData(cursor_4c_Titulos.Vencs), ;
                                 TratarNulo(cursor_4c_Titulos.Valors, 0), ;
                                 TratarNulo(cursor_4c_Titulos.Valpags, 0), ;
                                 TratarNulo(cursor_4c_Titulos.Saldos, 0), ;
                                 LEFT(TratarNulo(cursor_4c_Titulos.Hists, ""), 26), ;
                                 TratarNulo(cursor_4c_Titulos.Moedas, ""))
                        ENDSCAN

                        USE IN cursor_4c_Titulos
                    ENDIF

                    *-- (5) Totais - so quando o grupo controla limite de credito
                    loc_cMoeLim = ALLTRIM(THIS.this_cMoedaPadrao)
                    loc_nCotLim = THIS.ObterCotacao(loc_cMoeLim, DATE())
                    IF loc_nCotLim = 0
                        loc_nCotLim = 1
                    ENDIF

                    STORE 0 TO loc_nLimite, loc_nSaldo, loc_nChqNeg, loc_nDisp, ;
                        loc_nChequeC, loc_nChequeP, loc_nChqAv, loc_nChqVc, ;
                        loc_nChqDv, loc_nVlEstq

                    IF THIS.this_nGrupoLimCredito = 1
                        *-- Limite de credito do cliente (SigClLcr)
                        IF USED("cursor_4c_Lcr")
                            USE IN cursor_4c_Lcr
                        ENDIF
                        loc_cSQL = "SELECT limcres, moedas FROM SigClLcr" + ;
                            " WHERE Grupos = " + EscaparSQL(loc_cGrupo) + ;
                            " AND Contas = " + EscaparSQL(loc_cConta)
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lcr")

                        IF loc_nResultado >= 0 AND USED("cursor_4c_Lcr")
                            IF RECCOUNT("cursor_4c_Lcr") > 0
                                SELECT cursor_4c_Lcr
                                GO TOP
                                IF ALLTRIM(TratarNulo(cursor_4c_Lcr.moedas, "")) != loc_cMoeLim
                                    loc_nCotSal = THIS.ObterCotacao( ;
                                        TratarNulo(cursor_4c_Lcr.moedas, ""), DATE())
                                    loc_nLimite = ROUND(TratarNulo(cursor_4c_Lcr.limcres, 0) * ;
                                        loc_nCotSal / loc_nCotLim, 2)
                                ELSE
                                    loc_nLimite = TratarNulo(cursor_4c_Lcr.limcres, 0)
                                ENDIF
                            ENDIF
                            USE IN cursor_4c_Lcr
                        ENDIF

                        *-- Saldo consolidado da conta (SigMvSlc), convertido
                        IF USED("cursor_4c_Slc")
                            USE IN cursor_4c_Slc
                        ENDIF
                        loc_cSQL = "SELECT grupos, moedas, saldos FROM SigMvSlc" + ;
                            " WHERE Grupos = " + EscaparSQL(loc_cGrupo) + ;
                            " AND Contas = " + EscaparSQL(loc_cConta)
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Slc")

                        IF loc_nResultado >= 0 AND USED("cursor_4c_Slc")
                            SELECT cursor_4c_Slc
                            SCAN
                                IF ALLTRIM(TratarNulo(cursor_4c_Slc.moedas, "")) != loc_cMoeLim
                                    loc_nCotSal = THIS.ObterCotacao( ;
                                        TratarNulo(cursor_4c_Slc.moedas, ""), DATE())
                                    loc_nSaldo = loc_nSaldo + ;
                                        ROUND(TratarNulo(cursor_4c_Slc.saldos, 0) * ;
                                        loc_nCotSal / loc_nCotLim, 2)
                                ELSE
                                    loc_nSaldo = loc_nSaldo + TratarNulo(cursor_4c_Slc.saldos, 0)
                                ENDIF
                            ENDSCAN
                            USE IN cursor_4c_Slc
                        ENDIF

                        loc_nDisp = loc_nLimite - loc_nSaldo

                        *-- Cheques negociados (saldo dos titulos), convertido
                        SELECT DbTitulo
                        SCAN
                            IF ALLTRIM(TratarNulo(DbTitulo.Moedas, "")) != loc_cMoeLim
                                loc_nCotSal = THIS.ObterCotacao(DbTitulo.Moedas, DATE())
                                loc_nChqNeg = loc_nChqNeg + ;
                                    ROUND(TratarNulo(DbTitulo.Saldos, 0) * ;
                                    loc_nCotSal / loc_nCotLim, 2)
                            ELSE
                                loc_nChqNeg = loc_nChqNeg + TratarNulo(DbTitulo.Saldos, 0)
                            ENDIF
                        ENDSCAN
                        GO TOP IN DbTitulo

                        loc_nDisp = loc_nDisp - loc_nChqNeg

                        *-- Cheques do cliente por situacao (a vencer / vencido /
                        *-- devolvido) e em carteira (SigOpFp.valpends <> 1)
                        IF USED("cursor_4c_CheSit")
                            USE IN cursor_4c_CheSit
                        ENDIF
                        loc_cSQL = "SELECT a.Valors, a.Fpags, a.Vencs," + ;
                            " b.Devolvidos, ISNULL(d.ValPends, 0) AS ValPends" + ;
                            " FROM SigChe a" + ;
                            " JOIN SigCdOpt b ON a.Umovs = b.Operacaos" + ;
                            " LEFT JOIN SigOpFp d ON a.Fpags = d.Fpags" + ;
                            " WHERE a.Grclis = " + EscaparSQL(loc_cGrupo) + ;
                            " AND a.Iclis = " + EscaparSQL(loc_cConta) + ;
                            " AND b.Tipos = 'DB'"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheSit")

                        IF loc_nResultado >= 0 AND USED("cursor_4c_CheSit")
                            SELECT cursor_4c_CheSit
                            SCAN
                                IF EMPTY(TratarNulo(cursor_4c_CheSit.Fpags, ""))
                                    loc_nChequeP = loc_nChequeP + ;
                                        TratarNulo(cursor_4c_CheSit.Valors, 0)
                                ELSE
                                    IF TratarNulo(cursor_4c_CheSit.ValPends, 0) <> 1
                                        loc_nChequeC = loc_nChequeC + ;
                                            TratarNulo(cursor_4c_CheSit.Valors, 0)
                                    ELSE
                                        loc_nChequeP = loc_nChequeP + ;
                                            TratarNulo(cursor_4c_CheSit.Valors, 0)
                                    ENDIF
                                ENDIF

                                IF ConverterParaData(cursor_4c_CheSit.Vencs) >= DATE()
                                    loc_nChqAv = loc_nChqAv + ;
                                        TratarNulo(cursor_4c_CheSit.Valors, 0)
                                ELSE
                                    loc_nChqVc = loc_nChqVc + ;
                                        TratarNulo(cursor_4c_CheSit.Valors, 0)
                                ENDIF

                                IF ALLTRIM(TratarNulo(cursor_4c_CheSit.Devolvidos, "")) == "S"
                                    loc_nChqDv = loc_nChqDv + ;
                                        TratarNulo(cursor_4c_CheSit.Valors, 0)
                                ENDIF
                            ENDSCAN
                            USE IN cursor_4c_CheSit
                        ENDIF

                        loc_nChequeC = ROUND(loc_nChequeC / loc_nCotLim, 2)
                        loc_nChequeP = ROUND(loc_nChequeP / loc_nCotLim, 2)
                        loc_nChqAv   = ROUND(loc_nChqAv   / loc_nCotLim, 2)
                        loc_nChqVc   = ROUND(loc_nChqVc   / loc_nCotLim, 2)
                        loc_nChqDv   = ROUND(loc_nChqDv   / loc_nCotLim, 2)

                        IF THIS.this_lChqLimitaCredito
                            loc_nDisp = loc_nDisp - loc_nChequeC
                        ENDIF
                    ENDIF

                    *-- (6) Valor do estoque em poder do cliente
                    IF THIS.this_nGrupoLimEstoque = 1 AND !EMPTY(THIS.this_cMoedaLimEstoque)
                        IF USED("cursor_4c_EstVal")
                            USE IN cursor_4c_EstVal
                        ENDIF

                        loc_cSQL = "SELECT a.Cpros, SUM(a.Sqtds) AS Qtds," + ;
                            " p.Moevs, p.Pvens, p.Fvendas, p.Moepvs, p.Pesoms," + ;
                            " p.Custofs, p.Moecusfs, l.TpVendas, l.TpCustos" + ;
                            " FROM SigMvEst a" + ;
                            " JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
                            " LEFT JOIN SigCdPro p ON a.Cpros = p.Cpros" + ;
                            " LEFT JOIN SigCdLin l ON p.Linhas = l.Linhas" + ;
                            " WHERE a.Estos = " + EscaparSQL(loc_cConta) + ;
                            " AND ISNULL(b.ChkLimEsts, 0) <> 2" + ;
                            " GROUP BY a.Cpros, p.Moevs, p.Pvens, p.Fvendas," + ;
                            " p.Moepvs, p.Pesoms, p.Custofs, p.Moecusfs," + ;
                            " l.TpVendas, l.TpCustos"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstVal")

                        IF loc_nResultado >= 0 AND USED("cursor_4c_EstVal")
                            SELECT cursor_4c_EstVal
                            SCAN
                                IF THIS.this_nTipoPreco = 1
                                    *-- Avalia a preco de VENDA
                                    loc_cMoeItem = TratarNulo(cursor_4c_EstVal.Moevs, "")
                                    loc_nValorItem = ROUND(TratarNulo(cursor_4c_EstVal.Pvens, 0) * ;
                                        IIF(TratarNulo(cursor_4c_EstVal.Fvendas, 0) <> 0 AND ;
                                            !EMPTY(TratarNulo(cursor_4c_EstVal.Moepvs, "")), ;
                                            TratarNulo(cursor_4c_EstVal.Fvendas, 0), 1), 2)
                                    IF ALLTRIM(TratarNulo(cursor_4c_EstVal.TpVendas, "")) == "2"
                                        loc_nValorItem = TratarNulo(cursor_4c_EstVal.Pesoms, 0) * ;
                                            loc_nValorItem
                                    ENDIF
                                ELSE
                                    *-- Avalia a CUSTO
                                    loc_cMoeItem = TratarNulo(cursor_4c_EstVal.Moecusfs, "")
                                    loc_nValorItem = TratarNulo(cursor_4c_EstVal.Custofs, 0)
                                    IF ALLTRIM(TratarNulo(cursor_4c_EstVal.TpCustos, "")) == "2"
                                        loc_nValorItem = TratarNulo(cursor_4c_EstVal.Pesoms, 0) * ;
                                            loc_nValorItem
                                    ENDIF
                                ENDIF

                                loc_nValorItem = loc_nValorItem * ;
                                    TratarNulo(cursor_4c_EstVal.Qtds, 0)

                                IF loc_cMoeLim != ALLTRIM(loc_cMoeItem)
                                    loc_nVlEstq = loc_nVlEstq + ;
                                        (loc_nValorItem * ;
                                         THIS.ObterCotacao(loc_cMoeItem, DATE()) / loc_nCotLim)
                                ELSE
                                    loc_nVlEstq = loc_nVlEstq + loc_nValorItem
                                ENDIF
                            ENDSCAN
                            USE IN cursor_4c_EstVal
                        ENDIF

                        loc_nDisp = loc_nDisp - loc_nVlEstq
                    ENDIF

                    *-- (7) Totais das grades (Fwget3 / Get_TotDevolvido)
                    *-- SUM ... TO exige MEMVAR (nao aceita property)
                    loc_nTotAberto = 0
                    loc_nTotDevolv = 0

                    SELECT dbAberto
                    SUM dbAberto.valors TO loc_nTotAberto
                    GO TOP IN dbAberto

                    SELECT dbDevolvido
                    SUM dbDevolvido.valors TO loc_nTotDevolv
                    GO TOP IN dbDevolvido

                    THIS.this_nTotalChequeAberto = loc_nTotAberto
                    THIS.this_nTotalDevolvido    = loc_nTotDevolv

                    THIS.this_nLimiteCredito       = loc_nLimite
                    THIS.this_nSaldoContaCorrente  = loc_nSaldo
                    THIS.this_nChequesNegociados   = loc_nChqNeg
                    THIS.this_nChequesAVencer      = loc_nChqAv
                    THIS.this_nChequesVencidos     = loc_nChqVc
                    THIS.this_nChequesDevolvidos   = loc_nChqDv
                    THIS.this_nValorEstoque        = loc_nVlEstq
                    THIS.this_nLimiteDisponivel    = loc_nDisp

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar os cheques:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarCartoes - Popula TmpCart (grade da aba Cartao), reproduzindo o
    * PCartao() legado: le os cartoes do cliente em SigCdCrd e mantem apenas os
    * que ainda tem saldo a receber (TotRes - TotPar <> 0).
    *==========================================================================
    FUNCTION CarregarCartoes()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cConta
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cConta = ALLTRIM(THIS.this_cConta)
        IF EMPTY(loc_cConta)
            THIS.this_cMensagemErro = "Conta de Estoque Inv" + CHR(225) + "lida."
            RETURN .F.
        ENDIF

        IF !USED("TmpCart")
            IF !THIS.CriarCursoresLocais()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                SELECT TmpCart
                ZAP

                loc_cSQL = "SELECT Cartaos, Datas, Fpags, Valos, Nocreditos," + ;
                    " Vencs, Totres, Totpar" + ;
                    " FROM SigCdCrd" + ;
                    " WHERE Iclis = " + EscaparSQL(loc_cConta)

                IF USED("cursor_4c_Card")
                    IF CURSORGETPROP("Buffering", "cursor_4c_Card") > 1
                        TABLEREVERT(.T., "cursor_4c_Card")
                    ENDIF
                    USE IN cursor_4c_Card
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Card")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao carregar os cart" + CHR(245) + ;
                        "es:" + CHR(13) + CapturarErroSQL()
                ELSE
                    SELECT cursor_4c_Card
                    SCAN
                        *-- Guard do legado: so cartao com saldo em aberto
                        IF (TratarNulo(cursor_4c_Card.Totres, 0) - ;
                            TratarNulo(cursor_4c_Card.Totpar, 0)) <> 0
                            INSERT INTO TmpCart ;
                                (grupos, cartaos, datas, fpags, valos, nocreditos, vencs) ;
                                VALUES ;
                                (ALLTRIM(THIS.this_cGrupoPadrao), ;
                                 TratarNulo(cursor_4c_Card.Cartaos, ""), ;
                                 ConverterParaData(cursor_4c_Card.Datas), ;
                                 LEFT(TratarNulo(cursor_4c_Card.Fpags, ""), 12), ;
                                 TratarNulo(cursor_4c_Card.Valos, 0), ;
                                 TratarNulo(cursor_4c_Card.Nocreditos, ""), ;
                                 ConverterParaData(cursor_4c_Card.Vencs))
                        ENDIF
                    ENDSCAN

                    IF USED("cursor_4c_Card")
                        USE IN cursor_4c_Card
                    ENDIF

                    SELECT TmpCart
                    GO TOP

                    THIS.this_lOkCartao = .T.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar os cart" + CHR(245) + "es:" + ;
                CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarEstoque - Popula dbEstoque (grade da aba Estoque), reproduzindo o
    * PEstoque() legado: soma por grupo/produto o que esta no estoque da conta
    * (SigMvEst.Estos), considerando SOMENTE as empresas ATIVAS (SigCdEmp.Ativas
    * = 1 - a coluna de empresa de SigCdEmp eh Cemps, nao Cemps, regra #48) e
    * descartando os produtos com saldo zero.
    *==========================================================================
    FUNCTION CarregarEstoque()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cConta
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cConta = ALLTRIM(THIS.this_cConta)
        IF EMPTY(loc_cConta)
            THIS.this_cMensagemErro = "Conta de Estoque Inv" + CHR(225) + "lida."
            RETURN .F.
        ENDIF

        IF !USED("dbEstoque")
            IF !THIS.CriarCursoresLocais()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                SELECT dbEstoque
                ZAP

                loc_cSQL = "SELECT a.Grupos, a.Cpros, SUM(a.Sqtds) AS Sqtds" + ;
                    " FROM SigMvEst a" + ;
                    " JOIN SigCdEmp b ON a.Emps = b.Cemps" + ;
                    " WHERE a.Estos = " + EscaparSQL(loc_cConta) + ;
                    " AND b.Ativas = 1" + ;
                    " GROUP BY a.Grupos, a.Cpros"

                IF USED("cursor_4c_Est")
                    IF CURSORGETPROP("Buffering", "cursor_4c_Est") > 1
                        TABLEREVERT(.T., "cursor_4c_Est")
                    ENDIF
                    USE IN cursor_4c_Est
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Est")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao carregar o estoque:" + CHR(13) + ;
                        CapturarErroSQL()
                ELSE
                    SELECT cursor_4c_Est
                    SCAN
                        *-- Guard do legado: produto com saldo zero nao entra
                        IF TratarNulo(cursor_4c_Est.Sqtds, 0) <> 0
                            INSERT INTO dbEstoque (grupos, cpros, sqtds) ;
                                VALUES ;
                                (TratarNulo(cursor_4c_Est.Grupos, ""), ;
                                 TratarNulo(cursor_4c_Est.Cpros, ""), ;
                                 TratarNulo(cursor_4c_Est.Sqtds, 0))
                        ENDIF
                    ENDSCAN

                    IF USED("cursor_4c_Est")
                        USE IN cursor_4c_Est
                    ENDIF

                    SELECT dbEstoque
                    GO TOP

                    THIS.this_lOkEstoque = .T.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar o estoque:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarHCheques - Popula dbCheqHist (grade GradeCheque da aba H.Cheques),
    * reproduzindo o trecho inicial do mativahcheque() legado: todo cheque da
    * conta pesquisada, com o Vencs EXIBIDO sobrescrito pelo CASE da ultima
    * movimentacao (CR usa a data dessa movimentacao, DB usa a data de hoje -
    * o legado faz essa troca via coluna duplicada no SELECT, regra #42-like),
    * o Tipo vindo do LEFT JOIN com SigCheh (cheque com historico fica azul) e
    * o DiasP calculado em cima do Vencs exibido (nunca negativo).
    *
    * O periodo (Cnt_periodo) existe no SCX mas o legado o mantem desligado do
    * filtro (os dois ramos que o usariam ficam comentados no Processa() -
    * "*If...*Else...*EndIf"): por fidelidade, o container fica no form (oculto,
    * como no dump) e NAO entra no WHERE aqui.
    *
    * Ao final, posiciona no cheque de vencimento mais distante (GO BOTTOM na
    * ordem Venc, igual ao legado) e chama CarregarMovimentoCheque para esse
    * registro, que eh o estado inicial que o AfterRowColChange reproduziria.
    *==========================================================================
    FUNCTION CarregarHCheques()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cConta, loc_dDiferenca
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cConta = ALLTRIM(THIS.this_cConta)
        IF EMPTY(loc_cConta)
            THIS.this_cMensagemErro = "Conta de Estoque Inv" + CHR(225) + "lida."
            RETURN .F.
        ENDIF

        IF !USED("dbCheqHist")
            IF !THIS.CriarCursoresLocais()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                SELECT dbCheqHist
                ZAP

                loc_cSQL = "SELECT a.Emps, a.Bancos, a.Agencias, a.NContas, a.NCheques," + ;
                    " a.Valors, a.GruCarts, a.ConCarts, a.Numeros, a.Nums," + ;
                    " b.DTEnts AS DtEntsMov," + ;
                    " CASE WHEN c.Tipos = 'CR' THEN c.DTEnts" + ;
                    " WHEN c.Tipos = 'DB' THEN GETDATE() END AS VencsExib," + ;
                    " d.Nums AS TipoHist" + ;
                    " FROM SigChe a" + ;
                    " JOIN (SELECT MAX(DTEnts) AS DTEnts, Nums FROM SigCqChm GROUP BY Nums) b" + ;
                    " ON a.Nums = b.Nums" + ;
                    " JOIN SigCqChm c ON b.Nums = c.Nums AND b.DTEnts = c.DTEnts" + ;
                    " LEFT JOIN SigCheh d ON a.Nums = d.Nums" + ;
                    " WHERE a.Iclis = " + EscaparSQL(loc_cConta) + ;
                    " ORDER BY a.Vencs"

                IF USED("cursor_4c_HistChe")
                    IF CURSORGETPROP("Buffering", "cursor_4c_HistChe") > 1
                        TABLEREVERT(.T., "cursor_4c_HistChe")
                    ENDIF
                    USE IN cursor_4c_HistChe
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistChe")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao carregar o hist" + CHR(243) + ;
                        "rico de cheques:" + CHR(13) + CapturarErroSQL()
                ELSE
                    SELECT cursor_4c_HistChe
                    SCAN
                        loc_dDiferenca = ConverterParaData(cursor_4c_HistChe.DtEntsMov) - ;
                            ConverterParaData(cursor_4c_HistChe.VencsExib)
                        IF loc_dDiferenca < 0
                            loc_dDiferenca = 0
                        ENDIF

                        INSERT INTO dbCheqHist ;
                            (Emps, Vencs, Bancos, Agencias, NContas, NCheques, Valors, ;
                             GruCarts, ConCarts, Numeros, DiasP, Tipo, Nums) ;
                            VALUES ;
                            (TratarNulo(cursor_4c_HistChe.Emps, ""), ;
                             ConverterParaData(cursor_4c_HistChe.VencsExib), ;
                             TratarNulo(cursor_4c_HistChe.Bancos, ""), ;
                             TratarNulo(cursor_4c_HistChe.Agencias, ""), ;
                             TratarNulo(cursor_4c_HistChe.NContas, ""), ;
                             TratarNulo(cursor_4c_HistChe.NCheques, ""), ;
                             TratarNulo(cursor_4c_HistChe.Valors, 0), ;
                             TratarNulo(cursor_4c_HistChe.GruCarts, ""), ;
                             TratarNulo(cursor_4c_HistChe.ConCarts, ""), ;
                             TratarNulo(cursor_4c_HistChe.Numeros, ""), ;
                             loc_dDiferenca, ;
                             TratarNulo(cursor_4c_HistChe.TipoHist, ""), ;
                             TratarNulo(cursor_4c_HistChe.Nums, ""))
                    ENDSCAN

                    IF USED("cursor_4c_HistChe")
                        USE IN cursor_4c_HistChe
                    ENDIF

                    SELECT dbCheqHist
                    SET ORDER TO TAG Venc
                    GO BOTTOM

                    IF RECCOUNT("dbCheqHist") > 0
                        THIS.CarregarMovimentoCheque(ALLTRIM(dbCheqHist.Nums))
                    ELSE
                        THIS.this_cFollowUpCheque = ""
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar o hist" + CHR(243) + "rico de cheques:" + ;
                CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarMovimentoCheque - Popula dbCheqMovim (GradeMovimenta) e
    * dbCheqProrrog (GradeProrrog) com a movimentacao/prorrogacoes do cheque
    * par_cNums, e this_cFollowUpCheque com o historico mais recente
    * (SigCheh.Hists) - transcricao do AfterRowColChange da GradeCheque do
    * legado. Chamado tanto pela carga inicial (CarregarHCheques) quanto pelo
    * Form a cada troca de linha da grade (regra #46 - cursor != grade pintada).
    *==========================================================================
    FUNCTION CarregarMovimentoCheque(par_cNums)
        LOCAL loc_cNums, loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        loc_cNums = ALLTRIM(IIF(VARTYPE(par_cNums) = "C", par_cNums, ""))

        IF EMPTY(loc_cNums)
            RETURN .F.
        ENDIF

        IF !USED("dbCheqMovim") OR !USED("dbCheqProrrog")
            IF !THIS.CriarCursoresLocais()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                *-- Movimentacao (SigCqChm), mais recente primeiro
                SELECT dbCheqMovim
                ZAP

                loc_cSQL = "SELECT Codigos, Nalineas, Dtents, Gruorigs, Conorigs," + ;
                    " Grupos, Contas, Numlotes, Protocolos" + ;
                    " FROM SigCqChm WHERE Nums = " + EscaparSQL(loc_cNums) + ;
                    " ORDER BY Nums, Dtsis DESC"

                IF USED("cursor_4c_CheMov")
                    USE IN cursor_4c_CheMov
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheMov")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao carregar a movimenta" + CHR(231) + CHR(227) + ;
                        "o do cheque:" + CHR(13) + CapturarErroSQL()
                ELSE
                    SELECT cursor_4c_CheMov
                    SCAN
                        INSERT INTO dbCheqMovim ;
                            (Codigos, Nalineas, Dtents, Gruorigs, Conorigs, Grupos, Contas, ;
                             Numlotes, Protocolos) ;
                            VALUES ;
                            (TratarNulo(cursor_4c_CheMov.Codigos, ""), ;
                             TratarNulo(cursor_4c_CheMov.Nalineas, 0), ;
                             ConverterParaData(cursor_4c_CheMov.Dtents), ;
                             TratarNulo(cursor_4c_CheMov.Gruorigs, ""), ;
                             TratarNulo(cursor_4c_CheMov.Conorigs, ""), ;
                             TratarNulo(cursor_4c_CheMov.Grupos, ""), ;
                             TratarNulo(cursor_4c_CheMov.Contas, ""), ;
                             TratarNulo(cursor_4c_CheMov.Numlotes, 0), ;
                             TratarNulo(cursor_4c_CheMov.Protocolos, ""))
                    ENDSCAN

                    IF USED("cursor_4c_CheMov")
                        USE IN cursor_4c_CheMov
                    ENDIF

                    SELECT dbCheqMovim
                    GO TOP

                    *-- Prorrogacoes (SigChea)
                    SELECT dbCheqProrrog
                    ZAP

                    loc_cSQL = "SELECT Vencs, PJuros, VJuros, Usuars, Motivo" + ;
                        " FROM SigChea WHERE Nums = " + EscaparSQL(loc_cNums)

                    IF USED("cursor_4c_CheProrrog")
                        USE IN cursor_4c_CheProrrog
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheProrrog")

                    IF loc_nResultado >= 0
                        SELECT cursor_4c_CheProrrog
                        SCAN
                            INSERT INTO dbCheqProrrog (Vencs, PJuros, VJuros, Usuars, Motivo) ;
                                VALUES ;
                                (ConverterParaData(cursor_4c_CheProrrog.Vencs), ;
                                 TratarNulo(cursor_4c_CheProrrog.PJuros, 0), ;
                                 TratarNulo(cursor_4c_CheProrrog.VJuros, 0), ;
                                 TratarNulo(cursor_4c_CheProrrog.Usuars, ""), ;
                                 TratarNulo(cursor_4c_CheProrrog.Motivo, ""))
                        ENDSCAN

                        IF USED("cursor_4c_CheProrrog")
                            USE IN cursor_4c_CheProrrog
                        ENDIF
                    ENDIF

                    SELECT dbCheqProrrog
                    GO TOP

                    *-- Follow-up mais recente (SigCheh.Hists)
                    THIS.this_cFollowUpCheque = ""

                    loc_cSQL = "SELECT Hists FROM SigCheh WHERE Nums = " + ;
                        EscaparSQL(loc_cNums) + " ORDER BY Datas DESC"

                    IF USED("cursor_4c_CheFollow")
                        USE IN cursor_4c_CheFollow
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheFollow")

                    IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_CheFollow") > 0
                        THIS.this_cFollowUpCheque = TratarNulo(cursor_4c_CheFollow.Hists, "")
                    ENDIF

                    IF USED("cursor_4c_CheFollow")
                        USE IN cursor_4c_CheFollow
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar a movimenta" + CHR(231) + CHR(227) + ;
                "o do cheque:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarCredito - Popula dbCredito (grade Grade da aba Credito) com os
    * lancamentos de SigFiCp (compra/cobranca por cheque pre-datado/carteira)
    * do CPF pesquisado, transcricao do mativacredito() legado: normaliza o
    * CPF/CGC digitado para o formato mascarado (11 digitos -> CPF, 14 ->
    * CNPJ, senao mantem como veio) e usa essa mascara como chave de busca em
    * SigFiCp.Ccpfs (char(20), a mesma coluna onde o legado grava a mascara).
    *
    * Tambem resolve a situacao do cliente (SigCdCli.Situas) e a descricao
    * correspondente em SigCdCst para o rotulo colorido (Label2) - vermelho
    * quando Situas = "*", azul nos demais casos, igual ao legado.
    *==========================================================================
    FUNCTION CarregarCredito()
        LOCAL loc_cCpfBruto, loc_cCpfMask, loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro      = ""
        THIS.this_cLabelSituacaoCredito = ""
        THIS.this_lSituacaoVermelha     = .F.

        IF !USED("dbCredito")
            IF !THIS.CriarCursoresLocais()
                RETURN .F.
            ENDIF
        ENDIF

        loc_cCpfBruto = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(THIS.this_cCpf), ".", ""), "-", ""), "/", "")

        DO CASE
            CASE LEN(loc_cCpfBruto) = 11
                loc_cCpfMask = TRANSFORM(loc_cCpfBruto, "@R 999.999.999-99")
            CASE LEN(loc_cCpfBruto) = 14
                loc_cCpfMask = TRANSFORM(loc_cCpfBruto, "@R 99.999.999/9999-99")
            OTHERWISE
                loc_cCpfMask = loc_cCpfBruto
        ENDCASE

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                SELECT dbCredito
                ZAP

                loc_cSQL = "SELECT Tipos, Usuars, Emps, Datas, Dopes, Numes, Ccpfs," + ;
                    " Nvalors, Dvencs, Cbancos, Cagencias, Ccontas, Ccheinis, Cdiginis," + ;
                    " Cchefins, Cdigfins, Cseries, Cdaberts, NChkDocs, TdDocs" + ;
                    " FROM SigFiCp" + ;
                    " WHERE Ccpfs = " + EscaparSQL(loc_cCpfMask) + ;
                    " ORDER BY Idchep"

                IF USED("cursor_4c_FiCp")
                    USE IN cursor_4c_FiCp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FiCp")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao carregar o cr" + CHR(233) + "dito:" + ;
                        CHR(13) + CapturarErroSQL()
                ELSE
                    SELECT cursor_4c_FiCp
                    SCAN
                        INSERT INTO dbCredito ;
                            (Tipos, Usuars, Emps, Datas, Dopes, Numes, Ccpfs, Nvalors, Dvencs, ;
                             Cbancos, Cagencias, Ccontas, Ccheinis, Cdiginis, Cchefins, ;
                             Cdigfins, Cseries, Cdaberts, NChkDocs, TdDocs) ;
                            VALUES ;
                            (TratarNulo(cursor_4c_FiCp.Tipos, ""), ;
                             TratarNulo(cursor_4c_FiCp.Usuars, ""), ;
                             TratarNulo(cursor_4c_FiCp.Emps, ""), ;
                             ConverterParaData(cursor_4c_FiCp.Datas), ;
                             TratarNulo(cursor_4c_FiCp.Dopes, ""), ;
                             TratarNulo(cursor_4c_FiCp.Numes, 0), ;
                             TratarNulo(cursor_4c_FiCp.Ccpfs, ""), ;
                             TratarNulo(cursor_4c_FiCp.Nvalors, 0), ;
                             ConverterParaData(cursor_4c_FiCp.Dvencs), ;
                             TratarNulo(cursor_4c_FiCp.Cbancos, ""), ;
                             TratarNulo(cursor_4c_FiCp.Cagencias, ""), ;
                             TratarNulo(cursor_4c_FiCp.Ccontas, ""), ;
                             TratarNulo(cursor_4c_FiCp.Ccheinis, ""), ;
                             TratarNulo(cursor_4c_FiCp.Cdiginis, ""), ;
                             TratarNulo(cursor_4c_FiCp.Cchefins, ""), ;
                             TratarNulo(cursor_4c_FiCp.Cdigfins, ""), ;
                             TratarNulo(cursor_4c_FiCp.Cseries, ""), ;
                             TratarNulo(cursor_4c_FiCp.Cdaberts, ""), ;
                             TratarNulo(cursor_4c_FiCp.NChkDocs, 0), ;
                             ConverterParaData(cursor_4c_FiCp.TdDocs))
                    ENDSCAN

                    IF USED("cursor_4c_FiCp")
                        USE IN cursor_4c_FiCp
                    ENDIF

                    SELECT dbCredito
                    GO TOP

                    *-- Situacao do cliente (pelo mesmo CPF) + descricao em SigCdCst
                    IF !EMPTY(loc_cCpfMask)
                        loc_cSQL = "SELECT Situas FROM SigCdCli WHERE Cpfs = " + ;
                            EscaparSQL(loc_cCpfMask)

                        IF USED("cursor_4c_CliSitua")
                            USE IN cursor_4c_CliSitua
                        ENDIF

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliSitua") > 0 ;
                                AND RECCOUNT("cursor_4c_CliSitua") > 0

                            THIS.this_lSituacaoVermelha = (ALLTRIM(TratarNulo(cursor_4c_CliSitua.Situas, "")) == "*")

                            loc_cSQL = "SELECT Descrs FROM SigCdCst WHERE Codigos = " + ;
                                EscaparSQL(PADR(TratarNulo(cursor_4c_CliSitua.Situas, ""), 3))

                            IF USED("cursor_4c_CstDesc")
                                USE IN cursor_4c_CstDesc
                            ENDIF

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CstDesc") > 0 ;
                                    AND RECCOUNT("cursor_4c_CstDesc") > 0
                                THIS.this_cLabelSituacaoCredito = ALLTRIM(TratarNulo(cursor_4c_CstDesc.Descrs, ""))
                            ENDIF

                            IF USED("cursor_4c_CstDesc")
                                USE IN cursor_4c_CstDesc
                            ENDIF
                        ENDIF

                        IF USED("cursor_4c_CliSitua")
                            USE IN cursor_4c_CliSitua
                        ENDIF
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar o cr" + CHR(233) + "dito:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir / Atualizar / ExecutarExclusao - NAO sobrescritos de proposito.
    *
    * SIGOPCGV eh um form OPERACIONAL de CONSULTA: a entidade SigCdCli eh
    * somente PESQUISADA aqui (por conta, nome, cpf/cgc, conjuge ou telefone)
    * para alimentar as abas de saldo, cheques, vendas, estoque, pendencias,
    * conserto, cartao, producao e credito. A unica gravacao de cliente do
    * form legado passa pelo wrapper clsconta (cnt_4c_Conta na Page de
    * alteracao), que tem seu proprio mGravaDados/mValidaObj - nao pela
    * ThisForm.poDataMgr deste BO. Por isso o comportamento padrao herdado
    * de BusinessBase ja eh o correto para Inserir/Atualizar/ExecutarExclusao.
    *==========================================================================

ENDDEFINE


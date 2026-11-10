# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-11-09 22:22:45] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-09 22:22:45] [INFO] Config FPW: (nao fornecido)
[2026-11-09 22:22:45] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-09 22:22:45] [INFO] Timeout: 300 segundos
[2026-11-09 22:22:45] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_juiovcg3.prg
[2026-11-09 22:22:45] [INFO] Conteudo do wrapper:
[2026-11-09 22:22:45] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpOch', 'C:\4c\tasks\task774\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpOch', 'C:\4c\tasks\task774\logs\06_testForm.log'
QUIT

[2026-11-09 22:22:45] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_juiovcg3.prg
[2026-11-09 22:22:45] [INFO] VFP output esperado em: C:\4c\tasks\task774\vfp_output.txt
[2026-11-09 22:22:45] [INFO] Executando Visual FoxPro 9...
[2026-11-09 22:22:45] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_juiovcg3.prg
[2026-11-09 22:22:45] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_juiovcg3.prg
[2026-11-09 22:22:45] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpOch
Inicio: 09/11/2026 22:22:45

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 09/11/2026 22:23:51
Duracao: 66 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-09 22:23:52] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-09 22:23:52] [INFO] VFP9 finalizado em 66.7092083 segundos
[2026-11-09 22:23:52] [INFO] Exit Code: 
[2026-11-09 22:23:52] [INFO] 
[2026-11-09 22:23:52] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-09 22:23:52] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_juiovcg3.prg
[2026-11-09 22:23:52] [INFO] 
[2026-11-09 22:23:52] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-09 22:23:52] [INFO] * Auto-generated wrapper for parameters
[2026-11-09 22:23:52] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-09 22:23:52] [INFO] * Parameters: 'FormSigOpOch', 'C:\4c\tasks\task774\logs\06_testForm.log'
[2026-11-09 22:23:52] [INFO] 
[2026-11-09 22:23:52] [INFO] * Anti-dialog protections for unattended execution
[2026-11-09 22:23:52] [INFO] SET SAFETY OFF
[2026-11-09 22:23:52] [INFO] SET RESOURCE OFF
[2026-11-09 22:23:52] [INFO] SET TALK OFF
[2026-11-09 22:23:52] [INFO] SET NOTIFY OFF
[2026-11-09 22:23:52] [INFO] SYS(2335, 0)
[2026-11-09 22:23:52] [INFO] 
[2026-11-09 22:23:52] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpOch', 'C:\4c\tasks\task774\logs\06_testForm.log'
[2026-11-09 22:23:52] [INFO] QUIT
[2026-11-09 22:23:52] [INFO] 
[2026-11-09 22:23:52] [INFO] === Fim do Wrapper.prg ===
[2026-11-09 22:23:52] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpOch.prg):
*==============================================================================
* FormSigOpOch.prg - Consulta de FollowUp
*
* Legado  : SIGOPOCH.SCX (task774) - dialogo MODAL "Consulta de FollowUp",
*           aberto pelo form pai com DO Form SigOpOch With <formPai>, <Nopers>,
*           <Opers>. BaseClass = form GENERICO (sem frmcadastro, sem PageFrame,
*           sem abas) - Form OPERACIONAL FLAT, todos os controles sao filhos
*           DIRETOS do form, igual ao legado.
*
* Layout legado (tasks\task774\SigOpOch_form_codigo_fonte.txt):
*   cntSombra (cabecalho cinza, Top=0/Left=0/Width=800/Height=80)
*     lblSombra / lblTitulo (Caption = ThisForm.Caption, setado no Init)
*   GridFollowUp (5 colunas, somente leitura - historico de FollowUp)
*   grd_lancamento (6 colunas, somente leitura - lancamento de conta corrente)
*   CommandGroup1.Sair (unico botao - "Encerrar" - fecha o dialogo)
*   Memo_Obs (somente leitura - observacao completa da linha corrente)
* O dialogo e PURAMENTE DE CONSULTA: nenhum INSERT/UPDATE/DELETE em lugar
* nenhum do codigo original (ver cabecalho de SigOpOchBO.prg).
*
* Historico de fases:
*   Fase 1/2: SigOpOchBO.prg (propriedades + CarregarContaCorrente/
*             CarregarFollowUp/CarregarDoCursor/ObterChavePrimaria).
*   Fase 3:   FormSigOpOch.prg - estrutura base (Init, InicializarForm,
*             ConfigurarPageFrame com cnt_4c_Sombra/lbl_4c_LblSombra/
*             lbl_4c_LblTitulo, Destroy). Form FLAT: o legado nao tem
*             PageFrame nem Page nenhuma - nenhum pgf_4c_* eh criado neste
*             form (mesma familia do SIGOPBIN/FormSIGOPBIN).
*   Fase 4/8: cursores de trabalho (cursor_4c_ContaCc/cursor_4c_FollowUp),
*             as DUAS grades (grd_lancamento -> grd_4c_Lancamento,
*             GridFollowUp -> grd_4c_FollowUp), o botao Encerrar
*             (CommandGroup1.Sair -> cmg_4c_Botoes.Buttons(1)) com o Click
*             real do legado, e CarregarLista/AtualizarGrades.
*   Fase 5/8:   Memo_Obs (obj_4c_Memo_Obs), somente leitura, ligado a
*             cursor_4c_FollowUp.ObsAudts (ConfigurarMemo), repintado junto
*             com as grades em AtualizarGrades.
*   Fase 6/8: ordem de tabulacao (TabIndex) dos 4 controles que o SCX
*             declara explicitamente: grd_4c_FollowUp=3, cmg_4c_Botoes=6,
*             grd_4c_Lancamento=8, obj_4c_Memo_Obs=34. O dialogo NAO tem
*             TextBox nenhum (nem campo digitavel, nem lookup) - as DUAS
*             grades sao somente-leitura e o unico controle de entrada eh
*             o botao Encerrar: o roteiro generico da Fase 6 (campos
*             restantes + BINDEVENT de lookup F4/F5) nao se aplica aqui,
*             e inventar TextBox/lookup que o legado nao tem violaria a
*             regra "NUNCA inventar" (mesmo raciocinio da nota da Fase 4).
*   Fase 7/8: eventos principais - AfterRowColChange do GridFollowUp
*             (GrdFollowUpAfterRowColChange, equivalente a
*             ThisForm.Memo_Obs.Refresh) ligado em ConfigurarEventos. Com
*             ele os DOIS unicos eventos do SCX legado estao portados
*             (o outro, Sair.Valid -> CmdEncerrarClick, veio na Fase 4).
*   Fase 8/8: consolidacao final - conferido metodo a metodo contra o dump
*             (tasks\task774\SigOpOch_form_codigo_fonte.txt) que os SEIS
*             metodos/eventos do legado (Init, Load, Release, AfterRowColChange,
*             Sair.Valid, Memo_Obs.When) estao TODOS portados; ver bloco
*             "FASE 8" abaixo para a disposicao dos 9 nomes do roteiro
*             generico de Fase 8 que nao se aplicam a este dialogo.
*
* FASE 8 - SEM BtnBuscar/BtnSalvar/BtnCancelarClick/FormParaBO/BOParaForm/
*          HabilitarCampos/LimparCampos/AjustarBotoesPorModo
* ---------------------------------------------------------------------
* O roteiro generico desta fase (BtnBuscarClick/BtnEncerrarClick/
* BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/
* LimparCampos/CarregarLista/AjustarBotoesPorModo) eh o checklist do
* frmcadastro (Page1=Lista + Page2=Dados com campos EDITAVEIS). Nenhum dos 8
* nomes restantes se aplica a este dialogo, pela MESMA razao ja registrada
* nas notas de Fase 4 e Fase 7 acima (sem PageFrame, sem Grupo_Op, sem
* pcEscolha, sem Page2) mais uma: AMBOS os grids E o Memo_Obs sao
* somente-leitura (ReadOnly = .T. no grid, em CADA coluna e no proprio
* memo) - nao ha "forma" digitavel para mapear de volta ao BO, nem campo
* para habilitar/desabilitar por modo. Disposicao, um a um:
*
*   Nome pedido pelo roteiro   Existe no legado?   Disposicao aqui
*   -------------------------  ------------------  --------------------------
*   BtnBuscarClick              NAO (SCX so tem    N/A - nao inventar botao
*                                 CommandGroup1,     que o legado nao tem
*                                 ButtonCount = 1)
*   BtnEncerrarClick             SIM (Sair,         Ja implementado como
*                                 Caption "Encerrar" CmdEncerrarClick (Sair.
*                                 no dump)           Valid -> ThisForm.Release)
*   BtnSalvarClick/              NAO (nenhum        N/A - SigOpOchBO nao
*   BtnCancelarClick             Insert/Update/     sobrescreve Inserir/
*                                 Delete no dump -   Atualizar/Executar
*                                 ver nota no fim     Exclusao; dialogo
*                                 de SigOpOchBO.prg)  PURAMENTE de consulta
*   FormParaBO / BOParaForm      N/A - sem campo    Coberto por
*                                 EDITAVEL nao ha     CarregarDoCursor (BO) +
*                                 o que "mapear de    GrdFollowUpAfterRowCol-
*                                 volta"; a leitura   Change (Form), que ja
*                                 (equivalente a      fazem esse sentido unico
*                                 BOParaForm) ja      (BO -> campo) a cada
*                                 existe              troca de linha
*   HabilitarCampos /            N/A - nenhum       .ReadOnly = .T. fixo,
*   LimparCampos                 campo muda de       declarado uma unica vez
*                                 estado por modo     em ConfigurarGrade
*                                 (o dialogo inteiro  Lancamento/Configurar
*                                 eh sempre so-       GradeFollowUp/
*                                 leitura)            ConfigurarMemo (nao ha
*                                                      modo INCLUIR/ALTERAR/
*                                                      VISUALIZAR aqui)
*   AjustarBotoesPorModo         N/A - o UNICO       N/A - Encerrar fica
*                                 botao do legado     sempre habilitado (nao
*                                 nao muda de estado   ha modo nenhum para
*                                 por modo             ajustar)
*   CarregarLista                 SIM                Ja implementado (Fase 4)
*
* Escrever qualquer um dos 8 metodos marcados N/A so para "bater o
* checklist" seria o stub disfarcado que a regra de completude PROIBE
* (corpo vazio ou so MsgAviso) - pior que a ausencia documentada, porque
* sugere fidelidade que nao existe.
*
* PROCEDURE Load legado (=fConfigGeral() + DoDefault()) tambem nao gera
* metodo aqui: fConfigGeral era inicializacao GLOBAL da aplicacao Fortyus
* (SIGFUNCS.PRG), substituida na nova arquitetura pela carga do proprio
* config.prg/ConfigurarAmbiente() no startup - mesmo raciocinio ja registrado
* em SigOpClpBO.prg, SIGOPGRCBO.prg, SigOpIpBBO.prg, SigOpMpdBO.prg e
* SigOpMpnBO.prg (outros forms SigOp* desta mesma leva de migracao).
*
* FASE 8/8 CONCLUIDA.
*
* FASE 7 - SEM BtnIncluir/BtnAlterar/BtnVisualizar/BtnExcluirClick
* ---------------------------------------------------------------
* O roteiro generico da Fase 7 pede os 4 handlers CRUD da barra do
* frmcadastro. Medido no dump (tasks\task774\SigOpOch_form_codigo_fonte.txt):
*   - "frmcadastro" ........... 0 ocorrencias (o legado herda de form PURO)
*   - "Grupo_Op" .............. 0 ocorrencias (nao ha barra CRUD)
*   - btn/cmd/Command + verbo
*     Incluir/Alterar/
*     Visualizar/Excluir ...... 0 ocorrencias
*   - "pcEscolha" (modo CRUD) . 0 ocorrencias
*   - INSERT/UPDATE/DELETE .... 0 (as duas unicas queries sao SELECT)
*   - botoes do legado ........ 1 (CommandGroup1, ButtonCount = 1, "Sair")
* Nao existe registro para incluir, alterar ou excluir nesta tela: criar os 4
* handlers exigiria INVENTAR botoes que o legado nao tem (viola o PILAR 1 e a
* regra "NUNCA inventar") ou escrever metodos vazios (proibido pela regra de
* completude). O que a Fase 7 entrega aqui sao os eventos dos controles que o
* form REALMENTE tem - o handler do unico botao (ja em CmdEncerrarClick) e o
* AfterRowColChange da grade de FollowUp - mesmo desenho de FormSIGMVCTH.
*
* FASE 4 - LAYOUT FLAT, SEM ConfigurarPaginaLista/AlternarPagina
* -------------------------------------------------------------
* O roteiro generico da Fase 4 pede ConfigurarPaginaLista + cnt_4c_Botoes com
* 6 botoes CRUD + AlternarPagina. Esse legado NAO tem nada disso, e a medicao
* no dump (tasks\task774\SigOpOch_form_codigo_fonte.txt) e' esta:
*   - PageFrame/Page .......... 0 ocorrencias de "BaseClass: pageframe"
*   - grades .................. 2 ("BaseClass: grid" - GridFollowUp e
*                                  grd_lancamento, filhas DIRETAS do form)
*   - botoes .................. 1 CommandGroup de ButtonCount = 1 ("Sair",
*                                  Caption "Encerrar", Cancel = .T.)
*   - INSERT/UPDATE/DELETE .... 0 (dialogo de consulta pura)
* Logo nao existe Lista x Dados para alternar nem registro para Incluir/
* Alterar/Excluir/Buscar: criar PageFrame, 6 botoes CRUD ou um AlternarPagina
* que nao alterna nada seria inventar UI (viola o PILAR 1 e a regra "NUNCA
* inventar") ou escrever metodo vazio (proibido pela regra de completude).
* O que a Fase 4 entrega aqui e' a estrutura que o form REALMENTE tem:
* grade + botao de acao + metodo de carga (ConfigurarGrades/ConfigurarBotoes/
* CarregarLista) - mesmo desenho de FormSIGMVCTH e FormSIGOPCAU.
*
* As duas grades do legado mapeiam para grd_4c_Dados no mapeamento.json (o
* GeradorMapeamento colide os dois nomes num so); aqui elas recebem nomes
* DISTINTOS (grd_4c_Lancamento / grd_4c_FollowUp), senao o segundo AddObject
* estouraria "Object GRD_4C_DADOS is already defined". O mapeamento.json da
* task foi corrigido junto. Mesma correcao para o CommandGroup: o JSON o
* nomeia obj_4c_CommandGroup1 (prefixo generico de tipo nao reconhecido); o
* canonico do projeto para CommandGroup e' cmg_4c_.
*
* Mapeamento (tasks\task774\mapeamento.json):
*   SIGOPOCH.cntSombra            -> cnt_4c_Sombra
*   SIGOPOCH.cntSombra.lblSombra  -> lbl_4c_LblSombra
*   SIGOPOCH.cntSombra.lblTitulo  -> lbl_4c_LblTitulo
*   SIGOPOCH.GridFollowUp         -> grd_4c_Dados (grd_4c_FollowUp nesta
*                                     migracao - nome mais especifico, ja que
*                                     ha DOIS grids no mesmo form)
*   SIGOPOCH.grd_lancamento       -> grd_4c_Dados (grd_4c_Lancamento)
*   SIGOPOCH.CommandGroup1        -> obj_4c_CommandGroup1 (cmg_4c_Botoes)
*   SIGOPOCH.Memo_Obs             -> obj_4c_Memo_Obs
*==============================================================================

DEFINE CLASS FormSigOpOch AS FormBase

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGOPOCH)
    Width       = 800
    Height      = 450
    DataSession = 2
    BorderStyle = 2
    AutoCenter  = .T.
    Caption     = "Consulta de FollowUp"
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    ShowWindow  = 1
    WindowType  = 1
    WindowState = 0
    Themes      = .F.

    *-- Parametros de filtro recebidos no Init (equivalem a pnNoper/pcOper do
    *-- PROCEDURE Init legado) - identificam o lancamento de conta corrente
    *-- cujo FollowUp esta sendo consultado.
    this_nNopers = 0
    this_cOpers  = ""

    *--------------------------------------------------------------------------
    * Init - Recebe os parametros do form pai (equivale ao LParameters poForm,
    * pnNoper, pcOper do legado) e os guarda ANTES de DODEFAULT(), para que
    * InicializarForm() (chamado por FormBase.Init via DODEFAULT) possa
    * transferi-los para o Business Object.
    *
    * par_oFormPai NAO e armazenado: o legado recebe poForm no LParameters mas
    * NUNCA o referencia em lugar nenhum do codigo fonte original (conferido
    * em tasks\task774\SigOpOch_form_codigo_fonte.txt) - guardar uma
    * referencia que nunca e lida inventaria uso que o legado nao tem.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_oFormPai, par_nNoper, par_cOper

        LOCAL loc_oErro
        TRY
            THIS.this_nNopers = IIF(VARTYPE(par_nNoper) = "N", par_nNoper, 0)
            THIS.this_cOpers  = IIF(VARTYPE(par_cOper) = "C", par_cOper, "")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.Init")
        ENDTRY

        *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object, transfere os parametros de
    * filtro e monta a estrutura visual base (cabecalho).
    * (chamado por FormBase.Init via DODEFAULT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo do form (imagem do Framework Fortyus legado)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpOchBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigOpOchBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSigOpOch.InicializarForm")
            ELSE
                THIS.this_oBusinessObject.this_nNopers = THIS.this_nNopers
                THIS.this_oBusinessObject.this_cOpers  = THIS.this_cOpers

                *-- 1) Cursores de trabalho ANTES das grades: atribuir
                *-- Column.ControlSource de cursor que ainda nao existe estoura
                *-- "Alias is not found" DENTRO deste TRY, InicializarForm
                *-- devolve .F. e o usuario clica no menu e nada abre.
                THIS.InicializarCursores()

                *-- 2) Cabecalho (cnt_4c_Sombra + labels) - o legado nao tem
                *-- PageFrame/Page nenhuma, entao nada mais eh criado aqui
                THIS.ConfigurarPageFrame()

                *-- 3) Grades (filhas DIRETAS do form, como no SCX legado)
                THIS.ConfigurarGrades()

                *-- 3b) Memo_Obs (observacao completa da linha corrente de
                *-- grd_4c_FollowUp) - depende de cursor_4c_FollowUp, ja
                *-- criado em InicializarCursores()
                THIS.ConfigurarMemo()

                *-- 4) Botao Encerrar DEPOIS do cabecalho: o CommandGroup do
                *-- legado fica em Top = -2 / Left = 720, ou seja DENTRO da
                *-- area do cnt_4c_Sombra (Top 0..80) - criado antes, a faixa
                *-- cinza o cobriria (mesma armadilha de ordem da regra #11).
                THIS.ConfigurarBotoes()

                *-- 5) Eventos (BINDEVENT exige metodos PUBLIC - regra #3)
                THIS.ConfigurarEventos()

                *-- Torna a arvore de controles visivel (AddObject cria com
                *-- Visible=.F.)
                THIS.TornarControlesVisiveis(THIS)

                *-- 6) Carga: o legado faz as duas consultas no PROPRIO Init,
                *-- antes de a tela aparecer. Falha de carga NAO impede a
                *-- abertura (a mensagem do BO ja foi exibida em CarregarLista).
                *--
                *-- Pulada em validacao de UI: ali gnConnHandle = -1, as duas
                *-- consultas falhariam e o MsgErro de CarregarLista BLOQUEIA o
                *-- processo headless (o dialog so se suprime com
                *-- gb_4c_ModoTeste E gc_4c_ArquivoErroTeste definidos).
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria o cabecalho (cnt_4c_Sombra + labels).
    *   Form OPERACIONAL FLAT: o legado (SIGOPOCH.SCX) nao tem PageFrame nem
    *   Page nenhuma - todos os controles sao filhos diretos do form. Nome do
    *   metodo mantido por convencao do orquestrador de migracao: este form NAO
    *   cria PageFrame algum, nem aqui nem em nenhum outro metodo.
    *
    *   NAO reescrever a frase acima citando a CHAMADA de criacao do PageFrame
    *   entre aspas: o gate da Fase 5 decide o layout FLAT procurando esse texto
    *   no arquivo INTEIRO, sem distinguir codigo de comentario - a prosa
    *   quotando a chamada derruba a fase com o form CORRETO (regra irma da que
    *   proibe comentario citando nome de metodo para satisfazer gate).
    *   Demais controles do legado (GridFollowUp, grd_lancamento,
    *   CommandGroup1, Memo_Obs) entram nas fases 4 a 6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oCab, loc_oErro
        TRY
            *-- cntSombra original: Top=0, Left=0, Width=800, Height=80,
            *-- BackColor=100,100,100
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCab = THIS.cnt_4c_Sombra
            WITH loc_oCab
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
            ENDWITH

            *-- Labels adicionados FORA do WITH do container (WITH aninhado com
            *-- AddObject ignora propriedades silenciosamente - regra conhecida)
            *-- lblSombra original: Top=18, Left=10, Width=769, Height=40,
            *-- ForeColor=0,0,0 (camada de sombra, preta, por TRAS do titulo)
            loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCab.lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .AutoSize      = .F.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
            ENDWITH

            *-- lblTitulo original: Top=17, Left=10, Width=769, Height=46,
            *-- ForeColor=255,255,255 (camada branca, por CIMA da sombra)
            loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCab.lbl_4c_LblTitulo
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = THIS.Caption
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = 769
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Cria os DOIS cursores de trabalho VAZIOS.
    *
    * Equivalem aos cursores ContaCC e Movimento do Init legado. Precisam
    * existir ANTES de qualquer Column.ControlSource: atribuir ControlSource de
    * cursor inexistente estoura "Alias 'CURSOR_4C_CONTACC' is not found"
    * dentro do TRY de InicializarForm, que devolve .F., CREATEOBJECT devolve
    * .F. e o usuario clica no menu e NADA acontece, sem erro visivel.
    *
    * A lista de campos eh EXATAMENTE a lista de colunas dos SELECT de
    * SigOpOchBO.CarregarContaCorrente/CarregarFollowUp: aquelas rotinas
    * populam um cursor temporario e trazem o resultado com ZAP + APPEND FROM
    * DBF(), que casa os campos por NOME - nome a mais ou a menos entra em
    * branco calado. Tipos conferidos em docs\schema.sql (UTF-16, lido com
    * Get-Content -Raw): SigMvCcr.datas datetime NULL, hists char(60) NULL,
    * valors numeric(11,2), opers char(1), emps char(3), saldos numeric(15,2),
    * concs bit, dtaudits datetime NULL; SigCqOch.datars/datas datetime NULL,
    * tplancs char(15), usuars char(10), obsaudts text NULL.
    *
    * SET NULL ON eh obrigatorio: o SQL Server devolve NULL nessas colunas e
    * sem campo nullable o APPEND FROM falha.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarCursores()
        LOCAL loc_oErro
        TRY
            *-- ContaCC legado (SigMvCcr) - RecordSource de grd_4c_Lancamento.
            *-- Concs/DtAudits NAO aparecem em coluna nenhuma da grade: sao as
            *-- colunas que o DynamicForeColor/DynamicBackColor do Init legado
            *-- le para colorir a linha (ver ConfigurarGradeLancamento).
            IF !USED("cursor_4c_ContaCc")
                SET NULL ON
                CREATE CURSOR cursor_4c_ContaCc ( ;
                    Datas    T          NULL, ;
                    Hists    C(60)      NULL, ;
                    Valors   N(11,2), ;
                    Opers    C(1), ;
                    Emps     C(3), ;
                    Saldos   N(15,2), ;
                    Concs    N(1), ;
                    DtAudits T          NULL)
                SET NULL OFF
            ENDIF

            *-- Movimento legado (SigCqOch + ObsAudt2 derivada) - RecordSource
            *-- de grd_4c_FollowUp. ObsAudts eh o texto COMPLETO (Memo_Obs, na
            *-- Fase 5); ObsAudt2 eh a versao truncada em 50 que o legado monta
            *-- com Padr(Nvl(ObsAudts,' '),50) para a coluna da grade.
            IF !USED("cursor_4c_FollowUp")
                SET NULL ON
                CREATE CURSOR cursor_4c_FollowUp ( ;
                    Datars   T      NULL, ;
                    TpLancs  C(15), ;
                    Datas    T      NULL, ;
                    Usuars   C(10), ;
                    ObsAudts M(4)   NULL, ;
                    ObsAudt2 C(50))
                SET NULL OFF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.InicializarCursores")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrades - Cria as DUAS grades do legado, filhas DIRETAS do form
    * (o SCX nao tem PageFrame nem Container envolvendo-as).
    *
    * Nenhuma das duas sobrepoe o cnt_4c_Sombra (Top 0..80) nem o cmg_4c_Botoes
    * (Top -2..83): grd_4c_Lancamento ocupa 89..165 e grd_4c_FollowUp 173..373.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrades()
        THIS.ConfigurarGradeLancamento()
        THIS.ConfigurarGradeFollowUp()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeLancamento - grd_lancamento legado (Class: grid).
    * Mostra o UNICO lancamento de conta corrente que o form pai selecionou
    * (SigMvCcr filtrado por Nopers + Opers). Somente leitura: ReadOnly = .T.
    * no grid E em cada coluna, como no SCX.
    *
    * As colunas conservam os nomes nativos Column1..Column6 (renomear Column
    * quebra TODAS as referencias .ColumnN). Correspondencia com o legado:
    *   Column1 = Col_Data  (Datas)    Column4 = Col_Oper  (Opers)
    *   Column2 = Col_Hist  (Hists)    Column5 = Col_Emp   (Emps)
    *   Column3 = Col_Valor (Valors)   Column6 = Col_Saldo (Saldos)
    *
    * ATENCAO a ColumnOrder: o SCX declara Column5.ColumnOrder = 6 e
    * Column6.ColumnOrder = 5, ou seja a ordem VISIVEL eh
    * Data | Historico | Valor | O | Saldo | Emp - o Saldo vem ANTES da
    * Empresa na tela, apesar de ser a ultima coluna declarada.
    *
    * NAO transcrito do dump: "Value = 0". Grid tem a propriedade Value (consta
    * em automation\propriedades_baseclasses.txt), mas ela reflete o valor da
    * celula ativa e nao aceita escrita em runtime como configuracao - eh
    * bookkeeping do Form Designer. Atribuir derrubaria o Init sem ganho visual
    * nenhum (mesma familia de ZOrderSet, regra #33).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeLancamento()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("grd_4c_Lancamento", "Grid")

            *-- grd_lancamento legado: Top=89, Left=60, Width=679, Height=76,
            *-- FontName="Tahoma", GridLineColor=238,238,238
            WITH THIS.grd_4c_Lancamento
                .Top               = 89
                .Left              = 60
                .Width             = 679
                .Height            = 76
                .HeaderHeight       = 0
                .FontName          = "Tahoma"
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                *-- TabIndex = 8 no SCX legado (ordem de tabulacao do dialogo)
                .TabIndex          = 8
                *-- ReadOnly do GRID vem ANTES do ReadOnly das colunas: o do
                *-- grid propaga e sobrescreveria o das colunas (regra #18)
                .ReadOnly          = .T.
                *-- Grid criado por AddObject em form OPERACIONAL: sem estas
                *-- duas, as barras de marcacao aparecem na lateral esquerda
                .DeleteMark        = .F.
                .RecordMark        = .F.
            ENDWITH

            *-- ColumnCount e RecordSource por referencia EXPLICITA, FORA do
            *-- WITH que acessa .Column1..: no instante em que o WITH eh aberto
            *-- as colunas ainda nao existem ("Unknown member COLUMN1").
            THIS.grd_4c_Lancamento.ColumnCount  = 6
            THIS.grd_4c_Lancamento.RecordSource = "cursor_4c_ContaCc"

            WITH THIS.grd_4c_Lancamento
                *-- ControlSource de TODAS as colunas (Init legado:
                *-- .Col_data.ControlSource = "Datas", etc.) - aqui
                *-- qualificado com o alias, padrao do projeto
                .Column1.ControlSource = "cursor_4c_ContaCc.Datas"
                .Column2.ControlSource = "cursor_4c_ContaCc.Hists"
                .Column3.ControlSource = "cursor_4c_ContaCc.Valors"
                .Column4.ControlSource = "cursor_4c_ContaCc.Opers"
                .Column5.ControlSource = "cursor_4c_ContaCc.Emps"
                .Column6.ControlSource = "cursor_4c_ContaCc.Saldos"

                *-- Coluna 1 (Col_Data) - "Data"
                .Column1.Width             = 74
                .Column1.FontName          = "Tahoma"
                .Column1.FontSize          = 8
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.Sparse            = .F.
                .Column1.ReadOnly          = .T.
                .Column1.Header1.Caption   = "Data"
                .Column1.Header1.FontName  = "Tahoma"
                .Column1.Header1.Alignment = 2
                .Column1.Text1.FontName    = "Tahoma"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ReadOnly    = .T.
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 2 (Col_Hist) - "Historico"
                .Column2.Width             = 280
                .Column2.FontName          = "Tahoma"
                .Column2.FontSize          = 8
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.Sparse            = .F.
                .Column2.ReadOnly          = .T.
                .Column2.Header1.Caption   = "Hist" + CHR(243) + "rico"
                .Column2.Header1.FontName  = "Tahoma"
                .Column2.Header1.Alignment = 2
                .Column2.Text1.FontName    = "Tahoma"
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.Alignment   = 3
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ReadOnly    = .T.
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 3 (Col_Valor) - "Valor". O dump tem Column3.Format =
                *-- "" (override VAZIO do Form Designer, nao se transcreve) e
                *-- Column3.InputMask = "9,999,999.99"; o Text1 traz Format E
                *-- InputMask com a mesma mascara.
                .Column3.Width             = 86
                .Column3.FontName          = "Tahoma"
                .Column3.FontSize          = 8
                .Column3.Movable           = .F.
                .Column3.Resizable         = .F.
                .Column3.Sparse            = .F.
                .Column3.ReadOnly          = .T.
                .Column3.InputMask         = "9,999,999.99"
                .Column3.Header1.Caption   = "Valor"
                .Column3.Header1.FontName  = "Tahoma"
                .Column3.Header1.Alignment = 2
                .Column3.Text1.FontName    = "Tahoma"
                .Column3.Text1.FontSize    = 8
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Format      = "9,999,999.99"
                .Column3.Text1.InputMask   = "9,999,999.99"
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ReadOnly    = .T.
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 4 (Col_Oper) - "O" (D/C do lancamento, 16px)
                .Column4.Width             = 16
                .Column4.FontName          = "Tahoma"
                .Column4.FontSize          = 8
                .Column4.Movable           = .F.
                .Column4.Resizable         = .F.
                .Column4.Sparse            = .F.
                .Column4.ReadOnly          = .T.
                .Column4.Header1.Caption   = "O"
                .Column4.Header1.FontName  = "Tahoma"
                .Column4.Header1.Alignment = 2
                .Column4.Text1.FontName    = "Tahoma"
                .Column4.Text1.FontSize    = 8
                .Column4.Text1.Alignment   = 3
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.Margin      = 0
                .Column4.Text1.ReadOnly    = .T.
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 5 (Col_Emp) - "Emp"
                .Column5.Width             = 30
                .Column5.FontName          = "Tahoma"
                .Column5.FontSize          = 8
                .Column5.Movable           = .F.
                .Column5.Resizable         = .F.
                .Column5.Sparse            = .F.
                .Column5.ReadOnly          = .T.
                .Column5.Header1.Caption   = "Emp"
                .Column5.Header1.FontName  = "Tahoma"
                .Column5.Header1.Alignment = 2
                .Column5.Text1.FontName    = "Tahoma"
                .Column5.Text1.FontSize    = 8
                .Column5.Text1.Alignment   = 3
                .Column5.Text1.BorderStyle = 0
                .Column5.Text1.Margin      = 0
                .Column5.Text1.ReadOnly    = .T.
                .Column5.Text1.ForeColor   = RGB(0, 0, 0)
                .Column5.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 6 (Col_Saldo) - "Saldo". O Init legado reaplica a
                *-- mascara na Column E no Text1 (.Col_Saldo.InputMask e
                *-- .Col_Saldo.Text1.InputMask), nao so no SCX.
                .Column6.Width             = 102
                .Column6.FontName          = "Tahoma"
                .Column6.FontSize          = 8
                .Column6.Movable           = .F.
                .Column6.Resizable         = .F.
                .Column6.Sparse            = .F.
                .Column6.ReadOnly          = .T.
                .Column6.InputMask         = "999,999,999.99"
                .Column6.Header1.Caption   = "Saldo"
                .Column6.Header1.FontName  = "Tahoma"
                .Column6.Header1.Alignment = 2
                .Column6.Text1.FontName    = "Tahoma"
                .Column6.Text1.FontSize    = 8
                .Column6.Text1.BorderStyle = 0
                .Column6.Text1.InputMask   = "999,999,999.99"
                .Column6.Text1.Margin      = 0
                .Column6.Text1.ReadOnly    = .T.
                .Column6.Text1.ForeColor   = RGB(0, 0, 0)
                .Column6.Text1.BackColor   = RGB(255, 255, 255)

                *-- Cores dinamicas do Init legado, transcritas:
                *--   .SetAll('DynamicForeColor','Iif(Concs, RGB(0,0,255), RGB(0,0,0))','Column')
                *--   .SetAll('DynamicBackColor','Iif(!IsEmpty(DtAudits), RGB(220,255,220), RGB(255,255,255))','Column')
                *-- Azul = lancamento conciliado; verde claro = lancamento
                *-- auditado. Duas adaptacoes necessarias:
                *-- (a) Concs eh bit no SQL Server e chega ao VFP ora Logico,
                *--     ora Numerico conforme o driver - o SELECT do BO faz
                *--     CAST(concs AS numeric(1,0)), entao aqui a comparacao eh
                *--     SEMPRE "= 1" (regra #13);
                *-- (b) IsEmpty eh o wrapper Fortyus, que trata NULL como
                *--     vazio; EMPTY(.NULL.) do VFP devolve .F., o que pintaria
                *--     de verde justamente a linha NAO auditada. !ISNULL(x) AND
                *--     !EMPTY(x) reproduz o legado exatamente (e eh seguro sem
                *--     short-circuit: EMPTY(.NULL.) nao estoura).
                .SetAll("DynamicForeColor", ;
                    "IIF(cursor_4c_ContaCc.Concs = 1, RGB(0,0,255), RGB(0,0,0))", "Column")
                .SetAll("DynamicBackColor", ;
                    "IIF(!ISNULL(cursor_4c_ContaCc.DtAudits) AND " + ;
                    "!EMPTY(cursor_4c_ContaCc.DtAudits), RGB(220,255,220), RGB(255,255,255))", "Column")
            ENDWITH

            *-- ColumnOrder POR ULTIMO (o SCX troca Saldo e Emp de lugar na
            *-- exibicao). Atribuir ColumnOrder TROCA a posicao com a coluna que
            *-- hoje ocupa o destino, entao a 1a linha ja deixa a Column6 em 5;
            *-- a 2a fica explicita so para espelhar o dump.
            THIS.grd_4c_Lancamento.Column5.ColumnOrder = 6
            THIS.grd_4c_Lancamento.Column6.ColumnOrder = 5
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.ConfigurarGradeLancamento")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeFollowUp - GridFollowUp legado (Class: fwgrade).
    * Mostra TODO o historico de FollowUp do Noper (SigCqOch), uma linha por
    * acao de auditoria. Somente leitura.
    *
    * Correspondencia com o legado (Init: .ColumnN.ControlSource):
    *   Column1 = Movimento.Datars   (data/hora do lancamento do FollowUp)
    *   Column2 = Movimento.TpLancs  (tipo do lancamento)
    *   Column3 = Movimento.datas    (data do registro)
    *   Column4 = Movimento.Usuars   (usuario)
    *   Column5 = Movimento.ObsAudt2 (observacao truncada em 50)
    *
    * As quatro primeiras colunas usam Courier New (fonte monoespacada, para
    * data/hora e codigo alinharem) e a quinta Arial, exatamente como o SCX.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeFollowUp()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("grd_4c_FollowUp", "Grid")

            *-- GridFollowUp legado: Top=173, Left=60, Width=679, Height=200,
            *-- FontName="Arial", FontSize=8, RowHeight=17
            WITH THIS.grd_4c_FollowUp
                .Top           = 173
                .Left          = 60
                .Width         = 679
                .Height        = 200
                .HeaderHeight       = 0
                .FontName      = "Arial"
                .FontSize      = 8
                .RowHeight     = 17
                .ScrollBars    = 2
                *-- TabIndex = 3 no SCX legado (ordem de tabulacao do dialogo)
                .TabIndex      = 3
                *-- ReadOnly do GRID antes do das colunas (regra #18)
                .ReadOnly      = .T.
                .DeleteMark    = .F.
                .RecordMark    = .F.
            ENDWITH

            *-- ColumnCount/RecordSource FORA do WITH das colunas
            THIS.grd_4c_FollowUp.ColumnCount  = 5
            THIS.grd_4c_FollowUp.RecordSource = "cursor_4c_FollowUp"

            WITH THIS.grd_4c_FollowUp
                .Column1.ControlSource = "cursor_4c_FollowUp.Datars"
                .Column2.ControlSource = "cursor_4c_FollowUp.TpLancs"
                .Column3.ControlSource = "cursor_4c_FollowUp.Datas"
                .Column4.ControlSource = "cursor_4c_FollowUp.Usuars"
                .Column5.ControlSource = "cursor_4c_FollowUp.ObsAudt2"

                *-- Coluna 1 - "Data / Hora Lancto"
                .Column1.Width             = 138
                .Column1.FontName          = "Courier New"
                .Column1.FontSize          = 8
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.Enabled           = .T.
                .Column1.ReadOnly          = .T.
                .Column1.Header1.Caption   = "Data / Hora Lancto"
                .Column1.Header1.FontName  = "Arial"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Text1.FontName    = "Courier New"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.Alignment   = 3
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Enabled     = .T.
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ReadOnly    = .T.
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 2 - "Tipo Lancto"
                .Column2.Width             = 90
                .Column2.FontName          = "Courier New"
                .Column2.FontSize          = 8
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.ReadOnly          = .T.
                .Column2.Header1.Caption   = "Tipo Lancto"
                .Column2.Header1.FontName  = "Arial"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Text1.FontName    = "Courier New"
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Enabled     = .T.
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ReadOnly    = .T.
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 3 - "Data"
                .Column3.Width             = 75
                .Column3.FontName          = "Courier New"
                .Column3.FontSize          = 8
                .Column3.Movable           = .F.
                .Column3.Resizable         = .F.
                .Column3.ReadOnly          = .T.
                .Column3.Header1.Caption   = "Data"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Text1.FontName    = "Courier New"
                .Column3.Text1.FontSize    = 8
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ReadOnly    = .T.
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 4 - "Usuario"
                .Column4.Width             = 75
                .Column4.FontName          = "Courier New"
                .Column4.FontSize          = 8
                .Column4.Movable           = .F.
                .Column4.Resizable         = .F.
                .Column4.ReadOnly          = .T.
                .Column4.Header1.Caption   = "Usu" + CHR(225) + "rio"
                .Column4.Header1.FontSize  = 8
                .Column4.Header1.Alignment = 2
                .Column4.Text1.FontName    = "Courier New"
                .Column4.Text1.FontSize    = 8
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.Margin      = 0
                .Column4.Text1.ReadOnly    = .T.
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)

                *-- Coluna 5 - "Observacao" (truncada em 50 pelo ObsAudt2; o
                *-- texto completo vai no Memo_Obs, Fase 5). O SCX NAO declara
                *-- Movable/Resizable nesta coluna - defaults preservados.
                .Column5.Width             = 268
                .Column5.FontName          = "Arial"
                .Column5.FontSize          = 8
                .Column5.ReadOnly          = .T.
                .Column5.Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
                .Column5.Header1.FontSize  = 8
                .Column5.Header1.Alignment = 2
                .Column5.Text1.FontSize    = 8
                .Column5.Text1.BorderStyle = 0
                .Column5.Text1.Margin      = 0
                .Column5.Text1.ForeColor   = RGB(0, 0, 0)
                .Column5.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.ConfigurarGradeFollowUp")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarMemo - Memo_Obs legado (Class: fwmemo, BaseClass: editbox),
    * somente leitura. Mostra o texto COMPLETO da observacao da linha
    * CORRENTE de grd_4c_FollowUp - a Column5 da grade (ObsAudt2) mostra so
    * os 50 primeiros caracteres (Padr(Nvl(ObsAudts,' '),50) do Init legado).
    *
    * ControlSource qualificado com o alias do cursor migrado: o legado usa
    * "Movimento.ObsAudts" (cursor local montado no Init); aqui o cursor
    * equivalente eh cursor_4c_FollowUp (criado em InicializarCursores),
    * coluna ObsAudts (M(4) NULL).
    *
    * Memo_Obs original: Top=381, Left=59, Width=682, Height=60, ReadOnly=.T.,
    * NullDisplay="  ". Nao sobrepoe grd_4c_FollowUp (173..373) nem o botao
    * Encerrar; cabe dentro do form (381+60=441 < Height=450).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarMemo()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("obj_4c_Memo_Obs", "EditBox")

            WITH THIS.obj_4c_Memo_Obs
                .Top           = 381
                .Left          = 59
                .Width         = 682
                .Height        = 60
                .ReadOnly      = .T.
                .NullDisplay   = "  "
                *-- TabIndex = 34 no SCX legado (ordem de tabulacao do dialogo)
                .TabIndex      = 34
                .ControlSource = "cursor_4c_FollowUp.ObsAudts"
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.ConfigurarMemo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup1 legado (ButtonCount = 1, botao "Sair"
    * com Caption "Encerrar"). E o UNICO botao do dialogo: nao ha Incluir/
    * Alterar/Excluir/Buscar porque nao ha gravacao nenhuma nesta tela.
    *
    * Geometria legada: grupo Top=-2, Left=720, 85x85; botao interno Top=5,
    * Left=5, 75x75. O grupo eh AutoSize = .T., e eh a geometria do botao
    * INTERNO que define o tamanho do grupo (75 + 5 + 5 = 85) - por isso
    * Buttons(1) eh configurado ANTES de posicionar o grupo (regra #31).
    *
    * CommandGroup NAO tem ForeColor nem FontName (regra #33): a cor e a fonte
    * moram no Buttons(1), exatamente como o SCX declara em Command1.
    *
    * Left=720 + Width=85 = 805 passa 5px do form (Width=800); eh o valor do
    * proprio SCX e nada visivel se perde - o botao interno ocupa 725..800,
    * encostado na borda.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cmg_4c_Botoes", "CommandGroup")

            WITH THIS.cmg_4c_Botoes
                .ButtonCount = 1

                WITH .Buttons(1)
                    .AutoSize    = .F.
                    .Top         = 5
                    .Left        = 5
                    .Height      = 75
                    .Width       = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Comic Sans MS"
                    .FontSize    = 8
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .Cancel      = .T.
                    .Caption     = "Encerrar"
                    .ToolTipText = "<ESC> Sair"
                    .ForeColor   = RGB(90, 90, 90)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH

                *-- Grupo DEPOIS do botao interno: com AutoSize = .T. eh o
                *-- interno que dita 85x85 (o SCX ja declara o resultado)
                .AutoSize      = .T.
                .Top           = -2
                .Left          = 720
                .Height        = 85
                .Width         = 85
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136, 189, 188)
                *-- TabIndex = 6 no SCX legado (ordem de tabulacao do dialogo)
                .TabIndex      = 6
                .Value         = 1
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - Liga os DOIS eventos que o legado tem:
    *
    *   CommandGroup1.Sair.Valid    -> CmdEncerrarClick
    *   GridFollowUp.AfterRowColChange -> GrdFollowUpAfterRowColChange
    *
    * Botao Encerrar: no legado o codigo esta em Sair.Valid (PROCEDURE
    * Sair.Valid -> ThisForm.Release). BINDEVENT em "Valid" nao dispara de
    * forma confiavel, entao o equivalente eh o "Click" do proprio botao - o
    * botao tem Cancel = .T., logo ESC tambem o acionara, como no legado.
    *
    * Grade de FollowUp: o legado repinta o Memo_Obs a cada troca de linha
    * (ver GrdFollowUpAfterRowColChange). Nao ha evento no grd_lancamento: o
    * SCX legado nao declara nenhum para ele (a grade mostra UM lancamento
    * so), e inventar um violaria a regra "NUNCA inventar".
    *
    * BINDEVENT exige metodo PUBLIC: com PROTECTED falha em SILENCIO (regra #3).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oErro
        TRY
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "CmdEncerrarClick")

            BINDEVENT(THIS.grd_4c_FollowUp, "AfterRowColChange", ;
                THIS, "GrdFollowUpAfterRowColChange")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.ConfigurarEventos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdEncerrarClick - Equivalente ao PROCEDURE Sair.Valid legado
    * (ThisForm.Release). Fecha o dialogo; o Destroy fecha os cursores e
    * reconstroi os popups do menu via DODEFAULT.
    *
    * PUBLIC (sem PROTECTED): alvo de BINDEVENT e chamado de fora pelo harness.
    *--------------------------------------------------------------------------
    PROCEDURE CmdEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdFollowUpAfterRowColChange - Equivalente ao AfterRowColChange do
    * GridFollowUp legado, que e o metodo INTEIRO:
    *
    *   LPARAMETERS nColIndex
    *   ThisForm.Memo_Obs.Refresh
    *
    * Cada linha do historico guarda a observacao COMPLETA em
    * cursor_4c_FollowUp.ObsAudts; a Column5 da grade mostra apenas os 50
    * primeiros caracteres (ObsAudt2, truncado com Padr(Nvl(ObsAudts,' '),50)
    * no Init legado). Trocar de linha move o ponteiro do cursor, mas o
    * EditBox ligado a ObsAudts NAO se repinta sozinho - sem este Refresh o
    * obj_4c_Memo_Obs continua exibindo o texto da linha ANTERIOR (regra #21a:
    * mover/popular cursor nao repinta o controle).
    *
    * USO CORRETO de AfterRowColChange (regra #46): carregar o DETALHE da
    * linha CORRENTE. O que a regra #46 proibe e VALIDAR CELULA aqui, porque
    * par_nColIndex e a coluna de DESTINO e nao a de origem - por isso nao ha
    * filtro de coluna neste handler: o legado declara nColIndex e NUNCA o le,
    * o refresh vale para qualquer coluna em que o usuario entre.
    *
    * par_nColIndex DEVE ser declarado mesmo sem uso: handler ligado por
    * BINDEVENT precisa repetir a assinatura do evento, senao estoura a cada
    * disparo (regra #3).
    *
    * PUBLIC (sem PROTECTED): alvo de BINDEVENT - com PROTECTED falharia em
    * SILENCIO (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE GrdFollowUpAfterRowColChange(par_nColIndex)
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "obj_4c_Memo_Obs", 5)
                THIS.obj_4c_Memo_Obs.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "FormSigOpOch.GrdFollowUpAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Executa as DUAS consultas que o Init legado faz antes de
    * a tela aparecer e repinta as grades:
    *   Select * From SigMvCcr Where Nopers = <n> And Opers = '<o>'  -> ContaCC
    *   Select * From SigCqOch Where Nopers = <n> Order by Datars,Datas -> Movi
    *
    * As duas consultas rodam SEMPRE, inclusive quando a primeira nao acha
    * nada: o legado tambem nao condiciona uma a outra, e o historico de
    * FollowUp depende so do Noper.
    *
    * Falha de consulta NAO impede a tela de abrir (igual ao legado, que nao
    * testa o retorno do SqlExecute) - a mensagem tecnica do BO eh exibida e o
    * usuario ve as grades vazias. MsgErro ja se suprime em modo de teste.
    *
    * PUBLIC (sem PROTECTED): o harness de teste automatizado chama
    * oForm.CarregarLista() de FORA da classe (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", ;
                    "FormSigOpOch.CarregarLista")
            ELSE
                loc_lSucesso = THIS.this_oBusinessObject.CarregarContaCorrente()

                IF !THIS.this_oBusinessObject.CarregarFollowUp()
                    loc_lSucesso = .F.
                ENDIF

                *-- Repinta as DUAS grades em TODO caminho de carga: popular o
                *-- cursor NAO repinta a grade sozinho (regra #21a) - sem isto
                *-- a tela fica visualmente vazia com os cursores cheios.
                THIS.AtualizarGrades()

                IF !loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro) ;
                   AND !THIS.this_oBusinessObject.this_lErroExibido
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Consulta de FollowUp")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarGrades - Posiciona os dois cursores no topo e repinta as duas
    * grades. Equivale ao "Select ContaCc / Go Top" + ".Refresh" do Init
    * legado.
    *
    * Metodo UNICO, chamado por TODO caminho que popula os cursores: encher o
    * cursor nao faz a grade exibir as linhas, e o sintoma ("a tela nao traz
    * dados") manda o diagnostico para SQL/permissao (regra #21a).
    *
    * NAO chamar deste metodo o AfterRowColChange da grade: o GO TOP daqui
    * devolveria o cursor a PRIMEIRA linha a cada troca de linha, travando a
    * navegacao do usuario no topo. O GrdFollowUpAfterRowColChange repinta so
    * o obj_4c_Memo_Obs, sem mexer no ponteiro.
    *
    * PUBLIC: o harness de teste automatizado chama de FORA da classe.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarGrades()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_ContaCc")
                GO TOP IN cursor_4c_ContaCc
            ENDIF
            IF USED("cursor_4c_FollowUp")
                GO TOP IN cursor_4c_FollowUp
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_Lancamento", 5)
                THIS.grd_4c_Lancamento.Refresh()
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_FollowUp", 5)
                THIS.grd_4c_FollowUp.Refresh()
            ENDIF
            *-- Memo_Obs acompanha a linha corrente de cursor_4c_FollowUp -
            *-- repintar junto, senao o 1o registro so aparece depois que o
            *-- usuario mexe na grade (regra #21a)
            IF PEMSTATUS(THIS, "obj_4c_Memo_Obs", 5)
                THIS.obj_4c_Memo_Obs.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.AtualizarGrades")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * (AddObject cria controles com Visible=.F. por padrao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_oErro
        TRY
            FOR loc_i = 1 TO par_oContainer.ControlCount
                loc_oControl = par_oContainer.Controls(loc_i)
                IF VARTYPE(loc_oControl) = "O"
                    IF PEMSTATUS(loc_oControl, "Visible", 5)
                        loc_oControl.Visible = .T.
                    ENDIF
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                       loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Equivalente ao PROCEDURE Release legado (ThisForm.poDataMgr.
    * Release + DoDefault()). Fecha os cursores de trabalho criados pelo form
    * (cursor_4c_ContaCc/cursor_4c_FollowUp, introduzidos na Fase 4 junto com
    * os grids) antes de liberar o Business Object.
    *
    * DataSession=2 (privada): os cursores ja seriam destruidos junto com a
    * sessao ao fechar o form, mas o USE IN explicito mantem o padrao do
    * projeto e evita qualquer referencia solta durante o proprio Destroy.
    *
    * DODEFAULT() por ULTIMO eh obrigatorio: eh FormBase.Destroy que reconstroi
    * os popups do menu principal depois de um form modal fechar.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_ContaCc")
                USE IN cursor_4c_ContaCc
            ENDIF
            IF USED("cursor_4c_FollowUp")
                USE IN cursor_4c_FollowUp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpOch.Destroy")
        ENDTRY

        THIS.this_oBusinessObject = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpOchBO.prg):
*==============================================================================
* SigOpOchBO.prg - Business Object para SigOpOch (Consulta de FollowUp)
*
* Legado  : SIGOPOCH.SCX (task774) - dialogo MODAL "Consulta de FollowUp"
* Tabelas : SigMvCcr (leitura - lancamento de conta corrente sendo consultado)
*           SigCqOch (leitura - historico de FollowUp/auditoria do lancamento)
*
* CONTEXTO (legado)
* ------------------
* SIGOPOCH.Init recebe tres parametros (poForm, pnNoper, pcOper) do form que o
* abre (DO Form SigOpOch With <form pai>, <Nopers>, <Opers>) e executa, na
* sessao PRIVADA do proprio dialogo (DataSession = 2):
*   1) Select * From SigMvCcr Where Nopers = <pnNoper> And Opers = <pcOper>
*      Into cursor ContaCC - o lancamento de conta corrente que o usuario
*      selecionou no form pai (grd_lancamento espelha ContaCC: Datas, Hists,
*      Valors, Opers, Emps, Saldos - somente leitura, sem nenhuma gravacao);
*   2) Select * From SigCqOch Where Nopers = <pnNoper> Order by Datars,Datas
*      Into cursor Movi - TODO o historico de FollowUp daquele Noper (pode
*      ter varias linhas, uma por acao de auditoria/observacao registrada);
*   3) Select *, Padr(Nvl(ObsAudts,' '),50) as ObsAudt2 From Movi Into Cursor
*      Movimento - GridFollowUp espelha Movimento: Datars, TpLancs, Datas,
*      Usuars, ObsAudt2 (observacao truncada para a coluna da grade); o Memo
*      inferior (Memo_Obs) espelha Movimento.ObsAudts (texto completo, sem
*      truncar) da linha corrente da grade.
* O dialogo e PURAMENTE DE CONSULTA: nenhum metodo do SCX faz INSERT/UPDATE/
* DELETE. O unico botao (Sair) apenas libera o form (ThisForm.Release).
*
* ADAPTACAO DE ARQUITETURA (PILAR 3)
* -----------------------------------
* Os parametros pnNoper/pcOper chegam aqui como propriedades explicitas
* (this_nNopers/this_cOpers), preenchidas pelo Form a partir dos parametros
* recebidos no Init (equivalente funcional ao LParameters do legado). As
* duas consultas (Fase 2) vao para cursores SEPARADOS e nao destrutivos
* (cursor_4c_ContaCc / cursor_4c_FollowUp), e a 3a consulta do legado
* (Movimento = Movi + ObsAudt2 calculado) sera reproduzida como parte da
* mesma query de FollowUp (coluna ObsAudt2 calculada no proprio SELECT),
* evitando um 3o cursor so para acrescentar uma coluna derivada.
*
* As propriedades abaixo espelham os campos efetivamente referenciados no
* codigo fonte original (ControlSource das colunas dos dois grids + os dois
* parametros de filtro). NAO ha campo editavel nem gravacao: as propriedades
* this_cTabela/this_cCampoChave herdadas de BusinessBase ficam apontando
* para SigCqOch (a tabela do "FollowUp" que da nome ao dialogo), mas sem uso
* de Inserir/Atualizar/ExecutarExclusao nesta BO (consulta pura).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpOchBO AS BusinessBase

    *==========================================================================
    * PARAMETROS DE FILTRO (pnNoper/pcOper do legado Init) - identificam o
    * lancamento de conta corrente cujo FollowUp esta sendo consultado
    *==========================================================================
    this_nNopers = 0    && numeric(7,0) - par_nNoper (filtro SigMvCcr.Nopers e SigCqOch.Nopers)
    this_cOpers  = ""   && char(1)      - par_cOper (filtro SigMvCcr.Opers - D/C)

    *==========================================================================
    * SigMvCcr (ContaCC) - lancamento de conta corrente exibido em
    * grd_lancamento (somente leitura, sem gravacao nesta tela)
    *==========================================================================
    this_dDatas  = {}   && datetime SigMvCcr.datas  - data do lancamento (Col_Data)
    this_cHists  = ""   && char(60) SigMvCcr.hists  - historico/descricao (Col_Hist)
    this_nValors = 0    && numeric(11,2) SigMvCcr.valors - valor do lancamento (Col_Valor)
    this_cEmps   = ""   && char(3)  SigMvCcr.emps   - empresa (Col_Emp)
    this_nSaldos = 0    && numeric(15,2) SigMvCcr.saldos - saldo apos o lancamento (Col_Saldo)

    *==========================================================================
    * SigCqOch (Movi/Movimento) - historico de FollowUp exibido em
    * GridFollowUp (multiplas linhas por Noper) + Memo_Obs (linha corrente)
    *==========================================================================
    this_dDatars   = {}   && datetime SigCqOch.datars  - data/hora do lancamento do FollowUp (Column1)
    this_cTpLancs  = ""   && char(15) SigCqOch.tplancs - tipo do lancamento de FollowUp (Column2)
    this_dDataLog  = {}   && datetime SigCqOch.datas   - data do registro de FollowUp (Column3)
    this_cUsuars   = ""   && char(10) SigCqOch.usuars  - usuario que registrou o FollowUp (Column4)
    this_cObsAudts = ""   && text SigCqOch.obsaudts    - observacao completa (Memo_Obs / Column5 truncada em ObsAudt2)

    *==========================================================================
    * Init - Configura tabela principal e chave primaria
    *
    * A tabela VAI no DODEFAULT: BusinessBase.Init() so instancia
    * this_oDataAccess quando recebe o parametro pcTabela. Com DODEFAULT()
    * sem argumento o objeto de acesso a dados fica .NULL. e todo metodo
    * herdado que depende dele devolve .F. reclamando que o acesso a dados
    * nao foi inicializado.
    *
    * this_cTabela = "SigCqOch" (a tabela de FollowUp que da nome ao
    * dialogo - "Consulta de FollowUp"); this_cCampoChave fica com o nome
    * convencional da PK de SigCqOch so para a nomenclatura herdada de
    * BusinessBase ter um valor coerente com o schema - esta BO NAO grava
    * nada (nenhum Inserir/Atualizar/ExecutarExclusao sera sobrescrito).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigCqOch")

            THIS.this_cTabela     = "SigCqOch"
            THIS.this_cCampoChave = "cidchaves"

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpOchBO.Init")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarContaCorrente - busca o lancamento de conta corrente filtrado
    * por this_nNopers/this_cOpers. Equivale ao 1o Select do Init legado:
    *   Select * From SigMvCcr Where Nopers = <pnNoper> And Opers = <pcOper>
    *
    * SQLEXEC roda sobre um cursor TEMPORARIO (cursor_4c_ContaCcTmp) e o
    * resultado eh copiado para cursor_4c_ContaCc via ZAP + APPEND FROM
    * DBF() - SQLEXEC direto sobre o alias ligado ao grd_4c_Lancamento
    * zeraria o ColumnCount do grid (cursor_4c_ContaCc eh criado pelo Form
    * com os campos Datas T, Hists C(60), Valors N(11,2), Opers C(1),
    * Emps C(3), Saldos N(15,2), Concs N(1), DtAudits T - mesma lista de
    * colunas do SELECT abaixo; APPEND FROM DBF casa os campos por NOME, logo
    * nome a mais ou a menos entra em branco calado).
    *
    * Ao final, espelha a linha encontrada nas propriedades this_* via
    * CarregarDoCursor(), para o Form poder exibir Data/Historico/Valor/
    * Empresa/Saldo tambem fora do grid, se precisar.
    *==========================================================================
    PROCEDURE CarregarContaCorrente()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                *-- Concs e DtAudits NAO aparecem em coluna nenhuma da grade:
                *-- sao as duas colunas que o DynamicForeColor/DynamicBackColor
                *-- do Init legado le para colorir a linha (azul = conciliado,
                *-- verde claro = auditado). O legado faz Select * e por isso
                *-- as tinha de graca; aqui a lista eh explicita, entao elas
                *-- precisam constar ou as cores do legado se perdem em
                *-- silencio. CAST do bit para numeric(1,0) para o VFP receber
                *-- SEMPRE Numerico: bit chega ora Logico, ora Numerico
                *-- conforme o driver, e a expressao do grid compara com 1.
                loc_cSQL = "SELECT Datas, Hists, Valors, Opers, Emps, Saldos, " + ;
                           "CAST(concs AS numeric(1,0)) AS Concs, " + ;
                           "dtaudits AS DtAudits " + ;
                           "FROM SigMvCcr " + ;
                           "WHERE Nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0) + ;
                           " AND Opers = " + EscaparSQL(THIS.this_cOpers)

                IF USED("cursor_4c_ContaCcTmp")
                    USE IN cursor_4c_ContaCcTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaCcTmp")

                IF loc_nResultado >= 0
                    IF USED("cursor_4c_ContaCc")
                        SELECT cursor_4c_ContaCc
                        ZAP
                        APPEND FROM DBF("cursor_4c_ContaCcTmp")
                        IF RECCOUNT("cursor_4c_ContaCc") > 0
                            GO TOP IN cursor_4c_ContaCc
                            THIS.CarregarDoCursor("cursor_4c_ContaCc")
                        ENDIF
                    ENDIF
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao buscar o lan" + CHR(231) + "amento de conta corrente." + CHR(13) + CapturarErroSQL()
                ENDIF

                IF USED("cursor_4c_ContaCcTmp")
                    USE IN cursor_4c_ContaCcTmp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpOchBO.CarregarContaCorrente")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarFollowUp - busca TODO o historico de FollowUp (SigCqOch) do
    * lancamento filtrado por this_nNopers. Equivale as 2a e 3a consultas do
    * Init legado combinadas numa unica query (a 3a so acrescenta a coluna
    * derivada ObsAudt2, que o SQL Server ja calcula no proprio SELECT):
    *   Select * From SigCqOch Where Nopers = <pnNoper> Order by Datars,Datas
    *   Select *, Padr(Nvl(ObsAudts,' '),50) as ObsAudt2 From Movi
    *
    * Mesmo padrao de cursor temporario + ZAP/APPEND FROM DBF() de
    * CarregarContaCorrente, preservando o RecordSource do GridFollowUp
    * (cursor_4c_FollowUp, criado pelo Form com Datars T, TpLancs C(15),
    * Datas T, Usuars C(10), ObsAudts M, ObsAudt2 C(50)).
    *==========================================================================
    PROCEDURE CarregarFollowUp()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                loc_cSQL = "SELECT Datars, TpLancs, Datas, Usuars, " + ;
                           "CAST(obsaudts AS VARCHAR(MAX)) AS ObsAudts, " + ;
                           "LEFT(ISNULL(CAST(obsaudts AS VARCHAR(MAX)), ''), 50) AS ObsAudt2 " + ;
                           "FROM SigCqOch " + ;
                           "WHERE Nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0) + ;
                           " ORDER BY Datars, Datas"

                IF USED("cursor_4c_FollowUpTmp")
                    USE IN cursor_4c_FollowUpTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FollowUpTmp")

                IF loc_nResultado >= 0
                    IF USED("cursor_4c_FollowUp")
                        SELECT cursor_4c_FollowUp
                        ZAP
                        APPEND FROM DBF("cursor_4c_FollowUpTmp")
                        GO TOP IN cursor_4c_FollowUp
                    ENDIF
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao buscar o hist" + CHR(243) + "rico de FollowUp." + CHR(13) + CapturarErroSQL()
                ENDIF

                IF USED("cursor_4c_FollowUpTmp")
                    USE IN cursor_4c_FollowUpTmp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpOchBO.CarregarFollowUp")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - mapeia a linha CORRENTE do cursor informado para as
    * propriedades this_*. Usado (a) uma vez, logo depois de popular
    * cursor_4c_ContaCc em CarregarContaCorrente, e (b) a cada troca de linha
    * do GridFollowUp (equivalente ao AfterRowColChange do legado, que so
    * fazia ThisForm.Memo_Obs.Refresh - aqui quem alimenta o Memo_Obs eh
    * this_cObsAudts, lido da linha corrente de cursor_4c_FollowUp).
    *
    * Detecta qual dos dois cursores foi passado pelas colunas presentes
    * (TYPE() - PEMSTATUS exige OBJETO, nao serve para alias de cursor) e
    * mapeia so o bloco correspondente.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            IF !EOF()
                IF TYPE(par_cAliasCursor + ".Hists") != "U"
                    *-- Linha de cursor_4c_ContaCc (SigMvCcr)
                    THIS.this_dDatas  = ConverterParaData(Datas)
                    THIS.this_cHists  = TratarNulo(Hists, "")
                    THIS.this_nValors = TratarNulo(Valors, 0)
                    THIS.this_cEmps   = TratarNulo(Emps, "")
                    THIS.this_nSaldos = TratarNulo(Saldos, 0)
                ENDIF

                IF TYPE(par_cAliasCursor + ".TpLancs") != "U"
                    *-- Linha de cursor_4c_FollowUp (SigCqOch)
                    THIS.this_dDatars   = ConverterParaData(Datars)
                    THIS.this_cTpLancs  = TratarNulo(TpLancs, "")
                    THIS.this_dDataLog  = ConverterParaData(Datas)
                    THIS.this_cUsuars   = TratarNulo(Usuars, "")
                    THIS.this_cObsAudts = TratarNulo(ObsAudts, "")
                ENDIF
            ENDIF

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - nao ha PK de registro unico editavel nesta tela
    * (dialogo de consulta, sem Inserir/Atualizar/Excluir). A "chave" do
    * dialogo eh o proprio par Nopers+Opers usado para filtrar as consultas.
    * Sobrescrito apenas para o contrato de BusinessBase; este BO nunca
    * chama RegistrarAuditoria/Salvar/Excluir - ver nota abaixo.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(STR(THIS.this_nNopers, 7)) + THIS.this_cOpers
    ENDPROC

    *==========================================================================
    * NOTA: Inserir()/Atualizar()/ExecutarExclusao() NAO sao sobrescritos.
    * O dialogo SIGOPOCH e PURAMENTE DE CONSULTA (o unico botao, Sair, apenas
    * libera o form com ThisForm.Release - nao ha INSERT/UPDATE/DELETE em
    * lugar nenhum do codigo original). Sobrescrever esses metodos aqui
    * inventaria gravacao que o legado nunca teve (violaria a paridade
    * funcional). Os defaults herdados de BusinessBase permanecem validos,
    * pois Salvar()/Excluir() jamais sao chamados por este BO/Form.
    *==========================================================================

ENDDEFINE


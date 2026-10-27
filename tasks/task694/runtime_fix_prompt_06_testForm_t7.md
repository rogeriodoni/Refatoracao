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
[2026-10-24 23:42:43] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-24 23:42:43] [INFO] Config FPW: (nao fornecido)
[2026-10-24 23:42:43] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-24 23:42:43] [INFO] Timeout: 300 segundos
[2026-10-24 23:42:43] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ons4ocsj.prg
[2026-10-24 23:42:43] [INFO] Conteudo do wrapper:
[2026-10-24 23:42:44] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpCgr', 'C:\4c\tasks\task694\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpCgr', 'C:\4c\tasks\task694\logs\06_testForm.log'
QUIT

[2026-10-24 23:42:44] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ons4ocsj.prg
[2026-10-24 23:42:44] [INFO] VFP output esperado em: C:\4c\tasks\task694\vfp_output.txt
[2026-10-24 23:42:44] [INFO] Executando Visual FoxPro 9...
[2026-10-24 23:42:45] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ons4ocsj.prg
[2026-10-24 23:42:45] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ons4ocsj.prg
[2026-10-24 23:42:45] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpCgr
Inicio: 24/10/2026 23:42:46

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 24/10/2026 23:46:55
Duracao: 249 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-24 23:46:55] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-24 23:46:56] [INFO] VFP9 finalizado em 250.9566177 segundos
[2026-10-24 23:46:56] [INFO] Exit Code: 
[2026-10-24 23:46:56] [INFO] 
[2026-10-24 23:46:56] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-24 23:46:57] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ons4ocsj.prg
[2026-10-24 23:46:57] [INFO] 
[2026-10-24 23:46:57] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-24 23:46:57] [INFO] * Auto-generated wrapper for parameters
[2026-10-24 23:46:58] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-24 23:46:58] [INFO] * Parameters: 'FormSigOpCgr', 'C:\4c\tasks\task694\logs\06_testForm.log'
[2026-10-24 23:46:58] [INFO] 
[2026-10-24 23:46:58] [INFO] * Anti-dialog protections for unattended execution
[2026-10-24 23:46:58] [INFO] SET SAFETY OFF
[2026-10-24 23:46:59] [INFO] SET RESOURCE OFF
[2026-10-24 23:46:59] [INFO] SET TALK OFF
[2026-10-24 23:46:59] [INFO] SET NOTIFY OFF
[2026-10-24 23:46:59] [INFO] SYS(2335, 0)
[2026-10-24 23:47:00] [INFO] 
[2026-10-24 23:47:00] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpCgr', 'C:\4c\tasks\task694\logs\06_testForm.log'
[2026-10-24 23:47:00] [INFO] QUIT
[2026-10-24 23:47:00] [INFO] 
[2026-10-24 23:47:00] [INFO] === Fim do Wrapper.prg ===
[2026-10-24 23:47:01] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCgr.prg):
*==============================================================================
* FormSigOpCgr.prg - Form Operacional: Pesquisa Global de Rastreabilidade
* Migrado de SIGOPCGR.SCX
* Herda de FormBase
* Business Object: SigOpCgrBO
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado
*   BD   -> Schema IDENTICO (SigPdMvf, SigOpPic, SigCdOpe)
*   CODE -> arquitetura em camadas (FormBase / SigOpCgrBO)
*
* Form OPERACIONAL: NAO segue o padrao Page1=Lista/Page2=Dados de cadastro
* CRUD (ver CLAUDE.md "Form OPERACIONAL"). No legado (fld_principal):
*   Pagina 1 = pag_consulta  -> filtros de pesquisa (N. Op OU Envelope OU
*              Pedido+Numero - o usuario preenche APENAS um dos tres) +
*              botao Processar + o CommandGroup grp_operacao (Encerrar).
*   Pagina 2 = pag_resultado -> grade com o resultado da pesquisa
*              (Grd_Produto, 7 colunas) + Container1 (3 CheckBoxes que
*              escolhem a chave de rastreabilidade: Op/Envelope/Pedido) +
*              botao Rastreab. (Bot_Rastro) + o CommandGroup grp_operacao
*              (Voltar).
* Os metodos de configuracao de pagina mantem os nomes canonicos do
* pipeline (ConfigurarPaginaLista/ConfigurarPaginaDados) mesmo as paginas
* nao sendo Lista/Dados de CRUD - mesma convencao de Formsigopcgc.prg.
*
* FASE 3/8: Estrutura base do Form - DEFINE CLASS, Init/InicializarForm,
* ConfigurarPageFrame com as 2 paginas (Consulta/Resultado) e os
* containers principais vazios: cnt_4c_Cabecalho (faixa do titulo, nas
* DUAS paginas - regra CLAUDE.md #11, que prevalece sobre o legado, cujo
* dump so tem cntSombra em pag_consulta), cnt_4c_Botoes (Page1 - vai
* receber o CommandGroup Encerrar + o botao Processar na Fase 4) e
* cnt_4c_BotoesAcao (Page2 - vai receber o CommandGroup Voltar + o botao
* Rastreab. na Fase 4).
*
* Largura do form escalada para o canonico 1000x600 (legado: 800x600),
* mesma convencao de Formsigopcgc.prg/Formsigopcgp.prg (familia de
* dialogos de pesquisa/consulta OPERACIONAL). Os botoes sao transcritos
* com o tamanho fisico do dump (75x75/85x85) nas Fases 4+; so a largura
* do form e a posicao horizontal dos containers mudam.
*
* FASE 4/8: Grade de resultado (grd_4c_Dados, ligada a
* this_oBusinessObject.this_cCursorResultado) e os botoes de acao:
* Page1 - CommandGroup cmg_4c_Operacao (Encerrar) + cmd_4c_Processar;
* Page2 - CommandGroup cmg_4c_Operacao (Voltar) + cmd_4c_Rastreab +
* Container1 (chk_4c_Op/chk_4c_Envelope/chk_4c_Pedido). Navegacao entre
* paginas (AlternarPagina) fica funcional; a consulta SQL dos criterios
* (Fase 7-8) depende dos campos de filtro das Fases 5-6.
*
* FASE 5/8 (PARTE 1/2): Campos do bloco "Dados para pesquisa" (Origem/
* Pedido no legado) - Page1. Primeira metade: txt_4c_Op (N. Op) e
* txt_4c_Env (Envelope) + respectivos labels, dentro dos containers
* cnt_4c_Origem/cnt_4c_Pedido. txt_4c_Pedido/txt_4c_Numero + o label
* "Pedido :" ficam para a segunda metade (Fase 6), junto com os
* handlers de Valid/When (guard "preencher so um dos tres filtros").
*
* FASE 6/8 (PARTE 2/2): txt_4c_Pedido (codigo da operacao) + txt_4c_Numero
* (numero sequencial) + label "Pedido :", completando o bloco "Dados para
* pesquisa". Handlers COMPLETOS dos 4 campos de filtro:
*   - When (GetOpWhenCheck/GetEnvWhenCheck/GetPedidoWhenCheck/
*     GetNumeroWhenCheck) - guard "preencher so um dos tres" (Op OU
*     Envelope OU Pedido+Numero), transcrito dos When legados.
*   - LostFocus (ValidarOpLostFocus/ValidarEnvLostFocus/
*     ValidarPedidoLostFocus) - equivalente ao Valid legado (regra
*     CLAUDE.md #47: lookup/validacao em LostFocus, nunca KeyPress sem
*     testar a tecla): Op confere existencia em SigOpPic + empresa
*     corrente (SigOpCgrBO.ValidarOperacao); Pedido faz SEEK em
*     cursor_4c_Operacoes e, se nao achar, abre o picker local
*     AbrirLookupPedido (FormBuscaAuxiliar Pattern A - DefinirCursor/
*     Mostrar sobre o cursor JA carregado, equivalente ao fwBuscaSel/
*     TmpOper legado). Todos resetam this_lConsultaExecutada quando o
*     campo e preenchido, igual ao legado.
* cursor_4c_Operacoes (equivalente a TmpOper) e carregado uma unica vez em
* InicializarForm, via SigOpCgrBO.CarregarOperacoes() - falha no load
* aborta a abertura do form, igual ao Init legado.
*
* FASE 7/8: Evento principal - BtnProcessarClick (cmdprocessar.Click
* legado): guard "preencher ao menos um dos 3 filtros" + transferencia dos
* criterios da tela para o BO (este dialogo so-leitura nao tem FormParaBO/
* BOParaForm) + THIS.this_oBusinessObject.Processar() (equivalente a
* ThisForm.Processa() - a consulta SQL REAL contra SigOpPic/SigPdMvf,
* implementada em SigOpCgrBO.prg: Processar/ProcessarPorOp/
* ProcessarPorEnvelope/ProcessarPorPedido/BuscarTopoPorOp/
* AppendPicagemPorOp/AppendResultado) + navegacao condicionada a haver
* linha no resultado (senao MsgAviso "Nenhum Registro Encontrado!!!") +
* sincronismo dos 3 CheckBoxes de Container1 (Page2), tudo incondicional
* apos o Processar() como no legado. AlternarPagina(2) agora tambem foca
* a 1a coluna da grade (equivalente ao ramo Else do pag_resultado.Activate
* legado, coberto pelo mesmo guard de ConsultaExecutada).
*
* Este form OPERACIONAL nao tem CRUD (eh dialogo de PESQUISA, sem Incluir/
* Alterar/Visualizar/Excluir no legado - ver "Decisao de projeto" no
* cabecalho de SigOpCgrBO.prg) - os eventos principais da Fase 7 sao os
* do fluxo real do dialogo (Processar/Encerrar/Voltar/Rastreab./
* CheckBoxes), ja implementados nas Fases 4-7.
*
* FASE 8/8: Eventos auxiliares e consolidacao final. Os metodos canonicos
* do pipeline ganham aqui o conteudo que o legado de fato tem, cada um
* transcrito de um trecho identificado do dump:
*
*   VincularGradeResultado() - o bloco "With .Fld_Principal.Pag_Resultado.
*     Grd_Produto / .RecordSource = 'dbProduto' / .ColumnCount = 7 / ..."
*     do PROCEDURE Init legado. Vira FONTE UNICA do bind da grade
*     (ConfigurarPaginaDados e CarregarLista chamam o MESMO metodo), para
*     os dois call sites nao divergirem em silencio. ControlSource,
*     Header1.Caption e Width sao reaplicados DEPOIS do RecordSource
*     (regra CLAUDE.md #41/#48 - RecordSource reseta Width e Caption).
*
*   CarregarLista() - repintura da grade de resultado: GO TOP no cursor +
*     Grid.Refresh (regra CLAUDE.md #21 - popular cursor NAO repinta a
*     grade), rebind SO quando o alias ligado ao Grid nao for mais o
*     cursor de resultado. Chamado em TODO caminho que popula ou exibe o
*     resultado: BtnProcessarClick, AlternarPagina(2) DEPOIS do ActivePage
*     (regra #21/Erro192 - Refresh em pagina OCULTA nao pinta) e
*     LimparCampos.
*
*   FormParaBO() / BOParaForm() - transferencia dos 4 campos de filtro
*     (Op / Envelope / Pedido+Numero) entre a tela e o BO, nos dois
*     sentidos. Antes estava embutida em BtnProcessarClick; extraida
*     aqui, BOParaForm passa a ser tambem quem sincroniza os 3 CheckBoxes
*     de cnt_4c_ModoRastro (o "With This.Parent.Parent.pag_resultado.
*     Container1" do fim do cmdprocessar.Click legado) e as flags
*     this_lRastroPor* que BtnRastreabClick consulta.
*
*   LimparCampos() - o "With .fld_principal.pag_consulta.Origem.Pedido /
*     .get_Env.Value = 0 / .get_Op.Value = 0 / .get_Numero.Value = 0 /
*     .get_Pedido.Value = Space(20) / EndWith" + ".ConsultaExecutada =
*     .f." do PROCEDURE Init legado, mais o "Select DbProduto / Zap" do
*     PROCEDURE processa. Passa a ser chamado no fim de InicializarForm,
*     que antes nao reproduzia esse trecho do Init.
*
*   HabilitarCampos(par_lHabilitar) - materializa os When dos 4 campos de
*     filtro ("preencher APENAS um dos tres": Op OU Envelope OU
*     Pedido+Numero). DESVIO CONSCIENTE do mecanismo legado, registrado:
*     o When eh EVENTO, nao propriedade, e nao se atribui a controle
*     criado por AddObject; ligado por BINDEVENT ele ate dispara, mas o
*     BINDEVENT DESCARTA o retorno do delegate, entao GetOpWhenCheck e
*     irmaos (Fase 6) avaliam o guard e nao bloqueiam nada. O equivalente
*     que funciona sem subclasse nova eh .Enabled: o usuario continua
*     impedido de preencher os outros dois grupos e o foco continua
*     pulando os campos bloqueados, com a unica diferenca de que o campo
*     bloqueado aparece esmaecido. Os BINDEVENT "When" da Fase 6 ficam no
*     lugar (documentam o guard do legado e sao inofensivos), mas quem
*     faz valer a regra eh este metodo.
*
*   AjustarBotoesPorModo() - FUNIL do estado dos botoes (regra CLAUDE.md
*     #40 - quem desabilita tem de reabilitar no caminho de volta):
*     Processar vive na pagina Consulta, Rastreab. na pagina Resultado e
*     so com linha no cursor (o When "Return Not Eof('dbProduto')" do
*     Bot_Rastro legado, hoje em AtualizarBotaoRastreab). Chamado por
*     AlternarPagina nas DUAS direcoes.
*
* VISIBILIDADE: FormParaBO / BOParaForm / LimparCampos sao PROTECTED
* EXPLICITO porque FormBase ja os declara assim (sao hooks chamados por
* FormBase por THIS.) e o VFP9 NAO deixa a subclasse ALARGAR escopo -
* declarar sem o modificador nao tornaria publico, so esconderia o fato.
* Medido neste form em 2026-10-24: chamados de FORA da classe estouram
* "Property FORMPARABO is not found" / "Property LIMPARCAMPOS is not
* found" mesmo sem o PROTECTED escrito, e PEMSTATUS(...,5) devolve .T.
* (so verifica existencia - regra CLAUDE.md #3/#51). Os demais metodos da
* fase (VincularGradeResultado / CarregarLista / HabilitarCampos /
* AjustarBotoesPorModo) NAO existem em FormBase/BusinessBase/GridBase,
* entao sao publicos de verdade e o harness os alcanca.
*
* AUSENCIAS LEGITIMAS (nao sao omissao - o legado nao tem o que migrar, e
* inventar violaria o PILAR 1 e a regra "NUNCA inventar"):
*   - BtnSalvarClick / BtnConfirmarClick: o SCX nao tem botao de gravar.
*     Este dialogo eh SO-LEITURA (consulta SigOpPic/SigPdMvf e exibe);
*     o botao de acao do legado eh "Processar" -> BtnProcessarClick.
*   - BtnCancelarClick: nao ha Page2 de Dados nem modo de edicao
*     cancelavel. O unico "voltar" do legado eh o grp_operacao da
*     pag_resultado ("ThisForm.fld_principal.ActivePage = 1") -> ja
*     migrado como BtnVoltarClick, que e' o nome do que o botao faz.
*   - BtnBuscarClick: nao existe botao "Buscar" no SCX - a consulta eh
*     disparada por "Processar", e a unica busca auxiliar da tela eh o
*     picker do campo Pedido (fwBuscaSel/TmpOper) -> AbrirLookupPedido.
*==============================================================================

DEFINE CLASS FormSigOpCgr AS FormBase

    *-- Dimensoes e propriedades visuais (padrao canonico de form OPERACIONAL)
    Height      = 600
    Width       = 1000
    BorderStyle = 2
    AutoCenter  = .T.
    ShowTips    = .T.
    Caption     = "Pesquisa Global de Rastreabilidade"
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowState = 0
    ShowWindow  = 1
    WindowType  = 1
    DataSession = 2
    Themes      = .F.

    *-- Guarda de reentrancia do lookup de Pedido (regra CLAUDE.md #37/#47 -
    *-- FormBuscaAuxiliar eh modal, tira o foco e redispara o proprio
    *-- LostFocus do campo que o abriu).
    this_lEmLookupPedido = .F.

    *-- Guarda "valor-nao-mudou" do ValidarPedidoLostFocus (regra CLAUDE.md
    *-- #47): LostFocus dispara SEMPRE, ao contrario do Valid legado, que so
    *-- dispara quando o valor MUDA - sem isto, passar pelo campo sem alterar
    *-- nada reabriria o picker a cada passagem.
    this_cUltimoValidarPedidoLostFocusValidado = ""

    *==========================================================================
    * Init() - o legado nao recebe parametros ("PROCEDURE Init" sem
    * LPARAMETERS) - DODEFAULT() ja chama InicializarForm via FormBase.Init
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ValidarParametros - guarda de conexao do Init legado ("Impossivel
    * Efetuar Conexao Com o Servidor de Banco de Dados..." no CreateObject
    * de poDataMgr), com bypass para os modos sem usuario (teste
    * automatizado / validacao de UI).
    *
    * PUBLIC de proposito: o harness da etapa 06b chama metodos do form de
    * FORA da classe, e metodo PROTECTED falha em runtime mesmo com
    * PEMSTATUS devolvendo .T. (regra CLAUDE.md #1/TesteAutomatico).
    *==========================================================================
    PROCEDURE ValidarParametros()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF TYPE("gb_4c_ModoTeste") = "L"
            IF gb_4c_ModoTeste
                RETURN .T.
            ENDIF
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L"
            IF gb_4c_ValidandoUI
                RETURN .T.
            ENDIF
        ENDIF

        DO CASE
            CASE TYPE("gnConnHandle") != "N"
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
                        "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
                loc_lValido = .F.
            CASE gnConnHandle <= 0
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
                        "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
                loc_lValido = .F.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * InicializarCursorResultado - Cria o cursor placeholder de resultado
    * (equivalente ao "Create Cursor dbProduto(...) / Index On Nops Tag Nops"
    * do PROCEDURE Load legado). Estrutura IDENTICA a que a Fase 7/8 vai
    * popular via SQLEXEC/APPEND FROM DBF, para o Grid poder ser configurado
    * (RecordSource/ControlSource) nesta mesma fase sem a tela quebrar.
    *==========================================================================
    PROTECTED PROCEDURE InicializarCursorResultado()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorResultado

        IF !USED(loc_cCursor)
            SET NULL ON
            CREATE CURSOR (loc_cCursor) ;
                (Nenvs N(10), Nops N(10), DopNums C(26), Cpros C(14), ;
                 Qtds N(12,3), Grupods C(10), Contads C(10))
            SET NULL OFF
            INDEX ON Nops TAG Nops
        ENDIF
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- A guarda de conexao fica FORA do TRY (mesmo padrao de
        *-- Formsigopcgc.prg): o harness de teste automatizado define
        *-- gnConnHandle = 0 de proposito, e a guarda precisa devolver
        *-- antes de qualquer SQLEXEC/CREATEOBJECT que dependa de conexao.
        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCgrBO")

            *-- cursor_4c_Operacoes (equivalente a TmpOper do Init legado) -
            *-- precisa estar carregado ANTES de ConfigurarPaginaLista, pois
            *-- o lookup do campo Pedido (Fase 6) faz SEEK nele. Falha aqui
            *-- aborta a abertura do form, igual ao legado ("Favor
            *-- Reinicializar o Processo!!!" + Return .f. no Init).
            IF THIS.this_oBusinessObject.CarregarOperacoes()

                *-- Cursor placeholder de cursor_4c_Resultado ANTES do
                *-- PageFrame: a Page2 liga Grid.RecordSource a este alias
                *-- na mesma fase (regra CLAUDE.md #41 - Column.ControlSource
                *-- de cursor inexistente derruba o Init). A estrutura e
                *-- IDENTICA ao Create Cursor dbProduto do Load() legado.
                THIS.InicializarCursorResultado()

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.TornarControlesVisiveis(THIS)

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1

                *-- Estado inicial do Init legado (valores dos 4 filtros +
                *-- ConsultaExecutada = .f.), consolidado em LimparCampos na
                *-- Fase 8 - inclui o guard dos When (HabilitarCampos) e a
                *-- primeira repintura da grade vazia.
                THIS.LimparCampos()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Constroi o PageFrame com 2 paginas
    * (Consulta/Resultado, espelhando pag_consulta/pag_resultado do legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 2
        loc_oPgf.Top       = -29
        loc_oPgf.Left      = 0
        loc_oPgf.Width     = THIS.Width
        loc_oPgf.Height    = THIS.Height + 29
        loc_oPgf.TabIndex  = 1
        loc_oPgf.Tabs      = .F.

        loc_oPgf.Page1.Caption = "Consulta"
        loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        loc_oPgf.Page2.Caption = "Resultado"
        loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Estrutura da Page1 (Consulta)
    * Fase 3/8: so a faixa do cabecalho + container vazio para o botao
    * Processar e o CommandGroup Encerrar (Fase 4). Campos de filtro
    * (N. Op / Envelope / Pedido / Numero) vem na Fase 5.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag, loc_oCab

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Faixa do cabecalho - PRIMEIRO AddObject da pagina (regra #11/#39
        *-- do CLAUDE.md): os containers de botao ficam em Top=29..33
        *-- (dentro da area da faixa) e tem de ser criados DEPOIS para
        *-- desenhar por cima.
        loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPag.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .SpecialEffect = 0
            .BackColor     = RGB(100, 100, 100)

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
            ENDWITH
        ENDWITH

        *-- Container "Dados para pesquisa" (Origem no legado, Top=201+29=230
        *-- apos compensacao do PageFrame.Top=-29 - regra CLAUDE.md #1/#11 -
        *-- bem acima do limite Top>=109 imposto pela faixa do cabecalho).
        *-- Centralizado horizontalmente no form 1000px (legado: Left=203 no
        *-- canvas 800px fica Left=203+(1000-800)/2=303 no canonico 1000px).
        loc_oPag.AddObject("cnt_4c_Origem", "Container")
        WITH loc_oPag.cnt_4c_Origem
            .Top         = 230
            .Left        = 303
            .Width       = 393
            .Height      = 129
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)

            .AddObject("lbl_4c__Origem1", "Label")
            WITH .lbl_4c__Origem1
                .Top       = 5
                .Left      = 6
                .Width     = 119
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .Alignment = 0
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Dados para pesquisa"
            ENDWITH

            *-- Pedido (container interno do legado) - campos de filtro.
            *-- O usuario preenche APENAS um dos tres (Op OU Envelope OU
            *-- Pedido+Numero - guards When do legado, replicados nos
            *-- handlers de Valid/LostFocus da Fase 6). Fase 5 Parte 1 so
            *-- cria Op e Envelope; Pedido/Numero entram na Parte 2.
            .AddObject("cnt_4c_Pedido", "Container")
            WITH .cnt_4c_Pedido
                .Top         = 33
                .Left        = 22
                .Width       = 348
                .Height      = 72
                .BackStyle   = 0
                .BorderWidth = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.

                *-- Get_Op do legado - "N. Op :" (numerico, this_nOps no BO)
                .AddObject("lbl_4c_Label1", "Label")
                WITH .lbl_4c_Label1
                    .Top       = 13
                    .Left      = 29
                    .Width     = 37
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 0
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Caption   = "N. Op :"
                ENDWITH

                .AddObject("txt_4c_Op", "TextBox")
                WITH .txt_4c_Op
                    .Top       = 9
                    .Left      = 68
                    .Width     = 85
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 3
                    .Format    = "K"
                    .ForeColor = RGB(0, 0, 0)
                    .Value     = 0
                    .TabIndex  = 1
                ENDWITH

                *-- Get_Env do legado - "Envelope : " (numerico, this_nEnvs no BO)
                .AddObject("lbl_4c_Label2", "Label")
                WITH .lbl_4c_Label2
                    .Top       = 13
                    .Left      = 177
                    .Width     = 56
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 0
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Caption   = "Envelope : "
                ENDWITH

                .AddObject("txt_4c_Env", "TextBox")
                WITH .txt_4c_Env
                    .Top       = 9
                    .Left      = 235
                    .Width     = 85
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 3
                    .Format    = "K"
                    .ForeColor = RGB(0, 0, 0)
                    .Value     = 0
                    .TabIndex  = 2
                ENDWITH

                *-- say_pedido do legado - "Pedido :" (linha 2 do container)
                .AddObject("lbl_4c_Label3", "Label")
                WITH .lbl_4c_Label3
                    .Top       = 43
                    .Left      = 25
                    .Width     = 41
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 0
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Caption   = "Pedido :"
                ENDWITH

                *-- Get_Pedido do legado - codigo da operacao (this_cPedido
                *-- no BO), com lookup contra cursor_4c_Operacoes (Fase 6).
                *-- Junto com txt_4c_Numero compoe a chave EmpDopNums usada
                *-- por Processar() na Fase 7/8 (regra CLAUDE.md #42 - chave
                *-- posicional Emps(3)+Dopes(20)+Numero(6)).
                .AddObject("txt_4c_Pedido", "TextBox")
                WITH .txt_4c_Pedido
                    .Top       = 39
                    .Left      = 68
                    .Width     = 154
                    .Height    = 23
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 3
                    .Format    = "K"
                    .MaxLength = 20
                    .ForeColor = RGB(0, 0, 0)
                    .Value     = ""
                    .TabIndex  = 3
                ENDWITH

                *-- Get_Numero do legado - numero sequencial dentro da
                *-- operacao (this_nNumero no BO)
                .AddObject("txt_4c_Numero", "TextBox")
                WITH .txt_4c_Numero
                    .Top       = 39
                    .Left      = 225
                    .Width     = 55
                    .Height    = 23
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 3
                    .Format    = "K"
                    .InputMask = "999999"
                    .ForeColor = RGB(0, 0, 0)
                    .Value     = 0
                    .TabIndex  = 4
                ENDWITH
            ENDWITH
        ENDWITH

        *-- Container com o botao Processar (cmdprocessar do legado,
        *-- Left=648/Top=4/Width=75/Height=75) + o CommandGroup grp_operacao
        *-- (1 botao Encerrar, Left=718/Top=-1/Width=85/Height=85). Os dois
        *-- ficam encostados, flush a direita como o legado (no canvas
        *-- 800px eles terminam em 803, 3px alem da borda).
        loc_oPag.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPag.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            *-- cmdprocessar - standalone, fora de CommandGroup. Themes=.T.
            *-- + DisabledPicture: o botao nunca eh desabilitado nesta
            *-- tela, mas padrao canonico (regra CLAUDE.md #99) evita
            *-- icone sumir se algum dia precisar.
            .AddObject("cmd_4c_Processar", "CommandButton")
            WITH .cmd_4c_Processar
                .Top             = 5
                .Left            = 0
                .Width           = 75
                .Height          = 75
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption         = "\<Processar"
            ENDWITH

            *-- grp_operacao (Page1) - 1 botao Encerrar
            .AddObject("cmg_4c_Operacao", "CommandGroup")
            WITH .cmg_4c_Operacao
                .Top         = 0
                .Left        = 75
                .Width       = 85
                .Height      = 85
                .ButtonCount = 1
                .BackStyle   = 0
                .BorderStyle = 0
                .Themes      = .F.
            ENDWITH

            WITH .cmg_4c_Operacao.Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .Cancel     = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Caption    = "Encerrar"
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Processar,          "Click", THIS, "BtnProcessarClick")
        BINDEVENT(loc_oPag.cnt_4c_Botoes.cmg_4c_Operacao.Buttons(1), "Click", THIS, "BtnEncerrarClick")

        *-- Valid/When dos 3 filtros mutuamente exclusivos (Op OU Envelope OU
        *-- Pedido+Numero - regra CLAUDE.md #47: lookup/validacao em
        *-- LostFocus, nunca em KeyPress sem testar a tecla).
        LOCAL loc_oPedido
        loc_oPedido = loc_oPag.cnt_4c_Origem.cnt_4c_Pedido

        BINDEVENT(loc_oPedido.txt_4c_Op,     "LostFocus", THIS, "ValidarOpLostFocus")
        BINDEVENT(loc_oPedido.txt_4c_Env,    "LostFocus", THIS, "ValidarEnvLostFocus")
        BINDEVENT(loc_oPedido.txt_4c_Pedido, "LostFocus", THIS, "ValidarPedidoLostFocus")

        BINDEVENT(loc_oPedido.txt_4c_Op,     "When", THIS, "GetOpWhenCheck")
        BINDEVENT(loc_oPedido.txt_4c_Env,    "When", THIS, "GetEnvWhenCheck")
        BINDEVENT(loc_oPedido.txt_4c_Pedido, "When", THIS, "GetPedidoWhenCheck")
        BINDEVENT(loc_oPedido.txt_4c_Numero, "When", THIS, "GetNumeroWhenCheck")
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Estrutura da Page2 (Resultado)
    * Fase 3/8: so a faixa do cabecalho + container vazio para o botao
    * Rastreab. e o CommandGroup Voltar (Fase 4). A grade de resultado
    * (Grd_Produto) e o Container1 (CheckBoxes de modo de rastreabilidade)
    * vem na Fase 4.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag, loc_oCab

        loc_oPag = THIS.pgf_4c_Paginas.Page2

        *-- Faixa do cabecalho - regra #11: o legado so tem cntSombra em
        *-- pag_consulta, mas o padrao do sistema novo repete a faixa nas
        *-- DUAS paginas (decisao do time, prevalece sobre o PILAR 1).
        loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPag.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .SpecialEffect = 0
            .BackColor     = RGB(100, 100, 100)

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
            ENDWITH
        ENDWITH

        *-- Container com o botao Rastreab. (Bot_Rastro do legado,
        *-- Left=647/Top=4/Width=75/Height=75) + o CommandGroup grp_operacao
        *-- (1 botao Voltar, Left=717/Top=-1/Width=85/Height=85).
        loc_oPag.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPag.cnt_4c_BotoesAcao
            .Top         = 29
            .Left        = 843
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            *-- Bot_Rastro - standalone, fora de CommandGroup. Enabled eh
            *-- alternado em runtime por AtualizarBotaoRastreab() (equivalente
            *-- ao When "Return Not Eof('dbProduto')" do legado) - por isso
            *-- Themes=.T. + DisabledPicture sao obrigatorios (regra #99),
            *-- senao o icone some quando o botao fica desabilitado.
            .AddObject("cmd_4c_Rastreab", "CommandButton")
            WITH .cmd_4c_Rastreab
                .Top             = 5
                .Left            = 0
                .Width           = 75
                .Height          = 75
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
                .Caption         = "Rastreab."
                .ToolTipText     = "Rastreabilidade"
                .Enabled         = .F.
            ENDWITH

            *-- grp_operacao (Page2) - 1 botao Voltar
            .AddObject("cmg_4c_Operacao", "CommandGroup")
            WITH .cmg_4c_Operacao
                .Top         = 0
                .Left        = 75
                .Width       = 85
                .Height      = 85
                .ButtonCount = 1
                .BackStyle   = 0
                .BorderStyle = 0
                .Themes      = .F.
            ENDWITH

            WITH .cmg_4c_Operacao.Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .Cancel     = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
                .Caption    = "Voltar"
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Rastreab,          "Click", THIS, "BtnRastreabClick")
        BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmg_4c_Operacao.Buttons(1), "Click", THIS, "BtnVoltarClick")

        *-- Container1 do legado - "Pesquisar OP por" (3 CheckBoxes
        *-- mutuamente exclusivos que escolhem a chave usada por
        *-- Bot_Rastro.Click: Op/Envelope/Pedido). Top original=46 fica
        *-- MUITO perto do topo da pagina (regra do re-layout da faixa de
        *-- cabecalho, CLAUDE.md #11: controle de dados tem de ficar com
        *-- Top >= 115, nao so +29 - no legado esta pagina nao tinha
        *-- cabecalho nenhum, e agora tem). Deslocamento aplicado: +40
        *-- (Container1 46+29+40=115; Grd_Produto 150+29+40=219, cabe
        *-- dentro do form - ver grade abaixo).
        loc_oPag.AddObject("cnt_4c_ModoRastro", "Container")
        WITH loc_oPag.cnt_4c_ModoRastro
            .Top         = 115
            .Left        = 35
            .Width       = 168
            .Height      = 101
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)
            .BorderWidth = 1
            .SpecialEffect = 1

            .AddObject("lbl_4c_PesquisarPor", "Label")
            WITH .lbl_4c_PesquisarPor
                .Top       = 4
                .Left      = 3
                .Width     = 97
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Pesquisar OP por"
            ENDWITH

            .AddObject("chk_4c_Op", "CheckBox")
            WITH .chk_4c_Op
                .Top       = 24
                .Left      = 36
                .Width     = 93
                .Height    = 20
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .Style     = 1
                .ForeColor = RGB(0, 0, 255)
                .BackColor = RGB(255, 255, 255)
                .Themes    = .F.
                .Value     = 0
                .Caption   = "Individual"
            ENDWITH

            .AddObject("chk_4c_Envelope", "CheckBox")
            WITH .chk_4c_Envelope
                .Top       = 48
                .Left      = 36
                .Width     = 93
                .Height    = 20
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .Style     = 1
                .ForeColor = RGB(255, 0, 0)
                .BackColor = RGB(255, 255, 255)
                .Themes    = .F.
                .Value     = 0
                .Caption   = "Envelope"
            ENDWITH

            .AddObject("chk_4c_Pedido", "CheckBox")
            WITH .chk_4c_Pedido
                .Top       = 72
                .Left      = 36
                .Width     = 93
                .Height    = 20
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .Style     = 1
                .ForeColor = RGB(0, 0, 128)
                .BackColor = RGB(255, 255, 255)
                .Themes    = .F.
                .Value     = 0
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPag.cnt_4c_ModoRastro.chk_4c_Op,       "Click", THIS, "ChkOpClick")
        BINDEVENT(loc_oPag.cnt_4c_ModoRastro.chk_4c_Envelope, "Click", THIS, "ChkEnvelopeClick")
        BINDEVENT(loc_oPag.cnt_4c_ModoRastro.chk_4c_Pedido,   "Click", THIS, "ChkPedidoClick")

        *-- Grd_Produto do legado - grade de resultado. ControlSource/
        *-- Header1.Caption/Width TRANSCRITOS do PROCEDURE Init legado (que
        *-- SOBRESCREVE os headers do dump estatico do SCX - regra "a pagina
        *-- segue o Init legado, nao o SCX desenhado"), nao do dump da
        *-- SECAO 2 (que tem Column6/7 com Header1.Caption = "Header1").
        loc_oPag.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oPag.grd_4c_Dados
            .Top           = 219
            .Left          = 35
            .Width         = 729
            .Height        = 400
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 17
            .ScrollBars    = 2
            .GridLineColor = RGB(238, 238, 238)
        ENDWITH

        *-- ColumnCount/RecordSource/ControlSource/Width/Header1.Caption
        *-- ficam em VincularGradeResultado (Fase 8) - FONTE UNICA do bind,
        *-- compartilhada com CarregarLista.
        THIS.VincularGradeResultado()

        BINDEVENT(loc_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
    ENDPROC

    *==========================================================================
    * VincularGradeResultado - Liga grd_4c_Dados ao cursor de resultado.
    * Transcrito do "With .Fld_Principal.Pag_Resultado.Grd_Produto" do
    * PROCEDURE Init legado (que SOBRESCREVE os headers do dump estatico do
    * SCX - a pagina segue o Init legado, nao o SCX desenhado: por isso
    * Column6/Column7 recebem "Fase"/"Conta" e nao o "Header1" do dump).
    *
    * ORDEM OBRIGATORIA (regra CLAUDE.md #41/#48): ColumnCount ->
    * RecordSource -> ControlSource -> Width -> Header1.Caption. Atribuir
    * RecordSource RECALCULA as larguras para o default 90 e zera os
    * captions, entao Width/Caption tem de vir DEPOIS - em TODO site que
    * re-vincula a grade, e nao so na montagem inicial.
    *
    * PUBLIC de proposito (regra CLAUDE.md #1/#51 - o harness da etapa 06b
    * chama metodos do form de FORA da classe).
    *==========================================================================
    PROCEDURE VincularGradeResultado()
        LOCAL loc_oGrid, loc_cCursor, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_oBusinessObject.this_cCursorResultado

        *-- Column.ControlSource de cursor INEXISTENTE derruba o Init
        *-- (regra CLAUDE.md #41) - o placeholder tem de existir antes.
        IF !USED(loc_cCursor)
            THIS.InicializarCursorResultado()
        ENDIF

        loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados

        TRY
            *-- ColumnCount so eh reatribuido quando DIVERGE de 7: qualquer
            *-- atribuicao recria os objetos Column (regra CLAUDE.md #144) e
            *-- aqui nao ha motivo para pagar esse custo a cada repintura.
            IF loc_oGrid.ColumnCount != 7
                loc_oGrid.ColumnCount = 7
            ENDIF

            loc_oGrid.RecordSource = loc_cCursor

            loc_oGrid.Column1.ControlSource = loc_cCursor + ".Nenvs"
            loc_oGrid.Column2.ControlSource = loc_cCursor + ".Nops"
            loc_oGrid.Column3.ControlSource = loc_cCursor + ".DopNums"
            loc_oGrid.Column4.ControlSource = loc_cCursor + ".Cpros"
            loc_oGrid.Column5.ControlSource = loc_cCursor + ".Qtds"
            loc_oGrid.Column6.ControlSource = loc_cCursor + ".Grupods"
            loc_oGrid.Column7.ControlSource = loc_cCursor + ".Contads"

            *-- Width e Header1.Caption DEPOIS do RecordSource/ControlSource
            WITH loc_oGrid.Column1
                .FontSize          = 8
                .Movable           = .F.
                .Resizable         = .F.
                .Width             = 68
                .Header1.Caption   = "Envelope"
                .Header1.Alignment = 2
                .Header1.FontSize  = 8
                .Text1.FontSize    = 8
            ENDWITH

            WITH loc_oGrid.Column2
                .FontSize          = 8
                .Movable           = .F.
                .Resizable         = .F.
                .Width             = 68
                .Header1.Caption   = "Op"
                .Header1.Alignment = 2
                .Header1.FontSize  = 8
                .Text1.FontSize    = 8
            ENDWITH

            WITH loc_oGrid.Column3
                .Alignment         = 2
                .FontSize          = 8
                .Movable           = .F.
                .Resizable         = .F.
                .Width             = 182
                .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
                .Header1.Alignment = 2
                .Header1.FontSize  = 8
                .Text1.FontSize    = 8
            ENDWITH

            WITH loc_oGrid.Column4
                .FontSize          = 8
                .Movable           = .F.
                .Resizable         = .F.
                .Width             = 108
                .Header1.Caption   = "Produto"
                .Header1.Alignment = 2
                .Header1.FontSize  = 8
                .Text1.FontSize    = 8
            ENDWITH

            WITH loc_oGrid.Column5
                .FontSize          = 8
                .Movable           = .F.
                .Resizable         = .F.
                .Width             = 68
                .Header1.Caption   = "Qtde"
                .Header1.Alignment = 2
                .Header1.FontSize  = 8
                .Text1.FontSize    = 8
            ENDWITH

            WITH loc_oGrid.Column6
                .FontSize          = 8
                .Movable           = .F.
                .Resizable         = .F.
                .Width             = 80
                .Header1.Caption   = "Fase"
                .Header1.Alignment = 2
                .Header1.FontSize  = 8
                .Text1.FontSize    = 8
            ENDWITH

            WITH loc_oGrid.Column7
                .FontSize          = 8
                .Movable           = .F.
                .Resizable         = .F.
                .Width             = 80
                .Header1.Caption   = "Conta"
                .Header1.Alignment = 2
                .Header1.FontSize  = 8
                .Text1.FontSize    = 8
            ENDWITH

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Vincular a Grade de Resultado")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AlternarPagina - troca a pagina ativa do PageFrame (equivalente a
    * ThisForm.fld_principal.ActivePage = N no legado). A ida para a
    * Pagina 2 (Resultado) so acontece se a consulta ja tiver sido rodada
    * (equivalente ao guard do pag_resultado.Activate legado: "If Not
    * ConsultaExecutada Then ActivePage = 1"); na Fase 4 isso bloqueia a
    * navegacao ate a Fase 7/8 implementar Processa() e marcar
    * this_lConsultaExecutada = .T. - comportamento correto, pois sem
    * consulta executada o legado tambem nao muda de pagina.
    *
    * PUBLIC de proposito (regra CLAUDE.md #1/TesteAutomatico - o harness
    * chama metodos do form direto de fora da classe).
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF par_nPagina = 2 AND !THIS.this_oBusinessObject.this_lConsultaExecutada
            RETURN
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        *-- FUNIL de volta (regra CLAUDE.md #40): quem desabilita botao/campo
        *-- ao SAIR de uma pagina tem de reabilitar ao VOLTAR, e isso mora
        *-- aqui, nao em cada botao que entra.
        THIS.AjustarBotoesPorModo()

        IF par_nPagina = 2
            *-- Repintura da grade DEPOIS do ActivePage: Refresh em pagina
            *-- OCULTA nao pinta (regra CLAUDE.md #21/Erro192) - o cursor
            *-- foi populado com a Page2 ainda escondida.
            THIS.CarregarLista()

            *-- pag_resultado.Activate legado (ramo Else, ja garantido pelo
            *-- guard acima: ConsultaExecutada = .T.): foco na 1a coluna da
            *-- grade de resultado.
            THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * AtualizarBotaoRastreab - equivalente ao When do Bot_Rastro legado
    * ("Return Not Eof('dbProduto')"): o botao so fica habilitado quando o
    * cursor de resultado tem pelo menos uma linha.
    *==========================================================================
    PROCEDURE AtualizarBotaoRastreab()
        LOCAL loc_cCursor, loc_lTemRegistro

        loc_cCursor      = THIS.this_oBusinessObject.this_cCursorResultado
        loc_lTemRegistro = USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0

        THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Rastreab.Enabled = loc_lTemRegistro
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - botao "Processar" (Page1). Equivalente a
    * cmdprocessar.Click do legado:
    *   1) guard "preencher ao menos um dos 3 filtros" - sem isso, MsgAviso
    *      + foco em N. Op (m.llRetorno = .f., nao processa nada);
    *   2) transfere os criterios da tela para o BO (equivalente a ler
    *      Get_Op/Get_Env/Get_Pedido/Get_Numero direto no corpo do Click
    *      legado - este dialogo nao tem FormParaBO/BOParaForm porque e
    *      so-leitura, sem Inserir/Atualizar/Excluir);
    *   3) ThisForm.Processa() -> THIS.this_oBusinessObject.Processar();
    *   4) Not Eof('DbProduto') -> avanca para a Pagina Resultado, senao
    *      MsgAviso("Nenhum Registro Encontrado!!!");
    *   5) sincroniza os 3 CheckBoxes de Container1 (Page2) com o criterio
    *      efetivamente usado - SEMPRE, dentro ou fora do bloco If/Else,
    *      igual ao legado (o With final do Click roda incondicionalmente).
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oPg, loc_lSucesso, loc_cCursor

        loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido

        IF EMPTY(loc_oPg.txt_4c_Env.Value) AND EMPTY(loc_oPg.txt_4c_Op.Value) AND ;
           EMPTY(loc_oPg.txt_4c_Pedido.Value)
            MsgAviso("Nenhum Op" + CHR(231) + CHR(227) + "o de Filtro Foi Informada!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_Op.SetFocus()
            RETURN
        ENDIF

        *-- Criterios da tela -> BO (Fase 8: extraido para FormParaBO).
        IF !THIS.FormParaBO()
            RETURN
        ENDIF

        THIS.LockScreen = .T.

        loc_lSucesso = THIS.this_oBusinessObject.Processar()
        loc_cCursor  = THIS.this_oBusinessObject.this_cCursorResultado

        IF loc_lSucesso AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
            *-- AlternarPagina(2) ja repinta a grade (CarregarLista) DEPOIS
            *-- de trocar o ActivePage - regra CLAUDE.md #21/Erro192.
            THIS.AlternarPagina(2)
            THIS.Refresh()
        ELSE
            IF loc_lSucesso
                MsgAviso("Nenhum Registro Encontrado!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        ENDIF

        THIS.LockScreen = .F.

        *-- "With This.Parent.Parent.pag_resultado.Container1" do fim do
        *-- cmdprocessar.Click legado - roda SEMPRE depois do Processa,
        *-- dentro ou fora do ramo "Not Eof('DbProduto')". Fase 8: os 3
        *-- CheckBoxes e as flags this_lRastroPor* saem de BOParaForm, que
        *-- le os MESMOS criterios que FormParaBO acabou de gravar no BO.
        THIS.BOParaForm()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - grp_operacao da Page1 (cmd_cancela.Click legado:
    * "ThisForm.Release").
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ValidarOpLostFocus - Get_Op.Valid legado: se preenchido, invalida a
    * consulta (ConsultaExecutada = .f.) e confere que a Op existe em
    * SigOpPic e pertence a empresa corrente. O legado cancela o Valid
    * (Return 0) sem limpar o valor digitado - aqui devolve o foco ao campo
    * com MsgAviso, tambem sem apagar o que o usuario digitou.
    *==========================================================================
    PROCEDURE ValidarOpLostFocus()
        LOCAL loc_oPg, loc_nValor, loc_lValido, loc_oErro

        loc_oPg    = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
        loc_nValor = loc_oPg.txt_4c_Op.Value

        *-- Guard dos When (Fase 8): reaplicado ANTES do early return, senao
        *-- limpar o campo nunca reabriria os outros dois filtros.
        THIS.HabilitarCampos(.T.)

        IF loc_nValor = 0
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_lConsultaExecutada = .F.

        loc_lValido = .F.
        TRY
            loc_lValido = THIS.this_oBusinessObject.ValidarOperacao(loc_nValor)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Validar Opera" + CHR(231) + CHR(227) + "o")
        ENDTRY

        IF !loc_lValido
            MsgAviso(THIS.this_oBusinessObject.this_cMensagemErroOp, ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_Op.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarEnvLostFocus - Get_Env.Valid legado: so invalida a consulta
    * executada quando o campo esta preenchido, sem checagem adicional.
    *==========================================================================
    PROCEDURE ValidarEnvLostFocus()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido

        IF loc_oPg.txt_4c_Env.Value != 0
            THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
        ENDIF

        *-- Guard dos When (Fase 8)
        THIS.HabilitarCampos(.T.)
    ENDPROC

    *==========================================================================
    * ValidarPedidoLostFocus - Get_Pedido.Valid legado: se preenchido,
    * invalida a consulta e confere (Seek) se o codigo digitado existe em
    * cursor_4c_Operacoes; se nao existir, abre o picker local
    * (AbrirLookupPedido). Se vazio, zera txt_4c_Numero (igual ao Else do
    * legado: "This.Parent.Get_Numero.Value = 0 / Refresh").
    *==========================================================================
    PROCEDURE ValidarPedidoLostFocus()
        LOCAL loc_oPg, loc_cValor

        *-- Guarda de reentrancia (regra CLAUDE.md #37/#47): o picker eh
        *-- modal, tira o foco do campo e redispara o proprio LostFocus.
        IF THIS.this_lEmLookupPedido
            RETURN
        ENDIF

        loc_oPg    = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Pedido.Value)

        *-- Guard de valor-nao-mudou (regra CLAUDE.md #47): LostFocus dispara
        *-- SEMPRE, ao contrario do Valid legado, que so dispara quando o
        *-- valor MUDA - sem isto, tabular pelo campo sem digitar nada
        *-- reabriria o picker a cada passagem.
        IF loc_cValor == THIS.this_cUltimoValidarPedidoLostFocusValidado
            RETURN
        ENDIF

        IF !EMPTY(loc_cValor)
            THIS.this_oBusinessObject.this_lConsultaExecutada = .F.

            IF !SEEK(loc_cValor, THIS.this_oBusinessObject.this_cCursorOperacoes, "Dopes")
                THIS.this_lEmLookupPedido = .T.
                THIS.AbrirLookupPedido()
                THIS.this_lEmLookupPedido = .F.
            ENDIF
        ELSE
            loc_oPg.txt_4c_Numero.Value = 0
            loc_oPg.txt_4c_Numero.Refresh()
        ENDIF

        THIS.this_cUltimoValidarPedidoLostFocusValidado = loc_cValor

        *-- Guard dos When (Fase 8): roda nos DOIS ramos - preencher Pedido
        *-- libera Numero e bloqueia Op/Envelope; limpar Pedido faz o
        *-- caminho inverso.
        THIS.HabilitarCampos(.T.)
    ENDPROC

    *==========================================================================
    * AbrirLookupPedido - fwBuscaSel('TmpOper', 'Dopes', ...) legado: abre o
    * picker local (FormBuscaAuxiliar Pattern A - DefinirCursor/Mostrar)
    * SOBRE cursor_4c_Operacoes JA carregado, sem nova consulta SQL.
    *==========================================================================
    PROCEDURE AbrirLookupPedido()
        LOCAL loc_oBusca, loc_cCursor, loc_oPg

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
        loc_oPg     = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
        loc_oBusca.DefinirCursor(loc_cCursor, "Dopes", "NDopes", ;
            "Cadastro de Opera" + CHR(231) + CHR(245) + "es")
        loc_oBusca.this_aColunas[1, 3] = "Opera" + CHR(231) + CHR(227) + "o"
        loc_oBusca.this_aColunas[2, 3] = "C" + CHR(243) + "digo"

        IF loc_oBusca.Mostrar()
            loc_oPg.txt_4c_Pedido.Value = loc_oBusca.cCodigoSelecionado
        ENDIF

        loc_oBusca.Release()
    ENDPROC

    *==========================================================================
    * GetOpWhenCheck/GetEnvWhenCheck/GetPedidoWhenCheck/GetNumeroWhenCheck -
    * equivalentes aos When dos 4 campos de filtro do legado: cada grupo
    * (Op, Envelope, Pedido+Numero) so recebe foco quando os OUTROS dois
    * grupos estao vazios - o usuario preenche APENAS um dos tres.
    *==========================================================================
    FUNCTION GetOpWhenCheck()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
        RETURN EMPTY(loc_oPg.txt_4c_Pedido.Value) AND EMPTY(loc_oPg.txt_4c_Env.Value)
    ENDFUNC

    FUNCTION GetEnvWhenCheck()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
        RETURN EMPTY(loc_oPg.txt_4c_Pedido.Value) AND EMPTY(loc_oPg.txt_4c_Op.Value)
    ENDFUNC

    FUNCTION GetPedidoWhenCheck()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
        RETURN EMPTY(loc_oPg.txt_4c_Op.Value) AND EMPTY(loc_oPg.txt_4c_Env.Value)
    ENDFUNC

    FUNCTION GetNumeroWhenCheck()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
        RETURN !EMPTY(loc_oPg.txt_4c_Pedido.Value)
    ENDFUNC

    *==========================================================================
    * BtnVoltarClick - grp_operacao da Page2 (cmd_voltar.Click legado:
    * "ThisForm.fld_principal.ActivePage = 1").
    *==========================================================================
    PROCEDURE BtnVoltarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * BtnRastreabClick - Bot_Rastro.Click legado: abre o relatorio
    * SigReCgr (Formsigrecgr, ja migrado) filtrado pela chave
    * correspondente ao modo marcado no cnt_4c_ModoRastro (Op/Envelope/
    * Pedido). As properties this_nSel*/this_cSel* vem de
    * CarregarDoCursor(), chamado a cada AfterRowColChange da grade.
    *==========================================================================
    PROCEDURE BtnRastreabClick()
        LOCAL loc_nTipo, loc_cFiltro, loc_oForm, loc_cCursor

        *-- O legado le a chave DIRETO da linha corrente ("dbProduto.Nops"),
        *-- nao de uma copia guardada: reposicionar as properties aqui
        *-- garante o mesmo valor mesmo que a grade nunca tenha disparado
        *-- AfterRowColChange (usuario clica Rastreab. sem trocar de linha).
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorResultado
        IF USED(loc_cCursor)
            THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
        ENDIF

        DO CASE
            CASE THIS.this_oBusinessObject.this_lRastroPorOp
                loc_nTipo   = 2
                loc_cFiltro = ALLTRIM(STR(THIS.this_oBusinessObject.this_nSelNops, 10))
            CASE THIS.this_oBusinessObject.this_lRastroPorEnvelop
                loc_nTipo   = 3
                loc_cFiltro = ALLTRIM(STR(THIS.this_oBusinessObject.this_nSelNenvs, 10))
            CASE THIS.this_oBusinessObject.this_lRastroPorPedido
                loc_nTipo   = 4
                loc_cFiltro = ALLTRIM(THIS.this_oBusinessObject.this_cSelDopNums)
            OTHERWISE
                RETURN
        ENDCASE

        loc_oForm = CREATEOBJECT("Formsigrecgr", loc_nTipo, loc_cFiltro, THIS)
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * ChkOp/Envelope/PedidoClick - Container1 do legado: os tres
    * CheckBoxes sao mutuamente exclusivos (marcar um desmarca os outros
    * dois) e definem a chave que Bot_Rastro.Click usa.
    *==========================================================================
    PROCEDURE ChkOpClick()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_ModoRastro

        loc_oCnt.chk_4c_Op.Value       = 1
        loc_oCnt.chk_4c_Envelope.Value = 0
        loc_oCnt.chk_4c_Pedido.Value   = 0
        loc_oCnt.chk_4c_Envelope.Refresh()
        loc_oCnt.chk_4c_Pedido.Refresh()

        THIS.this_oBusinessObject.this_lRastroPorOp      = .T.
        THIS.this_oBusinessObject.this_lRastroPorEnvelop = .F.
        THIS.this_oBusinessObject.this_lRastroPorPedido  = .F.

        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.SetFocus()
    ENDPROC

    PROCEDURE ChkEnvelopeClick()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_ModoRastro

        loc_oCnt.chk_4c_Envelope.Value = 1
        loc_oCnt.chk_4c_Op.Value       = 0
        loc_oCnt.chk_4c_Pedido.Value   = 0
        loc_oCnt.chk_4c_Op.Refresh()
        loc_oCnt.chk_4c_Pedido.Refresh()

        THIS.this_oBusinessObject.this_lRastroPorOp      = .F.
        THIS.this_oBusinessObject.this_lRastroPorEnvelop = .T.
        THIS.this_oBusinessObject.this_lRastroPorPedido  = .F.

        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.SetFocus()
    ENDPROC

    PROCEDURE ChkPedidoClick()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_ModoRastro

        loc_oCnt.chk_4c_Pedido.Value   = 1
        loc_oCnt.chk_4c_Envelope.Value = 0
        loc_oCnt.chk_4c_Op.Value       = 0
        loc_oCnt.chk_4c_Envelope.Refresh()
        loc_oCnt.chk_4c_Op.Refresh()

        THIS.this_oBusinessObject.this_lRastroPorOp      = .F.
        THIS.this_oBusinessObject.this_lRastroPorEnvelop = .F.
        THIS.this_oBusinessObject.this_lRastroPorPedido  = .T.

        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Column1.SetFocus()
    ENDPROC

    *==========================================================================
    * GrdDadosAfterRowColChange - reposiciona as properties this_nSel*/
    * this_cSel* do BO (CarregarDoCursor) e reavalia o Enabled do botao
    * Rastreab. a cada troca de linha/coluna na grade de resultado. Metodo
    * SEM filtro de coluna (regra CLAUDE.md #46 - carregar detalhe da
    * linha corrente eh o uso correto de AfterRowColChange).
    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorResultado

        IF USED(loc_cCursor)
            THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
        ENDIF

        THIS.AtualizarBotaoRastreab()
    ENDPROC

    *==========================================================================
    * CarregarLista - Repinta a grade de resultado. Popular um cursor NAO
    * repinta a grade ligada a ele (regra CLAUDE.md #21): o legado sempre
    * fecha o ciclo com "Go Top In <cursor>" + "<grid>.Refresh", e aqui
    * isso vira um METODO UNICO chamado em TODO caminho que popula ou
    * exibe o resultado - BtnProcessarClick (depois do Processar),
    * AlternarPagina(2) DEPOIS de trocar o ActivePage (Refresh em pagina
    * OCULTA nao pinta - regra #21/Erro192) e LimparCampos.
    *
    * O rebind so acontece quando o alias ligado ao Grid DEIXOU de ser o
    * cursor de resultado: o BO popula por ZAP + APPEND BLANK/REPLACE no
    * MESMO alias (nunca derruba o cursor), entao no caminho normal basta
    * reposicionar e repintar - re-atribuir RecordSource a toa resetaria
    * Width/Caption e a posicao de rolagem sem necessidade.
    *
    * PUBLIC de proposito (regra CLAUDE.md #1/#51).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_cCursor, loc_oGrid, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_oBusinessObject.this_cCursorResultado

        IF !USED(loc_cCursor)
            THIS.InicializarCursorResultado()
        ENDIF

        loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados

        TRY
            IF UPPER(ALLTRIM(loc_oGrid.RecordSource)) != UPPER(ALLTRIM(loc_cCursor))
                THIS.VincularGradeResultado()
            ENDIF

            SELECT (loc_cCursor)
            GO TOP

            loc_oGrid.Refresh()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Carregar a Lista de Resultado")
        ENDTRY

        *-- A linha corrente mudou (GO TOP) - reposiciona as properties
        *-- this_nSel*/this_cSel* do BO e reavalia o Enabled do Rastreab.
        IF USED(loc_cCursor)
            THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
        ENDIF
        THIS.AtualizarBotaoRastreab()

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere os 4 campos de filtro da tela para o BO
    * (equivalente a leitura de Get_Op/Get_Env/Get_Pedido/Get_Numero no
    * corpo do PROCEDURE processa legado: "lnOp = ...Get_Op.Value" etc).
    * Este dialogo eh so-leitura: a "ficha" transferida sao os criterios de
    * pesquisa, nao campos de um registro a gravar.
    *
    * PROTECTED EXPLICITO, e nao por preferencia de estilo: FormBase declara
    * PROTECTED PROCEDURE FormParaBO (hook chamado por FormBase.Salvar/Novo/
    * Cancelar) e o VFP9 NAO deixa a subclasse ALARGAR o escopo - omitir a
    * palavra nao torna o metodo publico, so esconde que ele continua
    * protegido. Medido neste form em 2026-10-24: oForm.FormParaBO() de FORA
    * da classe estoura "Property FORMPARABO is not found" mesmo declarado
    * sem modificador (e PEMSTATUS(...,5) responde .T., porque so verifica
    * existencia - mesma armadilha da regra CLAUDE.md #3/#51). Chamar SEMPRE
    * por THIS. de dentro da classe.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido

            WITH THIS.this_oBusinessObject
                .this_nOps    = loc_oPg.txt_4c_Op.Value
                .this_nEnvs   = loc_oPg.txt_4c_Env.Value
                .this_cPedido = loc_oPg.txt_4c_Pedido.Value
                .this_nNumero = loc_oPg.txt_4c_Numero.Value
            ENDWITH

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Ler os Filtros da Tela")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - Sentido inverso de FormParaBO: escreve os criterios
    * guardados no BO de volta nos 4 campos de filtro (Page1) e sincroniza
    * os 3 CheckBoxes de cnt_4c_ModoRastro (Page2) com o criterio
    * efetivamente usado - este segundo trecho eh o "With
    * This.Parent.Parent.pag_resultado.Container1 / .Chk_op.Value =
    * Iif(Empty(...Get_Op.Value), 0, 1) / ..." que fecha o
    * cmdprocessar.Click legado.
    *
    * As flags this_lRastroPor* do BO sao derivadas no MESMO ponto, para
    * nao divergirem dos CheckBoxes: BtnRastreabClick as consulta para
    * escolher a chave (equivalente ao "If Chk_op.Value = 1" do
    * Bot_Rastro.Click legado).
    *
    * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO: o escopo vem da
    * HERANCA (FormBase declara PROTECTED PROCEDURE BOParaForm) e nao da
    * ausencia do modificador aqui.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg, loc_oCnt, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_ModoRastro

            WITH THIS.this_oBusinessObject
                loc_oPg.txt_4c_Op.Value     = .this_nOps
                loc_oPg.txt_4c_Env.Value    = .this_nEnvs
                loc_oPg.txt_4c_Pedido.Value = PADR(.this_cPedido, 20)
                loc_oPg.txt_4c_Numero.Value = .this_nNumero

                *-- Iif(Empty(<campo>), 0, 1) do legado, campo a campo
                .this_lRastroPorOp      = !EMPTY(.this_nOps)
                .this_lRastroPorEnvelop = !EMPTY(.this_nEnvs)
                .this_lRastroPorPedido  = !EMPTY(.this_cPedido)

                loc_oCnt.chk_4c_Op.Value       = IIF(.this_lRastroPorOp, 1, 0)
                loc_oCnt.chk_4c_Envelope.Value = IIF(.this_lRastroPorEnvelop, 1, 0)
                loc_oCnt.chk_4c_Pedido.Value   = IIF(.this_lRastroPorPedido, 1, 0)
            ENDWITH

            loc_oCnt.chk_4c_Op.Refresh()
            loc_oCnt.chk_4c_Envelope.Refresh()
            loc_oCnt.chk_4c_Pedido.Refresh()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Exibir os Filtros na Tela")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparCampos - Estado inicial do dialogo. Transcrito de dois trechos
    * do legado:
    *   PROCEDURE Init  -> "With .fld_principal.pag_consulta.Origem.Pedido /
    *                       .get_Env.Value = 0 / .get_Op.Value = 0 /
    *                       .get_Numero.Value = 0 /
    *                       .get_Pedido.Value = Space(20) / EndWith"
    *                      e ".ConsultaExecutada = .f."
    *   PROCEDURE processa -> "*-[ Limpa os Arquivos ]-* / Select DbProduto /
    *                       Zap" (o resultado anterior some junto com os
    *                       criterios que o produziram).
    * Fecha reaplicando o guard dos When (HabilitarCampos), repintando a
    * grade vazia (CarregarLista) e reavaliando os botoes.
    *
    * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO: o escopo vem da
    * HERANCA (FormBase declara PROTECTED PROCEDURE LimparCampos) e nao da
    * ausencia do modificador aqui. Quem precisa de um ponto de entrada
    * PUBLICO para zerar a tela usa THIS.AjustarBotoesPorModo /
    * THIS.CarregarLista, que nao existem em FormBase e sao publicos de
    * verdade.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg, loc_cCursor, loc_oErro

        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido

            loc_oPg.txt_4c_Env.Value    = 0
            loc_oPg.txt_4c_Op.Value     = 0
            loc_oPg.txt_4c_Numero.Value = 0
            loc_oPg.txt_4c_Pedido.Value = SPACE(20)

            WITH THIS.this_oBusinessObject
                .this_nOps                = 0
                .this_nEnvs               = 0
                .this_cPedido             = SPACE(20)
                .this_nNumero             = 0
                .this_lConsultaExecutada  = .F.
                .this_cMensagemErroOp     = ""
            ENDWITH

            *-- "Select DbProduto / Zap" do processa legado
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorResultado
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                ZAP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Limpar os Campos")
        ENDTRY

        *-- BOParaForm zera tambem os 3 CheckBoxes de modo e as flags
        *-- this_lRastroPor* (todos os criterios estao vazios agora).
        THIS.BOParaForm()
        THIS.HabilitarCampos(.T.)
        THIS.CarregarLista()
        THIS.AjustarBotoesPorModo()

        *-- ".Fld_Principal.pag_consulta.origem.Pedido.get_Op.SetFocus" do
        *-- Init legado. Guardado por Visible: durante o Init o form ainda
        *-- nao foi exibido e SetFocus em controle invisivel estoura.
        IF VARTYPE(loc_oPg) = "O" AND THIS.Visible AND ;
           THIS.pgf_4c_Paginas.ActivePage = 1 AND loc_oPg.txt_4c_Op.Enabled
            loc_oPg.txt_4c_Op.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Guard "preencher APENAS um dos tres filtros"
    * (Op OU Envelope OU Pedido+Numero), que no legado mora nos When dos
    * 4 campos:
    *   Get_Op.When     -> Empty(Get_Pedido.Value) And Empty(Get_Env.Value)
    *   Get_Env.When    -> Empty(Get_Pedido.Value) And Empty(Get_Op.Value)
    *   Get_Pedido.When -> Empty(Get_Op.Value)     And Empty(Get_Env.Value)
    *   Get_Numero.When -> Not Empty(Get_Pedido.Value)
    *
    * par_lHabilitar = .F. bloqueia os quatro de uma vez (usado enquanto a
    * consulta roda e quando a pagina ativa e' a de Resultado); .T. ou
    * ausente aplica o guard campo a campo, reusando os MESMOS predicados
    * dos GetXWhenCheck da Fase 6 (fonte unica - os dois call sites nao
    * podem divergir em silencio).
    *
    * DESVIO registrado no cabecalho do arquivo: o mecanismo e' .Enabled e
    * nao When, porque When e' evento (nao se atribui a controle criado por
    * AddObject) e, ligado por BINDEVENT, tem o retorno DESCARTADO - o
    * guard do legado nao chegaria a bloquear nada.
    *
    * PUBLIC de proposito (regra CLAUDE.md #1/#51).
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHabilitar

        loc_lHabilitar = .T.
        IF VARTYPE(par_lHabilitar) = "L"
            loc_lHabilitar = par_lHabilitar
        ENDIF

        loc_oPg = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.cnt_4c_Pedido

        IF loc_lHabilitar
            loc_oPg.txt_4c_Op.Enabled     = THIS.GetOpWhenCheck()
            loc_oPg.txt_4c_Env.Enabled    = THIS.GetEnvWhenCheck()
            loc_oPg.txt_4c_Pedido.Enabled = THIS.GetPedidoWhenCheck()
            loc_oPg.txt_4c_Numero.Enabled = THIS.GetNumeroWhenCheck()
        ELSE
            loc_oPg.txt_4c_Op.Enabled     = .F.
            loc_oPg.txt_4c_Env.Enabled    = .F.
            loc_oPg.txt_4c_Pedido.Enabled = .F.
            loc_oPg.txt_4c_Numero.Enabled = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - FUNIL do estado dos botoes (regra CLAUDE.md
    * #40: quem desabilita tem de reabilitar no caminho de VOLTA, e isso
    * mora no funil de troca de pagina, nunca so no botao que entra).
    *
    * Pagina 1 (Consulta): Processar ativo; os campos de filtro voltam ao
    * guard dos When. Pagina 2 (Resultado): Rastreab. ativo apenas com
    * linha no cursor (o When "Return Not Eof('dbProduto')" do Bot_Rastro
    * legado, em AtualizarBotaoRastreab) e os filtros ficam bloqueados -
    * eles pertencem a outra pagina e so voltam a valer no retorno.
    * Encerrar e Voltar NUNCA sao desabilitados: sao a unica saida da tela
    * (o form tem ControlBox = .F. / Closable = .F.).
    *
    * PUBLIC de proposito (regra CLAUDE.md #1/#51).
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lNaConsulta

        loc_lNaConsulta = (THIS.pgf_4c_Paginas.ActivePage = 1)

        THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.cmd_4c_Processar.Enabled = loc_lNaConsulta

        THIS.HabilitarCampos(loc_lNaConsulta)
        THIS.AtualizarBotaoRastreab()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F.;
    * este metodo percorre Pages E Controls recursivamente tornando tudo
    * visivel apos a montagem do form.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                loc_oObjeto.Visible = .T.
            ENDIF

            IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                FOR loc_nP = 1 TO loc_oObjeto.PageCount
                    THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                ENDFOR
            ELSE
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - delega para FormBase.Destroy (restaura menu apos fechamento)
    *==========================================================================
    PROCEDURE Destroy()
        RETURN DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCgrBO.prg):
*------------------------------------------------------------------------------
* SigOpCgrBO - Business Object para FormSigOpCgr
* Dialogo operacional de "Pesquisa Global de Rastreabilidade": o usuario
* informa UM dos tres criterios (N. Op, Envelope ou Pedido/Numero), o BO
* monta a lista de produtos envolvidos naquele lote (tabela SigPdMvf,
* cruzada com a picagem de SigOpPic e a lista de operacoes de SigCdOpe) e
* o form exibe o resultado numa grade. A partir de uma linha do resultado,
* o usuario abre o relatorio SigReCgr (rastreabilidade) filtrado por
* Op/Envelope/Pedido, conforme o modo marcado.
* Migrado de: SIGOPCGR (Framework Fortyus)
*
* Este dialogo nao possui tabela propria persistida (nao ha Inserir/
* Atualizar/Excluir no legado - e so consulta). A tabela "principal" para
* efeito de this_cTabela/this_cCampoChave e SigPdMvf, que e a fonte real
* do resultado (equivalente a dbProduto no legado); SigCdOpe e SigOpPic
* sao consultadas apenas como apoio (lista de operacoes e picagem).
*------------------------------------------------------------------------------
DEFINE CLASS SigOpCgrBO AS BusinessBase

    *-- Criterios de pesquisa (equivalentes aos Get_Op/Get_Env/Get_Pedido/
    *-- Get_Numero do dump legado - o usuario preenche APENAS um dos tres
    *-- grupos: Op, OU Envelope, OU Pedido+Numero)
    this_nOps    = 0
    this_nEnvs   = 0
    this_cPedido = ""
    this_nNumero = 0

    *-- Estado de controle (equivalente a ThisForm.ConsultaExecutada) -
    *-- evita reprocessar a mesma consulta enquanto nenhum criterio mudou
    this_lConsultaExecutada = .F.

    *-- Modo de rastreabilidade escolhido na pagina de resultado
    *-- (equivalente aos Chk_op/chk_Env/Chk_Dop do Container1 do legado -
    *-- define qual chave o Bot_Rastro.Click usa para abrir SigReCgr)
    this_lRastroPorOp      = .F.
    this_lRastroPorEnvelop = .F.
    this_lRastroPorPedido  = .F.

    *-- Linha corrente do resultado (equivalente ao registro atual de
    *-- dbProduto - usado pelo Bot_Rastro.Click e pelas colunas da grade)
    this_nSelNenvs   = 0
    this_nSelNops    = 0
    this_cSelDopNums = ""
    this_cSelCpros   = ""
    this_nSelQtds    = 0
    this_cSelGrupods = ""
    this_cSelContads = ""

    *-- Nomes dos cursores que este BO consome/popula (propriedade para o
    *-- Form referenciar sem repetir literais - padrao sigopagrBO/SigMvSbnBO)
    this_cCursorOperacoes = "cursor_4c_Operacoes" && equivalente a TmpOper (SigCdOpe) - lista de operacoes para o lookup do Pedido
    this_cCursorPicagem   = "cursor_4c_Picagem"   && equivalente a crSigOpPic (SigOpPic) - picagem por Op/Envelope/EmpDopNums
    this_cCursorMovimento = "cursor_4c_Movimento" && equivalente a crSigPdMvf (SigPdMvf) - lote/producao por Op ou por EmpDNps
    this_cCursorTopo      = "cursor_4c_Topo"      && equivalente a crTopMfas (SigPdMvf) - top 1 EmpDNps por envelope
    this_cCursorResultado = "cursor_4c_Resultado" && equivalente a dbProduto - grade de resultado exibida na pagina 2

    *-- Mensagem de erro do ultimo ValidarOperacao() (equivalente aos dois
    *-- MessageBox do Get_Op.Valid legado: "Op Nao Cadastrada!!!" / "Op de
    *-- Outra Empresa!!!") - o Form le esta property para exibir o MsgAviso.
    this_cMensagemErroOp = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigPdMvf"
        THIS.this_cCampoChave = "Nops"
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega os dados da linha CORRENTE do cursor de
    * resultado (equivalente ao registro atual de dbProduto no legado) para
    * as properties this_nSel*/this_cSel*. E chamado pelo form ao posicionar
    * o grid de resultado (AfterRowColChange da grade) e antes de
    * Bot_Rastro.Click, que precisa da linha selecionada para montar a
    * chave (Nops/Nenvs/DopNums) usada ao abrir SigReCgr.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_nSelNenvs   = TratarNulo(Nenvs, 0)
            THIS.this_nSelNops    = TratarNulo(Nops, 0)
            THIS.this_cSelDopNums = TratarNulo(DopNums, "")
            THIS.this_cSelCpros   = TratarNulo(Cpros, "")
            THIS.this_nSelQtds    = TratarNulo(Qtds, 0)
            THIS.this_cSelGrupods = TratarNulo(Grupods, "")
            THIS.this_cSelContads = TratarNulo(Contads, "")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Popula this_cCursorOperacoes (equivalente a TmpOper
    * do PROCEDURE Init legado: Select Dopes, NDopes, Globalizas, Reservas
    * From SigCdOpe Where Globalizas In (1, 2), Index On Dopes Tag Dopes).
    * Usado pelo lookup do campo Pedido (Fase 6): SEEK contra o cursor local
    * + picker FormBuscaAuxiliar.DefinirCursor/Mostrar (Pattern A - regra
    * "FormBuscaAuxiliar Pattern B broken") sobre este MESMO cursor, sem
    * nova consulta SQL - igual ao fwBuscaSel legado, que tambem trabalha
    * em cima do cursor ja carregado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_cCursor, loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorOperacoes

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        *-- Modo teste/validacao de UI: sem conexao real de SQL Server -
        *-- SQLEXEC com handle invalido DISPARA excecao (nao devolve -1),
        *-- entao criar o cursor vazio com a MESMA estrutura do TmpOper
        *-- legado, para o SEEK do lookup de Pedido nao estourar "Alias
        *-- CURSOR_4C_OPERACOES is not found".
        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
           (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            CREATE CURSOR (loc_cCursor) ;
                (Dopes C(20), NDopes N(4, 0), Globalizas N(1, 0), Reservas N(1, 0))
            INDEX ON Dopes TAG Dopes
            RETURN .T.
        ENDIF

        loc_cSQL = "SELECT Dopes, NDopes, Globalizas, Reservas " + ;
                   "FROM SigCdOpe WHERE Globalizas IN (1, 2)"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado >= 0 AND USED(loc_cCursor)
            SELECT (loc_cCursor)
            INDEX ON Dopes TAG Dopes
            GO TOP
            loc_lSucesso = .T.
        ELSE
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (" + loc_cCursor + ")")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOperacao - Confere se a Op existe em SigOpPic e pertence a
    * empresa corrente (equivalente ao Get_Op.Valid legado: CursorQuery +
    * Eof('crSigOpPic') + crSigOpPic.Emps <> _Empr). Preenche
    * this_cMensagemErroOp quando invalido, para o Form exibir o MsgAviso.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOperacao(par_nOps)
        LOCAL loc_cCursor, loc_cSQL, loc_nResultado, loc_lValido

        loc_lValido = .F.
        THIS.this_cMensagemErroOp = ""
        loc_cCursor = "cursor_4c_ValOp"

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        loc_cSQL = "SELECT TOP 1 Emps FROM SigOpPic WHERE Nops = " + ;
                   FormatarNumeroSQL(par_nOps, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado > 0 AND USED(loc_cCursor) AND !EOF(loc_cCursor)
            SELECT (loc_cCursor)
            IF ALLTRIM(Emps) == ALLTRIM(go_4c_Sistema.cCodEmpresa)
                loc_lValido = .T.
            ELSE
                THIS.this_cMensagemErroOp = "Op de Outra Empresa!!!"
            ENDIF
        ELSE
            THIS.this_cMensagemErroOp = "Op N" + CHR(227) + "o Cadastrada!!!"
        ENDIF

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - equivalente ao PROCEDURE processa do legado: monta o
    * resultado da pesquisa (this_cCursorResultado) a partir de QUAL dos
    * tres criterios foi preenchido (Op, Envelope ou Pedido+Numero). O
    * guard "If Not Thisform.ConsultaExecutada" do legado fica aqui dentro
    * (nao reprocessa enquanto nenhum criterio mudou - os handlers de
    * LostFocus dos filtros resetam this_lConsultaExecutada no Form).
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_cCursorResultado, loc_lSucesso

        loc_lSucesso          = .T.
        loc_cCursorResultado  = THIS.this_cCursorResultado

        IF !THIS.this_lConsultaExecutada
            *-[ Limpa os Arquivos ]-* (equivalente a "Select DbProduto / Zap")
            IF USED(loc_cCursorResultado)
                SELECT (loc_cCursorResultado)
                ZAP
            ENDIF

            DO CASE
                CASE THIS.this_nOps != 0
                    loc_lSucesso = THIS.ProcessarPorOp()
                CASE THIS.this_nEnvs > 0
                    loc_lSucesso = THIS.ProcessarPorEnvelope()
                OTHERWISE
                    loc_lSucesso = THIS.ProcessarPorPedido()
            ENDCASE

            IF loc_lSucesso
                THIS.this_lConsultaExecutada = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarPorOp - ramo "If (lnOp <> 0)" do legado: pesquisa a picagem
    * (SigOpPic) da Op informada e, para cada linha, busca o topo de
    * producao (SigPdMvf) correspondente.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPorOp()
        LOCAL loc_cCursorPic, loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_aDopes[1], loc_aNumes[1], loc_aQtds[1], loc_nTotal, loc_nI

        loc_lSucesso   = .T.
        loc_cCursorPic = THIS.this_cCursorPicagem

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        loc_cSQL = "SELECT Dopes, Numes, Qtds FROM SigOpPic WHERE Nops = " + ;
                   FormatarNumeroSQL(THIS.this_nOps, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorPic)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigOpPic)")
            RETURN .F.
        ENDIF

        *-- Snapshot em array ANTES de fechar o cursor: BuscarTopoPorOp faz
        *-- SQLEXEC/SELECT proprios, e um SCAN direto neste cursor perderia
        *-- a posicao corrente quando a funcao chamada troca de workarea.
        loc_nTotal = 0
        IF USED(loc_cCursorPic)
            loc_nTotal = RECCOUNT(loc_cCursorPic)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aDopes[loc_nTotal]
            DIMENSION loc_aNumes[loc_nTotal]
            DIMENSION loc_aQtds[loc_nTotal]

            SELECT (loc_cCursorPic)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aDopes[loc_nI] = Dopes
                loc_aNumes[loc_nI] = Numes
                loc_aQtds[loc_nI]  = Qtds
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            IF !THIS.BuscarTopoPorOp(THIS.this_nOps, loc_aDopes[loc_nI], ;
                    loc_aNumes[loc_nI], loc_aQtds[loc_nI], "1")
                loc_lSucesso = .F.
                EXIT
            ENDIF
        ENDFOR

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarPorEnvelope - ramo "If (lnEnv > 0)" do legado: acha o topo
    * de EmpDNps do envelope informado, pesquisa TODAS as linhas de
    * SigPdMvf daquele EmpDNps e, para cada uma, busca a picagem (SigOpPic)
    * da Op correspondente.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPorEnvelope()
        LOCAL loc_cCursorTopo, loc_cSQL, loc_nResultado, loc_cChave, loc_lSucesso
        LOCAL loc_cCursorMvf, loc_nTotal, loc_nI
        LOCAL loc_aNops[1], loc_aNenvs[1], loc_aCodPds[1], loc_aGrupods[1], loc_aContads[1]

        loc_lSucesso    = .T.
        loc_cCursorTopo = THIS.this_cCursorTopo

        IF USED(loc_cCursorTopo)
            USE IN (loc_cCursorTopo)
        ENDIF

        loc_cSQL = "SELECT TOP 1 EmpDNps FROM SigPdMvf " + ;
                   "WHERE Nenvs = " + FormatarNumeroSQL(THIS.this_nEnvs, 0) + " " + ;
                   "ORDER BY Nenvs DESC, EmpDNps DESC"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTopo)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crTopMfas)")
            RETURN .F.
        ENDIF

        *-- legado: "If Not Eof()" - sem registro, nao eh erro, simplesmente
        *-- nao ha nada para acrescentar ao resultado.
        IF !USED(loc_cCursorTopo) OR EOF(loc_cCursorTopo)
            IF USED(loc_cCursorTopo)
                USE IN (loc_cCursorTopo)
            ENDIF
            RETURN .T.
        ENDIF

        SELECT (loc_cCursorTopo)
        GO TOP
        loc_cChave = EmpDNps
        USE IN (loc_cCursorTopo)

        loc_cCursorMvf = THIS.this_cCursorMovimento
        IF USED(loc_cCursorMvf)
            USE IN (loc_cCursorMvf)
        ENDIF

        loc_cSQL = "SELECT Nenvs, Nops, CodPds, Grupods, Contads, Emps, Dopps, Numps " + ;
                   "FROM SigPdMvf WHERE EmpDNps = " + EscaparSQL(loc_cChave) + " " + ;
                   "ORDER BY Nenvs, Nops, CodPds, Grupods, Contads, Emps, Dopps, Numps"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorMvf)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigPdMvf 2)")
            RETURN .F.
        ENDIF

        loc_nTotal = 0
        IF USED(loc_cCursorMvf)
            loc_nTotal = RECCOUNT(loc_cCursorMvf)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aNops[loc_nTotal]
            DIMENSION loc_aNenvs[loc_nTotal]
            DIMENSION loc_aCodPds[loc_nTotal]
            DIMENSION loc_aGrupods[loc_nTotal]
            DIMENSION loc_aContads[loc_nTotal]

            SELECT (loc_cCursorMvf)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aNops[loc_nI]    = Nops
                loc_aNenvs[loc_nI]   = Nenvs
                loc_aCodPds[loc_nI]  = CodPds
                loc_aGrupods[loc_nI] = Grupods
                loc_aContads[loc_nI] = Contads
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorMvf)
            USE IN (loc_cCursorMvf)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            IF !THIS.AppendPicagemPorOp(loc_aNops[loc_nI], loc_aNenvs[loc_nI], ;
                    loc_aCodPds[loc_nI], loc_aGrupods[loc_nI], loc_aContads[loc_nI])
                loc_lSucesso = .F.
                EXIT
            ENDIF
        ENDFOR

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarPorPedido - ramo "Else" (nem Op nem Envelope) do legado:
    * monta a chave posicional EmpDopNums (Emps(3)+Dopes(20)+Numero(6) =
    * 29 = SigOpPic.EmpDopNums char(29) - regra CLAUDE.md #42) e pesquisa
    * a picagem direto por ela.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPorPedido()
        LOCAL loc_cEDN, loc_cCursorPic, loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_aNops[1], loc_aDopes[1], loc_aNumes[1], loc_aQtds[1], loc_nTotal, loc_nI

        loc_lSucesso = .T.

        *-- Chave POSICIONAL - PADR explicito nas DUAS partes de largura
        *-- fixa (nunca ALLTRIM, regra CLAUDE.md #42), independente do
        *-- padding que txt_4c_Pedido.Value tenha trazido.
        loc_cEDN = PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3) + ;
                   PADR(THIS.this_cPedido, 20) + ;
                   STR(THIS.this_nNumero, 6)

        loc_cCursorPic = THIS.this_cCursorPicagem
        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        loc_cSQL = "SELECT Nops, Dopes, Numes, Qtds FROM SigOpPic " + ;
                   "WHERE EmpDopNums = " + EscaparSQL(loc_cEDN)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorPic)

        IF loc_nResultado < 0
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigOpPic)")
            RETURN .F.
        ENDIF

        loc_nTotal = 0
        IF USED(loc_cCursorPic)
            loc_nTotal = RECCOUNT(loc_cCursorPic)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aNops[loc_nTotal]
            DIMENSION loc_aDopes[loc_nTotal]
            DIMENSION loc_aNumes[loc_nTotal]
            DIMENSION loc_aQtds[loc_nTotal]

            SELECT (loc_cCursorPic)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aNops[loc_nI]  = Nops
                loc_aDopes[loc_nI] = Dopes
                loc_aNumes[loc_nI] = Numes
                loc_aQtds[loc_nI]  = Qtds
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            IF !THIS.BuscarTopoPorOp(loc_aNops[loc_nI], loc_aDopes[loc_nI], ;
                    loc_aNumes[loc_nI], loc_aQtds[loc_nI], "3")
                loc_lSucesso = .F.
                EXIT
            ENDIF
        ENDFOR

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarTopoPorOp - equivalente ao "Select Top 1 Nops, Nenvs, CodPds,
    * Grupods, Contads From SigPdMvf Where Nops = ... Order By ... Desc"
    * repetido nos ramos Op e Pedido do legado. par_cContexto reproduz o
    * numero do MessageBox de falha original (crSigPdMvf 1 / 3).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BuscarTopoPorOp(par_nOps, par_cDopes, par_nNumes, par_nQtds, par_cContexto)
        LOCAL loc_cCursorMvf, loc_cSQL, loc_nResultado
        LOCAL loc_nNenvs, loc_cCodPds, loc_cGrupods, loc_cContads

        loc_cCursorMvf = THIS.this_cCursorMovimento

        IF USED(loc_cCursorMvf)
            USE IN (loc_cCursorMvf)
        ENDIF

        loc_cSQL = "SELECT TOP 1 Nops, Nenvs, CodPds, Grupods, Contads " + ;
                   "FROM SigPdMvf " + ;
                   "WHERE Nops = " + FormatarNumeroSQL(par_nOps, 0) + " " + ;
                   "ORDER BY Nops DESC, Nenvs DESC, CodPds DESC, Grupods DESC, Contads DESC"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorMvf)

        IF loc_nResultado < 0 OR !USED(loc_cCursorMvf) OR EOF(loc_cCursorMvf)
            MostrarErro("Favor Reinicializar o Processo!!!", ;
                "Falha na Conex" + CHR(227) + "o (crSigPdMvf " + par_cContexto + ")")
            IF USED(loc_cCursorMvf)
                USE IN (loc_cCursorMvf)
            ENDIF
            RETURN .F.
        ENDIF

        SELECT (loc_cCursorMvf)
        GO TOP
        loc_nNenvs   = Nenvs
        loc_cCodPds  = CodPds
        loc_cGrupods = Grupods
        loc_cContads = Contads

        USE IN (loc_cCursorMvf)

        THIS.AppendResultado(loc_nNenvs, par_nOps, ;
            par_cDopes + STR(par_nNumes, 6), loc_cCodPds, par_nQtds, loc_cGrupods, loc_cContads)

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AppendPicagemPorOp - equivalente ao bloco interno do ramo Envelope do
    * legado: "ThisForm.poDataMgr.CursorQuery('SigOpPic', ..., 'Nops', ...)
    * / Scan / Append Blank" - pesquisa a picagem da Op da linha de
    * SigPdMvf corrente e acrescenta UMA linha de resultado por cada linha
    * de picagem encontrada.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AppendPicagemPorOp(par_nNops, par_nNenvs, par_cCodPds, par_cGrupods, par_cContads)
        LOCAL loc_cCursorPic, loc_cSQL, loc_nResultado
        LOCAL loc_aDopes[1], loc_aNumes[1], loc_aQtds[1], loc_nTotal, loc_nI

        loc_cCursorPic = THIS.this_cCursorPicagem

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        loc_cSQL = "SELECT Dopes, Numes, Qtds FROM SigOpPic WHERE Nops = " + ;
                   FormatarNumeroSQL(par_nNops, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorPic)

        IF loc_nResultado < 0
            IF USED(loc_cCursorPic)
                USE IN (loc_cCursorPic)
            ENDIF
            RETURN .F.
        ENDIF

        loc_nTotal = 0
        IF USED(loc_cCursorPic)
            loc_nTotal = RECCOUNT(loc_cCursorPic)
        ENDIF

        IF loc_nTotal > 0
            DIMENSION loc_aDopes[loc_nTotal]
            DIMENSION loc_aNumes[loc_nTotal]
            DIMENSION loc_aQtds[loc_nTotal]

            SELECT (loc_cCursorPic)
            GO TOP
            FOR loc_nI = 1 TO loc_nTotal
                loc_aDopes[loc_nI] = Dopes
                loc_aNumes[loc_nI] = Numes
                loc_aQtds[loc_nI]  = Qtds
                SKIP
            ENDFOR
        ENDIF

        IF USED(loc_cCursorPic)
            USE IN (loc_cCursorPic)
        ENDIF

        FOR loc_nI = 1 TO loc_nTotal
            THIS.AppendResultado(par_nNenvs, par_nNops, ;
                loc_aDopes[loc_nI] + STR(loc_aNumes[loc_nI], 6), ;
                par_cCodPds, loc_aQtds[loc_nI], par_cGrupods, par_cContads)
        ENDFOR

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AppendResultado - equivalente a "Select DbProduto / Append Blank /
    * Replace ..." do legado. Unico ponto de escrita em
    * this_cCursorResultado, usado pelos tres ramos de Processar().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AppendResultado(par_nNenvs, par_nNops, par_cDopNums, par_cCpros, par_nQtds, par_cGrupods, par_cContads)
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorResultado

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        APPEND BLANK
        REPLACE Nenvs   WITH TratarNulo(par_nNenvs, 0), ;
                Nops    WITH TratarNulo(par_nNops, 0), ;
                DopNums WITH TratarNulo(par_cDopNums, ""), ;
                Cpros   WITH TratarNulo(par_cCpros, ""), ;
                Qtds    WITH TratarNulo(par_nQtds, 0), ;
                Grupods WITH TratarNulo(par_cGrupods, ""), ;
                Contads WITH TratarNulo(par_cContads, "")
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave que identifica a linha corrente do
    * resultado (nao existe PK de tabela gravavel neste dialogo - ver
    * decisao de projeto abaixo). Usa Nops, o mesmo campo definido como
    * this_cCampoChave no Init, igual ao padrao dos demais BOs.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nSelNops)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Decisao de projeto: BO somente-leitura (sem Inserir/Atualizar/Excluir)
    *--------------------------------------------------------------------------
    * O SIGOPCGR legado e um dialogo de PESQUISA (Pesquisa Global de
    * Rastreabilidade): o unico Create Cursor do Init e dbProduto, que e
    * um cursor LOCAL (nunca gravado no SQL Server), e todo Insert
    * Into/Replace do codigo fonte original tem como alvo esse mesmo
    * cursor local. Nao ha TableUpdate nem AddCursor contra tabela remota
    * em lugar nenhum do dump - as unicas chamadas SqlExecute/CursorQuery
    * do Processa()/Init() sao SELECTs de leitura (SigPdMvf, SigOpPic,
    * SigCdOpe). Por isso este BO nao sobrescreve Inserir(), Atualizar()
    * nem ExecutarExclusao(): o comportamento padrao herdado de
    * BusinessBase (recusar a operacao) ja eh o correto para uma tela que
    * so consulta. CarregarDoCursor() acima e o unico ponto de leitura de
    * linha que este BO precisa, pois alimenta a selecao usada por
    * Bot_Rastro.Click; RegistrarAuditoria() herdado de BusinessBase
    * tambem nao e chamado, porque nao ha Inserir/Atualizar/Excluir que o
    * dispare.
    *--------------------------------------------------------------------------

ENDDEFINE


# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarDadosReais': Property CARREGARDADOS is not found. | Detalhes: Linha: 877, Proc: testecarregardadosreais

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-11-17 07:03:20] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-17 07:03:20] [INFO] Config FPW: (nao fornecido)
[2026-11-17 07:03:20] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-17 07:03:20] [INFO] Timeout: 300 segundos
[2026-11-17 07:03:20] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_otneok23.prg
[2026-11-17 07:03:20] [INFO] Conteudo do wrapper:
[2026-11-17 07:03:20] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigopsep', 'C:\4c\tasks\task800', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigopsep', 'C:\4c\tasks\task800', 'OPERACIONAL'
QUIT

[2026-11-17 07:03:21] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_otneok23.prg
[2026-11-17 07:03:21] [INFO] VFP output esperado em: C:\4c\tasks\task800\vfp_output.txt
[2026-11-17 07:03:21] [INFO] Executando Visual FoxPro 9...
[2026-11-17 07:03:21] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_otneok23.prg
[2026-11-17 07:03:21] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_otneok23.prg
[2026-11-17 07:03:21] [INFO] Timeout configurado: 300 segundos
[2026-11-17 07:03:22] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-17 07:03:22] [INFO] VFP9 finalizado em 1.249706 segundos
[2026-11-17 07:03:22] [INFO] Exit Code: 
[2026-11-17 07:03:22] [INFO] 
[2026-11-17 07:03:23] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-17 07:03:23] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_otneok23.prg
[2026-11-17 07:03:23] [INFO] 
[2026-11-17 07:03:23] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-17 07:03:23] [INFO] * Auto-generated wrapper for parameters
[2026-11-17 07:03:23] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-17 07:03:23] [INFO] * Parameters: 'Formsigopsep', 'C:\4c\tasks\task800', 'OPERACIONAL'
[2026-11-17 07:03:23] [INFO] 
[2026-11-17 07:03:23] [INFO] * Anti-dialog protections for unattended execution
[2026-11-17 07:03:23] [INFO] SET SAFETY OFF
[2026-11-17 07:03:23] [INFO] SET RESOURCE OFF
[2026-11-17 07:03:24] [INFO] SET TALK OFF
[2026-11-17 07:03:24] [INFO] SET NOTIFY OFF
[2026-11-17 07:03:24] [INFO] SYS(2335, 0)
[2026-11-17 07:03:24] [INFO] 
[2026-11-17 07:03:24] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigopsep', 'C:\4c\tasks\task800', 'OPERACIONAL'
[2026-11-17 07:03:24] [INFO] QUIT
[2026-11-17 07:03:24] [INFO] 
[2026-11-17 07:03:24] [INFO] === Fim do Wrapper.prg ===
[2026-11-17 07:03:25] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigopsep",
  "timestamp": "20261117070322",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "ContainersFlutuantes",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum container flutuante encontrado (OK)"
    },
    {
      "nome": "CarregarDadosReais",
      "passou": false,
      "erro": "Property CARREGARDADOS is not found.",
      "detalhes": "Linha: 877, Proc: testecarregardadosreais"
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum PageFrame encontrado (form sem paginas)"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnIncluirClick nao encontrado (OK para REPORT/OPERACIONAL)"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnEncerrarClick encontrado"
    },
    {
      "nome": "GridTemDados",
      "passou": true,
      "erro": "",
      "detalhes": "Teste pulado (gb_4c_ValidandoUI = .T., sem conexao ao banco)"
    },
    {
      "nome": "LookupMetodosExistem",
      "passou": true,
      "erro": "",
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 1 (KEYPRESS)"
    },
    {
      "nome": "Fechar",
      "passou": true,
      "erro": "",
      "detalhes": "Formulario fechado com sucesso"
    }
  ],
  "resumo": {
    "total": 9,
    "passou": 8,
    "falhou": 1,
    "percentual": 89
  }
}



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopsep.prg):
*==============================================================================
* Formsigopsep.prg - Selecao de Produtos para Lista de Precos
*
* Legado : SIGOPSEP.SCX (task800)
* Herda  : FormBase
* Tipo   : OPERACIONAL - dialogo FILHO, layout FLAT (sem PageFrame)
*
*------------------------------------------------------------------------------
* FUNCAO DA TELA
*
* Dialogo aberto por um form de Lista de Precos (SIGOPPxx - ParentForm do
* legado). O usuario filtra produtos por Grupo de Venda/Grupo de Produto/
* Moeda de Venda + Linhas marcadas numa grade auxiliar, clica Processar para
* consultar SigCdPro, marca os produtos desejados na grade principal e clica
* "Copia p/ Lista" para devolver os marcados ao cursor de itens do form pai
* (CrSigCdLpi no legado).
*
*------------------------------------------------------------------------------
* CONTRATO COM O FORM PAI (transcrito do legado)
*
*    SIGOPSEP.Init    : LParameters poForm
*                        ThisForm.ParentForm = poForm
*                        (sem ParentForm.Enabled = .F. aqui - diferente de
*                        outros dialogos da familia SIGOPxxx, o legado NAO
*                        desabilita o pai no Init deste form)
*
*    SIGOPSEP.Release : fecha CsSigCdPro/CsSigCdLin, repinta
*                        ParentForm.Pagina.Dados.Grade e faz
*                        ParentForm.Enabled = .T. incondicionalmente
*
*    SIGOPSEP.Sair.Click       : ThisForm.Release()
*    SIGOPSEP.CopiaLista.Click : grava os marcados em CrSigCdLpi (form pai) e
*                                ThisForm.Release()
*
* O repintar da grade do pai e o Enabled=.T. ficam para a fase em que
* Sair/CopiaLista forem religados (eventos - fase 7/8): a estrutura do form
* pai migrado (nomes _4c_) so e conhecida quando o form pai existir, e
* acessar por nome fixo (Pagina.Dados.Grade.Column1) violaria o PILAR 3
* (objetos renomeados). Por ora this_oFormPai so guarda a referencia.
*
*------------------------------------------------------------------------------
* ESCOPO JA ENTREGUE
*
* Fase 1/8 - sigopsepBO.prg: propriedades de filtro + Init.
* Fase 2/8 - sigopsepBO.prg: BuscarLinhas/MarcarTodasLinhas/BuscarProdutos/
*            MarcarTodosProdutos/ObterProdutosParaCopia/LimparCursores.
* Fase 3/8 - estrutura base do Form: DEFINE CLASS + propriedades visuais do
*            dump, Init completo (contexto do pai + BO + InicializarForm),
*            cabecalho cinza (cntSombra -> cnt_4c_Sombra) e Destroy.
*
* Fase 4/8 (ESTA FASE) - as DUAS grades do dialogo e os botoes de acao:
*   - cnt_4c_Filtro (CrtFiltro): campos de filtro + grd_4c_Linhas
*     (GradeLinhas) + cmd_4c_Marcar/cmd_4c_Desmarcar
*   - grd_4c_Itens (GradeItens, direto na Form, 6 colunas)
*   - botoes de acao direto na Form: cmd_4c_Processar, cmd_4c_CopiaLista,
*     cmd_4c_Encerrar (Sair), cmd_4c_MarcaProd, cmd_4c_DesmarcaProd
*   - funis de carga CarregarLinhas()/CarregarDados(), que ligam cada grade
*     ao seu cursor e instalam o CheckBox da coluna de marcacao
*     (InstalarCheckBoxColuna) - replicam o fecho do SIGOPSEP.Init
*
* NAO existe aqui PageFrame nem pagina Lista/Dados: o SCX legado NAO tem
* Page nenhuma (layout FLAT, controles direto na Form) - igual ao padrao ja
* usado em FormSigOpCrd.prg para a mesma familia de dialogos OPERACIONAL.
* Inventar PageFrame Lista/Dados violaria o PILAR 1. Os nomes de metodo
* ConfigurarPageFrame/ConfigurarPaginaLista/ConfigurarPaginaDados seguem o
* CONTRATO do pipeline, mas o conteudo de cada um e o que de fato existe no
* dump:
*
*   ConfigurarPageFrame   -> fundo do form (Picture new_background.jpg)
*   ConfigurarPaginaLista -> cnt_4c_Filtro (CrtFiltro do legado): campos de
*       filtro (Grupo Venda/Produto, Moeda, Acrescimo/Desconto,
*       Arredondamento, Situacao) + grd_4c_Linhas + cmd_4c_Marcar/
*       cmd_4c_Desmarcar
*   ConfigurarPaginaDados -> grd_4c_Itens (GradeItens) + os cinco botoes de
*       acao, todos filhos diretos da Form no dump
*
* mapeamento.json (gerado automaticamente) mapeia GradeLinhas E GradeItens
* para o MESMO nome "grd_4c_Dados" - colisao de gerador (mesma familia de
* bug ja registrada em outras tasks: alvo duplicado no mapeamento auto).
* Por isso os dois grids usam nomes DISTINTOS e explicitos (grd_4c_Linhas /
* grd_4c_Itens), escolhidos manualmente, e os botoes cmdMarcaProd/
* cmdDesmarcaProd (que marcam PRODUTOS) usam cmd_4c_MarcaProd/
* cmd_4c_DesmarcaProd para nao colidir com cmd_4c_Marcar/cmd_4c_Desmarcar
* (que marcam LINHAS, dentro de cnt_4c_Filtro).
*
* Fase 5/8 - FormParaBO()/BOParaForm() dos campos de filtro de cnt_4c_Filtro
*   (Grupo Venda/Produto codigo+descricao, Moeda Venda codigo+descricao,
*   Acrescimo/Desconto, Arredondamento, Situacao), espelhando 1:1 as
*   properties ja existentes em sigopsepBO (Fase 1/8).
*
* Fase 6/8 (ESTA FASE) - os 6 lookups de cnt_4c_Filtro, transcritos de
*   Get_grVenda/Get_DgrVenda (SigCdCol: colecoes/descs),
*   Get_grProduto/Get_DgrProduto (SigCdGrp: cgrus/dgrus) e
*   Get_moevenda/Get_Dmoevenda (SigCdMoe: cmoes/dmoes) - cada par nos DOIS
*   sentidos, via FormBuscaAuxiliar (NAO fwBuscaExt: padrao canonico do
*   projeto). O campo de descricao deixou de ser ReadOnly (Fase 4/5 tinha
*   essa suposicao errada - o legado o deixa editavel, com mutua exclusao
*   via When: so recebe foco quando o campo de codigo irmao esta vazio).
*   Validacao em LostFocus, nunca KeyPress (regra #47); guarda de
*   reentrancia this_lEmLookup compartilhada entre os 3 pares (picker eh
*   modal e tira o foco, regra #37). Tambem entrou aqui o InteractiveChange
*   dos 6 campos (FiltroAlterado), que desabilita CopiaLista - mesma
*   propriedade de UMA linha so, repetida no dump nos DOIS lados de cada
*   par (codigo E descricao, nao so o codigo - corrigido na Fase 8/8,
*   faltavam os 3 campos de descricao).
*
* Fase 7/8 (ESTA FASE) - os eventos restantes:
*   - cmd_4c_Marcar/cmd_4c_Desmarcar.Click -> BO.MarcarTodasLinhas(1/0) +
*     Refresh de grd_4c_Linhas (Marcar/Desmarcar do legado)
*   - cmd_4c_MarcaProd/cmd_4c_DesmarcaProd.Click -> BO.MarcarTodosProdutos
*     (1/0) + Refresh de grd_4c_Itens (cmdMarcaProd/cmdDesmarcaProd)
*   - chk_4c_MarcaProduto.When -> so edita a celula quando
*     cursor_4c_Produtos.lMarcas = 0 (GradeItens.Column1.Check1.When do
*     legado, literal)
*   - cmd_4c_Processar.Click -> FormParaBO() + BO.BuscarProdutos(""),
*     religa grd_4c_Itens (ReligarGradeItens, novo - fatorado de
*     CarregarDados porque o BO recria o alias e a grade precisa ser
*     religada nas DUAS situacoes) e replica o aviso "Nao existem
*     produtos.../habilita CopiaLista" do fim do Processar.Click legado
*   - cmd_4c_CopiaLista.Click -> FormParaBO() + BO.ObterProdutosParaCopia
*     ("") preenche cursor_4c_ProdutosCopia (cpros/dpros/pvens/pliqs/moevs)
*     com os candidatos (flagctabs=1 AND lMarcas=0, filtrados por
*     Situacao) - EXATAMENTE o SCAN do CopiaLista.Click legado, so sem a
*     parte que pertence ao form PAI (abaixo)
*   - cmd_4c_Encerrar Click -> THIS.Release() (literal)
*
* O QUE CONTINUA DEFERIDO (documentado desde a Fase 3, linhas 35-39): a
* gravacao real em CrSigCdLpi - Delete From CrSigCdLpi Where Empty(cpros),
* cidchaves via fUniqueIds(), lprecos do cabecalho CrSigCdLpc, flagutabs,
* vencis/vencfs, e o arredondamento condicional via fArredondamento
* (NAO portada - this_oFormPai so guarda a referencia, gnConnHandle. PILAR
* 3 impede acessar objeto do pai por nome fixo (Pagina.Dados.Grade), e
* nenhum form SIGOPPxx desta familia foi migrado ainda para expor um
* CONTRATO conhecido. BtnCopiaListaClick entrega o cursor ja filtrado
* (cursor_4c_ProdutosCopia) ao pai atraves de um metodo PUBLIC opcional
* (AdicionarProdutosSelecionados), chamado de forma DEFENSIVA via
* PEMSTATUS - o mesmo padrao ja usado em ReabilitarFormPai/RepintarFormPai
* (e em FormSigOpCrd.LerTextoDoPai) para nunca estourar enquanto o pai nao
* existir. BtnProcessarClick passa par_cCursorListaPrecos = "" pelo mesmo
* motivo (equivalente a "lista ainda vazia" no legado).
*
*------------------------------------------------------------------------------
* Fase 8/8 (ESTA FASE) - consolidacao final.
*
* O prompt generico de Fase 8 pede BtnBuscarClick/BtnSalvarClick/
* BtnCancelarClick/HabilitarCampos/LimparCampos/CarregarLista/
* AjustarBotoesPorModo - vocabulario do padrao CRUD (frmcadastro, paginas
* Lista/Dados, modos INCLUIR/ALTERAR/VISUALIZAR). Este dialogo NAO tem
* nenhum desses conceitos no legado (confirmado em comportamento.json: 26
* metodos, nenhum Buscar/Salvar/Cancelar, nenhuma nocao de modo) - os
* botoes reais sao Processar/Copia p/ Lista/Encerrar/Marcar/Desmarcar/
* MarcaProd/DesmarcaProd, TODOS ja ligados nas Fases 4 e 7. Inventar esses
* metodos so para satisfazer o nome do template violaria o PILAR 1 (UI e
* comportamento inexistentes no legado) e a regra de NUNCA criar stub.
*
* Verificacao final contra comportamento.json (26/26 metodos) encontrou UM
* gap real: Get_DgrVenda/Get_DgrProduto/Get_Dmoevenda (os 3 campos de
* DESCRICAO) tambem tem InteractiveChange -> "ThisForm.CopiaLista.Enabled =
* .F." no dump (SIGOPSEP.CrtFiltro.Get_DgrVenda etc, linhas ~1239/1289/1333
* do dump) - a Fase 6/8 so tinha ligado os 3 campos de CODIGO. Os 3
* BINDEVENT faltantes foram adicionados em ConfigurarPaginaLista, reusando
* o mesmo handler FiltroAlterado (PILAR 3: 1 metodo so, igual ao dump que
* repete a MESMA linha 6 vezes).
*
* PROCEDURE Load do legado ("=fConfigGeral()") NAO PORTADO, pelo mesmo
* motivo ja registrado em FormSigMvExp.prg/FormSigMvMen.prg e nos demais
* BOs da familia SigOp*: fConfigGeral era funcao GLOBAL de inicializacao da
* aplicacao Fortyus (sig.prg/SIGFUNCS.PRG), ausente do acervo; o wrapper
* utils\fconfiggeral.prg (RETURN .T.) existe so para o p-code de VCX
* legado que ainda a invoca, nunca para ser chamado por codigo novo. O que
* fConfigGeral fazia (SETs, paths, aliases, conexao) ja ocorre antes deste
* dialogo abrir, em config.prg/main.prg.
*==============================================================================

DEFINE CLASS Formsigopsep AS FormBase

    *==========================================================================
    * PROPRIEDADES VISUAIS - PILAR 1: transcritas do dump do SCX
    *
    * Declaradas no dump de SIGOPSEP: BorderStyle = 2, Height = 600,
    * Width = 800, ControlBox = .F., MaxButton = .F., MinButton = .F.,
    * TitleBar = 0, Caption = "Seleciona Produtos".
    *
    * NAO declaradas no dump e portanto NAO inventadas (regra #25): Closable
    * fica no default .T. - sem barra de titulo ele nao desenha, mas
    * Closable = .F. mataria o Alt+F4 (nao ha botao Encerrar visivel ate a
    * fase 5, e mesmo depois o legado nao declara Closable).
    *
    * DoCreate = .T. do dump NAO entra: flag de design-time do SCX, nao
    * property de runtime (regra #33).
    *
    * WindowType / ShowWindow NAO vem do SCX (legado abria com "Do Form"):
    * canonico do projeto e 1 (modal), igual a FormSigOpCrd - o form e
    * criado com CREATEOBJECT + Show().
    *==========================================================================
    this_cMensagemErro = ""
    BorderStyle  = 2
    Height       = 600
    Width        = 800
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    WindowType   = 1
    ShowWindow   = 1
    AutoCenter   = .T.
    Caption      = "Seleciona Produtos"

    *==========================================================================
    * PROPRIEDADES DE ESTADO
    *==========================================================================
    this_oBusinessObject = .NULL.

    *-- Form PAI (ParentForm do legado). O legado NAO desabilita o pai no
    *-- Init (diferente de SigOpCrd) - por isso nao ha flag
    *-- this_lPaiDesabilitado aqui; o Destroy ainda reabilita o pai de forma
    *-- defensiva (PEMSTATUS) para nunca deixa-lo travado, mesmo que o
    *-- caller venha a desabilita-lo por fora no futuro.
    this_oFormPai = .NULL.

    *-- Guarda de reentrancia dos 6 lookups de cnt_4c_Filtro: o picker
    *-- (FormBuscaAuxiliar) eh MODAL e tira o foco do campo, o que redispara
    *-- o proprio LostFocus (regra #37). Compartilhada entre os 3 pares
    *-- codigo/descricao, igual ao padrao de FormCco.
    this_lEmLookup = .F.

    *-- Guarda "valor nao mudou" (Problema 45, complementar a this_lEmLookup
    *-- acima - regra #47): o Valid do legado so dispara quando o valor
    *-- MUDA, mas LostFocus dispara SEMPRE que o campo perde o foco. Sem
    *-- isso, sair do campo sem digitar nada reabre o picker a cada Tab.
    *-- Uma property por handler (nao compartilhada, cada campo tem o seu
    *-- ultimo valor validado). .NULL. de proposito (nao ""): o PRIMEIRO
    *-- LostFocus tem de validar mesmo que o campo esteja vazio.
    this_cUltimoValidarGrVendaValidado = .NULL.
    this_cUltimoValidarDgrVendaValidado = .NULL.
    this_cUltimoValidarGrProdutoValidado = .NULL.
    this_cUltimoValidarDgrProdutoValidado = .NULL.
    this_cUltimoValidarMoeVendaValidado = .NULL.
    this_cUltimoValidarDmoeVendaValidado = .NULL.


    *==========================================================================
    * Init - recebe o contexto do form PAI
    *
    * A ORDEM aqui e regra, nao estilo: FormBase.Init() chama
    * InicializarForm(), logo o contexto vindo por parametro tem de estar
    * guardado ANTES do DODEFAULT().
    *
    * par_oFormPai - form que abriu o dialogo (ParentForm do legado)
    *==========================================================================
    PROCEDURE Init(par_oFormPai)
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        RETURN DODEFAULT()
    ENDPROC


    *==========================================================================
    * InicializarForm - monta a estrutura base do dialogo
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigopsepBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Fundo do form (new_background.jpg do dump)
                THIS.ConfigurarPageFrame()

                *-- Cabecalho cinza (cntSombra do legado) - PRIMEIRO AddObject,
                *-- para os controles das fases seguintes desenharem por cima
                *-- (regra #11)
                THIS.ConfigurarCabecalho()

                *-- Fase 4: filtros + grade de LINHAS (ConfigurarPaginaLista)
                *-- e grade de PRODUTOS + botoes de acao (ConfigurarPaginaDados)
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- AddObject cria tudo com Visible = .F.
                THIS.TornarControlesVisiveis()

                *-- Replica o fecho do SIGOPSEP.Init: popula CsSigCdLin
                *-- (cursor_4c_Linhas), cria CsSigCdPro (cursor_4c_Produtos)
                *-- vazio e liga as DUAS grades. Entra so aqui, depois de
                *-- TornarControlesVisiveis, porque RecordSource/ControlSource
                *-- exigem o cursor ja criado (regra #41) e o CheckBox das
                *-- colunas de marcacao exige o bind feito (ver CarregarLinhas).
                *-- As duas cargas sao independentes: a falha da primeira nao
                *-- deve mascarar o resultado da segunda, por isso o AND vem
                *-- depois das duas chamadas, nao em curto-circuito.
                loc_lSucesso = THIS.CarregarLinhas()
                loc_lSucesso = THIS.CarregarDados() AND loc_lSucesso
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                        "vel criar o objeto de neg" + CHR(243) + "cio sigopsepBO.", ;
                        "Erro ao Inicializar")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar Formsigopsep")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * ConfigurarPageFrame - aparencia base do form
    *
    * O nome e o do contrato do pipeline; NAO ha PageFrame a criar porque o
    * SCX legado nao tem Page nenhuma (layout FLAT - ver cabecalho). Picture
    * do dump: ..\framework\imagens\new_background.jpg - o caminho NUNCA se
    * reconstroi a partir de gc_4c_CaminhoBase (regra #156/#170); o arquivo
    * existe tanto em vbmp\ quanto em Framework\imagens\, e o canonico do
    * projeto e gc_4c_CaminhoIcones.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.ScrollBars = 0

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado)
    *
    * Dump: cntSombra Top=0 Left=0 Width=800 Height=80 BackColor=100,100,100
    *       lblSombra Top=18 Height=40 Left=10 Width=769 ForeColor=0,0,0
    *       lblTitulo Top=17 Height=46 Left=10 Width=769 ForeColor=255,255,255
    *       ambos Tahoma 18 bold, BackStyle=0, Alignment=0, WordWrap=.T.
    *
    * As larguras 800/769 do dump batem com o Width do form (800), entao nao
    * ha o artefato do Form Designer visto em outros dumps (container maior
    * que o form) - mesmo assim o container e os labels acompanham
    * THIS.Width, nunca o literal, para nao quebrar se o Width mudar.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .BackStyle     = 1
            .BackColor     = RGB(100, 100, 100)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label de sombra: preto, 1px acima do titulo (efeito de relevo)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
            *-- AutoSize = .F. explicito: AutoSize e NO-OP em Label criado
            *-- por AddObject e, com WordWrap = .T., DESCARTA a Height e
            *-- corta o texto (regra #23).
            .AutoSize      = .F.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Top           = 18
            .Left          = 10
            .Width         = THIS.Width - 20
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label do titulo: branco sobre o cinza do container OPACO - este
        *-- e o caso em que o branco esta CORRETO (regra #12)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
            .AutoSize    = .F.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = THIS.Caption
            .Top         = 17
            .Left        = 10
            .Width       = THIS.Width - 20
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ConfigurarPaginaLista - cnt_4c_Filtro (CrtFiltro do legado)
    *
    * Dump: CrtFiltro Top=130 Left=62 Width=656 Height=182, BackStyle=0,
    * BorderWidth=0, SpecialEffect=2 (3D).
    *
    * Contem os campos de filtro (Grupo Venda/Produto, Moeda Venda,
    * Acrescimo/Desconto, Arredondamento, Situacao), a grade de Linhas
    * (GradeLinhas -> grd_4c_Linhas, 3 colunas: check/codigo/descricao) e
    * os botoes Marcar/Desmarcar (fwbtnp do legado).
    *
    * Os campos de DESCRICAO (txt_4c_DgrVenda/DgrProduto/DmoeVenda) sao
    * ReadOnly - no legado sao preenchidos pelo lookup fwBuscaExt do campo
    * de codigo correspondente (fase 6/8, ainda nao ligado aqui).
    *
    * Labels (Say1..Say7): dump NAO declara ForeColor/Width/Alignment
    * (classe "say" pura) - canonico RGB(90,90,90) + Alignment=0 + Width
    * explicita que caiba o texto (regra #23/#12). AutoSize=.T. NAO entra:
    * eh no-op em Label criado por AddObject.
    *
    * obj_4c_Situacao (Opc_situacao): OptionGroup com ControlSource
    * NUMERICO - Value = INDICE do botao (1=Ativos, 2=Inativos, 3=Todos),
    * NUNCA 0/1 (regra #45/#188). Legenda/ordem/Top de cada botao
    * transcritos do dump, nunca inventados.
    *
    * grd_4c_Linhas: estrutura so (ColumnCount, fontes, larguras, headers);
    * ControlSource e RecordSource ficam para CarregarLinhas(), chamado
    * depois de TornarControlesVisiveis() em InicializarForm - atribuir
    * ControlSource contra cursor_4c_Linhas aqui derrubaria o Init, porque
    * o cursor ainda nao existe (regra #41).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.AddObject("cnt_4c_Filtro", "Container")
        WITH THIS.cnt_4c_Filtro
            .Top           = 130
            .Left          = 62
            .Width         = 656
            .Height        = 182
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 2
            .Visible       = .T.
        ENDWITH

        *-- Labels (Say1..Say7 do legado)
        THIS.cnt_4c_Filtro.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.cnt_4c_Filtro.lbl_4c_Label1
            .Caption   = "Grupo Venda :"
            .Top       = 9
            .Left      = 36
            .Width     = 69
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Filtro.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.cnt_4c_Filtro.lbl_4c_Label2
            .Caption   = "Moeda Venda :"
            .Top       = 57
            .Left      = 33
            .Width     = 72
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Filtro.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.cnt_4c_Filtro.lbl_4c_Label3
            .Caption   = "Acr" + CHR(233) + "scimos/Descontos :"
            .Top       = 57
            .Left      = 385
            .Width     = 114
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Filtro.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.cnt_4c_Filtro.lbl_4c_Label4
            .Caption   = "Arredondamento :"
            .Top       = 33
            .Left      = 432
            .Width     = 88
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Filtro.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.cnt_4c_Filtro.lbl_4c_Label5
            .Caption   = "%"
            .Top       = 57
            .Left      = 545
            .Width     = 20
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Filtro.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.cnt_4c_Filtro.lbl_4c_Label6
            .Caption   = "Linhas :"
            .Top       = 80
            .Left      = 68
            .Width     = 37
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Filtro.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.cnt_4c_Filtro.lbl_4c_Label7
            .Caption   = "Grupo Produtos :"
            .Top       = 33
            .Left      = 23
            .Width     = 82
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Grupo de Venda: codigo + descricao, lookup SigCdCol (colecoes/descs)
        *-- em ambos os sentidos - igual ao legado (Get_grVenda.Valid /
        *-- Get_DgrVenda.Valid+When)
        THIS.cnt_4c_Filtro.AddObject("txt_4c_GrVenda", "TextBox")
        WITH THIS.cnt_4c_Filtro.txt_4c_GrVenda
            .Top       = 6
            .Left      = 109
            .Width     = 80
            .MaxLength = 10
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 1
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_GrVenda, "LostFocus", THIS, "ValidarGrVenda")
        BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_GrVenda, "InteractiveChange", THIS, "FiltroAlterado")

        *-- Get_DgrVenda do legado NAO eh ReadOnly: o When so permite foco
        *-- quando txt_4c_GrVenda esta vazio (mutua exclusao), e o Valid faz o
        *-- lookup reverso por descricao (colecoes.descs)
        THIS.cnt_4c_Filtro.AddObject("txt_4c_DgrVenda", "TextBox")
        WITH THIS.cnt_4c_Filtro.txt_4c_DgrVenda
            .Top       = 6
            .Left      = 189
            .Width     = 366
            .Height    = 23
            .MaxLength = 40
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 2
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DgrVenda, "When",      THIS, "DgrVendaWhenCheck")
        BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DgrVenda, "LostFocus", THIS, "ValidarDgrVenda")
        BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DgrVenda, "InteractiveChange", THIS, "FiltroAlterado")

        *-- Grupo de Produto: codigo + descricao, lookup SigCdGrp (cgrus/dgrus)
        THIS.cnt_4c_Filtro.AddObject("txt_4c_GrProduto", "TextBox")
        WITH THIS.cnt_4c_Filtro.txt_4c_GrProduto
            .Top       = 30
            .Left      = 109
            .Width     = 31
            .MaxLength = 3
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 3
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_GrProduto, "LostFocus", THIS, "ValidarGrProduto")
        BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_GrProduto, "InteractiveChange", THIS, "FiltroAlterado")

        THIS.cnt_4c_Filtro.AddObject("txt_4c_DgrProduto", "TextBox")
        WITH THIS.cnt_4c_Filtro.txt_4c_DgrProduto
            .Top       = 30
            .Left      = 140
            .Width     = 150
            .MaxLength = 20
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 4
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DgrProduto, "When",      THIS, "DgrProdutoWhenCheck")
        BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DgrProduto, "LostFocus", THIS, "ValidarDgrProduto")
        BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DgrProduto, "InteractiveChange", THIS, "FiltroAlterado")

        *-- Arredondamento (InputMask "9.9" do dump - regra #49)
        THIS.cnt_4c_Filtro.AddObject("txt_4c_Arrend", "TextBox")
        WITH THIS.cnt_4c_Filtro.txt_4c_Arrend
            .Top       = 30
            .Left      = 524
            .Width     = 31
            .MaxLength = 3
            .InputMask = "9.9"
            .TabIndex  = 5
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Moeda de Venda: codigo + descricao, lookup SigCdMoe (cmoes/dmoes)
        THIS.cnt_4c_Filtro.AddObject("txt_4c_MoeVenda", "TextBox")
        WITH THIS.cnt_4c_Filtro.txt_4c_MoeVenda
            .Top       = 54
            .Left      = 109
            .Width     = 31
            .MaxLength = 3
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 6
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_MoeVenda, "LostFocus", THIS, "ValidarMoeVenda")
        BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_MoeVenda, "InteractiveChange", THIS, "FiltroAlterado")

        THIS.cnt_4c_Filtro.AddObject("txt_4c_DmoeVenda", "TextBox")
        WITH THIS.cnt_4c_Filtro.txt_4c_DmoeVenda
            .Top       = 54
            .Left      = 140
            .Width     = 115
            .MaxLength = 15
            .ForeColor = RGB(0, 0, 0)
            .TabIndex  = 7
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda, "When",      THIS, "DmoeVendaWhenCheck")
        BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda, "LostFocus", THIS, "ValidarDmoeVenda")
        BINDEVENT(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda, "InteractiveChange", THIS, "FiltroAlterado")

        *-- Acrescimo/Desconto percentual (InputMask "9999" do dump)
        THIS.cnt_4c_Filtro.AddObject("txt_4c_AcreDesc", "TextBox")
        WITH THIS.cnt_4c_Filtro.txt_4c_AcreDesc
            .Top       = 54
            .Left      = 503
            .Width     = 38
            .MaxLength = 4
            .InputMask = "9999"
            .TabIndex  = 8
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Situacao (Opc_situacao do legado) - Value = indice do botao
        *-- (1=Ativos, 2=Inativos, 3=Todos), transcrito do dump
        THIS.cnt_4c_Filtro.AddObject("obj_4c_Situacao", "OptionGroup")
        WITH THIS.cnt_4c_Filtro.obj_4c_Situacao
            .Top         = 6
            .Left        = 569
            .Width       = 79
            .Height      = 69
            .ButtonCount = 3
            .BackStyle   = 0
            .TabIndex    = 9
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .FontName  = "Tahoma"
                .Caption   = "\<Ativos"
                .Left      = 10
                .Top       = 5
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Tahoma"
                .Caption   = "\<Inativos"
                .Left      = 10
                .Top       = 26
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "\<Todos"
                .Height    = 15
                .Left      = 10
                .Top       = 47
                .Width     = 47
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Grade de Linhas (GradeLinhas do legado) - estrutura (ColumnCount,
        *-- fontes, larguras, headers); RecordSource/ControlSource entram em
        *-- CarregarLinhas() (regra #41). HeaderHeight=0 e fiel ao dump (o
        *-- legado esconde a linha de header desta grade).
        THIS.cnt_4c_Filtro.AddObject("grd_4c_Linhas", "Grid")
        WITH THIS.cnt_4c_Filtro.grd_4c_Linhas
            .Top          = 79
            .Left         = 109
            .Width        = 454
            .Height       = 94
            .ColumnCount  = 3
            .FontName     = "Courier New"
            .HeaderHeight = 0
            .ReadOnly     = .F.
            .RecordMark   = .F.
            .DeleteMark   = .F.
            .TabIndex     = 10
            .Visible      = .T.

            .Column1.FontName          = "Courier New"
            .Column1.Width             = 20
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.ReadOnly          = .F.
            .Column1.Sparse            = .F.
            .Column1.Visible           = .T.
            .Column1.Header1.Caption   = ""
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8

            .Column2.FontName          = "Courier New"
            .Column2.FontSize          = 9
            .Column2.Width             = 120
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.ReadOnly          = .T.
            .Column2.Visible           = .T.
            .Column2.Header1.Caption   = "C" + CHR(243) + "digo"
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2

            .Column3.FontName          = "Courier New"
            .Column3.FontSize          = 9
            .Column3.Width             = 290
            .Column3.Movable           = .F.
            .Column3.Resizable         = .F.
            .Column3.ReadOnly          = .T.
            .Column3.Visible           = .T.
            .Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto"
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.FontSize  = 8
            .Column3.Header1.Alignment = 2
        ENDWITH

        *-- Botoes Marcar/Desmarcar das LINHAS (fwbtnp do legado). O dump
        *-- declara so Top/Left/Picture/Caption/ToolTipText: Width/Height vem
        *-- da classe fwbtnp (40x40), nao se inventa numero novo (regra #30).
        *-- O Click (Replace All lMarcas... + Refresh, ja replicado em
        *-- sigopsepBO.MarcarTodasLinhas) e ligado na fase de eventos.
        THIS.cnt_4c_Filtro.AddObject("cmd_4c_Marcar", "CommandButton")
        WITH THIS.cnt_4c_Filtro.cmd_4c_Marcar
            .Top             = 88
            .Left            = 573
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
            .DisabledPicture = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .MousePointer    = 15
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .ToolTipText     = "Marca Todas as Linhas de Produto"
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Filtro.cmd_4c_Marcar, "Click", THIS, "BtnMarcarClick")

        THIS.cnt_4c_Filtro.AddObject("cmd_4c_Desmarcar", "CommandButton")
        WITH THIS.cnt_4c_Filtro.cmd_4c_Desmarcar
            .Top             = 128
            .Left            = 573
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "onebit_33.ico"
            .DisabledPicture = gc_4c_CaminhoIcones + "onebit_33.ico"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .MousePointer    = 15
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .ToolTipText     = "Desmarca Todas as Linhas de Produto"
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Filtro.cmd_4c_Desmarcar, "Click", THIS, "BtnDesmarcarClick")

        RETURN .T.
    ENDPROC


    *==========================================================================
    * CarregarLinhas - FUNIL de carga da grade de Linhas (GradeLinhas)
    *
    * Replica o trecho do SIGOPSEP.Init que popula CsSigCdLin e liga a grade.
    * A ORDEM aqui e regra medida, nao estilo:
    *   RecordSource -> ControlSource de TODAS as colunas -> Column.AddObject
    *   do CheckBox + .Value = 0 -> Sparse = .F. + CurrentControl -> Width /
    *   Header1.Caption.
    * Motivos: (a) atribuir ControlSource antes do cursor existir estoura
    * "Alias not found" dentro do TRY do InicializarForm e a tela nao abre
    * (regra #41); (b) Grid sem RecordSource AUTO-BINDA na area de trabalho
    * CORRENTE quando o ColumnCount e definido, e um AddObject de CheckBox
    * sobre coluna de texto estoura "Data type mismatch" - por isso o CheckBox
    * e instalado AQUI, depois do bind, e nao em ConfigurarPaginaLista;
    * (c) BuscarLinhas faz USE IN no alias, o que DESTROI o controle posto por
    * Column.AddObject (CurrentControl volta a "Text1") preservando
    * ColumnCount/Width/Header - perda PARCIAL e silenciosa, por isso a
    * instalacao e reentrante; (d) RecordSource reseta Width/Header1.Caption
    * para o default (Problema 48), que tem de ser reaplicados DEPOIS do bind.
    *==========================================================================
    PROTECTED PROCEDURE CarregarLinhas()
        LOCAL loc_oGrid

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF !THIS.this_oBusinessObject.BuscarLinhas()
            MsgErro("Favor reinicializar o processo." + CHR(13) + ;
                    NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""), ;
                    "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_oGrid = THIS.cnt_4c_Filtro.grd_4c_Linhas

        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount = 3
        loc_oGrid.RecordSource = "cursor_4c_Linhas"
        loc_oGrid.Column1.ControlSource = "cursor_4c_Linhas.lMarcas"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Linhas.linhas"
        loc_oGrid.Column3.ControlSource = "cursor_4c_Linhas.descs"

        *-- Column1.Check1 do dump: a coluna de marcacao das Linhas
        THIS.InstalarCheckBoxColuna(loc_oGrid.Column1, "chk_4c_MarcaLinha")

        *-- A fonte do GRID vai ANTES dos cabecalhos: medido no VFP9 em
        *-- 2026-11-17, atribuir Grid.FontName/FontSize PROPAGA para
        *-- Column.FontName E para Column.Header1.FontName, sobrescrevendo o
        *-- Tahoma 8 que o dump declara por Header1 (ficava Courier New 9).
        THIS.FormatarGridLista(loc_oGrid)

        *-- RecordSource reseta Width/Header1.Caption para o default, e a
        *-- fonte do grid acabou de achatar o Header1 - reaplicar os dois
        *-- (Problema 48). Header1: Tahoma 8 em todas, Alignment 2 nas de
        *-- texto, como no dump de GradeLinhas.
        THIS.AplicarCabecalhoColuna(loc_oGrid.Column1,  20, "", 0, -1)
        THIS.AplicarCabecalhoColuna(loc_oGrid.Column2, 120, ;
            "C" + CHR(243) + "digo", 2, -1)
        THIS.AplicarCabecalhoColuna(loc_oGrid.Column3, 290, ;
            "Descri" + CHR(231) + CHR(227) + "o do Produto", 2, -1)

        SELECT cursor_4c_Linhas
        GO TOP
        loc_oGrid.Refresh()

        RETURN .T.
    ENDPROC


    *==========================================================================
    * FiltroAlterado - InteractiveChange dos 6 campos de cnt_4c_Filtro (os 3
    * pares codigo/descricao: GrVenda/DgrVenda, GrProduto/DgrProduto,
    * MoeVenda/DmoeVenda). Legado: as SEIS propriedades InteractiveChange do
    * SCX fazem so "ThisForm.CopiaLista.Enabled = .F." - qualquer alteracao
    * no filtro, pelo codigo OU pela descricao, invalida a selecao de
    * produtos ja feita.
    *==========================================================================
    PROCEDURE FiltroAlterado()
        THIS.cmd_4c_CopiaLista.Enabled = .F.
    ENDPROC


    *==========================================================================
    * Lookups de cnt_4c_Filtro (fase 6/8) - 3 pares codigo/descricao, cada um
    * nos DOIS sentidos, transcritos de Get_grVenda/Get_DgrVenda,
    * Get_grProduto/Get_DgrProduto e Get_moevenda/Get_Dmoevenda.
    *
    * Padrao (igual nos 3 pares):
    *   - campo CODIGO: Valid do legado sem When - sempre editavel. Vazio
    *     limpa so a descricao (This.Parent.Get_DX.Value = ''); preenchido,
    *     faz SEEK exato e abre o picker so se nao achou (contrato
    *     this_lAchouRegistro - regra #37); ESC/cancelamento LIMPA os DOIS
    *     campos (LastKey()<>27 And Used(...) no legado) - diferente da
    *     regra #50 (que veda apagar o digitado quando NAO ha picker): aqui
    *     o picker SEMPRE abre antes de limpar, e o proprio legado manda
    *     limpar no cancelamento.
    *   - campo DESCRICAO: so recebe foco quando o campo CODIGO irmao esta
    *     vazio (When = Return(Empty(Parent.Get_X.Value)), mutua exclusao -
    *     BINDEVENT "When" compartilha o retorno com o nativo). Mesmo
    *     contrato do lookup, buscando pela coluna de DESCRICAO.
    *
    * Guarda this_lEmLookup: o picker eh MODAL e tira o foco do campo, o que
    * redispara o proprio LostFocus (regra #37) - compartilhada entre os 3
    * pares, igual ao padrao de FormCco.
    *==========================================================================

    *--------------------------------------------------------------------------
    * Par 1: Grupo de Venda <-> Descricao (SigCdCol: colecoes/descs)
    *--------------------------------------------------------------------------
    PROCEDURE DgrVendaWhenCheck()
        RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value))
    ENDPROC

    PROCEDURE ValidarGrVenda()
        LOCAL loc_cValor

        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value)

        IF VARTYPE(THIS.this_cUltimoValidarGrVendaValidado) == "C" AND ;
                loc_cValor == THIS.this_cUltimoValidarGrVendaValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cValor)
            THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value = ""
        ELSE
            THIS.AbrirBuscaGrVenda()
        ENDIF

        THIS.this_cUltimoValidarGrVendaValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value)
    ENDPROC

    PROCEDURE ValidarDgrVenda()
        LOCAL loc_cValor

        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value)

        IF VARTYPE(THIS.this_cUltimoValidarDgrVendaValidado) == "C" AND ;
                loc_cValor == THIS.this_cUltimoValidarDgrVendaValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cValor)
            THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value = ""
        ELSE
            THIS.AbrirBuscaDgrVenda()
        ENDIF

        THIS.this_cUltimoValidarDgrVendaValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value)
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaGrVenda()
        LOCAL loc_oBusca, loc_cValor, loc_oErro

        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value)

        THIS.this_lEmLookup = .T.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCol", "cursor_4c_BuscaColecoes", "colecoes", loc_cValor, ;
                "Cole" + CHR(231) + CHR(245) + "es")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("colecoes", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaColecoes")
                    THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value  = ALLTRIM(cursor_4c_BuscaColecoes.colecoes)
                    THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value = ALLTRIM(cursor_4c_BuscaColecoes.descs)
                ELSE
                    THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value  = ""
                    THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formsigopsep.AbrirBuscaGrVenda: " + loc_oErro.Message, "Erro")
        ENDTRY
        THIS.this_lEmLookup = .F.

        IF USED("cursor_4c_BuscaColecoes")
            USE IN cursor_4c_BuscaColecoes
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaDgrVenda()
        LOCAL loc_oBusca, loc_cValor, loc_oErro

        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value)

        THIS.this_lEmLookup = .T.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCol", "cursor_4c_BuscaColecoes", "descs", loc_cValor, ;
                "Cole" + CHR(231) + CHR(245) + "es")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("colecoes", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaColecoes")
                    THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value = ALLTRIM(cursor_4c_BuscaColecoes.descs)
                    THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value  = ALLTRIM(cursor_4c_BuscaColecoes.colecoes)
                ELSE
                    THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value = ""
                    THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value  = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formsigopsep.AbrirBuscaDgrVenda: " + loc_oErro.Message, "Erro")
        ENDTRY
        THIS.this_lEmLookup = .F.

        IF USED("cursor_4c_BuscaColecoes")
            USE IN cursor_4c_BuscaColecoes
        ENDIF
    ENDPROC


    *--------------------------------------------------------------------------
    * Par 2: Grupo de Produto <-> Descricao (SigCdGrp: cgrus/dgrus)
    *--------------------------------------------------------------------------
    PROCEDURE DgrProdutoWhenCheck()
        RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value))
    ENDPROC

    PROCEDURE ValidarGrProduto()
        LOCAL loc_cValor

        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value)

        IF VARTYPE(THIS.this_cUltimoValidarGrProdutoValidado) == "C" AND ;
                loc_cValor == THIS.this_cUltimoValidarGrProdutoValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cValor)
            THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = ""
        ELSE
            THIS.AbrirBuscaGrProduto()
        ENDIF

        THIS.this_cUltimoValidarGrProdutoValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value)
    ENDPROC

    PROCEDURE ValidarDgrProduto()
        LOCAL loc_cValor

        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value)

        IF VARTYPE(THIS.this_cUltimoValidarDgrProdutoValidado) == "C" AND ;
                loc_cValor == THIS.this_cUltimoValidarDgrProdutoValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cValor)
            THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value = ""
        ELSE
            THIS.AbrirBuscaDgrProduto()
        ENDIF

        THIS.this_cUltimoValidarDgrProdutoValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value)
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaGrProduto()
        LOCAL loc_oBusca, loc_cValor, loc_oErro

        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value)

        THIS.this_lEmLookup = .T.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGrupos", "cgrus", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cgrus", "XXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupos")
                    THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value  = ALLTRIM(cursor_4c_BuscaGrupos.cgrus)
                    THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = ALLTRIM(cursor_4c_BuscaGrupos.dgrus)
                ELSE
                    THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value  = ""
                    THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formsigopsep.AbrirBuscaGrProduto: " + loc_oErro.Message, "Erro")
        ENDTRY
        THIS.this_lEmLookup = .F.

        IF USED("cursor_4c_BuscaGrupos")
            USE IN cursor_4c_BuscaGrupos
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaDgrProduto()
        LOCAL loc_oBusca, loc_cValor, loc_oErro

        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value)

        THIS.this_lEmLookup = .T.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGrupos", "dgrus", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("cgrus", "XXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupos")
                    THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = ALLTRIM(cursor_4c_BuscaGrupos.dgrus)
                    THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value  = ALLTRIM(cursor_4c_BuscaGrupos.cgrus)
                ELSE
                    THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = ""
                    THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value  = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formsigopsep.AbrirBuscaDgrProduto: " + loc_oErro.Message, "Erro")
        ENDTRY
        THIS.this_lEmLookup = .F.

        IF USED("cursor_4c_BuscaGrupos")
            USE IN cursor_4c_BuscaGrupos
        ENDIF
    ENDPROC


    *--------------------------------------------------------------------------
    * Par 3: Moeda de Venda <-> Descricao (SigCdMoe: cmoes/dmoes)
    *
    * Unica assimetria do trio: Get_Dmoevenda.Valid do legado NAO tem o ramo
    * "If Empty(This.Value) / Parent.Get_MoeVenda.Value = ''" que os outros
    * dois pares tem - so entra no bloco de lookup quando !Empty(This.Value).
    * Com o campo vazio, o codigo e simplesmente IGNORADO (o When ja garante
    * que so se chega aqui com o codigo vazio de qualquer forma). Transcrito
    * literalmente: ValidarDmoeVenda NAO limpa txt_4c_MoeVenda no ramo vazio.
    *--------------------------------------------------------------------------
    PROCEDURE DmoeVendaWhenCheck()
        RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value))
    ENDPROC

    PROCEDURE ValidarMoeVenda()
        LOCAL loc_cValor

        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value)

        IF VARTYPE(THIS.this_cUltimoValidarMoeVendaValidado) == "C" AND ;
                loc_cValor == THIS.this_cUltimoValidarMoeVendaValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cValor)
            THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value = ""
        ELSE
            THIS.AbrirBuscaMoeVenda()
        ENDIF

        THIS.this_cUltimoValidarMoeVendaValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value)
    ENDPROC

    PROCEDURE ValidarDmoeVenda()
        LOCAL loc_cValor

        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value)

        IF VARTYPE(THIS.this_cUltimoValidarDmoeVendaValidado) == "C" AND ;
                loc_cValor == THIS.this_cUltimoValidarDmoeVendaValidado
            RETURN
        ENDIF

        IF !EMPTY(loc_cValor)
            THIS.AbrirBuscaDmoeVenda()
        ENDIF

        THIS.this_cUltimoValidarDmoeVendaValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value)
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaMoeVenda()
        LOCAL loc_oBusca, loc_cValor, loc_oErro

        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value)

        THIS.this_lEmLookup = .T.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoedas", "cmoes", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cmoes", "XXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoedas")
                    THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value  = ALLTRIM(cursor_4c_BuscaMoedas.cmoes)
                    THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value = ALLTRIM(cursor_4c_BuscaMoedas.dmoes)
                ELSE
                    THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value  = ""
                    THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formsigopsep.AbrirBuscaMoeVenda: " + loc_oErro.Message, "Erro")
        ENDTRY
        THIS.this_lEmLookup = .F.

        IF USED("cursor_4c_BuscaMoedas")
            USE IN cursor_4c_BuscaMoedas
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaDmoeVenda()
        LOCAL loc_oBusca, loc_cValor, loc_oErro

        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value)

        THIS.this_lEmLookup = .T.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoedas", "dmoes", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("cmoes", "XXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoedas")
                    THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value = ALLTRIM(cursor_4c_BuscaMoedas.dmoes)
                    THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value  = ALLTRIM(cursor_4c_BuscaMoedas.cmoes)
                ELSE
                    THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value = ""
                    THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value  = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formsigopsep.AbrirBuscaDmoeVenda: " + loc_oErro.Message, "Erro")
        ENDTRY
        THIS.this_lEmLookup = .F.

        IF USED("cursor_4c_BuscaMoedas")
            USE IN cursor_4c_BuscaMoedas
        ENDIF
    ENDPROC


    *==========================================================================
    * ConfigurarPaginaDados - grade de PRODUTOS + botoes de acao
    *
    * O nome vem do contrato do pipeline; nao ha Page a configurar (layout
    * FLAT - ver cabecalho). Aqui entram os objetos que o dump declara direto
    * na Form: GradeItens (grd_4c_Itens) e os cinco CommandButton de acao
    * (Sair/CopiaLista/Processar/cmdMarcaProd/cmdDesmarcaProd).
    *
    * APENAS a estrutura da grade (ColumnCount, fontes, larguras, headers):
    * RecordSource/ControlSource e o CheckBox da Column1 ficam no funil
    * CarregarDados(), pela sequencia medida que esta documentada la.
    *
    * Sair/CopiaLista/Processar sao fwbtng no legado e o SCX sobrepoe apenas
    * Top/Left/Picture/Caption/Cancel/ToolTipText/PicturePosition; o resto vem
    * da classe ("Comic Sans MS" 8 bold+italic, ForeColor 90,90,90, BackColor
    * branco, WordWrap, MousePointer 15).
    *
    * Width/Height = 75: e o canonico do projeto para botao de acao (regra #10 e
    * framework_frmcadastro_layout.md) e e o que FECHA a geometria do dump - os
    * Left do legado sao 576/651/725, isto e, passo de 75, e 725 + 75 = 800 =
    * Form.Width exato; com Height = 75 a linha de botoes termina em 78, dentro
    * da faixa de 80 do cabecalho. O 80x100 do fwbtng em framework.vcx e o
    * default da classe-exemplo ("Grande"), que o projeto sobrepoe - adotado ali
    * deixaria Sair 5px FORA do form e 23px abaixo da faixa.
    * cmdMarcaProd/cmdDesmarcaProd sao fwbtnp (classe: 40x40), icone-only.
    * Picture: todos TRANSCRITOS do dump (regra #25), conferidos em vbmp\.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *----------------------------------------------------------------------
        * GradeItens -> grd_4c_Itens (dump: Top=316 Left=64 Width=673
        * Height=130 ColumnCount=6 FontName="Courier New" TabIndex=2)
        *
        * RecordMark/DeleteMark nao sao declarados no dump desta grade (ao
        * contrario de GradeLinhas, que declara RecordMark = .F.); ficam .F.
        * por serem o canonico do projeto para grade de dados em OPERACIONAL.
        *----------------------------------------------------------------------
        THIS.AddObject("grd_4c_Itens", "Grid")
        WITH THIS.grd_4c_Itens
            .Top         = 316
            .Left        = 64
            .Width       = 673
            .Height      = 130
            .ColumnCount = 6
            .FontName    = "Courier New"
            .FontSize    = 9
            .ReadOnly    = .F.
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .TabIndex    = 2
            .Visible     = .T.
        ENDWITH

        *-- Column1: marcacao (CheckBox). O ReadOnly da COLUNA vem DEPOIS do
        *-- ReadOnly do GRID, que propaga e sobrescreveria (regra #18).
        WITH THIS.grd_4c_Itens.Column1
            .FontName          = "Courier New"
            .Width             = 20
            .Movable           = .F.
            .Resizable         = .F.
            .Sparse            = .F.
            .ReadOnly          = .F.
            .Visible           = .T.
            .Header1.Caption   = ""
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.ForeColor = RGB(0, 0, 0)
        ENDWITH

        WITH THIS.grd_4c_Itens.Column2
            .FontName          = "Courier New"
            .Width             = 108
            .Movable           = .F.
            .Resizable         = .F.
            .Sparse            = .F.
            .ReadOnly          = .T.
            .Visible           = .T.
            .Header1.Caption   = "C" + CHR(243) + "digo Produto"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(0, 0, 0)
            .Text1.FontName    = "Courier New"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Itens.Column3
            .FontName          = "Courier New"
            .Width             = 250
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Visible           = .T.
            .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(0, 0, 0)
            .Text1.FontName    = "Courier New"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Preco de Venda (C): InputMask "999,999,999.99" transcrita do dump
        *-- (regra #49) - o legado formata o valor na propria coluna. O Header
        *-- deste e o UNICO com ForeColor 36,84,155 no dump.
        WITH THIS.grd_4c_Itens.Column4
            .FontName          = "Courier New"
            .Width             = 110
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .InputMask         = "999,999,999.99"
            .Visible           = .T.
            .Header1.Caption   = "Pre" + CHR(231) + "o de Venda (C)"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(36, 84, 155)
            .Text1.FontName    = "Courier New"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Itens.Column5
            .FontName          = "Courier New"
            .Width             = 40
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Visible           = .T.
            .Header1.Caption   = "Moeda"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(0, 0, 0)
            .Text1.FontName    = "Courier New"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Preco de Venda (L) = pliqs. O dump NAO declara Column6.ReadOnly e
        *-- declara Column6.Text1.ReadOnly = .F.: e a unica celula editavel da
        *-- grade (o usuario ajusta o preco liquido antes de copiar).
        WITH THIS.grd_4c_Itens.Column6
            .FontName          = "Courier New"
            .Width             = 110
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .F.
            .InputMask         = "999,999,999.99"
            .Visible           = .T.
            .Header1.Caption   = "Pre" + CHR(231) + "o de Venda (L)"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(0, 0, 0)
            .Text1.FontName    = "Courier New"
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .F.
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *----------------------------------------------------------------------
        * Botoes de acao (direto na Form, como no dump)
        *----------------------------------------------------------------------

        *-- Processar (dump: Top=3 Left=651, geral_processar_60.jpg)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 651
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .ToolTipText     = "Seleciona os Produtos Conforme os Filtros"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

        *-- Copia p/ Lista (dump: Top=3 Left=576, geral_pendencia_60.jpg,
        *-- PicturePosition = 7)
        THIS.AddObject("cmd_4c_CopiaLista", "CommandButton")
        WITH THIS.cmd_4c_CopiaLista
            .Top             = 3
            .Left            = 576
            .Width           = 75
            .Height          = 75
            .Caption         = "Copia p/ \<Lista"
            .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
            .PicturePosition = 7
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .ToolTipText     = "Copia os Produtos Marcados Para a Lista"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_CopiaLista, "Click", THIS, "BtnCopiaListaClick")

        *-- Encerrar (Sair do dump: Top=3 Left=725, Cancel = .T. - e o botao
        *-- que responde ao ESC; cadastro_sair_60.jpg)
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .ToolTipText     = "Encerra a Sele" + CHR(231) + CHR(227) + "o de Produtos"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Marca / Desmarca TODOS os PRODUTOS (cmdMarcaProd/cmdDesmarcaProd
        *-- do dump: Top=455, Left=626/666, fwbtnp 40x40, icone-only).
        *-- Nomes distintos dos irmaos de cnt_4c_Filtro (cmd_4c_Marcar/
        *-- cmd_4c_Desmarcar), que marcam LINHAS e nao PRODUTOS.
        THIS.AddObject("cmd_4c_MarcaProd", "CommandButton")
        WITH THIS.cmd_4c_MarcaProd
            .Top             = 455
            .Left            = 626
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
            .DisabledPicture = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .MousePointer    = 15
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .ToolTipText     = "Marca Todas as Linhas de Produto"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_MarcaProd, "Click", THIS, "BtnMarcaProdClick")

        THIS.AddObject("cmd_4c_DesmarcaProd", "CommandButton")
        WITH THIS.cmd_4c_DesmarcaProd
            .Top             = 455
            .Left            = 666
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "onebit_33.ico"
            .DisabledPicture = gc_4c_CaminhoIcones + "onebit_33.ico"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .MousePointer    = 15
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .ToolTipText     = "Desmarca Todas as Linhas de Produto"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_DesmarcaProd, "Click", THIS, "BtnDesmarcaProdClick")

        RETURN .T.
    ENDPROC


    *==========================================================================
    * CarregarDados - FUNIL de carga da grade de Produtos (GradeItens)
    *
    * Replica o fecho do SIGOPSEP.Init: cria CsSigCdPro VAZIO, liga a grade,
    * aplica o DynamicForeColor e deixa CopiaLista desabilitado (so Processar
    * habilita, quando trouxer produtos).
    *
    * A estrutura do cursor mora UNICAMENTE no BO (CriarCursorProdutos):
    * repetir o CREATE CURSOR aqui criaria duas versoes do mesmo cursor, e
    * divergencia de ordem/nome de campo quebra em silencio o APPEND e o
    * ControlSource. Serve a toda repintura (aqui e, na fase de eventos, em
    * Processar), pela mesma sequencia medida que CarregarLinhas documenta.
    *==========================================================================
    PROTECTED PROCEDURE CarregarDados()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        *-- Sem o cursor, atribuir ControlSource estoura "Alias not found"
        *-- dentro do TRY do InicializarForm e a tela nao abre (regra #41)
        THIS.this_oBusinessObject.CriarCursorProdutos()

        IF !THIS.ReligarGradeItens()
            RETURN .F.
        ENDIF

        *-- SIGOPSEP.Init termina com CopiaLista.Enabled = .F.
        THIS.cmd_4c_CopiaLista.Enabled = .F.

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ReligarGradeItens - (re)liga grd_4c_Itens a cursor_4c_Produtos
    *
    * Fatorado de CarregarDados (Fase 4) porque BO.BuscarProdutos (Fase 7,
    * usado em BtnProcessarClick) RECRIA cursor_4c_Produtos (USE IN +
    * CREATE CURSOR, via CriarCursorProdutos) para popula-lo com dados
    * reais - a MESMA razao, ja documentada em InstalarCheckBoxColuna, pela
    * qual fechar/recriar o alias do RecordSource destroi o CheckBox posto
    * por Column.AddObject. Por isso o bind tem de ser refeito do ZERO
    * depois de QUALQUER recriacao do cursor, nao so na carga inicial.
    *==========================================================================
    PROTECTED PROCEDURE ReligarGradeItens()
        LOCAL loc_oGrid

        IF !USED("cursor_4c_Produtos")
            RETURN .F.
        ENDIF

        loc_oGrid = THIS.grd_4c_Itens

        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount = 6
        loc_oGrid.RecordSource = "cursor_4c_Produtos"
        loc_oGrid.Column1.ControlSource = "cursor_4c_Produtos.flagctabs"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Produtos.cpros"
        loc_oGrid.Column3.ControlSource = "cursor_4c_Produtos.dpros"
        loc_oGrid.Column4.ControlSource = "cursor_4c_Produtos.pvens"
        loc_oGrid.Column5.ControlSource = "cursor_4c_Produtos.moevs"
        loc_oGrid.Column6.ControlSource = "cursor_4c_Produtos.pliqs"

        *-- Column1.Check1 do dump: a coluna de marcacao dos Produtos. O
        *-- objeto acabou de nascer de novo (RecordSource acima destruiu o
        *-- anterior) - religar o When (GradeItens.Column1.Check1.When do
        *-- legado: "Return(CsSigCdPro.lMarcas = 0)") no objeto NOVO.
        THIS.InstalarCheckBoxColuna(loc_oGrid.Column1, "chk_4c_MarcaProduto")
        BINDEVENT(loc_oGrid.Column1.chk_4c_MarcaProduto, "When", THIS, "WhenMarcaProduto")

        *-- DynamicForeColor do legado: azul no produto que JA esta na lista de
        *-- precos do form pai (lMarcas = 1), preto nos demais. Transcrito do
        *-- SIGOPSEP.Init, com o nome do cursor migrado.
        loc_oGrid.SetAll("DynamicForeColor", ;
            "RGB(0,0,IIF(cursor_4c_Produtos.lMarcas = 0,0,255))", "Column")

        *-- A fonte do GRID vai ANTES dos cabecalhos: medido no VFP9 em
        *-- 2026-11-17, atribuir Grid.FontName/FontSize PROPAGA para
        *-- Column.FontName E para Column.Header1.FontName, sobrescrevendo o
        *-- Tahoma 8 que o dump declara por Header1 (ficava Courier New 9).
        THIS.FormatarGridLista(loc_oGrid)

        *-- RecordSource reseta Width/Header1.Caption para o default, e a
        *-- fonte do grid acabou de achatar o Header1 - reaplicar os dois
        *-- (Problema 48). Header1 de GradeItens no dump: Tahoma 8,
        *-- Alignment 2 nas colunas de texto, ForeColor 0,0,0 em todas MENOS
        *-- a de Preco de Venda (C), que o legado pinta de 36,84,155.
        THIS.AplicarCabecalhoColuna(loc_oGrid.Column1,  20, "", 0, RGB(0, 0, 0))
        THIS.AplicarCabecalhoColuna(loc_oGrid.Column2, 108, ;
            "C" + CHR(243) + "digo Produto", 2, RGB(0, 0, 0))
        THIS.AplicarCabecalhoColuna(loc_oGrid.Column3, 250, ;
            "Descri" + CHR(231) + CHR(227) + "o do Produto", 2, RGB(0, 0, 0))
        THIS.AplicarCabecalhoColuna(loc_oGrid.Column4, 110, ;
            "Pre" + CHR(231) + "o de Venda (C)", 2, RGB(36, 84, 155))
        THIS.AplicarCabecalhoColuna(loc_oGrid.Column5,  40, "Moeda", 2, RGB(0, 0, 0))
        THIS.AplicarCabecalhoColuna(loc_oGrid.Column6, 110, ;
            "Pre" + CHR(231) + "o de Venda (L)", 2, RGB(0, 0, 0))

        SELECT cursor_4c_Produtos
        GO TOP
        loc_oGrid.Refresh()

        RETURN .T.
    ENDPROC


    *==========================================================================
    * WhenMarcaProduto - When do CheckBox de marcacao de grd_4c_Itens
    * (GradeItens.Column1.Check1.When do legado: "Return(CsSigCdPro.lMarcas
    * = 0)", literal). So permite editar a celula quando o produto AINDA
    * NAO esta na lista de precos do pai - produto ja presente (lMarcas=1)
    * fica travado, visualmente distinguido pelo DynamicForeColor azul de
    * ReligarGradeItens.
    *==========================================================================
    PROCEDURE WhenMarcaProduto()
        IF USED("cursor_4c_Produtos")
            RETURN (cursor_4c_Produtos.lMarcas = 0)
        ENDIF

        RETURN .T.
    ENDPROC


    *==========================================================================
    * Eventos dos botoes de acao (Fase 7/8)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnMarcarClick / BtnDesmarcarClick - Marcar.Click/Desmarcar.Click do
    * legado (marcam/desmarcam TODAS as linhas da grade de filtro).
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarcarClick()
        IF THIS.this_oBusinessObject.MarcarTodasLinhas(1)
            THIS.cnt_4c_Filtro.grd_4c_Linhas.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesmarcarClick()
        IF THIS.this_oBusinessObject.MarcarTodasLinhas(0)
            THIS.cnt_4c_Filtro.grd_4c_Linhas.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarcaProdClick / BtnDesmarcaProdClick - cmdMarcaProd.Click/
    * cmdDesmarcaProd.Click do legado (marcam/desmarcam TODOS os produtos
    * da grade de resultado que ainda nao estao na lista - lMarcas = 0).
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarcaProdClick()
        IF THIS.this_oBusinessObject.MarcarTodosProdutos(1)
            THIS.grd_4c_Itens.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesmarcaProdClick()
        IF THIS.this_oBusinessObject.MarcarTodosProdutos(0)
            THIS.grd_4c_Itens.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Processar.Click do legado: consulta SigCdPro
    * pelos filtros atuais (FormParaBO sincroniza a UI nas properties do
    * BO) e preenche grd_4c_Itens.
    *
    * par_cCursorListaPrecos de BuscarProdutos() vai "" por ora: o form pai
    * (SIGOPPxx) ainda nao existe migrado, e o nome do cursor de itens dele
    * eh desconhecido neste CONTRATO (PILAR 3 - ver nota no cabecalho do
    * arquivo). BuscarProdutos trata "" como "nenhum item ja esta na
    * lista", que eh exatamente o caso mais comum (Processar roda ANTES de
    * qualquer Copia p/ Lista).
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        WAIT WINDOW "Aguarde !!! Selecionando Produtos..." NOWAIT

        THIS.FormParaBO()

        IF !THIS.this_oBusinessObject.BuscarProdutos("")
            WAIT CLEAR
            MsgErro("Favor reinicializar o processo." + CHR(13) + ;
                    NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""), ;
                    "Falha na Conex" + CHR(227) + "o")
            THIS.Release()
            RETURN
        ENDIF

        THIS.ReligarGradeItens()

        WAIT CLEAR

        IF EOF("cursor_4c_Produtos")
            MsgAviso("N" + CHR(227) + "o existem produtos com esses par" + ;
                     CHR(226) + "metros !!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Filtro.txt_4c_GrVenda.SetFocus()
        ELSE
            THIS.cmd_4c_CopiaLista.Enabled = .T.
            THIS.grd_4c_Itens.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCopiaListaClick - CopiaLista.Click do legado: devolve ao form pai
    * os produtos marcados (flagctabs=1) que ainda nao estao na lista
    * (lMarcas=0), respeitando a Situacao do filtro, e encerra o dialogo.
    *
    * BO.ObterProdutosParaCopia("") replica o SCAN inteiro do legado
    * (guard de Situacao incluso) e preenche cursor_4c_ProdutosCopia
    * (cpros/dpros/pvens/pliqs/moevs) - exatamente os candidatos que o
    * legado insere em CrSigCdLpi.
    *
    * A gravacao em si (limpar a linha em branco, cidchaves via
    * fUniqueIds(), lprecos do cabecalho CrSigCdLpc, flagutabs, vencis/
    * vencfs, arredondamento condicional via fArredondamento quando
    * CompVenda <> "C") pertence ao form PAI - ele quem conhece
    * CrSigCdLpi/CrSigCdLpc/CompVenda/poDataMgr. Entregar o cursor por um
    * metodo PUBLIC opcional (AdicionarProdutosSelecionados), chamado
    * DEFENSIVAMENTE via PEMSTATUS, eh o mesmo padrao ja usado em
    * ReabilitarFormPai/RepintarFormPai - nao estoura enquanto nenhum form
    * SIGOPPxx desta familia existir migrado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCopiaListaClick()
        LOCAL loc_oErro

        THIS.FormParaBO()

        IF !THIS.this_oBusinessObject.ObterProdutosParaCopia("")
            MsgErro(NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""), ;
                    "Formsigopsep.BtnCopiaListaClick")
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
                PEMSTATUS(THIS.this_oFormPai, "AdicionarProdutosSelecionados", 5)
            TRY
                THIS.this_oFormPai.AdicionarProdutosSelecionados("cursor_4c_ProdutosCopia")
            CATCH TO loc_oErro
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                        "vel copiar os produtos para a lista: " + loc_oErro.Message, ;
                        "Formsigopsep.BtnCopiaListaClick")
            ENDTRY
        ENDIF

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Sair.Click do legado (literal: ThisForm.Release()).
    * Destroy() (abaixo) replica o fecho de SIGOPSEP.Release - cursores
    * locais, repintar e reabilitar o pai.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC


    *==========================================================================
    * InstalarCheckBoxColuna - instala (ou REINSTALA) o CheckBox de marcacao
    * numa Column de Grid, no estado em que o dump declara Column1.Check1
    * (Top=27 Left=7 Width=60 Height=17 Alignment=0 Caption="" ReadOnly=.F.) -
    * o mesmo nos dois grids do form.
    *
    * Column.AddObject cria o objeto mas NAO o exibe: sem CurrentControl a
    * coluna segue desenhando o Text1 dela, e sem Sparse = .F. o controle
    * aparece so na linha ativa (regra #18).
    *
    * REENTRANTE de proposito: fechar/recriar o alias do RecordSource destroi
    * o objeto adicionado por Column.AddObject (CurrentControl volta a
    * "Text1") preservando ColumnCount/Width/Header - perda PARCIAL e
    * silenciosa. Por isso o AddObject so corre quando o membro sumiu, e todo
    * o resto e sempre reaplicado.
    *
    * par_oColuna - objeto Column, JA ligado via ControlSource
    * par_cNome   - nome do CheckBox a instalar nessa coluna
    *==========================================================================
    PROTECTED PROCEDURE InstalarCheckBoxColuna(par_oColuna, par_cNome)
        LOCAL loc_oChk

        IF VARTYPE(par_oColuna) != "O" OR VARTYPE(par_cNome) != "C" OR EMPTY(par_cNome)
            RETURN .F.
        ENDIF

        IF !PEMSTATUS(par_oColuna, par_cNome, 5)
            par_oColuna.AddObject(par_cNome, "CheckBox")
        ENDIF

        *-- Membro alcancado por NOME: EVALUATE na leitura. Controls(<nome>) e
        *-- indexado por NUMERO e estouraria em runtime (regras #15/#34).
        loc_oChk = EVALUATE("par_oColuna." + par_cNome)

        IF VARTYPE(loc_oChk) != "O"
            RETURN .F.
        ENDIF

        WITH loc_oChk
            .Caption   = ""
            .Alignment = 0
            .Top       = 27
            .Left      = 7
            .Width     = 60
            .Height    = 17
            .ReadOnly  = .F.
            *-- CheckBox.Value e NUMERICO (0/1), nunca .F./.T.: as colunas
            *-- ligadas (lMarcas/flagctabs) sao N(1)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        par_oColuna.Sparse         = .F.
        par_oColuna.CurrentControl = par_cNome
        par_oColuna.ReadOnly       = .F.

        RETURN .T.
    ENDPROC

    *==========================================================================
    * AplicarCabecalhoColuna - reaplica largura e cabecalho de uma Column
    *
    * Chamado pelos funis de carga SEMPRE DEPOIS de FormatarGridLista, nesta
    * ordem por medicao (VFP9, 2026-11-17): atribuir Grid.FontName/FontSize
    * PROPAGA para Column.FontName e para Column.Header1.FontName, achatando
    * o Tahoma 8 que o dump declara por Header1 (o header saia em Courier New
    * 9). Medido tambem que RecordSource, ao contrario, NAO mexe na fonte do
    * Header1 - mas zera Width e Caption (Problema 48).
    *
    * par_oColuna     - objeto Column
    * par_nWidth      - largura do dump
    * par_cCaption    - caption do Header1, do dump
    * par_nAlignment  - Header1.Alignment do dump (0 = esquerda, 2 = centro)
    * par_nForeColor  - Header1.ForeColor do dump; passar -1 quando o dump
    *                   NAO declara ForeColor, para nao inventar propriedade
    *                   que o legado deixou no default (regra #25)
    *==========================================================================
    PROTECTED PROCEDURE AplicarCabecalhoColuna(par_oColuna, par_nWidth, ;
            par_cCaption, par_nAlignment, par_nForeColor)

        IF VARTYPE(par_oColuna) != "O"
            RETURN .F.
        ENDIF

        WITH par_oColuna
            .Width             = par_nWidth
            .Header1.Caption   = par_cCaption
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = par_nAlignment

            IF par_nForeColor >= 0
                .Header1.ForeColor = par_nForeColor
            ENDIF
        ENDWITH

        RETURN .T.
    ENDPROC


    *==========================================================================
    * FormParaBO - le os campos de cnt_4c_Filtro para as properties do BO.
    *
    * Chamado ANTES de Processar (Fase 6/8): o legado le os mesmos campos
    * direto do container CrtFiltro dentro de Grupo_op.Processar.Click (With
    * ThisForm.CrtFiltro / lcCGrus = ... / lcColecoes = ... / lcMoevs = ...
    * / lnAjuste = 1 + (.Get_AcreDesc.Value/100) / lnArredonda =
    * .Get_Arrend.Value / lnSitua = .Opc_situacao.Value).
    *
    * Os campos de DESCRICAO (txt_4c_DgrVenda/DgrProduto/DmoeVenda) sao
    * ReadOnly e preenchidos so pelo lookup (fase 6/8) - ainda assim sao
    * espelhados aqui porque BOParaForm precisa do caminho inverso simetrico
    * (ex.: reabrir o dialogo com filtro ja preenchido pelo form pai).
    *
    * obj_4c_Situacao.Value JA eh o indice do botao (1/2/3) - nunca 0/1
    * (regra #45/#188), por isso vai direto, sem IIF.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_cGrupoVenda        = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value)
            .this_cDescGrupoVenda    = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value)
            .this_cGrupoProduto      = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value)
            .this_cDescGrupoProduto  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value)
            .this_cMoedaVenda        = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value)
            .this_cDescMoedaVenda    = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value)
            .this_nAcrescimoDesconto = THIS.cnt_4c_Filtro.txt_4c_AcreDesc.Value
            .this_nArredondamento    = THIS.cnt_4c_Filtro.txt_4c_Arrend.Value
            .this_nSituacao          = THIS.cnt_4c_Filtro.obj_4c_Situacao.Value
        ENDWITH
    ENDPROC


    *==========================================================================
    * BOParaForm - caminho inverso de FormParaBO, usado pelo Init (Fase 1/8
    * ja guarda o estado no BO com os defaults do SIGOPSEP.Init - pcMercs
    * vazio) e por qualquer recarga futura do filtro a partir do BO.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        WITH THIS.this_oBusinessObject
            THIS.cnt_4c_Filtro.txt_4c_GrVenda.Value    = .this_cGrupoVenda
            THIS.cnt_4c_Filtro.txt_4c_DgrVenda.Value   = .this_cDescGrupoVenda
            THIS.cnt_4c_Filtro.txt_4c_GrProduto.Value  = .this_cGrupoProduto
            THIS.cnt_4c_Filtro.txt_4c_DgrProduto.Value = .this_cDescGrupoProduto
            THIS.cnt_4c_Filtro.txt_4c_MoeVenda.Value   = .this_cMoedaVenda
            THIS.cnt_4c_Filtro.txt_4c_DmoeVenda.Value  = .this_cDescMoedaVenda
            THIS.cnt_4c_Filtro.txt_4c_AcreDesc.Value   = .this_nAcrescimoDesconto
            THIS.cnt_4c_Filtro.txt_4c_Arrend.Value     = .this_nArredondamento
            THIS.cnt_4c_Filtro.obj_4c_Situacao.Value   = .this_nSituacao
        ENDWITH
    ENDPROC


    *==========================================================================
    * TornarControlesVisiveis - AddObject cria tudo com Visible = .F.
    *
    * Sem parametro (igual FormSigOpCrd): este form nao tem container
    * flutuante a filtrar ate agora. Se uma fase futura introduzir painel
    * Visible=.F. alternado por botao, o filtro entra aqui.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_nI, loc_nJ, loc_oControle, loc_oFilho

        FOR loc_nI = 1 TO THIS.ControlCount
            loc_oControle = THIS.Controls(loc_nI)

            IF VARTYPE(loc_oControle) = "O"
                IF PEMSTATUS(loc_oControle, "Visible", 5)
                    loc_oControle.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControle, "ControlCount", 5)
                    FOR loc_nJ = 1 TO loc_oControle.ControlCount
                        loc_oFilho = loc_oControle.Controls(loc_nJ)
                        IF VARTYPE(loc_oFilho) = "O" AND PEMSTATUS(loc_oFilho, "Visible", 5)
                            loc_oFilho.Visible = .T.
                        ENDIF
                    ENDFOR
                ENDIF
            ENDIF
        ENDFOR

        RETURN .T.
    ENDPROC


    *==========================================================================
    * FormatarGridLista - formatacao visual padrao de grid (fase 4/5 chamam
    * apos popular grd_4c_Linhas / grd_4c_Itens)
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN .F.
        ENDIF

        par_oGrid.FontName = "Courier New"
        par_oGrid.FontSize = 9
        par_oGrid.Refresh()

        RETURN .T.
    ENDPROC


    *==========================================================================
    * RepintarFormPai - ParentForm.Pagina.Dados.Refresh do legado
    * (SIGOPSEP.Release). THIS.this_oFormPai.Refresh() cascateia para TODOS
    * os controles do form pai (containers/paginas/grids) - o Form.Refresh
    * nativo do VFP9 ja desce a arvore de controles sozinho, entao nao e
    * preciso conhecer os nomes _4c_ do pai (PILAR 3) nem presumir a
    * hierarquia Pagina.Dados.Grade do legado. Serve a QUALQUER form pai
    * desta familia (SIGOPPxx), migrado com qualquer layout.
    *==========================================================================
    PROCEDURE RepintarFormPai()
        LOCAL loc_oErro

        IF VARTYPE(THIS.this_oFormPai) != "O"
            RETURN .F.
        ENDIF

        TRY
            THIS.this_oFormPai.Refresh()
        CATCH TO loc_oErro
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel repintar a tela de origem: " + ;
                    loc_oErro.Message, "Formsigopsep.RepintarFormPai")
        ENDTRY

        RETURN .T.
    ENDPROC


    *==========================================================================
    * ReabilitarFormPai - ParentForm.Enabled = .T. do legado (SIGOPSEP.Release)
    *
    * O legado faz isso INCONDICIONALMENTE (sem flag de "fomos nos que
    * desabilitamos") - diferente de SigOpCrd. Mantido defensivo via
    * PEMSTATUS para nunca estourar se o pai nao tiver a property.
    *==========================================================================
    PROCEDURE ReabilitarFormPai()
        LOCAL loc_oErro

        IF VARTYPE(THIS.this_oFormPai) != "O"
            RETURN .F.
        ENDIF

        TRY
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel reabilitar a tela de origem: " + ;
                    loc_oErro.Message, "Formsigopsep.ReabilitarFormPai")
        ENDTRY

        RETURN .T.
    ENDPROC


    *==========================================================================
    * Destroy - equivalente ao SIGOPSEP.Release: cursores locais, repintar
    * (RepintarFormPai) e reabilitar (ReabilitarFormPai) o pai, na mesma
    * ordem do legado (Refresh antes de Enabled = .T.). SetFocus no Grade
    * do pai (Pagina.Dados.Grade.Column1.SetFocus) fica de fora - exigiria
    * conhecer o nome do grid do pai, violando o PILAR 3 (ver nota de
    * CONTRATO no cabecalho do arquivo); o Refresh em cascata ja garante
    * que os dados aparecam.
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.LimparCursores()
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        THIS.RepintarFormPai()
        THIS.ReabilitarFormPai()
        THIS.this_oFormPai = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopsepBO.prg):
*==============================================================================
* SIGOPSEPBO.PRG
* Business Object - Selecao de Produtos para Lista de Preco
* Origem: SIGOPSEP.SCX (form filho, chamado por ThisForm.ParentForm)
*==============================================================================

DEFINE CLASS sigopsepBO AS BusinessBase

    *-- Filtro: Grupo de Venda (colecoes - SigCdCol)
    this_cGrupoVenda = ""
    this_cDescGrupoVenda = ""

    *-- Filtro: Grupo de Produto (cgrus - SigCdGrp)
    this_cGrupoProduto = ""
    this_cDescGrupoProduto = ""

    *-- Filtro: Moeda de Venda (cmoes - SigCdMoe)
    this_cMoedaVenda = ""
    this_cDescMoedaVenda = ""

    *-- Filtro: Acrescimo/Desconto percentual
    this_nAcrescimoDesconto = 0

    *-- Filtro: Arredondamento
    this_nArredondamento = 0

    *-- Filtro: Situacao (1=Ativos, 2=Inativos, 3=Todos)
    this_nSituacao = 1

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("SigCdPro")

        THIS.this_cCampoChave = "cpros"

        THIS.this_cGrupoVenda = ""
        THIS.this_cDescGrupoVenda = ""
        THIS.this_cGrupoProduto = ""
        THIS.this_cDescGrupoProduto = ""
        THIS.this_cMoedaVenda = ""
        THIS.this_cDescMoedaVenda = ""
        THIS.this_nAcrescimoDesconto = 0
        THIS.this_nArredondamento = 0
        THIS.this_nSituacao = 1

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarLinhas - Carrega cursor_4c_Linhas (SigCdLin) para a grade de
    * marcacao de linhas do filtro (SIGOPSEP.Init: CsSigCdLin).
    * SQLEXEC() devolve cursor SOMENTE-LEITURA; como a grade marca/desmarca
    * via REPLACE, convertemos para READWRITE antes de expor o cursor.
    *
    * O bypass de teste vem no TOPO porque o TesteAutomatico.prg e o
    * ValidarUIFidelity.prg NAO conectam ao SQL Server (definem gnConnHandle
    * como SENTINELA). Sem ele a falha de conexao devolveria .F., o
    * InicializarForm do Form devolveria .F., CREATEOBJECT devolveria o
    * LOGICO .F. e a tela simplesmente nao abriria no harness - com uma
    * mensagem de conexao que nao corresponde a falha de rede nenhuma. O
    * cursor VAZIO e criado com a MESMA estrutura e ordem de campos do SELECT
    * abaixo (lMarcas, linhas C(10), descs C(40) - larguras de SigCdLin no
    * schema), para a grade ter o que ligar em ControlSource.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarLinhas()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
           (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            IF USED("cursor_4c_Linhas")
                USE IN cursor_4c_Linhas
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Linhas (lMarcas N(1), linhas C(10), descs C(40))
            SET NULL OFF
            SELECT cursor_4c_Linhas
            GO TOP
            RETURN .T.
        ENDIF

        TRY
            IF USED("cursor_4c_LinhasTmp")
                USE IN cursor_4c_LinhasTmp
            ENDIF
            IF USED("cursor_4c_Linhas")
                USE IN cursor_4c_Linhas
            ENDIF

            loc_cSQL = "SELECT 0 AS lMarcas, linhas, descs FROM SigCdLin"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhasTmp")

            IF loc_nResultado >= 0
                SET NULL ON
                SELECT * FROM cursor_4c_LinhasTmp INTO CURSOR cursor_4c_Linhas READWRITE
                SET NULL OFF

                IF USED("cursor_4c_LinhasTmp")
                    USE IN cursor_4c_LinhasTmp
                ENDIF

                SELECT cursor_4c_Linhas
                GO TOP

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o." + CHR(13) + CapturarErroSQL()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodasLinhas - Replica Marcar.Click/Desmarcar.Click (Replace All
    * lMarcas With <valor> In CsSigCdLin).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodasLinhas(par_nValor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Linhas")
                SELECT cursor_4c_Linhas
                REPLACE ALL lMarcas WITH par_nValor
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorProdutos - Estrutura identica ao "Create Cursor CsSigCdPro"
    * do SIGOPSEP.Init. Cursor local (nao vem de SQLEXEC), por isso ja nasce
    * READWRITE - suporta o CheckBox da coluna flagctabs (Column1) e os
    * REPLACE de MarcarTodosProdutos/ObterProdutosParaCopia.
    *
    * PUBLIC de proposito: o Form chama este metodo para criar o cursor VAZIO
    * antes de ligar a grade de produtos (o SIGOPSEP.Init legado faz o
    * "Create Cursor" inline, antes do RecordSource/ControlSource). Deixar a
    * estrutura do cursor SO aqui evita duas versoes do mesmo CREATE CURSOR -
    * divergencia de ordem/nome de campo quebra em silencio o APPEND e o
    * ControlSource da grade. Metodo que o Form chama de fora NAO pode ser
    * PROTECTED em nenhum nivel da heranca (regra #51): a chamada compila
    * limpo e estoura em runtime com "Property ... is not found".
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursorProdutos()
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Produtos (flagctabs N(1), cpros C(14), dpros C(40), pvens N(12,2), ;
            pliqs N(12,2), moevs C(3), situas N(1), cgrus C(3), colecoes C(10), linhas C(10), lMarcas N(1))
        SET NULL OFF

        INDEX ON cpros + cgrus TAG CProGrus
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutos - Replica SIGOPSEP.Processar.Click: monta o WHERE a
    * partir dos filtros (this_cGrupoProduto/this_cGrupoVenda/
    * this_cMoedaVenda) e das linhas marcadas em cursor_4c_Linhas, consulta
    * SigCdPro e recria cursor_4c_Produtos com pliqs calculado
    * (this_nAcrescimoDesconto/this_nArredondamento).
    *
    * par_cCursorListaPrecos: cursor VFP do form pai (equivalente a
    * CrSigCdLpi) - usado so para marcar flagctabs/lMarcas = 1 quando o
    * produto ja esta na lista de precos (Seek por CPros, igual ao legado).
    * Passar "" quando o form pai ainda nao disponibilizar esse cursor.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutos(par_cCursorListaPrecos)
        LOCAL loc_lSucesso, loc_cWhere, loc_cLinhas, loc_cSQL, loc_nResultado, ;
            loc_nVariacao, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cWhere = "0 = 0 "

            IF !EMPTY(THIS.this_cGrupoProduto)
                loc_cWhere = loc_cWhere + "AND cgrus = " + EscaparSQL(THIS.this_cGrupoProduto) + " "
            ENDIF
            IF !EMPTY(THIS.this_cGrupoVenda)
                loc_cWhere = loc_cWhere + "AND colecoes = " + EscaparSQL(THIS.this_cGrupoVenda) + " "
            ENDIF
            IF !EMPTY(THIS.this_cMoedaVenda)
                loc_cWhere = loc_cWhere + "AND moevs = " + EscaparSQL(THIS.this_cMoedaVenda) + " "
            ENDIF

            loc_cLinhas = ""
            IF USED("cursor_4c_Linhas")
                SELECT cursor_4c_Linhas
                GO TOP
                SCAN
                    IF cursor_4c_Linhas.lMarcas = 1
                        loc_cLinhas = loc_cLinhas + "linhas = " + EscaparSQL(cursor_4c_Linhas.linhas) + " OR "
                    ENDIF
                ENDSCAN
            ENDIF
            IF !EMPTY(loc_cLinhas)
                loc_cWhere = loc_cWhere + "AND (" + LEFT(loc_cLinhas, LEN(loc_cLinhas) - 3) + ") "
            ENDIF

            loc_cSQL = "SELECT flagctabs, cpros, dpros, pvens, moevs, situas, cgrus, colecoes, linhas " + ;
                       "FROM SigCdPro " + ;
                       "WHERE " + loc_cWhere + ;
                       "ORDER BY cpros, cgrus, flagctabs, dpros, pvens, moevs, situas, colecoes, linhas"

            IF USED("cursor_4c_ProdutosTmp")
                USE IN cursor_4c_ProdutosTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosTmp")

            IF loc_nResultado >= 0
                THIS.CriarCursorProdutos()

                loc_nVariacao = 1 + (THIS.this_nAcrescimoDesconto / 100)

                SELECT cursor_4c_ProdutosTmp
                GO TOP
                SCAN
                    SCATTER MEMVAR

                    IF !EMPTY(par_cCursorListaPrecos) AND USED(par_cCursorListaPrecos) ;
                            AND SEEK(cursor_4c_ProdutosTmp.cpros, par_cCursorListaPrecos, "CPros")
                        m.flagctabs = 1
                    ELSE
                        m.flagctabs = 0
                    ENDIF
                    m.lMarcas = m.flagctabs

                    m.pliqs = ROUND(cursor_4c_ProdutosTmp.pvens * loc_nVariacao, 2)
                    IF THIS.this_nArredondamento <> 0
                        m.pliqs = ROUND(m.pliqs / THIS.this_nArredondamento, 0) * THIS.this_nArredondamento
                    ENDIF

                    INSERT INTO cursor_4c_Produtos FROM MEMVAR

                    SELECT cursor_4c_ProdutosTmp
                ENDSCAN

                IF USED("cursor_4c_ProdutosTmp")
                    USE IN cursor_4c_ProdutosTmp
                ENDIF

                SELECT cursor_4c_Produtos
                GO TOP

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o." + CHR(13) + CapturarErroSQL()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodosProdutos - Replica cmdMarcaProd.Click/cmdDesmarcaProd.Click
    * (Replace All flagctabs With <valor> For lMarcas = 0).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodosProdutos(par_nValor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                REPLACE ALL flagctabs WITH par_nValor FOR lMarcas = 0
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterProdutosParaCopia - Replica o SCAN de SIGOPSEP.CopiaLista.Click:
    * seleciona os produtos marcados pelo usuario (flagctabs=1) que ainda
    * nao estavam na lista (lMarcas=0), respeitando o filtro de situacao
    * (this_nSituacao: 3=Todos), e reconfere que nao foram copiados nesse
    * meio-tempo (Seek por CPros no cursor do form pai).
    *
    * par_cCursorListaPrecos: cursor VFP do form pai (CrSigCdLpi).
    *
    * A INSERCAO final nesse cursor (cidchaves=fUniqueIds(), lprecos do
    * cabecalho CrSigCdLpc, vencis/vencfs={}, flagutabs=.T., pvens=pliqs)
    * fica por conta do Form: a estrutura de CrSigCdLpi/CrSigCdLpc pertence
    * ao form pai (fora do escopo deste BO, que so enxerga SigCdPro/
    * SigCdLin). fArredondamento(pvens, poDataMgr) do legado NAO foi
    * portada (funcao global Fortyus ausente do acervo, SIGFUNCS.PRG) -
    * fica de fora de proposito; o Form aplica essa funcao, quando portada,
    * somente quando o form pai indicar CompVenda <> "C" (mesmo guard do
    * legado). NUNCA substituir por ROUND/INT/CEILING.
    *
    * Popula cursor_4c_ProdutosCopia com cpros/dpros/pvens/pliqs/moevs.
    *--------------------------------------------------------------------------
    PROCEDURE ObterProdutosParaCopia(par_cCursorListaPrecos)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_oErro

        loc_lSucesso = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro = ""

        IF !USED("cursor_4c_Produtos")
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            TRY
                IF USED("cursor_4c_ProdutosCopia")
                    USE IN cursor_4c_ProdutosCopia
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_ProdutosCopia (cpros C(14), dpros C(40), pvens N(12,2), ;
                    pliqs N(12,2), moevs C(3))
                SET NULL OFF

                SELECT cursor_4c_Produtos
                GO TOP
                SCAN FOR cursor_4c_Produtos.flagctabs = 1 AND cursor_4c_Produtos.lMarcas = 0
                    IF THIS.this_nSituacao = 3 OR THIS.this_nSituacao = cursor_4c_Produtos.situas
                        IF EMPTY(par_cCursorListaPrecos) OR !USED(par_cCursorListaPrecos) ;
                                OR !SEEK(cursor_4c_Produtos.cpros, par_cCursorListaPrecos, "CPros")
                            INSERT INTO cursor_4c_ProdutosCopia (cpros, dpros, pvens, pliqs, moevs) VALUES ;
                                (cursor_4c_Produtos.cpros, cursor_4c_Produtos.dpros, cursor_4c_Produtos.pvens, ;
                                 cursor_4c_Produtos.pliqs, cursor_4c_Produtos.moevs)
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_Produtos
                ENDSCAN

                SELECT cursor_4c_ProdutosCopia
                GO TOP

                loc_lSucesso = .T.

            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha os cursores locais abertos pelo BO.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        IF USED("cursor_4c_Linhas")
            USE IN cursor_4c_Linhas
        ENDIF
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF
        IF USED("cursor_4c_ProdutosCopia")
            USE IN cursor_4c_ProdutosCopia
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera os cursores locais ao destruir o BO.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * Este BO NAO persiste nenhuma tabela propria: o SIGOPSEP legado apenas
    * CONSULTA SigCdPro/SigCdLin (filtros + grade de selecao) e copia os
    * produtos marcados para o cursor de ITENS do form pai (CrSigCdLpi,
    * fora do escopo deste BO) - nunca grava em SigCdPro. Por isso
    * Inserir()/Atualizar()/ExecutarExclusao()/RegistrarAuditoria()/
    * CarregarDoCursor()/ObterChavePrimaria() NAO sao sobrescritos aqui - o
    * comportamento padrao herdado de BusinessBase ja eh o correto para
    * este caso (mesmo padrao de SigOpCtsBO.prg/SigOpAutBO.prg, outras
    * telas operacionais sem tabela mestre propria).
    *==========================================================================

ENDDEFINE


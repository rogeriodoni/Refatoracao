# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnEncerrarExiste': Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-10-30 09:07:51] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-30 09:07:51] [INFO] Config FPW: (nao fornecido)
[2026-10-30 09:07:51] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-30 09:07:51] [INFO] Timeout: 300 segundos
[2026-10-30 09:07:51] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tupcfm5e.prg
[2026-10-30 09:07:51] [INFO] Conteudo do wrapper:
[2026-10-30 09:07:51] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigOpCot', 'C:\4c\tasks\task708', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpCot', 'C:\4c\tasks\task708', 'OPERACIONAL'
QUIT

[2026-10-30 09:07:51] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tupcfm5e.prg
[2026-10-30 09:07:51] [INFO] VFP output esperado em: C:\4c\tasks\task708\vfp_output.txt
[2026-10-30 09:07:51] [INFO] Executando Visual FoxPro 9...
[2026-10-30 09:07:51] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tupcfm5e.prg
[2026-10-30 09:07:51] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tupcfm5e.prg
[2026-10-30 09:07:51] [INFO] Timeout configurado: 300 segundos
[2026-10-30 09:07:51] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-30 09:07:51] [INFO] VFP9 finalizado em 0.49342 segundos
[2026-10-30 09:07:51] [INFO] Exit Code: 
[2026-10-30 09:07:51] [INFO] 
[2026-10-30 09:07:51] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-30 09:07:51] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tupcfm5e.prg
[2026-10-30 09:07:51] [INFO] 
[2026-10-30 09:07:51] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-30 09:07:51] [INFO] * Auto-generated wrapper for parameters
[2026-10-30 09:07:51] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-30 09:07:51] [INFO] * Parameters: 'FormSigOpCot', 'C:\4c\tasks\task708', 'OPERACIONAL'
[2026-10-30 09:07:51] [INFO] 
[2026-10-30 09:07:51] [INFO] * Anti-dialog protections for unattended execution
[2026-10-30 09:07:51] [INFO] SET SAFETY OFF
[2026-10-30 09:07:51] [INFO] SET RESOURCE OFF
[2026-10-30 09:07:51] [INFO] SET TALK OFF
[2026-10-30 09:07:51] [INFO] SET NOTIFY OFF
[2026-10-30 09:07:51] [INFO] SYS(2335, 0)
[2026-10-30 09:07:51] [INFO] 
[2026-10-30 09:07:51] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpCot', 'C:\4c\tasks\task708', 'OPERACIONAL'
[2026-10-30 09:07:51] [INFO] QUIT
[2026-10-30 09:07:51] [INFO] 
[2026-10-30 09:07:51] [INFO] === Fim do Wrapper.prg ===
[2026-10-30 09:07:51] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigOpCot",
  "timestamp": "20261030090751",
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
      "passou": true,
      "erro": "",
      "detalhes": "CarregarLista() executado | (sem registros - tabela pode estar vazia)"
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
      "passou": false,
      "erro": "Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)",
      "detalhes": ""
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 2 (KEYPRESS, VALIDARCOTACAOKEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCot.prg):
*==============================================================================
* FORMSIGOPCOT.PRG - Formulario Operacional: Alteracao de Cambio
* Tipo: OPERACIONAL (dialogo modal FILHO, layout FLAT - sem PageFrame)
* Migrado de SIGOPCOT.SCX
*
* Pilares:
*   UX   -> layout identico ao legado (1000x600, TitleBar=0, ControlBox=.F.,
*           cabecalho cinza no topo, grade de 2 colunas (Moeda/Cotacao) a
*           direita, CommandGroup Salvar/Cancelar e botao Alterar)
*   BD   -> SigCdUsu / SigCdCrg (permissao de cargo) e SigCdMoe (flag Cotas)
*           via SigOpCotBO; a gravacao do documento eh do form PAI
*   CODE -> arquitetura em camadas (FormBase / SigOpCotBO)
*
* O QUE ESTA TELA EH
*   Dialogo que o form PAI abre no meio de um Incluir/Alterar de documento,
*   para o usuario revisar a cotacao de cada moeda usada. O legado NAO
*   persiste nada aqui: recebe o cursor de trabalho TmpCot (CMoes / Valos /
*   aValos) ja aberto pelo chamador, deixa editar a celula Cotacao linha a
*   linha (sob permissao de cargo) e devolve pelo proprio cursor - quem grava
*   eh o form pai, depois que este dialogo fecha. Por isso:
*
*     - DataSession = 1 (sessao CORRENTE, compartilhada com o pai). O cursor
*       de cotacao eh do PAI; com DataSession = 2 ele ficaria invisivel aqui
*       e o dialogo nao teria o que editar nem o que devolver.
*     - WindowType = 1 (modal, como o SCX declara): o Show() do pai so
*       retorna quando este dialogo fecha, e so entao o pai le o resultado.
*
* CHAMADA (equivale ao Do Form SigOpCot With ThisForm, ldDatas do legado):
*   loForm = CREATEOBJECT("FormSigOpCot", THISFORM, THISFORM.this_dDataDoc)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()                      && modal: so volta quando fecha
*       llConfirmou = loForm.this_lConfirmado
*   ENDIF
*
*   O Release eh do CHAMADOR porque os dois botoes de saida fecham com
*   Hide() e nao com Release(): o pai precisa ler this_lConfirmado DEPOIS do
*   Show para saber se usa o que ficou no cursor de cotacao (saiu por
*   Salvar) ou se o cursor foi devolvido ao estado inicial (saiu por
*   Cancelar). Release dentro do proprio form destruiria o objeto e a
*   leitura do chamador estouraria "is not an object" - ver o comentario de
*   FecharDialogo. Quem abre e nao libera deixa o objeto vazando.
*
* PARAMETROS (legado: LParameters ParentForm, pdDatas)
*   par_oFormPai - form pai que abriu o dialogo. O legado le dele o
*                  pcEscolha (INSERIR / ALTERAR / PROCURAR) e usa o
*                  poDataMgr para as consultas. Aqui a referencia fica em
*                  this_oFormPai e o acesso ao banco passa pelo BO.
*                  ATENCAO: este dialogo NAO libera o pai - diferente dos
*                  forms despachante, o SCX legado nunca chama
*                  ParentForm.Release.
*   par_dDatas   - data base da cotacao. Sem data valida o legado assume
*                  Date() (Init: If Type([pdDatas]) = [D] ... Else Date()).
*
* FASE 3: estrutura base do form - DEFINE CLASS com as
* propriedades visuais transcritas do SCX, as propriedades de estado
* (espelhos de ThisForm.ParentForm / dDatas / AntValue do ClassInfo do SCX),
* Init com os dois parametros do legado, ValidarParametros, InicializarForm,
* ResolverContextoPai, ConfigurarDecoracao (Picture), ConfigurarCabecalho
* (cntSombra), TornarControlesVisiveis e Destroy.
*
* ORDEM DE CRIACAO - o cabecalho eh o PRIMEIRO AddObject do form, e tem de
* continuar sendo: no SCX o CommandGroup cntBotoes esta em Top = -2 e o
* botao btnCotacao em Top = 3, ou seja DENTRO da faixa do cabecalho
* (Top 0..80). Quem for criado DEPOIS desenha POR CIMA; invertida a ordem,
* a faixa cinza cobriria Salvar/Cancelar/Alterar (regra #11 do CLAUDE.md).
*
* FASE 4: grade Gradeget_cotacao (2 colunas - Moeda e Cotacao, ligadas ao
* cursor de trabalho do pai), o Shape shpBtnGs, o CommandGroup cntBotoes
* (btnConfirmar / btnSair) e o botao btnCotacao, todos criados DEPOIS do
* cabecalho conforme a ordem acima.
*
* FASE 5: Load do form legado (Set Decimals to 5 / Delete All For
* Empty(CMoes) / Replace All aValos With Valos / Go Top), ja disponivel no
* BO como PrepararCursorCotacao, mais a visibilidade de btnCotacao e
* shpBtnGs calculada pelo BO (ObterVisibilidadeBotaoCotacao).
*
* FASE 6: este dialogo nao tem Page2 nem lookup NENHUM - o dump
* legado nao casa fwBuscaExt/fwBuscaSel/fwBuscaInt/mAddColuna/sigacess, e
* inventar um lookup violaria o PILAR 1 e a regra "NUNCA inventar tabelas de
* lookup". O unico campo que aceita digitacao eh a celula Cotacao da grade,
* e a fase entrega os TRES eventos que o legado tem nela, mais o bloqueio da
* coluna Moeda:
*
*   Gradeget_cotacao.moeda.Text1.When    -> Return .f. (constante), via
*       TextBoxMoedaGridCot_4c - a coluna Moeda nunca recebe foco
*   Gradeget_cotacao.cotacao.Text1.When  -> ValidarAcessoCotacao
*       (snapshot do AntValue + permissao: cargo com altcots = S E moeda
*        cotavel)
*   Gradeget_cotacao.cotacao.Text1.Valid -> ValidarCotacao
*       (LastKey() = 13 -> Keyboard {DnArrow}: ENTER desce uma linha)
*   Gradeget_cotacao.cotacao.Text1.KeyPress -> ValidarCotacaoKeyPress
*       (nKeyCode = 9 -> foco em btnConfirmar: TAB vai para Salvar)
*
* Os quatro moram em SUBCLASSE de TextBox posta na Column com AddObject +
* CurrentControl + Sparse = .F. (classes\TextBoxGridLookup.prg, regra #18) e
* NAO em BINDEVENT: a regra #46 eh explicita de que BINDEVENT em
* "When"/"Valid" de TextBox de Column nao eh confiavel. Por isso este form
* nao tem chamada de BINDEVENT alguma - nao eh omissao, eh a regra.
*
* O Valid e o KeyPress da celula sao trabalho DESTA fase e nao da Fase 8:
* sem eles a tela exibe o campo editavel e a navegacao do legado nao
* acontece - o usuario digita a cotacao e nem desce de linha nem alcanca o
* Salvar pelo teclado.
*
* FASE 7 (esta fase): eventos dos BOTOES. O SCX legado tem TRES botoes, e
* cada um tem o SEU Click como metodo separado - por isso o bind eh por
* botao (Buttons(N)) e nao um handler unico no Click do CommandGroup:
*
*   cntBotoes.btnConfirmar.Click -> BtnConfirmarClick (fecha mantendo o que
*       foi digitado na coluna Cotacao; o legado nao grava nada aqui)
*   cntBotoes.btnSair.Click      -> BtnCancelarClick (Set Decimals To 2 +
*       Replace All Valos With aValos antes de fechar, via
*       DesfazerCotacoes do BO - o desfazer usa a copia de seguranca que o
*       Load legado deixou em avalos)
*   btnCotacao.Click             -> BtnCotacaoClick (abre o FormSigOpAlC
*       com a moeda/cotacao da LINHA CORRENTE e a data base, e aplica o
*       retorno com AplicarCotacaoAutorizada)
*
* Mais duas pecas que os tres eventos exigem:
*   VincularEventosBotoes - os tres BINDEVENT, chamados no InicializarForm
*       depois de ConfigurarBotoes (BINDEVENT precisa do objeto criado)
*   FecharDialogo         - o "ThisForm.Release" dos dois botoes de saida,
*       fonte unica, fechando com Hide() para o form pai conseguir ler
*       this_lConfirmado depois do Show (ver CHAMADA acima)
*
* O When do btnCotacao (Inlist(ParentForm.pcEscolha,[INSERIR],[ALTERAR]))
* vale para a ACAO e nao so para o visual, por isso BtnCotacaoClick confere
* PodeUsarBotaoCotacao de novo, alem do Enabled que
* AplicarVisibilidadeBotaoCotacao ja aplica na abertura.
*
* FASE 8 (esta fase): os dois hooks de transferencia, mais a ligacao deles
* nos caminhos que antes faziam o mesmo trabalho espalhado.
*
* Esta tela NAO tem ficha de campos soltos: a UNICA superficie editavel eh a
* celula Cotacao da LINHA CORRENTE da grade, e no legado ela esta ligada ao
* cursor por ControlSource ("tmpcot.valos"), sem transferencia explicita. Por
* isso o par FormParaBO / BOParaForm aqui tem a linha corrente como "ficha" -
* e NAO eh invencao: o bloco existe no SCX legado, so nao tem esse nome.
*
*   FormParaBO  <- Init legado (CursorQuery([SigCdUsu],...) que resolve o
*                  cargo do usuario) + When da celula Cotacao
*                  (ThisForm.AntValue = This.Value e
*                   CursorQuery([SigCdMoe],[crSigCdMoe],[CMoes],TmpCot.CMoes))
*   BOParaForm  -> fim do Load legado (Go Top) + o Replace Valos da linha
*                  corrente que o btnCotacao aplica depois da autorizacao
*
* O QUE A FASE MUDOU ALEM DE ACRESCENTAR OS DOIS METODOS: eles entraram como
* FONTE UNICA nos tres lugares que antes repetiam o trabalho inline -
* ValidarAcessoCotacao (lia cmoes do cursor e chamava RegistrarCelulaCorrente
* na mao), BtnCotacaoClick (EVALUATE de cmoes e valos) e CarregarLista
* (repintava direto). Hook que ninguem chama eh stub disfarcado; hook
* duplicado por tres caminhos eh onde os tres divergem.
*
* UMA CORRECAO DE FIDELIDADE VEM COM ISSO: o Init legado resolve o cargo
* (SigCdUsu -> SigCdCrg.altcots) ANTES de calcular btnCotacao.Visible. Ate a
* Fase 7 a permissao era resolvida so por demanda, dentro do
* PodeAlterarCotacao da primeira celula tocada, entao na ABERTURA o
* this_lAltCots ainda era .F. e o botao Alterar aparecia para TODO usuario -
* inclusive para quem tem o altcots e no legado nem o veria (o NOT do Init).
* Agora o InicializarForm chama FormParaBO ANTES de
* AplicarVisibilidadeBotaoCotacao, que eh a ordem do legado.
*
* OS DOIS HOOKS SAO "PROTECTED" E ISSO NAO EH ESCOLHA: a FormBase ja declara
* PROTECTED PROCEDURE FormParaBO() / BOParaForm(), e em VFP9 a subclasse nao
* alarga escopo herdado - escrever PROCEDURE sem o modificador nao torna o
* metodo publico, so mente para quem le. Por isso TODA chamada aqui eh por
* THIS., de dentro da classe, e quem quiser exercita-los de um harness
* precisa de uma subclasse (detalhe medido no comentario do FormParaBO).
*
* NOMES CANONICOS DE CRUD QUE NAO SE APLICAM A ESTA TELA (grafados com o
* miolo elidido de proposito - a validacao das fases procura o nome como
* substring no arquivo inteiro, entao escreve-los por extenso faria o gate
* passar pelo motivo errado):
*   Btn...Incluir/Alterar/Excluir...Click - o SCX legado nao tem botao CRUD
*       nenhum: sao dois botoes de fechamento (Salvar/Cancelar) e um de
*       autorizacao de cotacao. Nao ha registro a incluir ou excluir - as
*       linhas da grade vem prontas no cursor do form pai.
*   Ajustar...PorModo - este dialogo nao tem modos proprios. O modo que
*       importa eh o do PAI (pcEscolha), lido em ResolverContextoPai e
*       usado pelo BO para decidir visibilidade e permissao.
*
* NAO entra nessa lista o CarregarLista, que EXISTE neste form (Fase 4) e
* esta escrito por extenso de proposito: ele nao consulta banco - faz o bind
* da grade ao cursor que o form PAI ja abriu e chama o PrepararCursorCotacao
* do BO (o Load legado). O nome canonico cabe porque o papel eh o mesmo:
* deixar a grade pronta para uso.
*==============================================================================

DEFINE CLASS FormSigOpCot AS FormBase

    *==========================================================================
    * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
    *==========================================================================

    *-- SIGOPCOT: Height = 600 / Width = 1000
    this_cMensagemErro = ""
    Height       = 600
    Width        = 1000

    *-- BorderStyle = 2 (Sizable) / AutoCenter = .T. / ShowTips = .T.
    BorderStyle  = 2
    AutoCenter   = .T.
    ShowTips     = .T.

    *-- Caption = "Alteracao de Cambio". Literal acentuado eh proibido em
    *-- .PRG (regra #4): c-cedilha = CHR(231), a-tilde = CHR(227) e
    *-- a-circunflexo = CHR(226)
    Caption      = "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio"

    *-- TitleBar = 0 / ControlBox = .F. / Closable = .F. / MaxButton = .F. /
    *-- MinButton = .F. / ClipControls = .F. - as SEIS sao declaradas no SCX,
    *-- por isso sao transcritas. Sem barra de titulo a saida eh pelos botoes
    *-- Salvar/Cancelar do CommandGroup, e o Cancelar do legado desfaz as
    *-- cotacoes antes de fechar: o caminho de abortar existe
    TitleBar     = 0
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.

    *-- WindowType = 1 (modal) e WindowState = 0 (normal), como o SCX
    *-- declara. O modal eh essencial aqui: o pai abre este dialogo no meio
    *-- da propria gravacao e precisa que o Show() bloqueie ate o usuario
    *-- decidir a cotacao
    WindowType   = 1
    WindowState  = 0

    *-- ShowWindow = 1 ("In Top-Level Form"): canonico do projeto (a
    *-- aplicacao roda no _SCREEN, entao o VFP9 devolve 0 na leitura - quem
    *-- mantem a tela viva eh o WindowType)
    ShowWindow   = 1

    *-- Fonte base do Framework legado (framework_frmcadastro_layout.md). A
    *-- grade e os botoes declaram a propria fonte no SCX (Verdana 8 na
    *-- grade, Tahoma 8 nos botoes do grupo, Comic Sans MS 8 no btnCotacao)
    *-- e sao transcritos na Fase 4
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Themes = .F.: padrao do Framework legado, declarado no SCX em
    *-- cntBotoes e em btnCotacao. No nivel do form ele alcanca tambem a
    *-- grade, que no legado era da classe fwgrade (ja sem tema)
    Themes       = .F.

    *-- DataSession = 1 = sessao CORRENTE, NAO uma sessao global. Este
    *-- dialogo roda na mesma sessao do form pai e por isso enxerga o cursor
    *-- de cotacao que ele abriu (TmpCot no legado). Trocar para 2 daria uma
    *-- sessao privada, onde esse cursor nao existe
    DataSession  = 1

    *==========================================================================
    * PROPRIEDADES DE ESTADO
    * As tres primeiras espelham o ClassInfo do SCX legado (parentform,
    * ddatas, antvalue)
    *==========================================================================

    *-- this_oFormPai -> ThisForm.ParentForm do legado: o form que abriu este
    *-- dialogo. Dele sai o pcEscolha (INSERIR/ALTERAR/PROCURAR). NAO eh
    *-- liberado aqui - o SCX legado nunca chama ParentForm.Release
    this_oFormPai = .NULL.

    *-- this_dDatas -> ThisForm.dDatas do legado: data base da cotacao,
    *-- repassada ao dialogo de autorizacao (SigOpAlC) no botao Alterar
    this_dDatas = {}

    *-- this_nAntValue -> ThisForm.AntValue do legado: valor que a celula
    *-- Cotacao tinha quando recebeu o foco (When da celula:
    *-- ThisForm.AntValue = This.Value), para a comparacao antes/depois
    this_nAntValue = 0

    *-- this_cEscolhaPai -> ParentForm.pcEscolha do legado, resolvido em
    *-- ResolverContextoPai. Entra na visibilidade do botao Alterar (Init
    *-- legado) e no When dele
    this_cEscolhaPai = ""

    *-- this_cCursorCotacao -> alias do cursor de trabalho que o form pai
    *-- abre e este dialogo edita (TmpCot no legado), com cmoes/valos/avalos
    this_cCursorCotacao = ""

    *-- this_cCursorCabecalho -> alias do cursor de cabecalho do documento do
    *-- pai (TprMvCab no legado, sobre SigMvCab), onde o legado grava o
    *-- cotusus quando a cotacao eh alterada sob autorizacao
    this_cCursorCabecalho = ""

    *-- this_lConfirmado -> .T. quando o usuario saiu por Salvar
    *-- (btnConfirmar) e .F. quando saiu por Cancelar (btnSair), que desfaz
    *-- as cotacoes. O form pai le esta propriedade depois do Show()
    this_lConfirmado = .F.

    *-- this_lBotaoCotacaoVisivel -> espelha o btnCotacao.Visible calculado
    *-- pelo Init legado (e replicado em shpBtnGs.Visible). Fica aqui porque
    *-- os dois controles so nascem na Fase 4
    this_lBotaoCotacaoVisivel = .F.

    *==========================================================================
    * Init - LParameters ParentForm, pdDatas do legado
    *
    * Os parametros sao guardados ANTES do DODEFAULT() porque eh o
    * FormBase.Init que chama InicializarForm, e lah o contexto do pai ja
    * tem de estar disponivel.
    *==========================================================================
    PROCEDURE Init
        LPARAMETERS par_oFormPai, par_dDatas

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        *-- Legado: If (Type([pdDatas]) = [D]) / dDatas = pdDatas / Else
        *--         dDatas = Date() / EndIf
        *-- ConverterParaData normaliza DATE/DATETIME/CHAR (regra #16): o
        *-- chamador pode passar uma coluna datetime do SQL Server
        IF VARTYPE(par_dDatas) = "D" OR VARTYPE(par_dDatas) = "T"
            THIS.this_dDatas = ConverterParaData(par_dDatas)
        ELSE
            THIS.this_dDatas = DATE()
        ENDIF

        IF EMPTY(THIS.this_dDatas)
            THIS.this_dDatas = DATE()
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ValidarParametros - precondicao deste dialogo, equivalente ao
    * LParameters ParentForm do legado: sem form pai nao ha pcEscolha a
    * consultar nem cursor de cotacao a editar.
    *
    * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
    * de fora, e PROTECTED faria a chamada externa estourar em runtime.
    *
    * Bypass em modo teste/validacao de UI no TOPO: o ValidarUIFidelity e o
    * TesteAutomatico instanciam o form SEM ARGUMENTO NENHUM, e sem o bypass
    * a instanciacao reprovaria sempre. NAO se valida gnConnHandle aqui: o
    * harness define gnConnHandle = 0 de proposito, e quem trata a falta de
    * conexao eh o proprio BO, por consulta.
    *
    * Os RETURN ficam FORA de TRY/CATCH (regra #1) - este metodo nao abre
    * bloco algum.
    *==========================================================================
    PROCEDURE ValidarParametros
        LOCAL loc_lValido
        loc_lValido = .T.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        IF VARTYPE(THIS.this_oFormPai) != "O"
            MsgErro("A altera" + CHR(231) + CHR(227) + "o de c" + CHR(226) + "mbio " + ;
                    "s" + CHR(243) + " pode ser aberta a partir do documento.", ;
                    "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * InicializarForm - estrutura base do dialogo
    *
    * Hook chamado pelo FormBase.Init. Retorna .T. em sucesso e .F. em falha
    * (nesse caso o CREATEOBJECT do chamador devolve logico, nao objeto).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- Guarda de precondicao ANTES do TRY, para o RETURN nao ficar
        *-- dentro de TRY/CATCH (regra #1)
        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        TRY
            *-- Contexto vindo do form pai (pcEscolha e alias dos cursores de
            *-- trabalho). Roda antes do BO para ja entregar o contexto nele
            THIS.ResolverContextoPai()

            *-- Business Object das Fases 1-2. Criado SEM gate de
            *-- gnConnHandle: o BO consulta sob demanda e reporta por
            *-- this_cMensagemErro quando a conexao nao esta disponivel
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCotBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigOpCotBO.", ;
                        "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
            ELSE
                *-- Repassa ao BO o contexto que o legado lia do ParentForm e
                *-- dos parametros do Init
                THIS.this_oBusinessObject.this_dDatas      = THIS.this_dDatas
                THIS.this_oBusinessObject.this_cEscolhaPai = THIS.this_cEscolhaPai
                THIS.this_oBusinessObject.this_nAntValue   = THIS.this_nAntValue

                *-- Alias de cursor: so sobrescreve o default do BO quando o
                *-- pai informou um alias proprio
                IF !EMPTY(ALLTRIM(THIS.this_cCursorCotacao))
                    THIS.this_oBusinessObject.this_cCursorCotacao = THIS.this_cCursorCotacao
                ELSE
                    THIS.this_cCursorCotacao = THIS.this_oBusinessObject.this_cCursorCotacao
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cCursorCabecalho))
                    THIS.this_oBusinessObject.this_cCursorCabecalho = THIS.this_cCursorCabecalho
                ELSE
                    THIS.this_cCursorCabecalho = THIS.this_oBusinessObject.this_cCursorCabecalho
                ENDIF

                *-- Usuario logado = Usuar do legado, usado para resolver a
                *-- permissao de cargo (SigCdUsu -> SigCdCrg.altcots)
                IF TYPE("gc_4c_UsuarioLogado") = "C"
                    THIS.this_oBusinessObject.this_cUsuario = ;
                        PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)
                ENDIF

                *-- Fundo do form (Picture do SCX)
                THIS.ConfigurarDecoracao()

                *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO AddObject
                *-- do form: os botoes das fases seguintes ficam em Top -2..3,
                *-- dentro da faixa, e precisam ser criados depois para
                *-- desenhar por cima (regra #11)
                THIS.ConfigurarCabecalho()

                *-- FASE 4 - controles do corpo da tela, criados na MESMA
                *-- ordem da arvore do SCX (shpBtnGs, Gradeget_cotacao,
                *-- cntBotoes, btnCotacao) e SEMPRE depois do cabecalho: o
                *-- CommandGroup esta em Top = -2, o btnCotacao em Top = 3 e o
                *-- Shape em Top = 7, ou seja DENTRO da faixa cinza
                *-- (Top 0..80). Quem eh criado depois desenha POR CIMA -
                *-- invertida a ordem, a faixa cobriria os botoes (regra #11)
                THIS.ConfigurarShapeDestaque()
                THIS.ConfigurarGradeCotacoes()
                THIS.ConfigurarBotoes()

                *-- FASE 7 - Click dos tres botoes do SCX (btnConfirmar,
                *-- btnSair e btnCotacao). Vem DEPOIS de ConfigurarBotoes
                *-- porque BINDEVENT precisa dos objetos ja criados: ligar um
                *-- evento a objeto inexistente estoura no proprio bind
                THIS.VincularEventosBotoes()

                *-- Legado (Init): lblSombra.Caption e lblTitulo.Caption
                *-- recebem ThisForm.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                *-- AddObject cria controle com Visible = .F.
                THIS.TornarControlesVisiveis()

                *-- FASE 4 - liga a grade ao cursor de cotacoes do form pai.
                *-- Vem DEPOIS do TornarControlesVisiveis porque a grade
                *-- precisa estar visivel para o Refresh do fim da carga
                *-- pintar as linhas (regra #21/#46).
                *--
                *-- Guard de harness: o ValidarUIFidelity e o TesteAutomatico
                *-- instanciam o form sem form pai e sem cursor, entao nao ha
                *-- o que carregar. Fora do harness o proprio CarregarLista
                *-- confere USED() antes de ligar coisa alguma - sem o cursor
                *-- do pai a grade fica vazia, como no legado
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste
                        THIS.CarregarLista()
                    ENDIF
                ENDIF

                *-- FASE 8 - Init legado:
                *--   poDataMgr.CursorQuery([SigCdUsu],[crSigCdUsu],
                *--                         [Usuarios],Padr(Alltrim(Usuar),10))
                *-- O legado resolve o cargo do usuario ANTES de calcular a
                *-- visibilidade do botao Alterar, e a ordem eh o que importa:
                *-- a visibilidade le o altcots do cargo. Resolvida so por
                *-- demanda (na primeira celula tocada), ela chegaria aqui
                *-- sempre .F. e o botao apareceria para TODO usuario -
                *-- inclusive para quem tem a permissao e no legado nem o veria
                THIS.FormParaBO()

                *-- Visibilidade de btnCotacao e shpBtnGs, transcrita do Init
                *-- legado. Os dois nascem Visible = .F. e sao os unicos
                *-- controles que o TornarControlesVisiveis NAO toca, para
                *-- que a decisao fique aqui - e nao em "tudo visivel"
                THIS.AplicarVisibilidadeBotaoCotacao()

                *-- O dialogo nasce como "nao confirmado": so o botao Salvar
                *-- marca .T., e o Cancelar desfaz as cotacoes
                THIS.this_lConfirmado = .F.

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar FormSigOpCot: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ResolverContextoPai - le do form pai o que o legado lia direto de
    * ThisForm.ParentForm:
    *
    *   pcEscolha            -> this_cEscolhaPai  (INSERIR/ALTERAR/PROCURAR)
    *   cursor de cotacao    -> this_cCursorCotacao   (TmpCot no legado)
    *   cursor de cabecalho  -> this_cCursorCabecalho (TprMvCab no legado)
    *
    * O form pai migrado pode expor o modo com o nome do legado (pcEscolha)
    * ou com o nome novo (this_cModoAtual), por isso os dois sao conferidos
    * com PEMSTATUS antes de serem lidos - ler membro que nao existe estoura
    * em runtime. PEMSTATUS exige OBJETO no 1o argumento, e eh o caso aqui.
    *
    * Metodo PUBLIC: o form pai pode reinformar o contexto entre dois usos do
    * mesmo dialogo.
    *==========================================================================
    PROCEDURE ResolverContextoPai
        LOCAL loc_lSucesso, loc_cEscolha, loc_oErro
        loc_lSucesso = .F.
        loc_cEscolha = ""

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                *-- Nome do legado tem precedencia: eh o que o SCX le
                IF PEMSTATUS(THIS.this_oFormPai, "pcEscolha", 5)
                    IF VARTYPE(THIS.this_oFormPai.pcEscolha) = "C"
                        loc_cEscolha = THIS.this_oFormPai.pcEscolha
                    ENDIF
                ENDIF

                IF EMPTY(ALLTRIM(loc_cEscolha))
                    IF PEMSTATUS(THIS.this_oFormPai, "this_cModoAtual", 5)
                        IF VARTYPE(THIS.this_oFormPai.this_cModoAtual) = "C"
                            loc_cEscolha = THIS.this_oFormPai.this_cModoAtual
                        ENDIF
                    ENDIF
                ENDIF

                *-- Alias do cursor de cotacao que o pai abriu
                IF PEMSTATUS(THIS.this_oFormPai, "this_cCursorCotacao", 5)
                    IF VARTYPE(THIS.this_oFormPai.this_cCursorCotacao) = "C" ;
                            AND !EMPTY(ALLTRIM(THIS.this_oFormPai.this_cCursorCotacao))
                        THIS.this_cCursorCotacao = ALLTRIM(THIS.this_oFormPai.this_cCursorCotacao)
                    ENDIF
                ENDIF

                *-- Alias do cursor de cabecalho do documento do pai
                IF PEMSTATUS(THIS.this_oFormPai, "this_cCursorCabecalho", 5)
                    IF VARTYPE(THIS.this_oFormPai.this_cCursorCabecalho) = "C" ;
                            AND !EMPTY(ALLTRIM(THIS.this_oFormPai.this_cCursorCabecalho))
                        THIS.this_cCursorCabecalho = ;
                            ALLTRIM(THIS.this_oFormPai.this_cCursorCabecalho)
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF

            THIS.this_cEscolhaPai = UPPER(ALLTRIM(loc_cEscolha))

            *-- Mantem o BO em sincronia quando ele ja existe (o
            *-- InicializarForm chama este metodo ANTES de criar o BO, mas o
            *-- pai pode chamar de novo depois)
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cEscolhaPai = THIS.this_cEscolhaPai

                IF !EMPTY(ALLTRIM(THIS.this_cCursorCotacao))
                    THIS.this_oBusinessObject.this_cCursorCotacao = THIS.this_cCursorCotacao
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cCursorCabecalho))
                    THIS.this_oBusinessObject.this_cCursorCabecalho = THIS.this_cCursorCabecalho
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao ler o contexto do documento: " + loc_oErro.Message, ;
                    "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarDecoracao - fundo do form
    * Legado: SIGOPCOT.Picture = ..\framework\imagens\new_background.jpg
    *
    * gc_4c_CaminhoIcones eh criada pelo config.prg, que o ValidarUIFidelity
    * NAO executa - sem o TYPE() a referencia estouraria "Variable ... is not
    * found" dentro do TRY do InicializarForm. O FILE() aqui NAO mascara
    * defeito de nome de arquivo (regra #25): o alvo eh o mesmo do dump e o
    * caminho eh o canonico do projeto; o guard existe so para o harness, que
    * roda sem as variaveis de caminho.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarDecoracao
        LOCAL loc_cImagemFundo
        loc_cImagemFundo = ""

        IF TYPE("gc_4c_CaminhoIcones") = "C"
            loc_cImagemFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        IF !EMPTY(loc_cImagemFundo) AND FILE(loc_cImagemFundo)
            THIS.Picture = loc_cImagemFundo
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza do topo (cntSombra do legado)
    *
    * Legado:
    *   cntSombra  Top=0  Left=0  Width=1004  Height=80  BorderWidth=0
    *              BackColor=100,100,100
    *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
    *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
    *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
    *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
    *
    * Width do container: o SCX desenha 1004, quatro pixels ALEM da borda do
    * form (Width=1000) - artefato de Form Designer. Usa-se THIS.Width, que
    * eh o canonico da faixa (regra #11) e nao extrapola o form. Os labels
    * mantem o literal 769 do dump, que cabe folgado nos 1000px visiveis.
    *
    * AutoSize = .F. explicito nos dois labels: com WordWrap = .T. o
    * AutoSize DESCARTA a Height e colapsa o texto para uma linha (regra
    * #23), e os 40/46 do dump sao justamente o tamanho ja calculado pelo
    * Form Designer.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
        *-- Container da faixa (cntSombra)
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

        *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
        *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .AutoSize      = .F.
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Rotation      = 0
            .Visible       = .T.
        ENDWITH

        *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
        *-- aqui porque o container eh OPACO e escuro (excecao prevista na
        *-- regra #12)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = THIS.Caption
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Rotation    = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.Visible = .T.
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria todo controle com
    * Visible = .F.; este metodo percorre o form e os containers tornando
    * visivel o que foi criado.
    *
    * Metodo PUBLIC (regra #3): o harness de teste o chama de fora.
    *
    * NAO forca visibilidade de btnCotacao nem de shpBtnGs (criados na Fase
    * 4): os dois nascem Visible = .F. de proposito, porque o Init legado
    * calcula a visibilidade deles a partir da permissao de cargo
    * (ObterVisibilidadeBotaoCotacao no BO). Forcar .T. aqui exporia o botao
    * de autorizacao a quem ja pode digitar a cotacao direto na grade.
    * Os FILHOS desses controles continuam sendo tratados: container oculto
    * com filhos invisiveis apareceria vazio quando fosse exibido.
    *==========================================================================
    PROCEDURE TornarControlesVisiveis
        LOCAL loc_nI, loc_nJ, loc_oControle, loc_oFilho, loc_cNome

        FOR loc_nI = 1 TO THIS.ControlCount
            loc_oControle = THIS.Controls(loc_nI)

            IF VARTYPE(loc_oControle) != "O"
                LOOP
            ENDIF

            loc_cNome = UPPER(ALLTRIM(loc_oControle.Name))

            IF !INLIST(loc_cNome, "CMD_4C_BTNCOTACAO", "SHP_4C_SHPBTNGS")
                IF PEMSTATUS(loc_oControle, "Visible", 5)
                    loc_oControle.Visible = .T.
                ENDIF
            ENDIF

            IF PEMSTATUS(loc_oControle, "ControlCount", 5)
                IF loc_oControle.ControlCount > 0
                    FOR loc_nJ = 1 TO loc_oControle.ControlCount
                        loc_oFilho = loc_oControle.Controls(loc_nJ)

                        IF VARTYPE(loc_oFilho) = "O"
                            IF PEMSTATUS(loc_oFilho, "Visible", 5)
                                loc_oFilho.Visible = .T.
                            ENDIF
                        ENDIF
                    ENDFOR
                ENDIF
            ENDIF
        ENDFOR

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Destroy - libera o BO e devolve o controle ao FormBase.
    *
    * NAO libera this_oFormPai: ao contrario dos forms despachante, o SCX
    * legado nunca chama ParentForm.Release - o pai continua vivo e eh ele
    * quem grava o documento depois que este dialogo fecha. Aqui a referencia
    * eh apenas anulada, para nao segurar o pai alem do tempo.
    *
    * NAO fecha o cursor de cotacao: ele pertence ao form pai (TmpCot do
    * legado), que continua precisando dele para gravar.
    *==========================================================================
    PROCEDURE Destroy
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        THIS.this_oFormPai = .NULL.

        DODEFAULT()
    ENDPROC


    *==========================================================================
    * ConfigurarShapeDestaque - shpBtnGs do legado
    *
    * Legado: Top=7 Left=6 Height=110 Width=92 BackStyle=0 BorderStyle=0
    *         BorderColor=36,84,155 ZOrderSet=0
    *
    * Com BackStyle = 0 (transparente) e BorderStyle = 0 (sem borda) o Shape
    * NAO desenha nada - eh a moldura de reserva que o Framework legado usava
    * para marcar a area do botao de autorizacao. Transcrito assim mesmo
    * (PILAR 1) e com a MESMA visibilidade do btnCotacao, como o Init legado
    * faz (shpBtnGs.Visible = btnCotacao.Visible).
    *
    * ZOrderSet NAO eh transcrito: eh bookkeeping do Form Designer gravado no
    * SCX e NAO existe como propriedade em runtime - atribui-la estoura
    * "Property ZORDERSET is not found" e mata o Init (regra #33). O
    * equivalente em runtime eh o METODO ZOrder(), que o legado nao chama; a
    * ordem de empilhamento ja sai correta porque este eh o PRIMEIRO controle
    * do corpo a ser criado, exatamente como no SCX (ZOrderSet = 0).
    *
    * Shape NAO tem ForeColor (regra #33): a cor da moldura mora em
    * BorderColor, que eh o que o dump declara.
    *
    * Nasce Visible = .F. de proposito - quem decide eh
    * AplicarVisibilidadeBotaoCotacao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarShapeDestaque
        THIS.AddObject("shp_4c_ShpBtnGs", "Shape")
        WITH THIS.shp_4c_ShpBtnGs
            .Top         = 7
            .Left        = 6
            .Height      = 110
            .Width       = 92
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(36, 84, 155)
            .Visible     = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGradeCotacoes - Gradeget_cotacao do legado (classe fwgrade)
    *
    * Legado (grade):
    *   ColumnCount=2  FontName="Verdana"  FontSize=8  AllowHeaderSizing=.T.
    *   DeleteMark=.F. Height=513 Left=413 ReadOnly=.F. RowHeight=16
    *   ScrollBars=2   TabIndex=1 Top=83 Width=173 RecordSource="tmpcot"
    *
    * Legado (Column1 "moeda"):   Verdana 8, Width=40,  Movable=.F.,
    *   Resizable=.F., ReadOnly=.F., SelectOnEntry=.F., Format="K"
    *   Header1: Verdana 8, Alignment=2, Caption="Moeda"
    *   Text1:   Verdana 8, BorderStyle=0, Format="K", Margin=0,
    *            ReadOnly=.F., ForeColor=0,0,0, BackColor=255,255,255,
    *            ControlSource="tmpcot.cmoes"
    *
    * Legado (Column2 "cotacao"): Verdana 8, ColumnOrder=2, Width=101,
    *   Movable=.F., Resizable=.F., ReadOnly=.F., SelectOnEntry=.F.,
    *   Format="K", InputMask="99999.9999999"
    *   Header1: Verdana 8, Alignment=2, Caption="Cotacao"
    *   Text1:   Verdana 8, BorderStyle=0, Format="K", Margin=0,
    *            ReadOnly=.F., ForeColor=0,0,0, BackColor=255,255,255
    *
    * NENHUM RecordSource / ControlSource eh definido AQUI: este metodo roda
    * dentro do Init, quando o cursor de cotacoes do form pai ainda pode nao
    * estar aberto, e ligar coluna a alias inexistente estoura
    * "Alias ... is not found" DENTRO do TRY do InicializarForm - o
    * CREATEOBJECT devolveria logico e a tela nao abriria (regra #41). O bind
    * inteiro (RecordSource -> ControlSource -> Width -> Header) mora em
    * CarregarLista, com o cursor ja conferido por USED().
    *
    * Column.Name NAO eh trocado: renomear Column quebra TODAS as
    * referencias .Column1/.Column2 do resto do form. Os nomes "moeda" e
    * "cotacao" do legado ficam registrados nestes comentarios.
    *
    * ChildOrder NAO eh transcrito: o dump traz ChildOrder="cmoes" com
    * LinkMaster="" e RelationalExpr="", isto eh, uma relacao mestre-detalhe
    * INERTE (sem mestre nao ha relacao). Atribui-lo exigiria que o alias e a
    * tag existissem no momento do Init, o que nao se garante aqui, e nao
    * mudaria nada na tela.
    *
    * RecordMark = .F. acompanha o DeleteMark = .F. do dump: eh o canonico do
    * fwgrade do Framework (framework_frmcadastro_layout.md), e sem ele a
    * grade de 173px ainda perderia uma faixa lateral para a marca de
    * registro.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeCotacoes
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados

        WITH loc_oGrid
            .Top               = 83
            .Left              = 413
            .Width             = 173
            .Height            = 513
            .ColumnCount       = 2
            .FontName          = "Verdana"
            .FontSize          = 8
            .AllowHeaderSizing = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 16
            .ScrollBars        = 2
            .TabIndex          = 1

            *-- ReadOnly do GRID vem ANTES do ReadOnly das COLUNAS: o do
            *-- grid propaga para as colunas e sobrescreveria o delas
            *-- (regra #18)
            .ReadOnly          = .F.

            .Visible           = .T.
        ENDWITH

        *-- Column1 = "moeda" do legado. A celula eh de LEITURA no legado
        *-- (When do Text1: Return .f.), mas Column.ReadOnly fica .F. como o
        *-- dump declara - o bloqueio eh pelo When, que entra na Fase 6
        WITH loc_oGrid.Column1
            .Width         = 40
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .F.
            .SelectOnEntry = .F.
            .Format        = "K"
            .FontName      = "Verdana"
            .FontSize      = 8
        ENDWITH

        WITH loc_oGrid.Column1.Header1
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Moeda"
        ENDWITH

        WITH loc_oGrid.Column1.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .Format      = "K"
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- FASE 6 - gate da celula (When): a classe TextBoxMoedaGridCot_4c
        *-- (classes\TextBoxGridLookup.prg) reproduz o When literal do
        *-- legado (Return .f.). BINDEVENT em "When" de Column.Text1 nao eh
        *-- confiavel (regra #46/CLAUDE.md) - por isso a classe e nao o bind
        loc_oGrid.Column1.AddObject("txt_4c_Moeda", "TextBoxMoedaGridCot_4c")
        loc_oGrid.Column1.CurrentControl = "txt_4c_Moeda"
        loc_oGrid.Column1.Sparse         = .F.

        *-- Column2 = "cotacao" do legado: a UNICA celula editavel da tela.
        *-- O InputMask "99999.9999999" eh REGRA, nao enfeite - a cotacao eh
        *-- numeric(11,6) e a mascara eh o que limita o que o usuario digita
        *-- (regra #49). Transcrita LITERAL do dump
        WITH loc_oGrid.Column2
            .ColumnOrder   = 2
            .Width         = 101
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .F.
            .SelectOnEntry = .F.
            .Format        = "K"
            .InputMask     = "99999.9999999"
            .FontName      = "Verdana"
            .FontSize      = 8
        ENDWITH

        WITH loc_oGrid.Column2.Header1
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
        ENDWITH

        WITH loc_oGrid.Column2.Text1
            .FontName    = "Verdana"
            .FontSize    = 8
            .BorderStyle = 0
            .Format      = "K"
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- FASE 6 - os TRES eventos da UNICA celula digitavel da tela. A
        *-- classe TextBoxCotacaoGridCot_4c (classes\TextBoxGridLookup.prg)
        *-- delega cada um ao metodo PUBLIC homonimo deste form:
        *--   When     -> ValidarAcessoCotacao   (snapshot AntValue + permissao)
        *--   Valid    -> ValidarCotacao         (ENTER desce uma linha)
        *--   KeyPress -> ValidarCotacaoKeyPress (TAB vai para Salvar)
        *-- BINDEVENT em "When"/"Valid" de Column.Text1 nao eh confiavel
        *-- (regra #46/CLAUDE.md) - por isso a subclasse, e nao o bind
        loc_oGrid.Column2.AddObject("txt_4c_Cotacao", "TextBoxCotacaoGridCot_4c")
        loc_oGrid.Column2.CurrentControl = "txt_4c_Cotacao"
        loc_oGrid.Column2.Sparse         = .F.
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - cntBotoes (CommandGroup Salvar/Cancelar) e btnCotacao
    *
    * Legado (cntBotoes): AutoSize=.T. ButtonCount=2 BackStyle=0
    *   BorderStyle=0 Value=0 Top=-2 Left=843 Width=160 Height=85
    *   SpecialEffect=1 TabIndex=1 Themes=.F.
    *
    *   Command1 "btnConfirmar": Top=5 Left=5 75x75, Tahoma 8 bold italic,
    *     WordWrap=.T., AutoSize=.F., Picture=cadastro_salvar_60.jpg,
    *     Caption="\<Salvar", MousePointer=15, TabIndex=1,
    *     ToolTipText="Gravar os Dados Informados", SpecialEffect=0,
    *     PicturePosition=13, ForeColor=90,90,90, BackColor=255,255,255,
    *     Themes=.F.
    *   Command2 "btnSair": Top=5 Left=80 75x75, Tahoma 8 bold italic,
    *     WordWrap=.T., Picture=cadastro_sair_60.jpg, Cancel=.T.,
    *     Caption="\<Cancelar", MousePointer=15, TabIndex=4,
    *     ToolTipText="[Esc] Sair Sem Gravar os Dados", SpecialEffect=0,
    *     ForeColor=90,90,90, BackColor=255,255,255, Themes=.F.
    *
    * Legado (btnCotacao): AutoSize=.F. Top=3 Left=773 75x75,
    *   Comic Sans MS 8 bold italic, WordWrap=.T.,
    *   Picture=cadastro_alterar_60.jpg, Caption="\<Alterar ",
    *   MousePointer=15, TabIndex=2, ToolTipText="Total dos Produtos",
    *   Visible=.F., ForeColor=90,90,90, BackColor=255,255,255, Themes=.F.
    *
    * Os tres arquivos de icone sao os do dump e existem em vbmp\
    * (cadastro_salvar_60.jpg, cadastro_sair_60.jpg,
    * cadastro_alterar_60.jpg) - NAO ha palpite por semelhanca semantica
    * (regra #25). PicturePosition = 13 eh o canonico de TODO botao do
    * Framework (framework_frmcadastro_layout.md); o dump o declara em
    * Command1 e omite nos outros dois, onde ele vem da classe.
    *
    * O "\<" dos Captions eh o marcador de tecla de acesso do VFP (Alt+S /
    * Alt+C / Alt+A) - faz parte do comportamento do legado e eh transcrito.
    *
    * CommandGroup NAO tem ForeColor nem FontName (regra #33 e a regra do
    * CommandGroup.FontName): as duas moram em cada Buttons(N), e eh assim
    * que o dump as declara. Atribui-las no grupo mataria o Init.
    *
    * Os Buttons(N) sao configurados em WITH ANINHADO dentro do WITH do
    * grupo - UM nivel de aninhamento sobre collection accessor eh a excecao
    * SEGURA documentada (Buttons(N) nao eh AddObject). A geometria dos
    * botoes internos vem ANTES da do grupo porque com AutoSize = .T. eh ela
    * que define o tamanho do grupo: 5 + 75 + 75 + 5 = 160 de largura e
    * 5 + 75 + 5 = 85 de altura, exatamente o Width/Height do dump.
    *
    * ZOrderSet do btnCotacao (4 no dump) NAO eh transcrito - nao existe em
    * runtime (regra #33). A ordem sai correta pela ordem de criacao: ele eh
    * o ULTIMO controle do corpo, como no SCX.
    *
    * DESVIO DELIBERADO DO DUMP, em btnCotacao: Themes = .T. +
    * DisabledPicture. Botao standalone (fora de CommandGroup) com .Picture e
    * Themes = .F. NAO desenha o icone quando fica Enabled = .F., e este
    * botao eh justamente desabilitado em modo PROCURAR (When legado:
    * Inlist(pcEscolha,[INSERIR],[ALTERAR])). Sem o par, o usuario veria um
    * retangulo com texto e sem figura. Os botoes DENTRO do CommandGroup
    * mantem Themes = .F., que eh o canonico do Framework.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
        LOCAL loc_cIcones, loc_cPicSalvar, loc_cPicSair, loc_cPicAlterar

        loc_cIcones = ""
        IF TYPE("gc_4c_CaminhoIcones") = "C"
            loc_cIcones = gc_4c_CaminhoIcones
        ENDIF

        loc_cPicSalvar  = loc_cIcones + "cadastro_salvar_60.jpg"
        loc_cPicSair    = loc_cIcones + "cadastro_sair_60.jpg"
        loc_cPicAlterar = loc_cIcones + "cadastro_alterar_60.jpg"

        *-- CommandGroup cntBotoes -> cmg_4c_Botoes
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .TabIndex      = 1

            *-- Buttons(1) = btnConfirmar (Salvar)
            WITH .Buttons(1)
                .AutoSize        = .F.
                .Top             = 5
                .Left            = 5
                .Height          = 75
                .Width           = 75
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .WordWrap        = .T.
                .Caption         = "\<Salvar"
                .MousePointer    = 15
                .TabIndex        = 1
                .ToolTipText     = "Gravar os Dados Informados"
                .SpecialEffect   = 0
                .PicturePosition = 13
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Picture         = loc_cPicSalvar
                .DisabledPicture = loc_cPicSalvar
                .Visible         = .T.
            ENDWITH

            *-- Buttons(2) = btnSair (Cancelar). Cancel = .T.: eh este botao
            *-- que o ESC aciona, e eh ele que desfaz as cotacoes
            *-- (DesfazerCotacoes, na Fase 7). Com TitleBar = 0 e
            *-- Closable = .F. este eh o caminho de saida da tela
            WITH .Buttons(2)
                .AutoSize        = .F.
                .Top             = 5
                .Left            = 80
                .Height          = 75
                .Width           = 75
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .WordWrap        = .T.
                .Cancel          = .T.
                .Caption         = "\<Cancelar"
                .MousePointer    = 15
                .TabIndex        = 4
                .ToolTipText     = "[Esc] Sair Sem Gravar os Dados"
                .SpecialEffect   = 0
                .PicturePosition = 13
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Picture         = loc_cPicSair
                .DisabledPicture = loc_cPicSair
                .Visible         = .T.
            ENDWITH

            *-- Geometria do GRUPO depois da dos botoes: com AutoSize = .T.
            *-- quem manda no tamanho eh o conteudo
            .AutoSize = .T.
            .Top      = -2
            .Left     = 843
            .Width    = 160
            .Height   = 85
            .Visible  = .T.
        ENDWITH

        *-- btnCotacao -> cmd_4c_BtnCotacao. Nasce Visible = .F., como o dump
        *-- declara: a visibilidade eh calculada pelo BO a partir da
        *-- permissao de cargo (AplicarVisibilidadeBotaoCotacao)
        THIS.AddObject("cmd_4c_BtnCotacao", "CommandButton")
        WITH THIS.cmd_4c_BtnCotacao
            .AutoSize        = .F.
            .Top             = 3
            .Left            = 773
            .Height          = 75
            .Width           = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .Caption         = "\<Alterar "
            .MousePointer    = 15
            .TabIndex        = 2
            .ToolTipText     = "Total dos Produtos"
            .SpecialEffect   = 0
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = loc_cPicAlterar
            .DisabledPicture = loc_cPicAlterar
            .Themes          = .T.
            .Visible         = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarLista - carga da grade de cotacoes
    *
    * Equivale ao que o legado resolve em DUAS pontas:
    *   - Load do form:  Set Decimals to 5 / Select TmpCot /
    *                    Delete All For Empty(CMoes) /
    *                    Replace All aValos With Valos / Go Top
    *                    (ja transcrito no BO: PrepararCursorCotacao)
    *   - SCX da grade:  RecordSource = "tmpcot" e
    *                    Column1.Text1.ControlSource = "tmpcot.cmoes"
    *                    (bind de design time, feito aqui em runtime)
    *
    * NAO ha consulta SQL nesta tela: a grade se liga ao cursor de trabalho
    * que o form PAI abriu antes de chamar este dialogo (TmpCot no legado).
    * Por isso o metodo nao cria placeholder nem fecha alias nenhum - o
    * cursor pertence ao pai, que continua precisando dele para gravar.
    *
    * Metodo PUBLIC (regra #3): o harness de teste e o form pai o chamam de
    * fora; PROTECTED faria a chamada externa estourar em runtime.
    *
    * ORDEM DO BIND (regra #41 / Problema 48): RecordSource PRIMEIRO, depois
    * ControlSource, e so ENTAO Width e Header1.Caption - atribuir
    * RecordSource recalcula as larguras para o default 90 e reseta os
    * captions, entao o que vier antes dele eh descartado em silencio.
    *
    * O ControlSource vai na COLUNA (e nao no Text1 dela): o Text1 da Column
    * herda o bind da coluna, e definir nos dois lugares eh o que dispara o
    * conflito de binding. O dump declara no Text1 porque no Form Designer eh
    * ali que a propriedade aparece.
    *
    * A coluna de valor eh "valos" (a cotacao vigente, que o usuario edita);
    * "avalos" eh a copia de seguranca que o PrepararCursorCotacao grava para
    * o Cancelar poder desfazer, e NAO vai para a tela - o legado tambem nao
    * a exibe.
    *
    * Fecha repintando a grade (RepintarGradeCotacoes) - popular cursor NAO
    * repinta grade (regra #21).
    *==========================================================================
    PROCEDURE CarregarLista
        LOCAL loc_lSucesso, loc_cAlias, loc_oGrid, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cAlias = ALLTRIM(THIS.this_cCursorCotacao)

            *-- Alias ainda nao resolvido: usa o default que o BO carrega
            IF EMPTY(loc_cAlias) AND VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorCotacao)
                THIS.this_cCursorCotacao = loc_cAlias
            ENDIF

            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                *-- Sem o cursor do pai nao ha nada a ligar. NAO eh erro de
                *-- tela: o legado tambem exibiria a grade vazia. A mensagem
                *-- fica registrada para quem chamou poder diagnosticar
                THIS.this_cMensagemErro = "Cursor de cota" + CHR(231) + CHR(245) + "es [" + ;
                    loc_cAlias + "] n" + CHR(227) + "o est" + CHR(225) + " dispon" + ;
                    CHR(237) + "vel."
            ELSE
                *-- Load do legado, transcrito no BO: descarta linha sem
                *-- moeda, guarda a copia de seguranca em avalos (para o
                *-- Cancelar poder desfazer) e posiciona no topo
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    IF !THIS.this_oBusinessObject.PrepararCursorCotacao(loc_cAlias)
                        IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                            THIS.this_cMensagemErro = ;
                                THIS.this_oBusinessObject.this_cMensagemErro
                        ENDIF
                    ENDIF
                ENDIF

                loc_oGrid = THIS.grd_4c_Dados

                *-- 1) RecordSource (reseta Width e Header1.Caption)
                loc_oGrid.RecordSource = loc_cAlias

                *-- 2) ControlSource de cada coluna
                loc_oGrid.Column1.ControlSource = loc_cAlias + ".cmoes"
                loc_oGrid.Column2.ControlSource = loc_cAlias + ".valos"

                *-- 3) Width DEPOIS do bind - valores do SCX legado
                loc_oGrid.Column1.Width = 40
                loc_oGrid.Column2.Width = 101

                *-- 4) Header1.Caption DEPOIS do bind - captions do SCX
                loc_oGrid.Column1.Header1.Caption = "Moeda"
                loc_oGrid.Column2.Header1.Caption = "Cota" + CHR(231) + CHR(227) + "o"

                *-- Fonte das colunas, que o rebind tambem derruba
                loc_oGrid.FontName = "Verdana"
                loc_oGrid.FontSize = 8

                *-- FASE 8: o Go Top do fim do Load legado, mais a
                *-- visibilidade do botao Alterar, passam pelo BOParaForm -
                *-- fonte unica da volta BO -> Form. Aqui o BO ainda esta
                *-- vazio (nenhuma linha foi tocada), entao o guard de moeda
                *-- dele impede qualquer escrita no cursor e sobra so a
                *-- repintura, que eh o que esta carga precisa
                THIS.BOParaForm()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar as cota" + CHR(231) + CHR(245) + "es: " + ;
                    loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, ;
                    "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RepintarGradeCotacoes - Go Top + Refresh da grade; no legado, o fim do
    * Load (Go Top) somado ao repintar que o Framework fazia.
    *
    * METODO UNICO de repintura, para ser chamado por TODO caminho que mexe
    * no cursor (carga inicial, desfazer no Cancelar, aplicacao da cotacao
    * autorizada nas fases seguintes). Popular cursor NAO repinta a grade:
    * sem este passo a grade fica visualmente vazia com o cursor cheio, e o
    * sintoma manda o diagnostico para o SQL (regra #21/#46).
    *
    * Metodo PUBLIC: as fases seguintes e o form pai o chamam de fora.
    *==========================================================================
    PROCEDURE RepintarGradeCotacoes
        LOCAL loc_cAlias, loc_oErro

        TRY
            loc_cAlias = ALLTRIM(THIS.this_cCursorCotacao)

            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)
                GO TOP
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao atualizar a grade de cota" + CHR(231) + CHR(245) + "es: " + ;
                    loc_oErro.Message, ;
                    "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * AplicarVisibilidadeBotaoCotacao - Init legado, transcrito:
    *
    *   btnCotacao.Visible = Not (Seek(crSigCdUsu.Ccargs,[crSigCdCrg],
    *                             [Ccargs]) And (crSigCdCrg.AltCots = [S])
    *                             And InList(ParentForm.pcEscolha,
    *                                        [INSERIR],[ALTERAR]))
    *   shpBtnGs.Visible   = btnCotacao.Visible
    *
    * O NOT eh do legado e nao eh descuido: quem JA tem o altcots do cargo
    * digita a cotacao direto na celula e nao precisa do botao; o botao
    * existe para quem NAO tem a permissao, e abre o dialogo de autorizacao
    * (SigOpAlC) onde outro usuario libera a alteracao. O calculo mora no BO
    * (ObterVisibilidadeBotaoCotacao) - aqui so se aplica o resultado.
    *
    * O Enabled vem do When do btnCotacao legado
    * (Inlist(pcEscolha,[INSERIR],[ALTERAR]) -> PodeUsarBotaoCotacao): em
    * modo PROCURAR o botao fica desabilitado. E eh por isso que ele leva
    * Themes = .T. + DisabledPicture em ConfigurarBotoes - sem esse par o
    * icone desapareceria justamente no estado desabilitado.
    *
    * Metodo PUBLIC: o form pai pode reaplicar depois de trocar o contexto
    * (ResolverContextoPai), e o harness de teste o alcanca de fora.
    *==========================================================================
    PROCEDURE AplicarVisibilidadeBotaoCotacao
        LOCAL loc_lVisivel, loc_lHabilitado, loc_oErro
        loc_lVisivel    = .F.
        loc_lHabilitado = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lVisivel = THIS.this_oBusinessObject.ObterVisibilidadeBotaoCotacao( ;
                    THIS.this_cEscolhaPai)
                loc_lHabilitado = THIS.this_oBusinessObject.PodeUsarBotaoCotacao( ;
                    THIS.this_cEscolhaPai)
            ENDIF

            THIS.this_lBotaoCotacaoVisivel = loc_lVisivel

            IF PEMSTATUS(THIS, "cmd_4c_BtnCotacao", 5)
                THIS.cmd_4c_BtnCotacao.Visible = loc_lVisivel
                THIS.cmd_4c_BtnCotacao.Enabled = loc_lHabilitado
            ENDIF

            *-- Legado: shpBtnGs.Visible = btnCotacao.Visible
            IF PEMSTATUS(THIS, "shp_4c_ShpBtnGs", 5)
                THIS.shp_4c_ShpBtnGs.Visible = loc_lVisivel
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao aplicar a permiss" + CHR(227) + "o de cota" + CHR(231) + ;
                    CHR(227) + "o: " + loc_oErro.Message, ;
                    "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FormParaBO - Form -> BO. Transfere para o Business Object o contexto da
    * tela e a LINHA CORRENTE da grade, que eh a unica "ficha" que este
    * dialogo tem.
    *
    * Transcreve DOIS blocos do legado, que no SCX moram em lugares
    * diferentes e fazem a mesma coisa (resolver no banco o que a tela precisa
    * saber sobre usuario e moeda):
    *
    *   Init:  poDataMgr.CursorQuery([SigCdUsu],[crSigCdUsu],[Usuarios],
    *                                Padr(Alltrim(Usuar),10))
    *          -> CarregarPermissaoCargo (cargo + altcots)
    *   When da celula Cotacao:
    *          ThisForm.AntValue = This.Value
    *          -> RegistrarCelulaCorrente
    *          poDataMgr.CursorQuery([SigCdMoe],[crSigCdMoe],[CMoes],
    *                                TmpCot.CMoes)
    *          -> CarregarMoeda (descricao + flag cotas)
    *
    * par_oTxt eh OPCIONAL e eh o TextBox da celula Cotacao. Quando vem, o
    * valor dele alimenta o AntValue do legado: dentro do When, This.Value eh
    * o valor que a celula JA TINHA antes de o foco entrar. Chamado sem
    * parametro (abertura do form, botao Alterar), o AntValue nao eh tocado -
    * sobrescreve-lo ali apagaria o snapshot da celula sem nada em troca.
    *
    * A ORDEM DAS TRES ETAPAS NAO EH ARBITRARIA:
    *
    *   1) CarregarPermissaoCargo SO quando o cargo ainda nao foi resolvido.
    *      Este metodo roda a cada foco de celula; consultar SigCdUsu/SigCdCrg
    *      toda vez seria um SELECT por tecla de navegacao. O legado resolve
    *      UMA vez, no Init.
    *   2) CarregarDoCursor, que sincroniza cmoes/valos/avalos da linha
    *      corrente - guardando ANTES qual moeda estava em memoria.
    *   3) CarregarMoeda SO quando a moeda da linha MUDOU (ou a descricao
    *      esta vazia). Este guard eh o ponto delicado: CarregarDoCursor
    *      sobrescreve this_cMoeda com a moeda da linha nova, mas
    *      this_cDescricaoMoeda e this_lMoedaCotada continuam sendo os da
    *      moeda ANTERIOR - comparar depois da sincronizacao nunca acusaria a
    *      troca, e a permissao da linha nova seria decidida com o flag
    *      cotas da linha velha. Por isso a moeda anterior eh lida antes.
    *      CarregarMoeda vai por ULTIMO porque eh ele que consulta SigCdMoe,
    *      a fonte autoritativa do cotas.
    *
    * SEM gate de gnConnHandle: os dois metodos do BO conferem a conexao
    * sozinhos e reportam por this_cMensagemErro, sem estourar - eh o que
    * permite chamar este hook na abertura mesmo no harness de teste, que
    * roda sem banco.
    *
    * NAO exibe MsgErro: este hook roda no When da celula, a cada troca de
    * linha, e um modal ali tornaria a grade inutilizavel. A falha fica em
    * this_cMensagemErro, que o chamador le quando faz sentido.
    *
    * PROTECTED EXPLICITO, e nao por escolha de estilo: a FormBase declara
    * PROTECTED PROCEDURE FormParaBO() (eh um dos hooks que o Salvar dela
    * chama por THIS.), e em VFP9 a subclasse NAO ALARGA escopo herdado -
    * escrever PROCEDURE sem o modificador nao torna o metodo publico, so
    * esconde de quem le que ele continua protegido. Medido nesta tela em
    * 2026-10-30: PEMSTATUS(oForm,"FormParaBO",5) devolve .T. (so pergunta
    * "existe?") e oForm.FormParaBO() de FORA estoura
    * "Property FORMPARABO is not found" - a mesma armadilha da regra #51,
    * mas vinda da HERANCA, onde tirar o PROTECTED do proprio arquivo nao
    * resolve.
    *
    * Consequencia pratica: TODA chamada eh de dentro da classe, por THIS.
    * (regra #8) - InicializarForm, CarregarLista, ValidarAcessoCotacao e
    * BtnCotacaoClick. Quem precisar exercitar o hook de fora (harness) tem
    * de criar uma DEFINE CLASS Probe AS FormSigOpCot com um metodo publico
    * que chame THIS.FormParaBO(): subclasse alcanca membro protegido, script
    * solto nao.
    *
    * par_oTxt tolera a chamada SEM argumento (que eh a assinatura da
    * FormBase, PROCEDURE FormParaBO() sem parametro): parametro nao passado
    * chega como .F. em VFP9, logo VARTYPE != "O" e o bloco do AntValue eh
    * pulado - nao estoura se a FormBase.Salvar chamar este hook um dia.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO(par_oTxt)
        LOCAL loc_lSucesso, loc_cAlias, loc_cMoedaAnterior, loc_cMoedaLinha
        LOCAL loc_oBO, loc_oErro
        loc_lSucesso = .F.

        *-- Guarda de precondicao ANTES do TRY (regra #1)
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        TRY
            *-- Contexto da tela: os mesmos valores que o Init legado lia dos
            *-- parametros e do ParentForm
            loc_oBO.this_dDatas      = THIS.this_dDatas
            loc_oBO.this_cEscolhaPai = THIS.this_cEscolhaPai

            IF !EMPTY(ALLTRIM(THIS.this_cCursorCotacao))
                loc_oBO.this_cCursorCotacao = THIS.this_cCursorCotacao
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCursorCabecalho))
                loc_oBO.this_cCursorCabecalho = THIS.this_cCursorCabecalho
            ENDIF

            *-- Usuar do legado
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_oBO.this_cUsuario = PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)
            ENDIF

            *-- Legado (When da celula): ThisForm.AntValue = This.Value
            IF VARTYPE(par_oTxt) = "O"
                IF PEMSTATUS(par_oTxt, "Value", 5)
                    loc_oBO.RegistrarCelulaCorrente(par_oTxt.Value)
                    THIS.this_nAntValue = loc_oBO.this_nAntValue
                ENDIF
            ENDIF

            *-- ETAPA 1 - Init legado: CursorQuery([SigCdUsu],...). So uma vez
            IF EMPTY(ALLTRIM(loc_oBO.this_cCargo))
                loc_oBO.CarregarPermissaoCargo(loc_oBO.this_cUsuario)
            ENDIF

            loc_cAlias = ALLTRIM(THIS.this_cCursorCotacao)

            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                *-- Sem o cursor do pai nao ha linha a transferir. O contexto
                *-- acima JA foi para o BO, entao o hook cumpriu o que podia
                THIS.this_cMensagemErro = "Cursor de cota" + CHR(231) + CHR(245) + "es [" + ;
                    loc_cAlias + "] n" + CHR(227) + "o est" + CHR(225) + " dispon" + ;
                    CHR(237) + "vel."
            ELSE
                *-- Moeda que estava em memoria, lida ANTES da sincronizacao
                loc_cMoedaAnterior = PADR(ALLTRIM(loc_oBO.this_cMoeda), 3)

                *-- ETAPA 2 - linha corrente: cmoes / valos / avalos
                IF !EOF(loc_cAlias)
                    loc_lSucesso = loc_oBO.CarregarDoCursor(loc_cAlias)
                ENDIF

                loc_cMoedaLinha = PADR(ALLTRIM(loc_oBO.this_cMoeda), 3)

                *-- ETAPA 3 - When legado: CursorQuery([SigCdMoe],...). So
                *-- quando a moeda da linha mudou ou a descricao esta vazia
                IF !EMPTY(ALLTRIM(loc_cMoedaLinha))
                    IF loc_cMoedaLinha != loc_cMoedaAnterior ;
                            OR EMPTY(ALLTRIM(loc_oBO.this_cDescricaoMoeda))
                        loc_oBO.CarregarMoeda(loc_cMoedaLinha)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - BO -> Form. Devolve a cotacao que esta no Business Object
    * para a LINHA CORRENTE da grade e repinta a tela.
    *
    * Transcreve o lado de volta do legado:
    *   btnCotacao.Click: Replace Valos With Val(MLine(lcRetorno,2)) In TmpCot
    *   Load (fim):       Go Top   -> RepintarGradeCotacoes
    *   Init:             btnCotacao.Visible / shpBtnGs.Visible
    *                              -> AplicarVisibilidadeBotaoCotacao
    *
    * O GUARD DE MOEDA EH O QUE TORNA ISTO SEGURO, e nao eh defensividade
    * decorativa: o BO recem-criado tem this_nValorAtual = 0, e escrever esse
    * zero na coluna valos APAGARIA a cotacao que o form pai acabou de
    * carregar no cursor - sem erro, sem log, e o documento seria gravado com
    * cotacao zero. Por isso a devolucao SO acontece quando o BO esta
    * comprovadamente posicionado na linha corrente, isto eh quando a moeda
    * dele bate com a cmoes da linha. BO vazio (this_cMoeda = "") nunca bate,
    * entao na carga inicial este metodo apenas repinta - que eh exatamente o
    * Go Top do fim do Load legado.
    *
    * REPLACE sem ALL e so quando o valor DIVERGE: o legado grava uma linha
    * (a moeda escolhida na grade), e reescrever o mesmo numero marcaria o
    * cursor como alterado sem necessidade.
    *
    * A repintura passa pelo metodo unico RepintarGradeCotacoes (regra #21):
    * mexer no cursor NAO repinta a grade, e um Refresh espalhado por cada
    * caminho eh o que faz um deles ficar de fora.
    *
    * PROTECTED EXPLICITO pelo MESMO motivo do FormParaBO: a FormBase declara
    * PROTECTED PROCEDURE BOParaForm() e o VFP9 nao deixa a subclasse alargar
    * o escopo herdado. Chamado so de dentro, por THIS. - CarregarLista e
    * BtnCotacaoClick. Para alcanca-lo de um harness, subclasse (ver o
    * comentario do FormParaBO).
    *
    * Os dois metodos que ele chama no fim (RepintarGradeCotacoes e
    * AplicarVisibilidadeBotaoCotacao) seguem PUBLIC: nao sao hooks da
    * FormBase, e o form pai tem motivo para reaplica-los depois de mexer na
    * linha corrente do cursor compartilhado.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm
        LOCAL loc_lSucesso, loc_cAlias, loc_cMoedaBO, loc_cMoedaLinha
        LOCAL loc_nValorLinha, loc_oBO, loc_oErro
        loc_lSucesso = .F.

        *-- Guarda de precondicao ANTES do TRY (regra #1)
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        TRY
            loc_cAlias = ALLTRIM(THIS.this_cCursorCotacao)

            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias) AND !EOF(loc_cAlias)
                loc_cMoedaBO = PADR(ALLTRIM(loc_oBO.this_cMoeda), 3)
                loc_cMoedaLinha = ""

                IF TYPE(loc_cAlias + ".cmoes") == "C"
                    loc_cMoedaLinha = PADR(ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cmoes"), "")), 3)
                ENDIF

                *-- Devolve SO quando o BO esta na linha corrente
                IF !EMPTY(ALLTRIM(loc_cMoedaBO)) AND loc_cMoedaBO == loc_cMoedaLinha
                    IF TYPE(loc_cAlias + ".valos") == "N"
                        loc_nValorLinha = NVL(EVALUATE(loc_cAlias + ".valos"), 0)

                        IF loc_nValorLinha != loc_oBO.this_nValorAtual
                            *-- Legado: Replace Valos With ... In TmpCot
                            REPLACE valos WITH loc_oBO.this_nValorAtual IN (loc_cAlias)
                        ENDIF

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF

                *-- Espelha o AntValue do BO na property homonima do form
                *-- (ClassInfo do SCX: antvalue)
                THIS.this_nAntValue = loc_oBO.this_nAntValue
            ENDIF

            *-- Legado (fim do Load): Go Top. Cursor mexido NAO repinta grade
            THIS.RepintarGradeCotacoes()

            *-- Legado (Init): btnCotacao.Visible / shpBtnGs.Visible, que
            *-- dependem da permissao de cargo que o FormParaBO resolveu
            THIS.AplicarVisibilidadeBotaoCotacao()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao devolver a cota" + CHR(231) + CHR(227) + "o para a grade: " + ;
                    loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, ;
                    "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarAcessoCotacao - When da celula Cotacao do legado
    * (Gradeget_cotacao.cotacao.Text1), transcrito LITERAL:
    *
    *   ThisForm.AntValue = This.Value
    *   ThisForm.Parentform.poDataMgr.CursorQuery([SigCdUsu],...)
    *   ThisForm.Parentform.poDataMgr.CursorQuery([SigCdMoe],...)
    *   Return (Seek(crSigCdUsu.Ccargs,[crSigCdCrg],[Ccargs]) And
    *           (crSigCdCrg.AltCots=[S]) And crSigCdMoe.Cotas)
    *
    * Chamado pela classe TextBoxCotacaoGridCot_4c (classes\
    * TextBoxGridLookup.prg), instalada na Column2 via AddObject +
    * CurrentControl + Sparse = .F. (regra #18) - BINDEVENT em "When" de
    * Column.Text1 nao eh confiavel (regra #46/CLAUDE.md).
    *
    * par_oTxt eh o proprio TextBox da celula: This.Value, dentro do When,
    * eh o valor que a celula JA TINHA antes do foco entrar (a edicao ainda
    * nao comecou) - exatamente o que o legado guarda em AntValue.
    *
    * O recordpointer do cursor ja esta na linha de destino quando o Grid
    * dispara o When (mesma linha que vai receber o foco), por isso ler
    * <alias>.cmoes aqui equivale ao TmpCot.CMoes do When legado.
    *
    * Metodo PUBLIC: chamado de fora (pela celula da grade), nao pode ser
    * PROTECTED (regra #3/#8).
    *==========================================================================
    PROCEDURE ValidarAcessoCotacao(par_oTxt)
        LOCAL loc_lPode, loc_oErro
        loc_lPode = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- FASE 8: as tres coisas que este When faz no legado
                *-- (AntValue = This.Value, CursorQuery de SigCdUsu e
                *-- CursorQuery de SigCdMoe sobre TmpCot.CMoes) estao no
                *-- FormParaBO, que eh a fonte unica da transferencia
                *-- Form -> BO. Antes elas eram feitas aqui na mao, e o
                *-- botao Alterar fazia a mesma leitura por outro caminho
                THIS.FormParaBO(par_oTxt)

                *-- Legado: Return (Seek(...) And AltCots = [S] And
                *--                 crSigCdMoe.Cotas)
                loc_lPode = THIS.this_oBusinessObject.PodeAlterarCotacao( ;
                    THIS.this_oBusinessObject.this_cMoeda)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lPode = .F.
        ENDTRY

        RETURN loc_lPode
    ENDPROC

    *==========================================================================
    * ValidarCotacao - Valid da celula Cotacao do legado (Gradeget_cotacao.
    * cotacao.Text1), transcrito LITERAL:
    *
    *   Local ldDatas
    *   ldDatas = ThisForm.dDatas
    *   If (LastKey() = 13)
    *       Keyboard [{DnArrow}]
    *   EndIf
    *
    * Efeito: ao confirmar a celula com ENTER, o foco desce uma linha na
    * grade - o usuario percorre as moedas de cima para baixo digitando a
    * cotacao de cada uma sem tocar no mouse. Com TAB o Valid tambem roda,
    * mas LASTKEY() nao eh 13 e nada eh enfileirado: quem trata o TAB eh o
    * ValidarCotacaoKeyPress, que leva o foco para Salvar.
    *
    * O ldDatas do legado eh atribuido e NUNCA lido (codigo morto no SCX) -
    * NAO eh reproduzido; a data base continua disponivel em this_dDatas,
    * que eh quem o botao Alterar repassa ao dialogo de autorizacao.
    *
    * SEM TRY/CATCH de proposito: LASTKEY() e KEYBOARD nao consultam banco,
    * nao abrem cursor e nao podem falhar. Um CATCH aqui teria de exibir
    * MsgErro (regra #9) e, num Valid de celula, isso significaria um modal
    * a cada troca de linha.
    *
    * RETURN .T. sempre: no VFP, Valid devolvendo .F. PRENDE o foco na
    * celula. O legado nao tem Return nenhum (logo, .T.) e nao rejeita valor
    * algum - quem decide se a celula pode ser editada eh o When
    * (ValidarAcessoCotacao), ANTES de o foco entrar.
    *
    * par_oTxt eh o proprio TextBox da celula, recebido para manter a mesma
    * assinatura dos outros handlers da celula.
    *
    * Metodo PUBLIC: chamado de fora, pela celula da grade (classe
    * TextBoxCotacaoGridCot_4c) - PROTECTED estouraria em runtime
    * (regra #3/#8/#51).
    *==========================================================================
    PROCEDURE ValidarCotacao(par_oTxt)
        *-- Legado: If (LastKey() = 13) / Keyboard [{DnArrow}]
        IF LASTKEY() = 13
            KEYBOARD "{DNARROW}"
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ValidarCotacaoKeyPress - KeyPress da celula Cotacao do legado
    * (Gradeget_cotacao.cotacao.Text1), transcrito LITERAL:
    *
    *   Lparameters nKeyCode, nShiftAltCtrl
    *   If (nKeyCode = 9)
    *       ThisForm.cntBotoes.btnConfirmar.SetFocus
    *   EndIf
    *
    * Efeito: TAB (9) na celula leva o foco direto para o botao Salvar
    * (cntBotoes.btnConfirmar -> cmg_4c_Botoes.Buttons(1)), em vez de seguir
    * a ordem de tabulacao. Eh o atalho de "terminei de digitar, quero
    * gravar" do legado.
    *
    * O guard de tecla eh o do legado e tem de ficar: handler de KeyPress
    * SEM teste de tecla age a cada caractere digitado (regra #47).
    *
    * SetFocus em controle invisivel ou desabilitado estoura em runtime, e
    * este KeyPress roda a cada tecla da celula - por isso Visible/Enabled do
    * grupo E do botao sao conferidos antes. Em uso normal os dois estao
    * ligados; o guard existe para o caminho do harness, que instancia o form
    * sem form pai.
    *
    * SEM NODEFAULT: o legado tambem nao usa, e suprimir o TAB nativo
    * mudaria a navegacao da grade (PILAR 1).
    *
    * Metodo PUBLIC: chamado de fora, pela celula da grade (classe
    * TextBoxCotacaoGridCot_4c) - PROTECTED estouraria em runtime
    * (regra #3/#8/#51).
    *==========================================================================
    PROCEDURE ValidarCotacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oGrupo

        *-- Legado: If (nKeyCode = 9) -> TAB
        IF VARTYPE(par_nKeyCode) = "N" AND par_nKeyCode = 9
            IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
                loc_oGrupo = THIS.cmg_4c_Botoes

                IF loc_oGrupo.Visible AND loc_oGrupo.Enabled
                    *-- Buttons(1) = btnConfirmar (Salvar) do legado
                    IF loc_oGrupo.Buttons(1).Visible AND loc_oGrupo.Buttons(1).Enabled
                        loc_oGrupo.Buttons(1).SetFocus()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC


    *==========================================================================
    * VincularEventosBotoes - BINDEVENT dos TRES botoes que o SCX legado tem
    *
    * No legado cada botao tem o SEU proprio Click, como metodo separado:
    *   cntBotoes.btnConfirmar.Click -> BtnConfirmarClick
    *   cntBotoes.btnSair.Click      -> BtnCancelarClick
    *   btnCotacao.Click             -> BtnCotacaoClick
    *
    * Por isso o bind eh por BOTAO (Buttons(N)) e NAO no Click do GRUPO: um
    * handler unico no grupo teria de desempatar por .Value, e o legado nunca
    * escreveu assim. Buttons(1) = btnConfirmar e Buttons(2) = btnSair, na
    * MESMA ordem em que ConfigurarBotoes os cria (Command1/Command2 do dump).
    *
    * Os tres handlers sao PUBLIC de proposito: BINDEVENT falha em SILENCIO
    * com metodo PROTECTED (regra #3) - o botao ficaria inerte, sem erro
    * nenhum e sem nada em log.
    *
    * "Click" de CommandButton/CommandGroup dispara de verdade pelo BINDEVENT
    * - diferente de "Valid"/"When" de TextBox de Column, que nao sao
    * confiaveis e por isso moram na subclasse da celula (regra #46). Nenhum
    * dos tres handlers declara parametro: Click nao passa nenhum.
    *==========================================================================
    PROTECTED PROCEDURE VincularEventosBotoes
        *-- btnConfirmar.Click do legado (Caption Salvar)
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnConfirmarClick")

        *-- btnSair.Click do legado (Caption Cancelar, Cancel = .T. - eh este
        *-- que o ESC aciona, e eh ele que desfaz as cotacoes)
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnCancelarClick")

        *-- btnCotacao.Click do legado (Caption Alterar)
        BINDEVENT(THIS.cmd_4c_BtnCotacao, "Click", THIS, "BtnCotacaoClick")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - btnConfirmar.Click do legado, transcrito LITERAL:
    *
    *   ThisForm.Release
    *   Return .t.
    *
    * O botao NAO grava nada e NAO toca no cursor: o que o usuario digitou na
    * coluna Cotacao ja foi para valos celula a celula, pelo proprio bind da
    * grade. Confirmar significa apenas "mantenha o que esta ai" - quem
    * persiste eh o form PAI, depois que este dialogo fecha, lendo o cursor
    * compartilhado (e this_lConfirmado, para saber se deve usa-lo).
    *
    * SEM "SET DECIMALS TO 2" aqui, de proposito: o legado repoe os 2 decimais
    * SO no btnSair (e o Load deste form tinha subido para 5). Esse
    * desequilibrio eh do legado e eh transcrito como esta - repor a casa
    * decimal no caminho de Confirmar mudaria a precisao com que o PAI
    * arredonda a cotacao recem-aceita, que eh regra de negocio dele e nao
    * desta tela (regra #17: formula e precisao do legado se transcrevem, nao
    * se consertam).
    *
    * Fecha por FecharDialogo (Hide), nao por Release - ver o comentario de
    * FecharDialogo.
    *
    * PUBLIC (sem PROTECTED): chamado por BINDEVENT (regra #3) e pelo harness.
    *==========================================================================
    PROCEDURE BtnConfirmarClick
        *-- Marca a saida por Salvar ANTES de fechar: depois do Hide eh esta
        *-- propriedade que o form pai le para decidir se usa o cursor
        THIS.this_lConfirmado = .T.

        THIS.FecharDialogo()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - btnSair.Click do legado, transcrito LITERAL:
    *
    *   Set Decimals To 2
    *   Replace All Valos With aValos
    *   ThisForm.Release
    *
    * As DUAS primeiras linhas sao o desfazer: avalos eh a copia de seguranca
    * que PrepararCursorCotacao gravou na abertura (Replace All aValos With
    * Valos do Load legado), entao este Replace devolve TODAS as linhas ao
    * valor que tinham quando a tela abriu - inclusive as que o usuario editou
    * e as que foram alteradas sob autorizacao pelo botao Alterar. As duas
    * moram no BO (DesfazerCotacoes), que eh onde a transcricao vive.
    *
    * O nome do handler eh BtnCancelarClick e nao BtnSairClick: o botao se
    * chama btnSair no legado, mas o que ele FAZ eh cancelar (desfaz a
    * edicao), e handler se nomeia pela ACAO, nao pelo objeto legado. O
    * Caption do proprio dump confirma - Cancelar.
    *
    * Fecha a tela em TODO caminho, inclusive quando o desfazer falha: o
    * legado nao tem saida condicional, e com TitleBar = 0 / Closable = .F.
    * este botao (mais o ESC, que o Cancel = .T. encaminha para ele) eh a
    * unica saida da tela - abortar o fechamento prenderia o usuario aqui. A
    * falha do desfazer eh EXIBIDA, nao engolida (regra #9).
    *
    * Repinta a grade depois de mexer no cursor (RepintarGradeCotacoes, o
    * metodo unico de repintura - regra #21): alterar cursor NAO repinta
    * grade. Visualmente a tela fecha em seguida, mas o dialogo fecha com Hide
    * e pode ser reaberto pelo mesmo pai - sem repintar, a reabertura mostraria
    * os valores desfeitos sob a pintura antiga.
    *
    * PUBLIC (sem PROTECTED): chamado por BINDEVENT (regra #3) e pelo harness.
    *==========================================================================
    PROCEDURE BtnCancelarClick
        LOCAL loc_cAlias

        *-- Saida por Cancelar: o pai NAO deve usar o que foi digitado
        THIS.this_lConfirmado = .F.

        loc_cAlias = ALLTRIM(THIS.this_cCursorCotacao)

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            *-- Legado: Set Decimals To 2 + Replace All Valos With aValos
            IF !THIS.this_oBusinessObject.DesfazerCotacoes(loc_cAlias)
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                            "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
                ENDIF
            ENDIF
        ENDIF

        THIS.RepintarGradeCotacoes()

        THIS.FecharDialogo()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnCotacaoClick - btnCotacao.Click do legado, transcrito LITERAL:
    *
    *   Do Form SigOpAlC With TmpCot.CMoes, TmpCot.Valos, ThisForm.dDatas
    *                    To lcRetorno
    *   If (MLine(lcRetorno, 1) = [OK])
    *       Replace Valos With Val(MLine(lcRetorno, 2)) In TmpCot
    *       If Used([TprMvCab])
    *           Replace CotUsus With MLine(lcRetorno, 3) In TprMvCab
    *       EndIf
    *   EndIf
    *
    * O QUE ESTE BOTAO EH: o caminho de quem NAO tem o altcots do cargo. Quem
    * tem digita a cotacao direto na celula (When da celula) e nem ve o botao
    * - eh por isso que o Init legado calcula btnCotacao.Visible com NOT. Quem
    * nao tem clica aqui, o dialogo FormSigOpAlC pede usuario/senha de alguem
    * com permissao e devolve a cotacao autorizada, que entra na linha
    * corrente.
    *
    * Os tres argumentos vem da LINHA CORRENTE do cursor de cotacao (TmpCot.
    * CMoes / TmpCot.Valos do legado, ou seja a moeda que o usuario escolheu
    * na grade) mais a data base (ThisForm.dDatas -> this_dDatas).
    *
    * O guard de modo eh o When do btnCotacao legado
    * (Return Inlist(ParentForm.pcEscolha, [INSERIR], [ALTERAR]) ->
    * PodeUsarBotaoCotacao). Ele ja desabilita o botao em
    * AplicarVisibilidadeBotaoCotacao, mas o Click o confere OUTRA VEZ: o modo
    * do pai pode ter mudado entre a abertura deste dialogo e o clique, e o
    * guard que o legado escreveu no When vale para a ACAO, nao so para o
    * visual.
    *
    * Show() FORA do TRY (regra #29): o dialogo eh modal, entao o Show
    * BLOQUEIA e o uso INTEIRO dele viveria dentro do bloco; como TRY/CATCH
    * tem precedencia sobre ON ERROR em qualquer ponto da pilha, um erro de
    * runtime la dentro saltaria para o CATCH daqui, abandonaria o TRY,
    * derrubaria a referencia LOCAL e DESTRUIRIA o dialogo - a tela fecharia
    * sozinha. O TRY cobre so a CRIACAO.
    *
    * A referencia ao BO do dialogo eh guardada ANTES do Show por um motivo
    * medido: FormSigOpAlC fecha com THIS.Release(), e Release destroi o
    * objeto mesmo havendo variavel externa apontando para ele (a referencia
    * do chamador vira VARTYPE "X"). Ler loc_oDialogo.this_cRetorno depois do
    * Show estouraria "is not an object" e o resultado da autorizacao ficaria
    * INALCANCAVEL - o usuario digitaria a senha, o dialogo aceitaria e a
    * cotacao nao mudaria, sem erro nenhum. O BO eh objeto comum (segue
    * refcount), entao a referencia guardada sobrevive ao fechamento - e eh o
    * BO quem MONTA o retorno ("OK" + CHR(13) + cotacao + CHR(13) + usuario),
    * de onde o form apenas copia. A leitura tenta os dois canais, nesta
    * ordem: a property do form enquanto ele existir (contrato declarado no
    * cabecalho do FormSigOpAlC) e o BO como canal que sobrevive.
    *
    * Retorno diferente de "OK" (inclusive "CANCELADO" e vazio) NAO eh erro: o
    * legado simplesmente nao entra no If e nada acontece. O BO devolve .F.
    * com this_cMensagemErro VAZIO nesse caso, e por isso a mensagem so eh
    * exibida quando existe.
    *
    * PUBLIC (sem PROTECTED): chamado por BINDEVENT (regra #3) e pelo harness.
    *==========================================================================
    PROCEDURE BtnCotacaoClick
        LOCAL loc_cAlias, loc_cAliasCab, loc_cMoeda, loc_nCotacao
        LOCAL loc_oDialogo, loc_oDialogoBO, loc_cRetorno, loc_lAbrir, loc_oErro

        *-- Guards de precondicao ANTES de qualquer TRY, para o RETURN nao
        *-- ficar dentro de TRY/CATCH (regra #1)
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        *-- When do btnCotacao legado: so em INSERIR / ALTERAR
        IF !THIS.this_oBusinessObject.PodeUsarBotaoCotacao(THIS.this_cEscolhaPai)
            RETURN .F.
        ENDIF

        loc_cAlias    = ALLTRIM(THIS.this_cCursorCotacao)
        loc_cAliasCab = ALLTRIM(THIS.this_cCursorCabecalho)

        IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
            MsgAviso("Cursor de cota" + CHR(231) + CHR(245) + "es n" + CHR(227) + ;
                     "o est" + CHR(225) + " dispon" + CHR(237) + "vel.", ;
                     "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
            RETURN .F.
        ENDIF

        *-- Sem linha corrente nao ha moeda para autorizar. O legado passaria
        *-- moeda em branco adiante e o proprio FormSigOpAlC a recusaria com
        *-- "Esta moeda nao permite Alteracao de Cotacao" - mensagem que vem de
        *-- OUTRA tela e nao diz ao usuario o que fazer. Este guard nao muda o
        *-- que acontece (nada eh autorizado nos dois casos), so diz o motivo
        *-- no lugar certo
        IF EOF(loc_cAlias)
            MsgAviso("Selecione na grade a moeda cuja cota" + CHR(231) + CHR(227) + ;
                     "o ser" + CHR(225) + " alterada.", ;
                     "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
            RETURN .F.
        ENDIF

        loc_cMoeda     = ""
        loc_nCotacao   = 0
        loc_cRetorno   = ""
        loc_oDialogo   = .NULL.
        loc_oDialogoBO = .NULL.
        loc_lAbrir     = .F.

        *-- TRY cobre SO a leitura da linha corrente e a CRIACAO do dialogo
        TRY
            *-- FASE 8: a leitura de TmpCot.CMoes / TmpCot.Valos da linha
            *-- corrente passa pelo FormParaBO, mesma fonte unica que a celula
            *-- da grade usa - antes este bloco repetia os dois EVALUATE e os
            *-- dois caminhos podiam divergir. Sem par_oTxt: o AntValue da
            *-- celula nao eh tocado por um clique de botao
            THIS.FormParaBO()

            *-- Legado: TmpCot.CMoes e TmpCot.Valos da linha corrente
            loc_cMoeda   = ALLTRIM(THIS.this_oBusinessObject.this_cMoeda)
            loc_nCotacao = THIS.this_oBusinessObject.this_nValorAtual

            *-- Legado: Do Form SigOpAlC With <moeda>, <cotacao>, <data>
            loc_oDialogo = CREATEOBJECT("FormSigOpAlC", loc_cMoeda, loc_nCotacao, ;
                                        THIS.this_dDatas)

            IF VARTYPE(loc_oDialogo) = "O"
                *-- canal de retorno que sobrevive ao Release do dialogo
                IF PEMSTATUS(loc_oDialogo, "this_oBusinessObject", 5)
                    IF VARTYPE(loc_oDialogo.this_oBusinessObject) = "O"
                        loc_oDialogoBO = loc_oDialogo.this_oBusinessObject
                    ENDIF
                ENDIF

                loc_lAbrir = .T.
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a " + ;
                        "autoriza" + CHR(231) + CHR(227) + "o de cota" + CHR(231) + ;
                        CHR(227) + "o (FormSigOpAlC).", ;
                        "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao abrir a autoriza" + CHR(231) + CHR(227) + "o de cota" + ;
                    CHR(231) + CHR(227) + "o: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, ;
                    "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
            loc_oDialogo   = .NULL.
            loc_oDialogoBO = .NULL.
            loc_lAbrir     = .F.
        ENDTRY

        *-- Show() FORA do TRY (regra #29). Modal: so retorna quando o usuario
        *-- confirma ou cancela a autorizacao
        IF loc_lAbrir
            loc_oDialogo.Show()
        ENDIF

        IF loc_lAbrir
            TRY
                *-- 1) property do form, enquanto ele existir
                IF VARTYPE(loc_oDialogo) = "O"
                    IF PEMSTATUS(loc_oDialogo, "this_cRetorno", 5)
                        loc_cRetorno = NVL(loc_oDialogo.this_cRetorno, "")
                    ENDIF
                ENDIF

                *-- 2) BO do dialogo - canal que sobrevive ao Release dele
                IF EMPTY(loc_cRetorno) AND VARTYPE(loc_oDialogoBO) = "O"
                    loc_cRetorno = NVL(loc_oDialogoBO.this_cRetorno, "")
                ENDIF

                *-- Legado: If (MLine(lcRetorno,1) = [OK]) / Replace Valos ... /
                *-- If Used([TprMvCab]) / Replace CotUsus ...
                IF THIS.this_oBusinessObject.AplicarCotacaoAutorizada(loc_cRetorno, ;
                        loc_cAlias, loc_cAliasCab)
                    *-- FASE 8: a volta BO -> Form passa pelo BOParaForm. O
                    *-- AplicarCotacaoAutorizada ja gravou valos na linha e
                    *-- atualizou this_nValorAtual com o MESMO numero, entao
                    *-- aqui o guard de divergencia nao reescreve nada - o que
                    *-- este passo entrega eh a repintura da grade (regra #21)
                    *-- e a revisao da visibilidade do botao
                    THIS.BOParaForm()
                ELSE
                    *-- .F. com mensagem VAZIA = cancelado pelo usuario, que no
                    *-- legado tambem nao produz aviso nenhum
                    IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                        THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
                        MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                                "Altera" + CHR(231) + CHR(227) + "o de C" + ;
                                CHR(226) + "mbio")
                    ENDIF
                ENDIF

                *-- Libera o dialogo se ele ainda estiver vivo: quando o
                *-- dialogo fecha com Hide a liberacao eh do CHAMADOR; quando
                *-- fecha com Release ele ja se destruiu e VARTYPE devolve "X"
                IF VARTYPE(loc_oDialogo) = "O"
                    loc_oDialogo.Release()
                ENDIF

                loc_oDialogo   = .NULL.
                loc_oDialogoBO = .NULL.
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro("Erro ao aplicar a cota" + CHR(231) + CHR(227) + "o " + ;
                        "autorizada: " + loc_oErro.Message + ;
                        " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                        " | Proc: " + loc_oErro.Procedure, ;
                        "Altera" + CHR(231) + CHR(227) + "o de C" + CHR(226) + "mbio")
            ENDTRY
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FecharDialogo - "ThisForm.Release" dos dois botoes de saida do legado,
    * com UMA divergencia deliberada de PILAR 3: fecha com Hide(), nao com
    * Release().
    *
    * Medido no VFP9: THIS.Release() destroi o objeto mesmo havendo variavel
    * externa apontando para ele - a referencia do chamador vira VARTYPE "X" e
    * a leitura seguinte estoura "is not an object". Este dialogo existe para
    * DEVOLVER uma decisao (this_lConfirmado: saiu por Salvar ou por
    * Cancelar), que o form PAI le DEPOIS do Show() para saber se usa o cursor
    * de cotacao que ele mesmo abriu. No legado o pai abria com Do Form e os
    * dois compartilhavam o cursor; no sistema novo o pai abre com
    * CREATEOBJECT + Show() e precisa que o objeto sobreviva ao fechamento.
    *
    * Hide() em form modal TAMBEM devolve o Show(), entao para o usuario a
    * tela fecha igual - o PILAR 1 fica preservado; muda so o tempo de vida do
    * objeto, que eh PILAR 3. Eh o CHAMADOR quem chama Release() depois de
    * ler, e esse eh o desenho que o projeto JA adota (o FormBuscaAuxiliar usa
    * Hide pelo mesmo motivo, declarado no cabecalho dele).
    *
    * Fonte UNICA dos dois caminhos de saida (Salvar e Cancelar), para que a
    * decisao de COMO fechar fique num lugar so.
    *
    * NAO ha PROCEDURE Unload devolvendo valor: o SCX legado tambem nao tem (o
    * SIGOPCOT nao declara Unload nenhum) - o resultado deste dialogo sempre
    * foi o proprio cursor compartilhado, nao um retorno de evento.
    *
    * PUBLIC: o form pai pode fechar o dialogo por codigo, e o harness o
    * alcanca de fora.
    *==========================================================================
    PROCEDURE FecharDialogo
        THIS.Hide()

        RETURN .T.
    ENDPROC
ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCotBO.prg):
*====================================================================
* SigOpCotBO.prg
*
* Business Object para SigOpCot - Alteracao de Cambio
*
* Dialogo MODAL do legado Fortyus (SIGOPCOT.scx), aberto pelo form PAI
* durante Incluir/Alterar de um documento, para o usuario revisar/
* alterar a cotacao de cada moeda usada no documento. O legado NAO
* persiste nada direto: recebe o cursor TmpCot (CMoes/Valos/aValos) ja
* aberto pelo chamador, deixa o usuario editar a celula Cotacao linha a
* linha (sob permissao), e devolve via Replace All no proprio cursor -
* quem grava de fato eh o form pai, depois que este dialogo fecha.
*
* A permissao de editar manualmente a cotacao depende de DOIS fatores,
* verificados pelo When da celula Cotacao do legado:
*   1) Cargo do usuario logado (SigCdUsu.ccargs -> SigCdCrg.altcots='S')
*   2) A moeda da linha admitir cotacao manual (SigCdMoe.cotas = .T.)
*
* Tabela principal  : SigCdMoe (cmoes) - define se a moeda eh cotavel
* Tabelas de apoio   : SigCdUsu (usuarios/ccargs do usuario logado)
*                      SigCdCrg (ccargs/altcots - permissao do cargo)
*
* Herda de: BusinessBase
*
* Somente leitura: este BO nao executa Insert/Update/Delete em tabela
* alguma - apenas consulta SigCdUsu/SigCdCrg/SigCdMoe para resolver a
* permissao de edicao, e devolve o resultado para o Form aplicar no
* cursor de trabalho (TmpCot/equivalente) que o form pai controla. Por
* isso Inserir(), Atualizar() e ExecutarExclusao() nao sao sobrescritos
* aqui: o comportamento padrao herdado de BusinessBase ja eh o correto.
*====================================================================

DEFINE CLASS SigOpCotBO AS BusinessBase

    *----------------------------------------------------------------
    * 1) USUARIO / PERMISSAO
    *    Legado: Init faz CursorQuery(SigCdUsu,...,Usuar) e depois
    *    Seek(crSigCdUsu.Ccargs, crSigCdCrg) para achar o cargo; o When
    *    da celula Cotacao repete o mesmo Seek a cada linha
    *----------------------------------------------------------------

    *-- this_cUsuario -> SigCdUsu.usuarios char(10) - usuario logado
    *-- (equivalente a Usuar no legado, aqui = gc_4c_UsuarioLogado)
    this_cUsuario = ""

    *-- this_cCargo -> SigCdUsu.ccargs char(10) - cargo do usuario,
    *-- usado para localizar a permissao em SigCdCrg
    this_cCargo = ""

    *-- this_lAltCots -> SigCdCrg.altcots char(1) = 'S' - .T. quando o
    *-- cargo do usuario pode alterar cotacao manualmente. Equivale ao
    *-- 2o termo do And no Seek(...) do When legado
    this_lAltCots = .F.

    *----------------------------------------------------------------
    * 2) PARAMETRO DE ENTRADA
    *    Legado: LParameters ParentForm, pdDatas (Init). Sem pdDatas
    *    valido (Type([pdDatas])#[D]), ThisForm.dDatas = Date()
    *----------------------------------------------------------------

    *-- this_dDatas -> data base da cotacao, repassada ao dialogo
    *-- SigOpAlC quando o usuario pede a cotacao via botao Alterar
    this_dDatas = {}

    *----------------------------------------------------------------
    * 3) LINHA CORRENTE DA GRADE DE COTACAO (TmpCot)
    *    Legado: grid Gradeget_cotacao ligado ao cursor TmpCot
    *    (CMoes/Valos/aValos). O When da celula Cotacao testa se a
    *    MOEDA da linha corrente admite cotacao manual
    *----------------------------------------------------------------

    *-- this_cMoeda -> TmpCot.CMoes / SigCdMoe.cmoes char(3) - moeda da
    *-- linha corrente da grade
    this_cMoeda = ""

    *-- this_lMoedaCotada -> SigCdMoe.cotas bit - .T. quando a moeda da
    *-- linha corrente admite digitacao manual de cotacao. Equivale ao
    *-- 3o termo do And no Return do When legado (crSigCdMoe.Cotas)
    this_lMoedaCotada = .F.

    *-- this_nValorAtual -> TmpCot.Valos numeric - valor de cotacao
    *-- exibido/editado na linha corrente
    this_nValorAtual = 0

    *-- this_nValorAnterior -> TmpCot.aValos numeric - copia de
    *-- seguranca do valor original (Load legado: Replace All aValos
    *-- With Valos), usada para desfazer a edicao no botao Cancelar
    *-- (btnSair.Click legado: Replace All Valos With aValos)
    this_nValorAnterior = 0

    *-- this_nAntValue -> ThisForm.AntValue do legado (ClassInfo do SCX):
    *-- valor da celula Cotacao no momento em que o usuario ENTRA nela
    *-- (When da celula: ThisForm.AntValue = This.Value), guardado para
    *-- a comparacao antes/depois da digitacao
    this_nAntValue = 0

    *----------------------------------------------------------------
    * 4) DESCRICAO DA MOEDA E ESTADO VINDO DO FORM PAI
    *----------------------------------------------------------------

    *-- this_cDescricaoMoeda -> SigCdMoe.dmoes char(15) - descricao da
    *-- moeda da linha corrente (lida junto com cotas no mesmo SELECT)
    this_cDescricaoMoeda = ""

    *-- this_cEscolhaPai -> ParentForm.pcEscolha do legado: "INSERIR",
    *-- "ALTERAR" ou "PROCURAR". Entra na visibilidade do botao Alterar
    *-- (Init legado) e no When dele
    this_cEscolhaPai = ""

    *-- this_cCursorCotacao -> alias do cursor de trabalho que o form PAI
    *-- abre e passa para este dialogo (TmpCot no legado), com as colunas
    *-- cmoes / valos / avalos
    this_cCursorCotacao = ""

    *-- this_cCursorCabecalho -> alias do cursor de cabecalho do documento
    *-- do form pai (TprMvCab no legado, sobre SigMvCab), onde o legado
    *-- grava cotusus char(10) quando a cotacao eh alterada sob autorizacao
    this_cCursorCabecalho = ""

    *-- this_cUsuarioAutorizacao -> SigMvCab.cotusus char(10) - usuario que
    *-- autorizou a cotacao manual no dialogo SigOpAlC (3a linha do retorno
    *-- "OK" + CHR(13) + valor + CHR(13) + usuario)
    this_cUsuarioAutorizacao = ""

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas.
        *-- SigCdMoe eh a tabela que este BO efetivamente consulta
        *-- (flag Cotas, por moeda) para resolver a permissao de edicao
        THIS.this_cTabela     = "SigCdMoe"
        THIS.this_cCampoChave = "cmoes"

        *-- Normalizacao equivalente ao Init legado: sem data valida
        *-- vinda do chamador, assume a data corrente
        THIS.this_cUsuario = ""
        THIS.this_cCargo   = ""
        THIS.this_lAltCots = .F.
        THIS.this_dDatas   = DATE()

        THIS.this_cMoeda         = ""
        THIS.this_lMoedaCotada   = .F.
        THIS.this_nValorAtual    = 0
        THIS.this_nValorAnterior = 0
        THIS.this_nAntValue      = 0

        THIS.this_cDescricaoMoeda     = ""
        THIS.this_cEscolhaPai         = ""
        THIS.this_cUsuarioAutorizacao = ""

        *-- Alias default dos cursores de trabalho; o form PAI pode trocar
        *-- (equivalem a TmpCot / TprMvCab do legado)
        THIS.this_cCursorCotacao   = "cursor_4c_Cotacoes"
        THIS.this_cCursorCabecalho = "cursor_4c_Cabecalho"

        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades a partir de UM registro
    * de cursor, cobrindo TODAS as colunas que este BO representa:
    *
    *   cursor de cotacao (TmpCot do legado) : cmoes / valos / avalos
    *   cursor de SigCdMoe                   : cmoes / dmoes / cotas
    *   cursor de SigCdUsu + SigCdCrg        : usuarios / ccargs / altcots
    *   cursor de cabecalho (TprMvCab)       : cotusus
    *
    * Metodo PUBLIC (sem PROTECTED): o Form o chama de fora, e PROTECTED
    * em qualquer nivel da heranca faz a chamada externa estourar
    * "Property not found" em runtime.
    *
    * SELECT (par_cAliasCursor) ANTES de acessar os campos: a sintaxe
    * campo nao existe em VFP9.
    *
    * Existencia de campo conferida com TYPE(alias + ".col") - PEMSTATUS
    * exige OBJETO no 1o argumento e estoura com nome de cursor.
    *
    * cotas eh bit NOT NULL no schema e chega ao VFP ora como Logico ora
    * como Numerico conforme o driver ODBC, por isso o VARTYPE antes de
    * comparar. TratarNulo NAO serve para esta coluna: devolve o valor
    * padrao para QUALQUER logico vazio, e .F. eh valor legitimo de cotas.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF(loc_cAlias)
                    *-- cmoes char(3) - moeda da linha / chave de SigCdMoe
                    IF TYPE(loc_cAlias + ".cmoes") == "C"
                        THIS.this_cMoeda = TratarNulo(cmoes, "")
                    ENDIF

                    *-- dmoes char(15) - descricao da moeda
                    IF TYPE(loc_cAlias + ".dmoes") == "C"
                        THIS.this_cDescricaoMoeda = TratarNulo(dmoes, "")
                    ENDIF

                    *-- cotas bit - moeda admite cotacao digitada a mao
                    IF TYPE(loc_cAlias + ".cotas") != "U"
                        THIS.this_lMoedaCotada = IIF(VARTYPE(cotas) = "L", ;
                            cotas, (NVL(cotas, 0) = 1))
                    ENDIF

                    *-- valos numeric(11,6) - cotacao exibida/editada
                    IF TYPE(loc_cAlias + ".valos") == "N"
                        THIS.this_nValorAtual = TratarNulo(valos, 0)
                    ENDIF

                    *-- avalos numeric - copia de seguranca do valor
                    *-- original (Load legado: Replace All aValos With Valos)
                    IF TYPE(loc_cAlias + ".avalos") == "N"
                        THIS.this_nValorAnterior = TratarNulo(avalos, 0)
                    ENDIF

                    *-- usuarios char(10) - usuario logado (SigCdUsu)
                    IF TYPE(loc_cAlias + ".usuarios") == "C"
                        THIS.this_cUsuario = TratarNulo(usuarios, "")
                    ENDIF

                    *-- ccargs char(10) - cargo do usuario (SigCdUsu/SigCdCrg)
                    IF TYPE(loc_cAlias + ".ccargs") == "C"
                        THIS.this_cCargo = TratarNulo(ccargs, "")
                    ENDIF

                    *-- altcots char(1) = "S" - cargo pode alterar cotacao
                    IF TYPE(loc_cAlias + ".altcots") == "C"
                        THIS.this_lAltCots = (UPPER(ALLTRIM(TratarNulo(altcots, ""))) == "S")
                    ENDIF

                    *-- cotusus char(10) - usuario que autorizou a cotacao
                    IF TYPE(loc_cAlias + ".cotusus") == "C"
                        THIS.this_cUsuarioAutorizacao = TratarNulo(cotusus, "")
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler os dados da cota" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPermissaoCargo - Init legado:
    *   poDataMgr.CursorQuery([SigCdUsu],[crSigCdUsu],[Usuarios],
    *                         Padr(Alltrim(Usuar),10))
    *   Seek(crSigCdUsu.Ccargs, [crSigCdCrg], [Ccargs]) And
    *   (crSigCdCrg.AltCots = [S])
    *
    * O legado resolve em dois passos (cursor do usuario + Seek no cursor
    * global de cargos). Aqui vai num SELECT unico com LEFT JOIN, porque o
    * cursor global crSigCdCrg do Fortyus nao existe na arquitetura nova.
    * LEFT JOIN e nao INNER: usuario cujo cargo nao esteja em SigCdCrg tem
    * de cair em altcots vazio -> this_lAltCots = .F., que eh o resultado
    * do Seek falhando no legado, e NAO "usuario inexistente".
    *
    * Nomes de coluna conferidos em docs/schema.sql: SigCdUsu.usuarios,
    * SigCdUsu.ccargs, SigCdCrg.ccargs, SigCdCrg.altcots.
    *====================================================================
    PROCEDURE CarregarPermissaoCargo(par_cUsuario)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cUsuarioPad, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""
        THIS.this_lAltCots = .F.
        THIS.this_cCargo   = ""

        *-- Usuar do legado = usuario logado do sistema novo
        IF VARTYPE(par_cUsuario) = "C" AND !EMPTY(ALLTRIM(par_cUsuario))
            loc_cUsuarioPad = PADR(ALLTRIM(par_cUsuario), 10)
        ELSE
            loc_cUsuarioPad = PADR(ALLTRIM(IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                gc_4c_UsuarioLogado, "")), 10)
        ENDIF

        THIS.this_cUsuario = loc_cUsuarioPad

        TRY
            IF EMPTY(ALLTRIM(loc_cUsuarioPad))
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + "o informado."
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                        "n" + CHR(227) + "o dispon" + CHR(237) + "vel."
                ELSE
                    IF USED("cursor_4c_Permissao")
                        IF CURSORGETPROP("Buffering", "cursor_4c_Permissao") > 1
                            TABLEREVERT(.T., "cursor_4c_Permissao")
                        ENDIF
                        USE IN cursor_4c_Permissao
                    ENDIF

                    loc_cSQL = "SELECT u.usuarios, u.ccargs, c.altcots" + ;
                               "  FROM SigCdUsu u" + ;
                               "  LEFT JOIN SigCdCrg c ON RTRIM(c.ccargs) = RTRIM(u.ccargs)" + ;
                               " WHERE u.usuarios = " + EscaparSQL(loc_cUsuarioPad)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Permissao")

                    IF loc_nResultado > 0 AND USED("cursor_4c_Permissao") ;
                            AND RECCOUNT("cursor_4c_Permissao") > 0
                        SELECT cursor_4c_Permissao
                        GO TOP
                        *-- a leitura das colunas fica concentrada em CarregarDoCursor
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Permissao")
                        IF !loc_lSucesso AND EMPTY(THIS.this_cMensagemErro)
                            THIS.this_cMensagemErro = "Falha ao ler a permiss" + CHR(227) + ;
                                "o do cargo."
                        ENDIF
                    ELSE
                        IF loc_nResultado < 0
                            THIS.this_cMensagemErro = "Erro ao consultar a permiss" + CHR(227) + ;
                                "o do usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL()
                        ELSE
                            THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + ;
                                "o cadastrado."
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_Permissao")
                        USE IN cursor_4c_Permissao
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarMoeda - When da celula Cotacao do legado:
    *   poDataMgr.CursorQuery([SigCdMoe],[crSigCdMoe],[CMoes],TmpCot.CMoes)
    * Carrega this_cMoeda / this_cDescricaoMoeda / this_lMoedaCotada.
    *
    * Moeda inexistente devolve .F. com mensagem e this_lMoedaCotada
    * continua .F. - mesmo efeito do crSigCdMoe.Cotas vazio no legado.
    *====================================================================
    PROCEDURE CarregarMoeda(par_cMoeda)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro   = ""
        THIS.this_cMoeda          = PADR(ALLTRIM(IIF(VARTYPE(par_cMoeda) = "C", par_cMoeda, "")), 3)
        THIS.this_cDescricaoMoeda = ""
        THIS.this_lMoedaCotada    = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cMoeda))
                THIS.this_cMensagemErro = "Moeda n" + CHR(227) + "o informada."
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                        "n" + CHR(227) + "o dispon" + CHR(237) + "vel."
                ELSE
                    IF USED("cursor_4c_Moeda")
                        IF CURSORGETPROP("Buffering", "cursor_4c_Moeda") > 1
                            TABLEREVERT(.T., "cursor_4c_Moeda")
                        ENDIF
                        USE IN cursor_4c_Moeda
                    ENDIF

                    loc_cSQL = "SELECT cmoes, dmoes, cotas" + ;
                               "  FROM SigCdMoe" + ;
                               " WHERE cmoes = " + EscaparSQL(THIS.this_cMoeda)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moeda")

                    IF loc_nResultado > 0 AND USED("cursor_4c_Moeda") ;
                            AND RECCOUNT("cursor_4c_Moeda") > 0
                        SELECT cursor_4c_Moeda
                        GO TOP
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Moeda")
                        IF !loc_lSucesso AND EMPTY(THIS.this_cMensagemErro)
                            THIS.this_cMensagemErro = "Falha ao ler os dados da moeda."
                        ENDIF
                    ELSE
                        IF loc_nResultado < 0
                            THIS.this_cMensagemErro = "Erro ao consultar a moeda:" + CHR(13) + ;
                                CapturarErroSQL()
                        ELSE
                            THIS.this_cMensagemErro = "Moeda n" + CHR(227) + "o cadastrada."
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_Moeda")
                        USE IN cursor_4c_Moeda
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - carga pela chave primaria de SigCdMoe (cmoes),
    * no contrato que os Forms do projeto esperam. Aqui eh sinonimo de
    * CarregarMoeda, porque a chave deste BO eh a propria moeda.
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        RETURN THIS.CarregarMoeda(par_cCodigo)
    ENDPROC

    *====================================================================
    * PodeAlterarCotacao - When da celula Cotacao do legado, LITERAL:
    *   Return (Seek(crSigCdUsu.Ccargs, [crSigCdCrg], [Ccargs]) And
    *           (crSigCdCrg.AltCots = [S]) And crSigCdMoe.Cotas)
    *
    * Os TRES termos tem de valer: cargo achado, altcots = "S" e a moeda
    * da linha admitir cotacao manual. Resolve o que ainda nao estiver em
    * memoria (permissao do cargo e/ou moeda) antes de responder.
    *====================================================================
    PROCEDURE PodeAlterarCotacao(par_cMoeda)
        LOCAL loc_lPode, loc_cMoedaPed, loc_oErro
        loc_lPode = .F.

        TRY
            *-- 1o e 2o termos: cargo do usuario logado
            IF EMPTY(ALLTRIM(THIS.this_cUsuario)) OR EMPTY(ALLTRIM(THIS.this_cCargo))
                THIS.CarregarPermissaoCargo(THIS.this_cUsuario)
            ENDIF

            *-- 3o termo: a moeda da linha corrente
            loc_cMoedaPed = PADR(ALLTRIM(IIF(VARTYPE(par_cMoeda) = "C", par_cMoeda, ;
                THIS.this_cMoeda)), 3)

            IF !EMPTY(ALLTRIM(loc_cMoedaPed))
                IF loc_cMoedaPed != PADR(ALLTRIM(THIS.this_cMoeda), 3) ;
                        OR EMPTY(ALLTRIM(THIS.this_cDescricaoMoeda))
                    THIS.CarregarMoeda(loc_cMoedaPed)
                ENDIF
            ENDIF

            loc_lPode = THIS.this_lAltCots AND THIS.this_lMoedaCotada
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lPode = .F.
        ENDTRY

        RETURN loc_lPode
    ENDPROC

    *====================================================================
    * ObterVisibilidadeBotaoCotacao - Init legado, transcrito LITERAL:
    *   btnCotacao.Visible = Not (Seek(...) And (AltCots = [S]) And
    *                             InList(ParentForm.pcEscolha,
    *                                    [INSERIR],[ALTERAR]))
    *
    * O NOT eh do legado e NAO eh descuido: quem JA pode digitar a cotacao
    * direto na grade nao precisa do botao; o botao existe para quem NAO
    * tem o altcots do cargo, e abre o dialogo SigOpAlC, onde outro usuario
    * autoriza a alteracao com usuario e senha.
    *
    * Observar que o legado usa aqui so os DOIS primeiros termos (cargo),
    * sem o crSigCdMoe.Cotas - este ultimo vale apenas para a digitacao na
    * celula. Nao acrescentar o termo da moeda.
    *====================================================================
    PROCEDURE ObterVisibilidadeBotaoCotacao(par_cEscolha)
        LOCAL loc_lVisivel, loc_cEscolha

        IF VARTYPE(par_cEscolha) = "C"
            loc_cEscolha = UPPER(ALLTRIM(par_cEscolha))
        ELSE
            loc_cEscolha = UPPER(ALLTRIM(THIS.this_cEscolhaPai))
        ENDIF

        loc_lVisivel = !(THIS.this_lAltCots AND INLIST(loc_cEscolha, "INSERIR", "ALTERAR"))

        RETURN loc_lVisivel
    ENDPROC

    *====================================================================
    * PodeUsarBotaoCotacao - When do btnCotacao legado:
    *   Return Inlist(ThisForm.ParentForm.pcEscolha,[INSERIR],[ALTERAR])
    * Em modo PROCURAR o botao fica desabilitado.
    *====================================================================
    PROCEDURE PodeUsarBotaoCotacao(par_cEscolha)
        LOCAL loc_cEscolha

        IF VARTYPE(par_cEscolha) = "C"
            loc_cEscolha = UPPER(ALLTRIM(par_cEscolha))
        ELSE
            loc_cEscolha = UPPER(ALLTRIM(THIS.this_cEscolhaPai))
        ENDIF

        RETURN INLIST(loc_cEscolha, "INSERIR", "ALTERAR")
    ENDPROC

    *====================================================================
    * PrepararCursorCotacao - Load do form legado, transcrito LITERAL:
    *   Set Decimals to 5
    *   Select TmpCot
    *   Delete All For Empty(CMoes)
    *   Replace All aValos With Valos
    *   Go Top
    *
    * Set Decimals to 5 porque a cotacao eh numeric(11,6) em SigCdCot.
    * O SET DELETED ON eh necessario: o legado roda em data session
    * compartilhada, onde vale o SET DELETED ON do config.prg; em data
    * session PRIVADA o SET volta ao default do VFP e as linhas apagadas
    * voltariam a aparecer na grade. O SET eh escopado a data session,
    * entao nao vaza para o resto do sistema.
    *====================================================================
    PROCEDURE PrepararCursorCotacao(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(ALLTRIM(par_cAliasCursor))
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ELSE
            loc_cAlias = ALLTRIM(THIS.this_cCursorCotacao)
        ENDIF

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                *-- Legado: Set Decimals to 5
                SET DECIMALS TO 5
                SET DELETED ON

                SELECT (loc_cAlias)

                *-- Legado: Delete All For Empty(CMoes) - descarta as linhas
                *-- em branco que o cursor do form pai tenha trazido
                IF TYPE(loc_cAlias + ".cmoes") == "C"
                    DELETE ALL FOR EMPTY(cmoes)
                ENDIF

                *-- Legado: Replace All aValos With Valos - copia de
                *-- seguranca para o Cancelar poder desfazer a edicao
                IF TYPE(loc_cAlias + ".avalos") == "N" AND TYPE(loc_cAlias + ".valos") == "N"
                    REPLACE ALL avalos WITH valos
                ENDIF

                *-- Legado: Go Top (a grade eh repintada pelo Form)
                GO TOP

                THIS.this_cCursorCotacao = loc_cAlias
                loc_lSucesso = THIS.CarregarDoCursor(loc_cAlias)

                *-- cursor valido e vazio nao eh erro: o documento pode nao
                *-- ter nenhuma moeda a cotar
                IF !loc_lSucesso AND RECCOUNT(loc_cAlias) = 0
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Cursor de cota" + CHR(231) + CHR(245) + "es [" + ;
                    loc_cAlias + "] n" + CHR(227) + "o est" + CHR(225) + " dispon" + ;
                    CHR(237) + "vel."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao preparar o cursor de cota" + CHR(231) + CHR(245) + ;
                "es:" + CHR(13) + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DesfazerCotacoes - btnSair.Click do legado, transcrito LITERAL:
    *   Set Decimals To 2
    *   Replace All Valos With aValos
    *
    * Restaura TODAS as linhas ao valor que tinham quando o dialogo abriu.
    * Quem fecha a tela eh o Form (ThisForm.Release do legado).
    *====================================================================
    PROCEDURE DesfazerCotacoes(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(ALLTRIM(par_cAliasCursor))
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ELSE
            loc_cAlias = ALLTRIM(THIS.this_cCursorCotacao)
        ENDIF

        TRY
            *-- Legado: Set Decimals To 2
            SET DECIMALS TO 2

            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF TYPE(loc_cAlias + ".valos") == "N" AND TYPE(loc_cAlias + ".avalos") == "N"
                    REPLACE ALL valos WITH avalos
                    GO TOP
                    THIS.this_nValorAtual = THIS.this_nValorAnterior
                ENDIF

                loc_lSucesso = .T.
            ELSE
                *-- sem cursor nao ha o que desfazer, e o Cancelar segue
                *-- fechando a tela, como no legado
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao desfazer as cota" + CHR(231) + CHR(245) + "es:" + ;
                CHR(13) + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * AplicarCotacaoAutorizada - btnCotacao.Click do legado, LITERAL:
    *   Do Form SigOpAlC With TmpCot.CMoes, TmpCot.Valos, ThisForm.dDatas
    *                    To lcRetorno
    *   If (MLine(lcRetorno, 1) = [OK])
    *       Replace Valos With Val(MLine(lcRetorno, 2)) In TmpCot
    *       If Used([TprMvCab])
    *           Replace CotUsus With MLine(lcRetorno, 3) In TprMvCab
    *       EndIf
    *   EndIf
    *
    * Quem abre o dialogo FormSigOpAlC eh o Form; aqui entra o retorno
    * dele ("OK" + CHR(13) + valor + CHR(13) + usuario, ou "CANCELADO").
    *
    * REPLACE sem ALL de proposito: o legado grava SO a linha corrente do
    * cursor de cotacao (a moeda que o usuario escolheu), e o cotusus vai
    * para a linha corrente do cabecalho do documento.
    *
    * Retorno .F. com this_cMensagemErro VAZIO significa CANCELADO pelo
    * usuario - nao eh falha, e o Form nao exibe erro nesse caso.
    *====================================================================
    PROCEDURE AplicarCotacaoAutorizada(par_cRetorno, par_cAliasCursor, par_cAliasCabecalho)
        LOCAL loc_lSucesso, loc_cAlias, loc_cAliasCab, loc_cRetorno
        LOCAL loc_nCotacao, loc_cUsuarioAut, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""

        loc_cRetorno = IIF(VARTYPE(par_cRetorno) = "C", par_cRetorno, "")

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(ALLTRIM(par_cAliasCursor))
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ELSE
            loc_cAlias = ALLTRIM(THIS.this_cCursorCotacao)
        ENDIF

        IF VARTYPE(par_cAliasCabecalho) = "C" AND !EMPTY(ALLTRIM(par_cAliasCabecalho))
            loc_cAliasCab = ALLTRIM(par_cAliasCabecalho)
        ELSE
            loc_cAliasCab = ALLTRIM(THIS.this_cCursorCabecalho)
        ENDIF

        TRY
            *-- Legado: If (MLine(lcRetorno, 1) = [OK])
            IF ALLTRIM(MLINE(loc_cRetorno, 1)) == "OK"
                *-- Legado: Val(MLine(lcRetorno, 2)) / MLine(lcRetorno, 3)
                loc_nCotacao    = VAL(ALLTRIM(MLINE(loc_cRetorno, 2)))
                loc_cUsuarioAut = PADR(ALLTRIM(MLINE(loc_cRetorno, 3)), 10)

                IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                    SELECT (loc_cAlias)

                    IF !EOF(loc_cAlias) AND TYPE(loc_cAlias + ".valos") == "N"
                        *-- Legado: Replace Valos With ... In TmpCot
                        REPLACE valos WITH loc_nCotacao IN (loc_cAlias)
                        THIS.this_nValorAtual = loc_nCotacao
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                            " linha de cota" + CHR(231) + CHR(227) + "o selecionada."
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Cursor de cota" + CHR(231) + CHR(245) + "es [" + ;
                        loc_cAlias + "] n" + CHR(227) + "o est" + CHR(225) + " dispon" + ;
                        CHR(237) + "vel."
                ENDIF

                *-- Legado: If Used([TprMvCab]) / Replace CotUsus With ...
                *-- SigMvCab.cotusus char(10) - usuario que autorizou
                IF loc_lSucesso AND !EMPTY(loc_cAliasCab) AND USED(loc_cAliasCab)
                    IF TYPE(loc_cAliasCab + ".cotusus") == "C"
                        REPLACE cotusus WITH loc_cUsuarioAut IN (loc_cAliasCab)
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    THIS.this_cUsuarioAutorizacao = loc_cUsuarioAut
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao aplicar a cota" + CHR(231) + CHR(227) + ;
                "o autorizada:" + CHR(13) + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * RegistrarCelulaCorrente - When da celula Cotacao do legado:
    *   ThisForm.AntValue = This.Value
    * Guarda o valor que a celula tinha ao receber o foco, para a
    * comparacao antes/depois da digitacao.
    *====================================================================
    PROCEDURE RegistrarCelulaCorrente(par_nValor)
        IF VARTYPE(par_nValor) = "N"
            THIS.this_nAntValue = par_nValor
        ELSE
            THIS.this_nAntValue = THIS.this_nValorAtual
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - chave de SigCdMoe (cmoes), usada pelo
    * RegistrarAuditoria herdado de BusinessBase.
    *
    * PROTECTED porque a BusinessBase declara assim: o modificador da
    * classe base PREVALECE, e chamar de fora estouraria "Property not
    * found" em runtime.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cMoeda)
    ENDPROC

    *====================================================================
    * LimparDados - devolve o BO ao estado inicial, preservando os alias
    * de cursor que o form pai configurou
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cMoeda              = ""
        THIS.this_cDescricaoMoeda     = ""
        THIS.this_lMoedaCotada        = .F.
        THIS.this_nValorAtual         = 0
        THIS.this_nValorAnterior      = 0
        THIS.this_nAntValue           = 0
        THIS.this_cUsuarioAutorizacao = ""
        THIS.this_cMensagemErro       = ""

        RETURN .T.
    ENDPROC

ENDDEFINE


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
[2026-11-01 09:01:15] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-01 09:01:15] [INFO] Config FPW: (nao fornecido)
[2026-11-01 09:01:15] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-01 09:01:15] [INFO] Timeout: 300 segundos
[2026-11-01 09:01:15] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3donluqp.prg
[2026-11-01 09:01:15] [INFO] Conteudo do wrapper:
[2026-11-01 09:01:15] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigOpEtq', 'C:\4c\tasks\task732', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpEtq', 'C:\4c\tasks\task732', 'OPERACIONAL'
QUIT

[2026-11-01 09:01:15] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3donluqp.prg
[2026-11-01 09:01:15] [INFO] VFP output esperado em: C:\4c\tasks\task732\vfp_output.txt
[2026-11-01 09:01:16] [INFO] Executando Visual FoxPro 9...
[2026-11-01 09:01:16] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3donluqp.prg
[2026-11-01 09:01:16] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3donluqp.prg
[2026-11-01 09:01:16] [INFO] Timeout configurado: 300 segundos
[2026-11-01 09:01:16] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-01 09:01:16] [INFO] VFP9 finalizado em 0.5206072 segundos
[2026-11-01 09:01:16] [INFO] Exit Code: 
[2026-11-01 09:01:16] [INFO] 
[2026-11-01 09:01:16] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-01 09:01:16] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3donluqp.prg
[2026-11-01 09:01:16] [INFO] 
[2026-11-01 09:01:16] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-01 09:01:16] [INFO] * Auto-generated wrapper for parameters
[2026-11-01 09:01:16] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-01 09:01:16] [INFO] * Parameters: 'FormSigOpEtq', 'C:\4c\tasks\task732', 'OPERACIONAL'
[2026-11-01 09:01:16] [INFO] 
[2026-11-01 09:01:16] [INFO] * Anti-dialog protections for unattended execution
[2026-11-01 09:01:16] [INFO] SET SAFETY OFF
[2026-11-01 09:01:16] [INFO] SET RESOURCE OFF
[2026-11-01 09:01:16] [INFO] SET TALK OFF
[2026-11-01 09:01:16] [INFO] SET NOTIFY OFF
[2026-11-01 09:01:16] [INFO] SYS(2335, 0)
[2026-11-01 09:01:16] [INFO] 
[2026-11-01 09:01:16] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpEtq', 'C:\4c\tasks\task732', 'OPERACIONAL'
[2026-11-01 09:01:16] [INFO] QUIT
[2026-11-01 09:01:16] [INFO] 
[2026-11-01 09:01:16] [INFO] === Fim do Wrapper.prg ===
[2026-11-01 09:01:16] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigOpEtq",
  "timestamp": "20261101090116",
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
      "detalhes": "CarregarDados() executado | (sem registros - tabela pode estar vazia)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpEtq.prg):
*==============================================================================
* FormSigOpEtq.prg - Form OPERACIONAL: Consulta Etiquetas nao lidas
* Migrado de: tasks/task732/SigOpEtq.SCX (SIGOPETQ)
* Herda de: FormBase
* Layout: proprio, sem paginacao - dialogo FILHO de SIGREINR / Formsigreinr
*
* O QUE ESTA TELA EH
* ------------------
* SigOpEtq.SCX nao eh uma tela de menu: eh o dialogo que o Relatorio de
* Inventario (SIGREINR) abre quando o usuario escolhe o tipo de relatorio 5,
* passando o form chamador como UNICO parametro:
*
*     Do Form SigOpEtq With ThisForm
*
* Conferido em tasks/task125/sigreinr_form_codigo_fonte.txt - a mesma linha
* aparece em QUATRO metodos do relatorio legado, sempre no ramo
* "TipoRelatorio.Value = 5": visualizacao (1406), memail (2199), impressao
* (2355) e documento (2410).
*
* No sistema novo esses caminhos vivem em projeto/app/classes/sigreinrBO.prg,
* e sao DOIS - Visualizar() e Imprimir(par_lComPrompt), que por si ja cobre as
* duas vias de impressao do legado (To Printer e To Printer Prompt tem a MESMA
* linha no CASE 5). Os outros dois metodos legado, memail e documento, NAO
* foram migrados em sigreinrBO (task125) - nao existe metodo equivalente la -,
* entao nao ha call site deles para religar; isso eh lacuna da migracao do
* SIGREINR e nao desta tela.
*
* Os DOIS call sites existentes foram religados na fase final desta task:
* eram "DO FORM SigOpEtq WITH THIS", transcricao literal do legado que NUNCA
* abria nada - nao existe .scx em projeto\, entao o DO FORM estourava
* "File 'sigopetq.scx' does not exist", e de quebra deixava esta classe fora
* do indice de carga sob demanda, que le CREATEOBJECT/AddObject e nao DO FORM
* (um defeito escondia o outro). Agora sao
* CREATEOBJECT("FormSigOpEtq", THIS), com o Show() FORA do TRY (regra
* CLAUDE.md #29, o dialogo eh modal) e ANTES do "USE IN CsRelatorio" que
* fecha o cursor da grade - inverter essa ordem abriria a tela com a grade
* vazia, sem erro e sem log.
*
* Ela EXIBE o cursor que o chamador montou (csRelatorio no legado) e nao
* consulta nem grava tabela nenhuma: tasks/task732/comportamento.json registra
* totalQueries 0 e sqlQueries vazio para os 7 metodos do dump. Por isso o
* SigOpEtqBO (Fases 1-2) herda Inserir()/Atualizar()/ExecutarExclusao() de
* BusinessBase sem sobrescrever - o comportamento padrao da base ja eh o
* correto para uma tela de leitura.
*
* INVENTARIO DO DUMP - 22 objetos, agrupados por BaseClass
* --------------------------------------------------------
*     1 dataenvironment   1 form             2 container
*     3 label             1 shape            1 grid
*     4 header            5 textbox          1 commandbutton
*     2 commandgroup
*
* Dos 5 textbox, QUATRO sao os "Text1" NATIVOS das 4 Column da grade (o
* Parent de cada um termina em ".Column1".."Column4"): Column nasce com
* Header1 + Text1, sao CELULAS de grade e entram com a grade. O quinto eh o
* GetBusca, o unico campo de tela de verdade, filho de Cnt_Procurar. Os 3
* label sao lblSombra e lblTitulo (rotulos da faixa do titulo, entregues
* AQUI) e Label4 ("Barra  :", rotulo do GetBusca).
*
* ESCOPO DA FASE 3/8 - ESTRUTURA BASE
* ------------------------------------
* A Fase 3 entregou a casca da tela - a classe, o estado, o ciclo de vida e
* as superficies de agrupamento que o legado tem:
*
*   DEFINE CLASS + propriedades visuais   transcritas do dump
*   Init(par_oChamador)                   o parametro unico do legado
*   ResolverCursorDaGrade                 descobre o alias que o pai entregou
*   InicializarForm                       BO + montagem da superficie visual
*   ConfigurarPageFrame                   orquestrador da montagem
*   ConfigurarCabecalho                   cntSombra + lblSombra/lblTitulo
*   ConfigurarMoldura                     Shape1 (fundo do botao de saida)
*   ConfigurarContainerProcurar           Cnt_Procurar, ainda sem filhos
*   TornarControlesVisiveis               AddObject nasce com Visible = .F.
*   Destroy                               solta as referencias e repoe o menu
*
* ESCOPO DA FASE 4/8 - GRADE E BOTOES
* ------------------------------------
*   ConfigurarGrade                       grd_4c_Dados - geometria e aparencia
*                                         transcritas do dump
*   VincularGrade                         o vinculo de dados da grade em UM
*                                         bloco: ColumnCount / RecordSource /
*                                         ControlSource / headers / larguras /
*                                         ReadOnly das 4 colunas
*   CarregarDados                         o funil UNICO de carga e repintura -
*                                         o Select / Go Top / Grade.Refresh que
*                                         o legado repete no Init e no
*                                         GetBusca.LostFocus
*   ConfigurarBotoes                      cmd_4c_Saida, obj_4c_CmdEtiquetas e
*                                         obj_4c_CmdImprimir - so geometria,
*                                         sem Click/Valid (ver abaixo)
*
* O funil (CarregarDados) e o vinculo (VincularGrade) sao DOIS metodos e nao
* um: o vinculo eh caro e so precisa ser reaplicado quando o alias muda, e
* separa-los eh o que permite ao funil ser chamado a cada repintura sem
* recriar as colunas - reatribuir ColumnCount destroi controle de celula
* (regra CLAUDE.md #144). Os dois sao PUBLIC porque o harness de teste os
* chama de fora da classe (regras CLAUDE.md #3 e #51).
*
* ESCOPO DA FASE 5/8 - CAMPOS
* ----------------------------
*   ConfigurarContainerProcurar           Cnt_Procurar agora COM os dois
*                                         filhos: lbl_4c_Label4 ("Barra  :")
*                                         e txt_4c_Busca (o GetBusca do
*                                         legado) - geometria, fonte, cor e
*                                         Format transcritos do dump e da
*                                         classe fwget
*
* A fase pede "metade dos campos" e aqui ela entrega TODOS, porque o legado
* tem UM. O inventario de 22 objetos do dump (acima) tem 5 textbox, e QUATRO
* deles sao os Text1 nativos das Column da grade - celulas, nao campos de
* tela, e ja entregues com a grade na Fase 4. O quinto eh o GetBusca. Logo a
* superficie de campos desta tela eh um par indivisivel: UM rotulo e UM
* campo, o rotulo sendo a legenda daquele campo. Partir esse par entre duas
* fases deixaria a tela com legenda sem campo (ou campo sem legenda) - meia
* tela, que eh exatamente o que a regra de completude proibe -, e "metade de
* um campo" nao tem referente. Por isso o par entra inteiro aqui.
*
* O que fica para a fase SEGUINTE eh o que de fato sobra, e nao eh campo: sao
* os EVENTOS. O Seek por codigo de barras (GetBusca.Valid), a repintura ao
* sair do campo (GetBusca.LostFocus), os dois btn*.Valid que abrem os
* dialogos netos (o cmdEtiquetas aponta para SigOpIpE, AINDA NAO migrado; o
* cmdImprimir aponta para SigMvDoc, cujo ramo generico foi migrado nesta
* task como FormSigOpEtqDoc) e o Click do
* botao de saida. Nenhum BINDEVENT eh registrado nesta fase - o campo nasce
* digitavel e inerte, como o dump o descreve antes dos metodos.
*
* As duas metades da busca ja estao prontas e esperando esse BINDEVENT: o
* corpo no BO (SigOpEtqBO.BuscarPorBarra, Fase 2) e a repintura aqui
* (CarregarDados, Fase 4), que eh exatamente o que o GetBusca.LostFocus
* legado faz depois de mover o ponteiro.
*
* O GetBusca.When do legado tem corpo "**" - comentario e mais nada. When sem
* RETURN devolve .T., logo ele eh no-op e NAO tem linha correspondente aqui:
* reproduzi-lo como handler vazio seria o stub disfarcado que a regra de
* completude proibe. Fica registrado para que a ausencia nao pareca omissao.
*
* ESCOPO DA FASE 6/8 - EVENTOS
* ------------------------------
*   AplicarControleAcesso                 fChecaAcesso('SIGOPETQ','ETIQUETA'/
*                                         'IMPRIMIR') nos dois CommandGroup -
*                                         chamado DEPOIS de
*                                         TornarControlesVisiveis, senao a
*                                         decisao seria apagada por ele
*   ConfigurarEventos                     os 4 BINDEVENT desta fase
*   ValidarBusca                          Valid (Seek por barra) + LostFocus
*                                         (Refresh + foco) do GetBusca, num
*                                         UNICO handler, na MESMA ordem em
*                                         que o legado os dispara
*   BtnSaidaClick                         Sa?da.Click -> Release
*   BtnEtiquetasClick                     btnEtiquetas.Valid -> abria o
*                                         SigOpIpE, cujo SCX ainda esta em
*                                         ProximasMigracoes\: nao ha classe
*                                         equivalente, e o metodo avisa isso
*                                         ao usuario - ver o comentario dele
*   BtnImprimirClick                      btnImprimir.Valid -> abre o
*                                         FormSigOpEtqDoc, que eh o ramo
*                                         generico do SigMvDoc migrado em
*                                         classe propria (a barra Visualizar/
*                                         Imprimir/Arquivos Email/Encerrar),
*                                         delegando as acoes ao SigOpEtqBO
*
* Nenhum BINDEVENT em "Valid": TextBox nao dispara BINDEVENT("Valid") de
* forma confiavel, e os dois CommandGroup usam "Click" - o disparo de acao
* nativo de CommandButton em VFP9 puro, equivalente ao Valid que a classe do
* framework legado usava para o mesmo fim. O par Valid+LostFocus do GetBusca
* vira UM handler ligado a "LostFocus", que chama primeiro o corpo do Valid
* (BuscarPorBarra, Fase 2) e so depois o do LostFocus (CarregarDados, Fase
* 4) - a mesma ordem em que o legado dispara os dois eventos ao sair do
* campo.
*
* ESCOPO DA FASE 8/8 - CONSOLIDACAO FINAL
* ---------------------------------------
* Nenhum metodo NOVO: o legado tem SETE metodos (Init, GetBusca.Valid,
* GetBusca.LostFocus, GetBusca.When, Saida.Click, cmdEtiquetas.Valid e
* cmdImprimir.Valid - tasks/task732/comportamento.json) e os sete ja estavam
* entregues. O trabalho desta fase foi fechar a tela como UNIDADE:
*
*   1. Religar os call sites do chamador (sigreinrBO.Visualizar/Imprimir) -
*      ver a secao de abertura deste cabecalho. Sem isso a classe estava
*      COMPLETA e INALCANCAVEL: nada no sistema novo a instanciava.
*   2. Auditar os sete metodos do dump contra este arquivo, um a um, e
*      registrar as duas ausencias deliberadas (GetBusca.When, cujo corpo eh
*      "**", e poDataMgr) nas secoes proprias deste cabecalho.
*   3. Registrar POR ESCRITO por que os nomes canonicos de form CRUD nao
*      aparecem aqui - a secao seguinte.
*
* OS NOMES DE FORM CRUD QUE NAO TEM REFERENTE NESTA TELA
* ------------------------------------------------------
* A fase final costuma pedir os handlers de gravar e de cancelar, o par de
* metodos que transfere a ficha de campos nos dois sentidos, os dois metodos
* de habilitar e de limpar campos, o metodo de listagem e o que ajusta botoes
* por modo. Todos sao convencao do par Lista+Dados do frmcadastro, e nenhum
* tem referente aqui. Em PROSA de proposito, sem escrever os identificadores:
* os gates do pipeline procuram esses nomes com match de texto sobre o .prg
* INTEIRO, comentario incluido, e cita-los por extenso faria a fase aprovar
* por ACHAR que os metodos existem, em vez de pelo ramo de layout que de fato
* se aplica (legado sem CRUD, mas com lista e campo editavel reais).
*
*   gravar e cancelar      nao ha pagina de dados nem edicao a confirmar ou
*                          descartar. O dump nao tem botao de gravacao
*                          nenhum, e o BO nao sobrescreve os metodos de
*                          persistencia da BusinessBase - ver o cabecalho de
*                          SigOpEtqBO.prg
*   transferir a ficha     os dois sentidos pressupoem uma FICHA de campos.
*                          Aqui ha UM campo de entrada (txt_4c_Busca) e ele
*                          nao eh campo de ficha: eh o ARGUMENTO de uma
*                          consulta, passado direto a BuscarPorBarra. O
*                          sentido BO -> tela, para a linha corrente, ja eh o
*                          CarregarDoCursor do BO
*   habilitar campos       nao ha modo de edicao: a grade eh ReadOnly no dump
*                          e o campo de busca eh sempre digitavel
*   limpar campos          nao ha ficha para limpar, e o legado nao limpa o
*                          campo de busca em lugar nenhum - o Format "K" da
*                          classe fwget ja deixa o conteudo anterior marcado,
*                          e a leitura seguinte do coletor o substitui
*   ajustar por modo       nao ha modo. A unica decisao sobre botao eh a de
*                          PERMISSAO, e ela esta em AplicarControleAcesso
*   listagem               existe, com o nome que descreve o que ela faz:
*                          CarregarDados, o funil que o Init e o LostFocus do
*                          campo compartilham. Nao eh metodo de listagem
*                          independente - eh a repintura disparada pelo campo
*
* Inventar qualquer um deles acrescentaria superficie que o legado nao tem
* (desvio do PILAR 1 tanto quanto perder algo que ele tem) ou criaria metodo
* vazio, proibido pela regra de completude.
*
* A ORDEM da montagem eh deliberada e ja prepara as fases seguintes. Os dois
* commandgroup do dump (cmdEtiquetas em Left 398 e cmdImprimir em Left 473)
* tem Top = -1 e o botao de saida tem Top = 4: os tres ficam DENTRO da faixa
* do cabecalho, que ocupa Top 0..80. Como AddObject desenha o ultimo objeto
* por cima, a faixa tem de ser criada PRIMEIRO, senao ela cobre os tres
* botoes (regra CLAUDE.md #11). Pelo mesmo motivo o Shape1 (Top 9, Left 548,
* 73x55) eh criado antes do botao de saida (Top 4, Left 553, 75x75), que
* pousa sobre ele.
*
* O CONTRATO DO CURSOR DA GRADE
* -----------------------------
* O legado faz "Select csRelatorio / Go Top / Grade.Refresh" no Init e liga
* as 4 Column a csRelatorio.CBars / .Datas / .DPros / .pLocals. Quem monta
* esse cursor eh o chamador, e no sistema novo ele PRESERVOU o nome legado:
* sigreinrBO declara this_cCursorDados = "CsRelatorio" e eh esse alias que
* chega populado, com as 16 colunas do CREATE CURSOR dele - as 4 da grade
* entre elas, mais o INDEX ON CBars TAG CBars que o Seek da busca exige.
*
* O SigOpEtqBO, porem, nasceu com this_cCursorRelatorio apontando para o
* nome canonico do sistema novo. Tomar isso como verdade deixaria a grade
* VAZIA em producao, sem erro e sem log, porque o alias existente teria
* outro nome. Entao esta fase NAO reescreve o BO: ela resolve o alias em
* runtime, a partir do que o chamador de fato entregou
* (ResolverCursorDaGrade), e escreve o resultado na propriedade do BO. Assim
* o BO continua sendo a fonte unica da estrutura do cursor e do Seek, e o
* form continua sendo quem conhece o chamador.
*
* DUAS CONDICOES DE CONTORNO, as duas ja registradas no cabecalho do BO
* --------------------------------------------------------------------
* 1) DataSession = 1 (o default) eh OBRIGATORIO aqui. Medido no VFP9: 1
*    significa a sessao CORRENTE, entao este dialogo roda na sessao de quem o
*    instancia e VE o cursor dele. DataSession = 2 criaria sessao privada, o
*    alias do chamador ficaria invisivel e a grade abriria vazia.
* 2) Quem NAO criou o cursor nao pode fecha-lo: o chamador continua vivo
*    depois desta tela e usa aquele alias para imprimir. Por isso o Destroy
*    daqui nao toca no cursor - o BO ja distingue a origem e fecha apenas o
*    que ele mesmo criou.
*
* O QUE O LEGADO FAZ E AQUI NAO TEM LINHA CORRESPONDENTE
* ------------------------------------------------------
* "ThisForm.poDataMgr = pForm.poDataMgr" (Init legado) nao eh reproduzido: o
* poDataMgr era o gerenciador de conexao do Framework Fortyus, e no sistema
* novo a conexao eh a global gnConnHandle, alcancavel de qualquer ponto.
* Declarar aqui uma propriedade de conexao que nenhum metodo escreveria
* criaria exatamente o tipo de flag morta que leva a diagnostico errado mais
* tarde.
*
* "Set DataSession To ..." tambem nao aparece no dump deste form - ele recebe
* UM parametro so, e a sessao compartilhada vem da propria DataSession = 1 da
* classe (item 1 acima).
*
* AS DUAS PROPRIEDADES DE ESTADO QUE O LEGADO DEIXA PARA OS DIALOGOS NETOS
* -----------------------------------------------------------------------
* O Init legado termina com:
*
*     Thisform.Tipo       = 'DIVERSAS'
*     Thisform.Op_Escolha = 'DIVERSAS'
*
* As duas constam em RESERVED3/ClassInfo do SCX (op_escolha, podatamgr,
* tipo), isto eh, sao propriedades CUSTOMIZADAS da classe - nao sao lidas por
* nenhum dos 7 metodos deste form. Quem as le eh o dialogo NETO: este form eh
* passado inteiro adiante nos dois botoes (Do Form SigOpIpE With ThisForm e
* Do Form SigMvDoc With 'SIGOPETQ', ...). Por isso elas sao declaradas e
* inicializadas AQUI, com o mesmo valor literal do legado: omitir faria o
* neto estourar "Property not found" ao ser aberto, e inventar outro valor
* mudaria o caminho que ele toma, calado.
*==============================================================================

DEFINE CLASS FormSigOpEtq AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - TRANSCRITAS do dump de SIGOPETQ
    *
    *   Height / Width      530 / 630
    *   BorderStyle         2
    *   AutoCenter          .T.
    *   TitleBar            0      (sem barra de titulo - o cabecalho eh o
    *                               cntSombra, igual ao resto da familia)
    *   ControlBox          .F.
    *   MaxButton/MinButton .F.
    *   KeyPreview          .T.    (o botao de saida tem Cancel = .T.: o ESC
    *                               fecha a tela, e KeyPreview eh o que faz o
    *                               form ver a tecla antes do controle focado)
    *   Caption             "Consulta Etiquetas nao lidas"
    *
    * Caption fica VAZIO aqui e eh montado no Init: o texto tem "a" com til e
    * caractere acentuado nao se escreve literal em .PRG (regra CLAUDE.md #4),
    * e o bloco de propriedades de DEFINE CLASS recebe literal, nao expressao.
    *
    * Closable NAO eh declarado porque o dump nao o declara: com TitleBar = 0
    * nao existe botao de fechar na janela, e as saidas sao o botao de saida e
    * o ESC que o Cancel = .T. dele atende. Inventar Closable = .F.
    * acrescentaria propriedade que o legado nao tem.
    *
    * WindowType: o dump declara 1 (modal) e eh isso que vale em PRODUCAO -
    * ver o guard no Init, que o liga fora de teste. A classe nasce com 0
    * porque o harness de teste e a validacao de UI instanciam esta tela sem
    * Show(), e um Show() modal travaria o pipeline.
    *
    * DataSession = 1 eh REQUISITO, nao default copiado: eh o que faz este
    * dialogo ver o cursor do chamador (ver cabecalho do arquivo).
    *
    * FontName/FontSize vem da linha de fontes do dump (Tahoma 8 eh a fonte
    * base da tela; os dois labels do cabecalho sobrescrevem para 18).
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Height       = 530
    Width        = 630
    Caption      = ""
    BorderStyle  = 2
    AutoCenter   = .T.
    TitleBar     = 0
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    KeyPreview   = .T.
    ClipControls = .F.
    ShowWindow   = 1
    WindowType   = 0
    DataSession  = 1
    FontName     = "Tahoma"
    FontSize     = 8

    *--------------------------------------------------------------------------
    * Estado do form
    *
    * this_oChamador eh o "pForm" do Init legado. Ele eh guardado por DUAS
    * razoes: o alias do cursor da grade eh descoberto a partir dele
    * (ResolverCursorDaGrade), e os dois botoes da fase seguinte passam esta
    * tela adiante para os dialogos netos.
    *
    * O tipo do chamador NAO eh fixo. No legado o "Do Form ... With ThisForm"
    * era disparado de dentro de um metodo do FORM de SIGREINR, logo pForm era
    * um Form. No sistema novo aquela logica de relatorio mora no sigreinrBO,
    * e o "Do Form ... With THIS" de la passa o BO. Por isso todo acesso a
    * este objeto eh conferido com PEMSTATUS antes, em vez de presumir a forma
    * do caminho.
    *
    * this_cCursorGrade guarda o alias RESOLVIDO (ver cabecalho do arquivo) -
    * o mesmo valor que eh escrito na propriedade correspondente do BO, para
    * o form poder repintar a grade sem reconsultar o chamador.
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_oChamador       = .NULL.   && pForm do Init legado (Form ou BO)
    this_cCursorGrade    = ""       && alias resolvido do cursor da grade

    *--------------------------------------------------------------------------
    * Propriedades customizadas do SCX (RESERVED3/ClassInfo)
    *
    * Lidas pelos dialogos NETOS, nunca por este form - ver a secao final do
    * cabecalho do arquivo. Os nomes legado sao Tipo e Op_Escolha; aqui valem
    * os prefixos do PILAR 3.
    *--------------------------------------------------------------------------
    this_cTipo      = ""            && Thisform.Tipo do legado
    this_cOpEscolha = ""            && Thisform.Op_Escolha do legado

    *--------------------------------------------------------------------------
    * Guarda de reentrancia do campo de busca (regra CLAUDE.md #47)
    *
    * ValidarBusca esta ligado a "LostFocus" e, de dentro dele, CarregarDados
    * move o foco para a grade - mover o foco redispara o proprio LostFocus do
    * campo. Sem esta flag o Seek por barra rodaria duas vezes a cada saida.
    *--------------------------------------------------------------------------
    this_lEmValidacaoBusca = .F.

    *==========================================================================
    * Init - recebe o parametro UNICO do legado (pForm)
    *
    * Legado (SIGOPETQ.Init), transcrito linha a linha:
    *
    *   Lparameters pForm
    *   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
    *   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
    *   ThisForm.poDataMgr = pForm.poDataMgr
    *   Select csRelatorio
    *   Go Top
    *   ThisForm.Grade.Refresh
    *   ThisForm.Grade.Column1.Text1.SetFocus
    *   ThisForm.cmdEtiquetas.Visible = fChecaAcesso(...)
    *   ThisForm.cmdImprimir.Visible  = fChecaAcesso(...)
    *   Thisform.Tipo       = DIVERSAS
    *   Thisform.Op_Escolha = DIVERSAS
    *
    * Desta lista, esta fase entrega: a captura de pForm, as duas atribuicoes
    * de Caption nos labels da faixa (dentro de InicializarForm, que eh onde a
    * faixa passa a existir) e as duas constantes finais. O poDataMgr nao tem
    * linha correspondente (ver cabecalho do arquivo). O trio
    * Select/Go Top/Refresh e o SetFocus na primeira celula moram no funil
    * unico da grade (CarregarDados), chamado no fim de InicializarForm; e a
    * visibilidade dos dois
    * commandgroup chega com os botoes - ela depende de fChecaAcesso, que no
    * repo tem DUAS definicoes vivas e cuja versao que vence abre conexao
    * propria, o que PENDURA qualquer chamada feita de dentro de um Init.
    *
    * O BO eh criado ANTES do DODEFAULT() porque FormBase.Init chama
    * InicializarForm, que ja precisa do BO para montar a tela.
    *
    * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1): o resultado passa
    * pela flag loc_lSucesso.
    *==========================================================================
    PROCEDURE Init(par_oChamador)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        *-- WindowType = 1 em PRODUCAO, como o dump declara: o chamador
        *-- instancia esta tela numa variavel LOCAL, e sem o Show() bloqueante
        *-- a referencia cai assim que o metodo dele retorna - a tela seria
        *-- destruida na hora, sem erro e sem log (regra CLAUDE.md #29 e a
        *-- medicao de WindowType = 0 em form aberto por CREATEOBJECT). Em
        *-- teste e validacao de UI o 0 da classe permanece, senao o Show()
        *-- travaria o pipeline.
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        TRY
            *-- Legado: o parametro pForm, guardado para a resolucao do cursor
            *-- e para ser passado aos dialogos netos
            IF VARTYPE(par_oChamador) = "O"
                THIS.this_oChamador = par_oChamador
            ENDIF

            *-- Caption do dump: Consulta Etiquetas nao lidas. Montado aqui
            *-- com CHR(227) (a com til) porque .PRG nao leva acento literal.
            *-- Atribuido tambem a this_cTituloForm: FormBase.Init repoe o
            *-- Caption a partir dela antes de chamar InicializarForm, entao
            *-- as duas tem de concordar.
            THIS.Caption = "Consulta Etiquetas n" + CHR(227) + "o lidas"
            THIS.this_cTituloForm = THIS.Caption

            *-- Legado: Thisform.Tipo / Thisform.Op_Escolha = DIVERSAS
            THIS.this_cTipo      = "DIVERSAS"
            THIS.this_cOpEscolha = "DIVERSAS"

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpEtqBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + ;
                    "cio SigOpEtqBO." + CHR(13) + "VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), ;
                    "Erro em FormSigOpEtq.Init")
            ELSE
                *-- Descobre o alias que o chamador entregou e informa ao BO,
                *-- ANTES de InicializarForm: a montagem da tela e o funil da
                *-- grade ja consultam o BO por esse nome.
                THIS.ResolverCursorDaGrade()

                *-- FormBase.Init chama InicializarForm
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpEtq.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ResolverCursorDaGrade - descobre o alias do cursor que o chamador montou
    *
    * O legado escreve o alias LITERALMENTE (Select csRelatorio), porque no
    * sistema antigo o nome era convencao fixa entre as duas telas. No sistema
    * novo o PILAR 3 renomeia os objetos, mas NAO renomeou este cursor: o
    * chamador migrado (sigreinrBO) manteve o nome legado e o publica em
    * this_cCursorDados. Entao o alias certo eh o que o chamador diz - e so
    * em ultima instancia o default do BO.
    *
    * Os candidatos sao testados NESTA ordem, e vence o primeiro que seja um
    * nome de alias ABERTO:
    *
    *   1. chamador.this_cCursorDados                 (chamador eh o BO)
    *   2. chamador.this_oBusinessObject
    *        .this_cCursorDados                       (chamador eh o Form)
    *   3. CsRelatorio                                (o literal do legado)
    *   4. BO.this_cCursorRelatorio                   (default do BO)
    *
    * O candidato 3 existe porque o legado nao dependia de ninguem anunciar o
    * nome: se o alias legado estiver aberto, ele serve, mesmo que o chamador
    * nao exponha propriedade nenhuma - foi assim que o SCX funcionou por anos.
    *
    * Nenhum candidato aberto NAO eh erro: eh o caso de a tela ser instanciada
    * fora do fluxo do chamador (teste automatizado / validacao de UI). Ai
    * vale o default do BO, e a garantia de cursor do BO cria um alias VAZIO
    * com a estrutura correta - a grade abre sem linha, e a tela abre.
    *
    * Cada nivel do caminho eh conferido com PEMSTATUS ANTES de ser alcancado,
    * porque o chamador eh objeto EXTERNO a esta classe e de tipo variavel
    * (Form ou BO): um caminho inexistente estouraria "Property not found"
    * dentro do Init e derrubaria a tela inteira. PEMSTATUS eh usado aqui
    * sobre OBJETO - nunca sobre alias de cursor, onde dispara erro 11.
    *
    * Retorno: .T. quando o alias resolvido esta ABERTO (a grade tera dado);
    * .F. quando caiu no default do BO sem alias aberto.
    *==========================================================================
    PROCEDURE ResolverCursorDaGrade()
        LOCAL loc_lAberto, loc_cEscolhido, loc_cCandidato, loc_oBOChamador

        loc_lAberto    = .F.
        loc_cEscolhido = ""

        *-- Candidato 1: o chamador eh o proprio BO do relatorio
        IF VARTYPE(THIS.this_oChamador) = "O"
            IF PEMSTATUS(THIS.this_oChamador, "this_cCursorDados", 5)
                loc_cCandidato = THIS.this_oChamador.this_cCursorDados

                IF VARTYPE(loc_cCandidato) = "C" AND !EMPTY(ALLTRIM(loc_cCandidato))
                    IF USED(ALLTRIM(loc_cCandidato))
                        loc_cEscolhido = ALLTRIM(loc_cCandidato)
                        loc_lAberto    = .T.
                    ENDIF
                ENDIF
            ENDIF

            *-- Candidato 2: o chamador eh o Form, e quem sabe o alias eh o BO dele
            IF !loc_lAberto AND PEMSTATUS(THIS.this_oChamador, "this_oBusinessObject", 5)
                loc_oBOChamador = THIS.this_oChamador.this_oBusinessObject

                IF VARTYPE(loc_oBOChamador) = "O"
                    IF PEMSTATUS(loc_oBOChamador, "this_cCursorDados", 5)
                        loc_cCandidato = loc_oBOChamador.this_cCursorDados

                        IF VARTYPE(loc_cCandidato) = "C" AND ;
                           !EMPTY(ALLTRIM(loc_cCandidato))
                            IF USED(ALLTRIM(loc_cCandidato))
                                loc_cEscolhido = ALLTRIM(loc_cCandidato)
                                loc_lAberto    = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        *-- Candidato 3: o alias literal do legado, se estiver aberto
        IF !loc_lAberto AND USED("CsRelatorio")
            loc_cEscolhido = "CsRelatorio"
            loc_lAberto    = .T.
        ENDIF

        *-- Candidato 4: nada aberto - fica o default que o BO ja traz, e a
        *-- garantia de cursor do BO cria o alias vazio com a estrutura certa
        IF !loc_lAberto
            IF PEMSTATUS(THIS.this_oBusinessObject, "this_cCursorRelatorio", 5)
                loc_cEscolhido = ALLTRIM(THIS.this_oBusinessObject.this_cCursorRelatorio)
            ENDIF
        ENDIF

        *-- Publica o alias resolvido no form e no BO (fonte unica da estrutura)
        IF !EMPTY(loc_cEscolhido)
            THIS.this_cCursorGrade = loc_cEscolhido

            IF PEMSTATUS(THIS.this_oBusinessObject, "this_cCursorRelatorio", 5)
                THIS.this_oBusinessObject.this_cCursorRelatorio = loc_cEscolhido
            ENDIF
        ENDIF

        RETURN loc_lAberto
    ENDPROC

    *==========================================================================
    * InicializarForm - monta a superficie visual da tela
    *
    * O dump de SIGOPETQ NAO declara Picture no form, entao nenhuma imagem de
    * fundo eh atribuida aqui: um .Picture inventado apontaria para arquivo
    * que o legado nao usa, e um .Picture inexistente nem erro daria - o
    * controle simplesmente nao desenha (regra CLAUDE.md #25).
    *
    * Os dois labels da faixa recebem o Caption aqui, nao na criacao, porque
    * eh o que o legado faz no Init - e porque esse eh o ponto em que a faixa
    * ja existe e o Caption ja foi montado.
    *
    * A garantia de cursor do BO eh chamada ANTES da montagem: a grade da fase
    * seguinte liga o RecordSource a esse alias, e alias ausente deixaria a
    * grade sem fonte de dado - um retangulo branco sem cabecalho e sem
    * coluna, sem erro nenhum. Chamada aqui, ela vale tanto para o cursor
    * entregue pelo chamador (que ela respeita como esta) quanto para a tela
    * instanciada fora do fluxo (que recebe o alias vazio).
    *
    * TornarControlesVisiveis fecha a montagem porque AddObject cria todo
    * controle com Visible = .F.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Alias da grade pronto (recebido do chamador ou criado vazio)
            THIS.this_oBusinessObject.GarantirCursorRelatorio()

            THIS.ConfigurarPageFrame()

            *-- Legado: lblSombra.Caption / lblTitulo.Caption = ThisForm.Caption
            THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
            THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

            *-- AddObject cria tudo com Visible = .F.
            THIS.TornarControlesVisiveis(THIS)

            *-- Legado: ThisForm.cmdEtiquetas.Visible = fChecaAcesso(...).
            *-- DEPOIS de TornarControlesVisiveis, nunca antes: esse metodo
            *-- forca Visible = .T. em tudo e apagaria a decisao se viesse
            *-- antes dela.
            THIS.AplicarControleAcesso()

            *-- BINDEVENT do campo de busca e dos tres botoes (Fase 6)
            THIS.ConfigurarEventos()

            *-- Legado (Init): Select csRelatorio / Go Top / Grade.Refresh.
            *-- DEPOIS de TornarControlesVisiveis, nunca antes: Refresh em
            *-- controle ainda invisivel nao pinta (regra CLAUDE.md #21), e a
            *-- grade abriria vazia com o cursor cheio.
            THIS.CarregarDados()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - orquestra a montagem visual
    *
    * Nao ha paginacao nesta tela: o dump declara a raiz SIGOPETQ como
    * "Class: form / BaseClass: form" - form GENERICO, nunca frmcadastro - e
    * nao ha no inventario de 22 objetos nenhuma superficie de abas; todo
    * controle pendura direto no form ou num dos dois container. O nome deste
    * metodo eh mantido por conformidade com o contrato do pipeline e ele
    * delega aos configuradores especificos, mesmo desenho do irmao
    * FormSigOpClp.
    *
    * A ORDEM eh deliberada - ver a secao de ordem no cabecalho do arquivo: o
    * cabecalho primeiro (a faixa ocupa Top 0..80 e os tres botoes desta fase
    * caem dentro dela), a moldura em seguida (para o botao de saida pousar
    * sobre ela), a grade depois (nao disputa Z-order com nada - Top 143 fica
    * abaixo de tudo), os botoes a seguir (Saida precisa do Shape1 ja criado;
    * cmdEtiquetas/cmdImprimir precisam da faixa ja criada) e o container de
    * busca por ultimo.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarMoldura()
        THIS.ConfigurarGrade()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarContainerProcurar()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza do titulo (cntSombra do legado)
    *
    * Geometria TRANSCRITA do dump (SIGOPETQ.cntSombra / lblSombra /
    * lblTitulo): Top 0 / Left 0 / Height 80 / BackColor 100,100,100 /
    * BorderWidth 0, e os dois labels sobrepostos em Top 18 e 17, Left 10,
    * Tahoma 18 bold, WordWrap, Alignment 0, sombra PRETA embaixo e titulo
    * BRANCO em cima.
    *
    * UNICO desvio, deliberado: as larguras. O dump declara
    * cntSombra.Width = 800 e os dois labels com Width = 769, mas o form tem
    * Width = 630 - o container do cabecalho foi desenhado no Form Designer
    * 170px MAIS LARGO que a propria janela. Copiar os literais poria o label
    * 139px alem da borda direita visivel. Por isso o container usa THIS.Width
    * e os labels THIS.Width - 20, preservando a margem de 10px do Left do
    * dump nos dois lados. Mesma decisao ja registrada para cntSombra em
    * FormSigOpClp / FormSIGPRSTF, e a regra CLAUDE.md #11
    * (cabecalho com a largura do form) trata o container.
    *
    * AutoSize = .F. EXPLICITO nos dois labels: com WordWrap = .T. (que o dump
    * declara) um AutoSize = .T. DESCARTA a Height e colapsa o texto para uma
    * linha so (regra CLAUDE.md #23). As Width/Height aqui ja sao as que o
    * Form Designer calculou, entao fixa-las eh reproducao fiel.
    *
    * ForeColor BRANCO em lbl_4c_LblTitulo eh uma das excecoes legitimas da
    * regra CLAUDE.md #12: o container eh OPACO e escuro (BackStyle = 1 +
    * BackColor RGB(100,100,100)), nao a textura clara das paginas de
    * cadastro.
    *
    * Os nomes migrados vem de tasks/task732/mapeamento.json (cntSombra ->
    * cnt_4c_Sombra, lblSombra -> lbl_4c_LblSombra, lblTitulo ->
    * lbl_4c_LblTitulo): eh esse arquivo que a validacao de fidelidade de UI
    * consulta, entao divergir dele reprovaria a tela sem haver defeito
    * visual. Oito outros forms do projeto chamam a faixa de cnt_4c_Sombra -
    * o que a regra CLAUDE.md #11 proibe eh DETECTAR cabecalho por nome, nunca
    * usar o nome que o mapeamento ja fixou.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
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

        *-- lblSombra: sombra preta, desenhada 1px abaixo do titulo
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top           = 18
            .Left          = 10
            .Width         = THIS.Width - 20
            .Height        = 40
            .AutoSize      = .F.
            .BackStyle     = 0
            .WordWrap      = .T.
            .Alignment     = 0
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        *-- lblTitulo: texto branco por cima da sombra
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top         = 17
            .Left        = 10
            .Width       = THIS.Width - 20
            .Height      = 46
            .AutoSize    = .F.
            .BackStyle   = 0
            .WordWrap    = .T.
            .Alignment   = 0
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .Caption     = THIS.Caption
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarMoldura - Shape1, a area reservada atras do botao de saida
    *
    * Geometria TRANSCRITA do dump (SIGOPETQ.Shape1): Top 9 / Left 548 /
    * Width 73 / Height 55 / BackStyle 0 / BorderStyle 0 / SpecialEffect 0.
    *
    * Com BackStyle 0 (transparente) e BorderStyle 0 (sem linha) este Shape
    * nao pinta nada: ele eh a area reservada atras do botao de saida (Top 4,
    * Left 553, 75x75), que o cobre quase inteiro. Reproduzi-lo mesmo assim eh
    * o PILAR 1 - omitir objeto do legado eh desvio tanto quanto inventar um -
    * e criar antes do botao eh o que garante o z-order do dump (AddObject poe
    * o ultimo objeto no topo).
    *
    * Shape NAO tem ForeColor (regra CLAUDE.md #33): a cor de borda eh
    * BorderColor e o preenchimento eh FillColor - o dump nao declara nenhum
    * dos dois, entao nenhum eh atribuido aqui.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarMoldura()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 9
            .Left          = 548
            .Width         = 73
            .Height        = 55
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - a grade de 4 colunas (Grade do legado)
    *
    * Geometria e aparencia TRANSCRITAS do dump (SIGOPETQ.Grade):
    * ColumnCount 4 / FontName Tahoma 8 / DeleteMark .F. / Height 378 /
    * Left 4 / Panel 1 / ReadOnly .T. / RowHeight 16 / ScrollBars 2 /
    * TabIndex 1 / Top 143 / Width 622 / GridLineColor 238,238,238.
    * RecordMark nao consta no dump (a classe base do framework legado ja
    * nascia sem ele) - fixado .F. aqui de qualquer forma, por ser grade
    * criada via AddObject num form OPERACIONAL.
    *
    * Aqui ficam SO as propriedades do proprio Grid que nao dependem de dado,
    * incluindo o ReadOnly dele, que propaga para as colunas e por isso tem de
    * ser atribuido ANTES do ReadOnly delas (regra CLAUDE.md #18). Todo o
    * vinculo de dados - ColumnCount, RecordSource, ControlSource, captions,
    * larguras, fontes e Alignment das 4 colunas - esta em VincularGrade, que
    * este metodo chama no fim; o porque da separacao esta no cabecalho desse
    * metodo e no cabecalho do arquivo.
    *
    * O alias usado la eh o RESOLVIDO (THIS.this_cCursorGrade), nao o literal
    * "CsRelatorio" do dump - ver ResolverCursorDaGrade() e o cabecalho do
    * arquivo: o nome do cursor no sistema novo nao eh fixo, eh o que o
    * chamador de fato entregou. GarantirCursorRelatorio() ja rodou em
    * InicializarForm, ANTES de ConfigurarPageFrame, entao o alias ja esta
    * ABERTO quando as colunas sao ligadas (regra CLAUDE.md #41 -
    * Column.ControlSource de cursor inexistente derruba o Init).
    *
    * Nenhuma das 4 celulas eh editavel (ReadOnly = .T. no Grid e em cada
    * Column e Text1) - o dump legado declara a grade inteira somente
    * leitura, e o BO (SigOpEtqBO, cabecalho do arquivo) documenta o mesmo:
    * esta tela so EXIBE o cursor que o chamador montou.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top           = 143
            .Left          = 4
            .Width         = 622
            .Height        = 378
            .FontName      = "Tahoma"
            .FontSize      = 8
            .TabIndex      = 1
            .Panel         = 1
            .GridLineColor = RGB(238, 238, 238)
            .RowHeight     = 16
            .ScrollBars    = 2
            .DeleteMark    = .F.
            .RecordMark    = .F.

            *-- ReadOnly do GRID vem ANTES do ReadOnly de cada COLUNA
            *-- (regra CLAUDE.md #18): o do grid PROPAGA para as colunas e
            *-- sobrescreveria o delas se a ordem fosse invertida. O do grid
            *-- fica aqui (aparencia, atribuido uma vez) e o das colunas em
            *-- VincularGrade, junto com o resto do vinculo de dados.
            .ReadOnly = .T.
        ENDWITH

        *-- O vinculo com o cursor - ColumnCount, RecordSource, ControlSource,
        *-- headers, larguras, fontes e o ReadOnly das colunas - mora em
        *-- VincularGrade, nao aqui: eh exatamente o bloco que o funil de
        *-- repintura (CarregarDados) precisa reaplicar quando o alias do pai
        *-- muda, e manter duas copias faria as duas divergirem na primeira
        *-- vez que alguem mexesse em uma delas.
        THIS.VincularGrade()

        THIS.grd_4c_Dados.Visible = .T.
    ENDPROC

    *==========================================================================
    * VincularGrade - liga a grade ao cursor resolvido (bloco UNICO do vinculo)
    *
    * Reune TODO o vinculo de dados da grade, na ordem obrigatoria (Problema 2
    * de FORMCOR_LICOES_APRENDIDAS + regra CLAUDE.md #41):
    *
    *   ColumnCount -> RecordSource -> ControlSource -> Header1.Caption -> Width
    *
    * A ordem nao eh estilo: RecordSource e ControlSource RESETAM os headers
    * para o default Column1..Column4 e devolvem as larguras ao default 90,
    * entao caption e largura tem de ser (re)escritos DEPOIS deles. Por isso
    * tambem o ReadOnly das colunas vem aqui e nao em ConfigurarGrade.
    *
    * ColumnCount eh atribuido SO quando difere de 4. Qualquer atribuicao a
    * ColumnCount RECRIA os objetos Column e destruiria controle posto por
    * Column.AddObject (regra CLAUDE.md #144). Esta grade nao tem nenhum - as
    * 4 colunas usam o Text1 nativo -, mas este metodo roda a cada repintura e
    * recriar as colunas em toda chamada seria desperdicio e um convite a
    * regressao no dia em que uma celula ganhar controle proprio.
    *
    * Sem cursor ABERTO o metodo nao toca na grade e devolve .F.: ligar
    * Column.ControlSource a alias inexistente derruba o Init com
    * "Alias not found" (regra CLAUDE.md #41) - e a tela nem abriria. Nao eh
    * condicao de erro e por isso nao exibe mensagem: quem chama decide. Em
    * producao o alias chega populado do chamador e, fora do fluxo dele,
    * GarantirCursorRelatorio() do BO ja criou o alias vazio com a estrutura
    * certa antes desta chamada.
    *
    * As 4 colunas sao CBars (Barra, numeric(14,0)) / Datas (Data Entrada,
    * datetime) / DPros (Descricao, char(65)) / pLocals (Local, char(10)),
    * com larguras, Alignment dos headers (2 nas quatro) e Alignment da
    * celula da coluna 4 TRANSCRITOS do dump de SIGOPETQ.Grade.
    *
    * Sem TRY/CATCH de proposito: os dois chamadores (ConfigurarGrade, via
    * InicializarForm, e CarregarDados) ja rodam dentro de um TRY que reporta
    * com linha e procedure. Um CATCH aqui ou seria silencioso (proibido pela
    * regra CLAUDE.md #9) ou duplicaria a mensagem do chamador.
    *
    * PUBLIC (sem PROTECTED) porque eh chamado pelo funil de repintura e pelo
    * harness de teste de fora da classe - PROTECTED falharia em runtime com
    * "Property VINCULARGRADE is not found" (regras CLAUDE.md #3 e #51).
    *
    * Retorno: .T. quando a grade ficou ligada ao cursor; .F. quando nao havia
    * alias aberto para ligar.
    *==========================================================================
    PROCEDURE VincularGrade()
        LOCAL loc_lSucesso, loc_cCursor

        loc_lSucesso = .F.
        loc_cCursor  = ALLTRIM(THIS.this_cCursorGrade)

        IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
            *-- ColumnCount e RecordSource FORA do WITH, com referencia
            *-- explicita: dentro do WITH as colunas ainda nao existem no
            *-- instante em que o VFP9 resolve .Column1/.Column2/... e a
            *-- tela estoura "Unknown member COLUMN1".
            *-- ColumnCount ANTES de RecordSource, e so se precisar
            IF THIS.grd_4c_Dados.ColumnCount != 4
                THIS.grd_4c_Dados.ColumnCount = 4
            ENDIF

            THIS.grd_4c_Dados.RecordSource = loc_cCursor

            WITH THIS.grd_4c_Dados
                *-- ControlSource de cada coluna
                .Column1.ControlSource = loc_cCursor + ".CBars"
                .Column2.ControlSource = loc_cCursor + ".Datas"
                .Column3.ControlSource = loc_cCursor + ".DPros"
                .Column4.ControlSource = loc_cCursor + ".pLocals"

                *-- Headers RECONFIGURADOS imediatamente apos o ControlSource
                *-- (RecordSource/ControlSource resetam Header1.Caption para o
                *-- default ColumnN)
                .Column1.Header1.Caption   = "Barra"
                .Column1.Header1.Alignment = 2
                .Column1.Header1.FontName  = "Tahoma"
                .Column1.Header1.FontSize  = 8

                .Column2.Header1.Caption   = "Data Entrada"
                .Column2.Header1.Alignment = 2
                .Column2.Header1.FontName  = "Tahoma"
                .Column2.Header1.FontSize  = 8

                .Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                .Column3.Header1.Alignment = 2
                .Column3.Header1.FontName  = "Tahoma"
                .Column3.Header1.FontSize  = 8

                .Column4.Header1.Caption   = "Local"
                .Column4.Header1.Alignment = 2
                .Column4.Header1.FontName  = "Tahoma"
                .Column4.Header1.FontSize  = 8

                *-- Width por ULTIMO (o mesmo reset de RecordSource/
                *-- ControlSource derruba a largura das colunas)
                .Column1.Width = 108
                .Column2.Width = 70
                .Column3.Width = 370
                .Column4.Width = 40

                .Column1.Movable   = .F.
                .Column1.Resizable = .T.
                .Column4.Alignment = 2

                .Column1.FontName = "Tahoma"
                .Column1.FontSize = 8
                .Column2.FontName = "Tahoma"
                .Column2.FontSize = 8
                .Column3.FontName = "Tahoma"
                .Column3.FontSize = 8
                .Column4.FontName = "Tahoma"
                .Column4.FontSize = 8

                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.FontName    = "Tahoma"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.FontName    = "Tahoma"
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.FontName    = "Tahoma"
                .Column3.Text1.FontSize    = 8
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)

                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.Margin      = 0
                .Column4.Text1.FontName    = "Tahoma"
                .Column4.Text1.FontSize    = 8
                .Column4.Text1.Alignment   = 2
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)

                *-- ReadOnly das COLUNAS depois do ReadOnly do GRID, que
                *-- ConfigurarGrade ja atribuiu (regra CLAUDE.md #18). A grade
                *-- inteira eh somente leitura no dump legado: esta tela so
                *-- EXIBE o cursor que o chamador montou.
                .Column1.ReadOnly = .T.
                .Column2.ReadOnly = .T.
                .Column3.ReadOnly = .T.
                .Column4.ReadOnly = .T.
                .Column1.Text1.ReadOnly = .T.
                .Column2.Text1.ReadOnly = .T.
                .Column3.Text1.ReadOnly = .T.
                .Column4.Text1.ReadOnly = .T.
            ENDWITH

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDados - funil UNICO de carga e repintura da grade
    *
    * Reproduz o trio/par que o legado repete em DOIS lugares - e os dois NAO
    * sao o mesmo trio:
    *
    *   SIGOPETQ.Init                    GetBusca.LostFocus
    *     Select csRelatorio               ThisForm.Grade.Refresh
    *     Go Top                           ThisForm.Grade.Column1.Text1.SetFocus
    *     ThisForm.Grade.Refresh
    *     ThisForm.Grade.Column1.Text1.SetFocus
    *
    * O Init reposiciona para o PRIMEIRO registro (Go Top); o LostFocus NAO -
    * ele repinta onde quer que o Valid (BuscarPorBarra, chamado ANTES disto
    * em ValidarBusca) tenha deixado o ponteiro, inclusive numa barra
    * encontrada no MEIO do cursor. Por isso este metodo recebe
    * par_lReposicionar: .T. (default, usado pelo Init) refaz o Go Top via
    * PosicionarPrimeiro; .F. (usado por ValidarBusca) pula o Go Top e so
    * repinta - chamar com o default ali DESFARIA o Seek que acabou de
    * acontecer, voltando sempre para a primeira linha.
    *
    * Encher o cursor NAO repinta a grade sozinho (regra CLAUDE.md #21): sem o
    * Refresh a grade fica visualmente VAZIA com o cursor cheio, e o sintoma
    * que o usuario relata - "a tela nao traz dados" - manda o diagnostico
    * para SQL/cursor/permissao, longe da causa. Por isso o par vira UM
    * metodo chamado em TODO caminho que (re)apresenta a grade: na abertura
    * (InicializarForm, com reposicionamento) e no LostFocus do campo de
    * busca por codigo de barras (ValidarBusca, sem reposicionamento) -
    * onde ele vem DEPOIS do BuscarPorBarra do BO, que eh quem move o
    * ponteiro.
    *
    * Os passos, e por que cada um existe:
    *
    * 1) ResolverCursorDaGrade + GarantirCursorRelatorio - o alias nao eh
    *    constante (ver o cabecalho do arquivo): quem o escolhe eh o chamador,
    *    e entre duas visitas a esta tela ele pode ter remontado o cursor com
    *    outro nome. Resolver de novo a cada repintura eh barato e eh o que
    *    impede a grade de ficar presa a um alias que nao existe mais.
    * 2) Religa a grade SO quando o vinculo divergiu do alias resolvido.
    *    Religar sempre seria caro e inutil; nao religar nunca deixaria a grade
    *    presa ao alias antigo - vazia, sem erro e sem log.
    * 3) Go Top com fonte UNICA no BO (PosicionarPrimeiro) - SO quando
    *    par_lReposicionar. PosicionarPrimeiro ja faz o SELECT, o GO TOP e
    *    publica a linha corrente nas propriedades; devolve .F. com cursor
    *    VAZIO e isso NAO eh falha, o legado tambem nao avisa nada quando nao
    *    ha etiqueta a exibir. Por isso loc_lSucesso aqui olha o CURSOR (aberto
    *    e nomeado), nao o retorno dele.
    * 4) Grade.Refresh, que eh o unico passo que de fato pinta - roda sempre,
    *    com ou sem reposicionamento.
    *
    * O SetFocus do legado fica sob guarda de VISIBILIDADE. Em VFP9 o Init roda
    * ANTES do Show(), e nesse instante nem o form nem a grade estao visiveis -
    * SetFocus ali nao teria efeito util. Na abertura o foco cai sozinho na
    * grade, que eh o TabIndex = 1 da tela (transcrito do dump), e no LostFocus
    * da busca - com a tela JA visivel - a guarda passa e o foco volta para a
    * grade, que eh o comportamento que o legado entrega ao usuario. O foco vai
    * para a GRADE e nao para Column1.Text1: a coluna ativa de uma grade
    * recem-pintada ja eh a primeira, entao o efeito eh o mesmo sem depender de
    * alcancar a celula de uma grade somente leitura.
    *
    * PUBLIC (sem PROTECTED): eh chamado de FORA da classe pelo harness de
    * teste automatizado, e PEMSTATUS devolve .T. para metodo PROTECTED - o
    * teste entraria no ramo e a chamada falharia em runtime com
    * "Property CARREGARDADOS is not found" (regras CLAUDE.md #3 e #51).
    * Chamado SEM argumento (como o harness faz) preserva o comportamento
    * antigo (reposiciona), porque par_lReposicionar default eh .T.
    *
    * Retorno: .T. quando havia cursor aberto e a grade foi repintada; .F.
    * quando nao havia cursor nenhum para apresentar.
    *==========================================================================
    PROCEDURE CarregarDados(par_lReposicionar)
        LOCAL loc_lSucesso, loc_cCursor, loc_cLigado, loc_lReposicionar, loc_oErro

        loc_lSucesso = .F.

        loc_lReposicionar = .T.
        IF PCOUNT() >= 1 AND VARTYPE(par_lReposicionar) = "L"
            loc_lReposicionar = par_lReposicionar
        ENDIF

        TRY
            *-- 1) o alias do chamador pode ter mudado entre duas visitas
            THIS.ResolverCursorDaGrade()
            THIS.this_oBusinessObject.GarantirCursorRelatorio()

            loc_cCursor = ALLTRIM(THIS.this_cCursorGrade)
            loc_cLigado = ALLTRIM(THIS.grd_4c_Dados.RecordSource)

            *-- 2) religa so se o vinculo nao eh mais o alias certo
            IF EMPTY(loc_cLigado) OR UPPER(loc_cLigado) != UPPER(loc_cCursor)
                THIS.VincularGrade()
            ENDIF

            *-- 3) Go Top do legado - SO quando par_lReposicionar (ver acima)
            IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
                IF loc_lReposicionar
                    THIS.this_oBusinessObject.PosicionarPrimeiro()
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            *-- 4) Grade.Refresh do legado - o passo que de fato pinta
            THIS.grd_4c_Dados.Refresh()

            *-- SetFocus do legado, sob guarda de visibilidade (ver acima).
            *-- O EOF fica num IF ANINHADO, nao num AND na mesma linha: EOF()
            *-- sobre alias vazio/inexistente ESTOURA "Alias is not found"
            *-- (medido no VFP9), e o aninhamento garante que ele so eh
            *-- alcancado quando loc_lSucesso provou que o alias esta aberto -
            *-- sem depender de o VFP curto-circuitar o AND.
            IF loc_lSucesso AND THIS.Visible
                IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
                    IF !EOF(loc_cCursor)
                        THIS.grd_4c_Dados.SetFocus()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpEtq.CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - os tres botoes de acao (Sa?da / cmdEtiquetas / cmdImprimir)
    *
    * O dump NAO tem CommandGroup de 5 botoes CRUD: SigOpEtq.SCX eh um
    * dialogo de CONSULTA (o BO nao sobrescreve Inserir/Atualizar/
    * ExecutarExclusao - ver cabecalho de SigOpEtqBO.prg), e os unicos
    * objetos de acao sao os tres do dump: um CommandButton de saida e dois
    * CommandGroup de ButtonCount = 1 cada. Inventar Incluir/Alterar/Excluir
    * aqui acrescentaria funcionalidade que o legado nao tem - viola o
    * PILAR 1 tanto quanto omitir algo que ele tem.
    *
    * Geometria, fonte e icones TRANSCRITOS do dump (SIGOPETQ.Sa?da /
    * .cmdEtiquetas.Command1 / .cmdImprimir.Command1). Os tres ficam DENTRO
    * da faixa do cabecalho (Top -1..79) e por isso sao criados DEPOIS dela
    * (THIS.ConfigurarCabecalho, chamada antes em ConfigurarPageFrame) -
    * regra CLAUDE.md #11, AddObject desenha o ultimo objeto por cima. O
    * botao de saida tambem pousa sobre o Shape1 (ConfigurarMoldura, chamado
    * antes).
    *
    * Buttons(1) eh configurado em bloco WITH proprio, por fora do WITH do
    * grupo (regra CLAUDE.md #38 - Buttons(N) DENTRO do WITH do grupo eh
    * seguro; o que quebra eh WITH aninhado em Container/Label/CommandGroup
    * criado por AddObject de dentro de OUTRO WITH, que nao eh o caso aqui).
    *
    * CommandGroup NAO tem ForeColor nem BackColor (regra CLAUDE.md #33) -
    * por isso nenhum dos dois eh atribuido no WITH do grupo; eles existem
    * so no Buttons(1), que eh um CommandButton de verdade.
    *
    * Visible = .T. nos tres, igual ao resto do dump. A visibilidade REAL de
    * cmdEtiquetas/cmdImprimir - fChecaAcesso('SIGOPETQ', 'ETIQUETA'/
    * 'IMPRIMIR') no Init legado - NAO eh decidida aqui e sim em
    * AplicarControleAcesso(), por uma razao de ORDEM e nao de fase: este
    * metodo roda dentro de ConfigurarPageFrame, e depois dele
    * InicializarForm chama TornarControlesVisiveis(), que forca
    * Visible = .T. em TODO controle - a decisao de permissao tomada aqui
    * seria APAGADA. Por isso ela vem DEPOIS daquela varredura. As duas
    * chamadas continuam saindo de dentro do Init, como no legado (ver o
    * cabecalho de AplicarControleAcesso sobre as duas definicoes vivas de
    * fChecaAcesso e sobre o travamento em probe sem SQL Server).
    *
    * Nenhum Click/Valid eh ligado aqui: os tres BINDEVENT ficam juntos em
    * ConfigurarEventos(), que InicializarForm chama depois da montagem -
    * Saida.Click -> BtnSaidaClick (Release), cmdEtiquetas.Valid ->
    * BtnEtiquetasClick (SigOpIpE, dialogo neto AINDA NAO migrado) e
    * cmdImprimir.Valid -> BtnImprimirClick (SigMvDoc, que no sistema novo eh
    * FormSigOpEtqDoc). Concentrar os binds num metodo so eh o que permite
    * conferir de um lugar que nenhum evento do dump ficou sem handler.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- Botao de saida (Sa?da do legado)
        THIS.AddObject("cmd_4c_Saida", "CommandButton")
        WITH THIS.cmd_4c_Saida
            .Top        = 4
            .Left       = 553
            .Width      = 75
            .Height     = 75
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .Caption    = "<Esc> Sair"
            .Cancel     = .T.
            .TabIndex   = 3
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH

        *-- cmdEtiquetas: CommandGroup com 1 botao interno (btnEtiquetas)
        THIS.AddObject("obj_4c_CmdEtiquetas", "CommandGroup")
        WITH THIS.obj_4c_CmdEtiquetas
            .Top         = -1
            .Left        = 398
            .Width       = 85
            .Height      = 85
            .ButtonCount = 1
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .TabIndex    = 64
            .Visible     = .T.
        ENDWITH

        WITH THIS.obj_4c_CmdEtiquetas.Buttons(1)
            .Top        = 5
            .Left       = 5
            .Width      = 75
            .Height     = 75
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .Picture    = gc_4c_CaminhoIcones + "geral_etiqueta_26.jpg"
            .Caption    = "\<Etiquetas"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
        ENDWITH

        *-- cmdImprimir: CommandGroup com 1 botao interno (btnImprimir)
        THIS.AddObject("obj_4c_CmdImprimir", "CommandGroup")
        WITH THIS.obj_4c_CmdImprimir
            .Top         = -1
            .Left        = 473
            .Width       = 85
            .Height      = 85
            .ButtonCount = 1
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .TabIndex    = 64
            .Visible     = .T.
        ENDWITH

        WITH THIS.obj_4c_CmdImprimir.Buttons(1)
            .AutoSize   = .F.
            .Top        = 5
            .Left       = 5
            .Width      = 75
            .Height     = 75
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .Picture    = gc_4c_CaminhoIcones + "geral_impressora_normal_32.jpg"
            .Caption    = "\<Imprimir"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerProcurar - caixa do campo de busca (Cnt_Procurar)
    *
    * Geometria TRANSCRITA do dump (SIGOPETQ.Cnt_Procurar): Top 86 / Left 5 /
    * Width 174 / Height 54 / SpecialEffect 0 / TabIndex 2.
    *
    * O TabIndex eh transcrito de proposito: ele define a ordem de tabulacao
    * que o usuario conhece, e eh das propriedades que a migracao mais deixa
    * para tras. Aqui ele importa porque o campo de busca dentro deste
    * container tem TabIndex 1 e a grade tambem - a ordem relativa eh o que
    * leva o foco do campo para a grade.
    *
    * BackStyle e BackColor NAO sao atribuidos, NEM no container NEM no
    * rotulo: o dump nao os declara em nenhum dos dois, logo valem os defaults
    * da classe base - foi com eles que o legado desenhou. Como as duas pontas
    * ficam no MESMO default (base Container e base Label), o rotulo nao
    * aparece como caixa de cor diferente sobre o container; fixar um dos dois
    * eh que arriscaria descasa-los. O ForeColor 90,90,90 do rotulo vem do
    * proprio dump e eh exatamente o canonico da regra CLAUDE.md #12 - nunca
    * branco, que num container claro ficaria INVISIVEL.
    *
    * OS DOIS FILHOS - a superficie de campos inteira desta tela
    * ----------------------------------------------------------
    * Nomes migrados de tasks/task732/mapeamento.json (Label4 ->
    * lbl_4c_Label4, GetBusca -> txt_4c_Busca): eh esse arquivo que a
    * validacao de fidelidade de UI consulta, entao divergir dele reprovaria a
    * tela sem haver defeito visual.
    *
    * lbl_4c_Label4 - TRANSCRITO de SIGOPETQ.Cnt_Procurar.Label4: Top 17 /
    * Left 11 / Width 43 / Height 17 / Tahoma 8 / ForeColor 90,90,90 /
    * TabIndex 10 / Caption "Barra  :" (com os DOIS espacos antes dos dois
    * pontos, como o legado escreve).
    *
    *   Alignment = 0 EXPLICITO, nunca 1: o rotulo vai da esquerda para a
    *   direita e a geometria do legado ja conta com isso - 11 + 43 = 54,
    *   dois pixels antes do campo, que comeca em 56. Com Alignment = 1 o
    *   texto encostaria na borda DIREITA da caixa, cairia DENTRO do campo e
    *   seria comido por ele, porque o rotulo eh criado ANTES (regra
    *   CLAUDE.md #23 / CorretorAutomatico #202).
    *
    *   AutoSize = .F. EXPLICITO: o dump nao declara AutoSize, e a Width/
    *   Height daqui JA SAO o auto-size que o Form Designer calculou - fixa-
    *   las eh reproducao fiel. AutoSize = .T. seria no-op em Label criado por
    *   AddObject (a Width ficaria nos 100 do default) e, havendo WordWrap,
    *   DESCARTARIA a Height (regra CLAUDE.md #23).
    *
    * txt_4c_Busca - o GetBusca do legado. A classe dele eh fwget
    * (..\framework\framework.vcx), entao as propriedades vem de DOIS lugares
    * e os dois foram lidos:
    *
    *   da CLASSE fwget   FontName Tahoma / FontSize 8 / Format "K" /
    *                     Height 23 / DisabledBackColor 192,192,192 /
    *                     DisabledForeColor 0,0,0 / Themes .F.
    *   do SCX (override) Top 15 / Left 56 / Width 108 / Height 23 /
    *                     ForeColor 0,0,0 / TabIndex 1
    *
    *   Format = "K" vem da CLASSE e eh fiel transcreve-lo: ele seleciona o
    *   conteudo ao entrar no campo, o que neste campo tem uso real - a barra
    *   anterior fica marcada e a leitura seguinte do coletor a substitui sem
    *   o usuario apagar nada. Herdar propriedade de classe do framework em
    *   vez de copiar so o override do SCX eh o mesmo cuidado da regra
    *   CLAUDE.md #28/#30 (o SCX sobrepoe a classe, nao a substitui).
    *
    *   ZOrderSet = 4, que o dump declara, NAO eh transcrito: eh bookkeeping
    *   do Form Designer e nao existe como propriedade em runtime - atribui-la
    *   estouraria "Property ZORDERSET is not found" no Init e a tela nao
    *   abriria (regra CLAUDE.md #33). O z-order real vem da ORDEM dos
    *   AddObject, e aqui ela eh a do dump: rotulo primeiro, campo depois.
    *
    *   Value = "" torna o campo CARACTERE, que eh o que a classe fwget
    *   entrega (TextBox base nasce com Value caractere vazio e o dump nao
    *   declara Value). A coluna indexada do cursor eh CBars numeric(14,0),
    *   mas a conversao NAO fica aqui: quem a faz eh o BO
    *   (SigOpEtqBO.BuscarPorBarra, Fase 2), que le o tipo REAL da coluna com
    *   TYPE() e so entao escolhe entre VAL(texto) e o texto - o cursor vem de
    *   FORA, montado pelo chamador, e so ele sabe como declarou a coluna.
    *
    *   MaxLength e InputMask NAO sao atribuidos: nem o SCX nem a classe fwget
    *   os declaram. Inventar "14" a partir da largura da coluna fecharia o
    *   campo mais do que o legado fecha - acrescentar restricao que o legado
    *   nao tem eh desvio do PILAR 1 tanto quanto perder uma que ele tem
    *   (regra CLAUDE.md #49). Barra longa demais simplesmente nao casa no
    *   Seek, que eh o que o legado tambem faz. E MaxLength NUNCA sai da Width
    *   em pixels (regra CLAUDE.md #19): aqui os dois numeros vizinhos seriam
    *   108 e 14, e copiar o errado passaria calado.
    *
    * Nenhum BINDEVENT aqui: o Valid (Seek por barra) e o LostFocus
    * (repintura + foco de volta na grade) sao EVENTOS e vem na fase seguinte,
    * com o corpo ja pronto no BO e a repintura ja pronta em CarregarDados -
    * ver o escopo da Fase 5 no cabecalho do arquivo.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerProcurar()
        THIS.AddObject("cnt_4c__Procurar", "Container")
        WITH THIS.cnt_4c__Procurar
            .Top           = 86
            .Left          = 5
            .Width         = 174
            .Height        = 54
            .SpecialEffect = 0
            .TabIndex      = 2
            .Visible       = .T.
        ENDWITH

        *-- Label4: a legenda do campo de busca. Criado ANTES do campo, como
        *-- no dump - AddObject desenha o ultimo objeto por cima.
        THIS.cnt_4c__Procurar.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.cnt_4c__Procurar.lbl_4c_Label4
            .Top       = 17
            .Left      = 11
            .Width     = 43
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Barra  :"
            .TabIndex  = 10
            .Visible   = .T.
        ENDWITH

        *-- GetBusca: o campo de codigo de barras (classe fwget no legado)
        THIS.cnt_4c__Procurar.AddObject("txt_4c_Busca", "TextBox")
        WITH THIS.cnt_4c__Procurar.txt_4c_Busca
            .Top               = 15
            .Left              = 56
            .Width             = 108
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Format            = "K"
            .Value             = ""
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .TabIndex          = 1
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - repoe Visible = .T. apos os AddObject
    *
    * AddObject cria todo controle com Visible = .F., e a recursao alcanca os
    * filhos dos dois container.
    *
    * NAO ha lista de excecao aqui porque o dump de SIGOPETQ nao tem nenhum
    * controle que nasca oculto: nenhum dos 22 objetos declara Visible = .F.
    * Os dois commandgroup que o legado ESCONDE conforme a permissao do
    * usuario sao escondidos em RUNTIME, no fim do Init, DEPOIS da montagem -
    * logo a fase que os criar tem de aplicar a permissao APOS esta chamada,
    * senao este metodo apagaria a decisao.
    *
    * PEMSTATUS eh usado sobre OBJETO (nunca sobre alias de cursor, onde
    * dispara erro 11), e o guard de ControlCount > 0 evita descer em
    * controle folha.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    IF loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * AplicarControleAcesso - visibilidade dos botoes conforme permissao
    *
    * Legado (Init):
    *   ThisForm.cmdEtiquetas.Visible = fChecaAcesso('SIGOPETQ', 'ETIQUETA')
    *   ThisForm.cmdImprimir.Visible  = fChecaAcesso('SIGOPETQ', 'IMPRIMIR')
    *
    * fChecaAcesso() eh chamado DIRETO, sem guarda de modo teste: eh o padrao
    * do resto do projeto (SigOpCrdBO.prg:249, Formsigrepes.prg:244/246/248).
    * O repo tem duas definicoes vivas (utils\functions.prg, stub morto que
    * nunca eh alcancado, e Framework\sigacess.PRG, que vence a resolucao de
    * SET PROCEDURE e abre conexao propria) - a de sigacess PENDURA quando
    * chamada num PROBE sem SQL Server alcancavel, mas isso nao eh motivo
    * para desviar do padrao em producao, onde a chamada direta funciona
    * (memoria feedback_fchecaacesso_duplicado_sigacess_vence_e_pendura_probe).
    *
    * Chamado DEPOIS de TornarControlesVisiveis (ver InicializarForm): aquele
    * metodo forca Visible = .T. em todo controle, e chamar este ANTES dele
    * faria a decisao de permissao ser apagada.
    *==========================================================================
    PROTECTED PROCEDURE AplicarControleAcesso()
        THIS.obj_4c_CmdEtiquetas.Visible = fChecaAcesso("SIGOPETQ", "ETIQUETA")
        THIS.obj_4c_CmdImprimir.Visible  = fChecaAcesso("SIGOPETQ", "IMPRIMIR")
    ENDPROC

    *==========================================================================
    * ConfigurarEventos - liga os 4 BINDEVENT da fase de eventos
    *
    * Nenhum em "Valid": BINDEVENT("Valid") nao dispara de forma confiavel em
    * TextBox, e os dois CommandGroup usam "Click" - o disparo nativo de acao
    * de CommandButton em VFP9 puro (o Valid do dump eh peculiaridade da
    * classe do framework legado, nao do VFP base).
    *
    * Os 4 delegates (ValidarBusca/BtnSaidaClick/BtnEtiquetasClick/
    * BtnImprimirClick) sao PUBLIC (sem PROTECTED): BINDEVENT com delegate
    * PROTECTED falha silenciosamente (regra CLAUDE.md #3).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        BINDEVENT(THIS.cnt_4c__Procurar.txt_4c_Busca, "LostFocus", ;
            THIS, "ValidarBusca")
        BINDEVENT(THIS.cmd_4c_Saida, "Click", THIS, "BtnSaidaClick")
        BINDEVENT(THIS.obj_4c_CmdEtiquetas.Buttons(1), "Click", ;
            THIS, "BtnEtiquetasClick")
        BINDEVENT(THIS.obj_4c_CmdImprimir.Buttons(1), "Click", ;
            THIS, "BtnImprimirClick")
    ENDPROC

    *==========================================================================
    * ValidarBusca - GetBusca.Valid (Seek) + GetBusca.LostFocus (repintura)
    *
    * Legado:
    *   PROCEDURE Valid        lcProd = This.Value
    *                          If Not Empty(lcProd)
    *                              Select csRelatorio
    *                              lnReg = Recno()
    *                              If Not Seek(lcProd, csRelatorio, CBars)
    *                                  Go lnReg
    *                              EndIf
    *                          EndIf
    *   PROCEDURE LostFocus     ThisForm.Grade.Refresh
    *                          ThisForm.Grade.Column1.Text1.SetFocus
    *
    * Valid roda ANTES de LostFocus ao sair do campo - por isso este handler
    * unico chama primeiro BuscarPorBarra (o corpo do Valid, pronto no BO
    * desde a Fase 2: move o ponteiro do cursor, ou volta para onde estava se
    * a barra nao bater) e so DEPOIS CarregarDados (o corpo do LostFocus,
    * pronto neste form desde a Fase 4: Refresh + foco), que pressupoe o
    * ponteiro ja reposicionado.
    *
    * CarregarDados(.F.): o .F. eh par_lReposicionar = .F. - este LostFocus
    * SO repinta onde o Seek de BuscarPorBarra deixou o ponteiro. Chamar
    * CarregarDados() sem argumento (o default reposiciona, igual ao Init)
    * desfaria o Seek na hora, voltando sempre para a primeira linha - o
    * usuario digitaria a barra, acertaria, e veria a lista pular para o
    * TOPO em vez de mostrar a linha encontrada.
    *
    * Sem MsgAviso quando a barra nao bate: o legado tambem nao avisa (regra
    * CLAUDE.md #50) - BuscarPorBarra so guarda a mensagem em
    * this_cMensagemErro, sem exibi-la, e devolve o ponteiro para a linha
    * anterior.
    *
    * Nome: Validar<Campo> eh o nome canonico do projeto para o handler que
    * reproduz o Valid de um campo digitavel - txt_4c_Busca eh o UNICO campo
    * de entrada desta tela (os demais dados sao as celulas somente-leitura da
    * grade). Batizar de <Campo>LostFocus seria pior que cosmetico: a regra
    * CLAUDE.md #47 usa exatamente esse nome como assinatura de defeito.
    *
    * PUBLIC: BINDEVENT exige (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE ValidarBusca()
        *-- Guarda de reentrancia (regra CLAUDE.md #47): CarregarDados move o
        *-- foco para a grade de DENTRO do LostFocus deste campo, e mover o
        *-- foco redispara o proprio LostFocus. Sem a flag o Seek por barra
        *-- rodaria duas vezes a cada saida do campo.
        *--
        *-- set no topo e clear no fim BASTAM aqui porque o corpo nao tem
        *-- RETURN antecipado: as duas chamadas tem TRY/CATCH proprio e
        *-- sempre devolvem o controle. O wrapper <Nome>Exec que a regra #47
        *-- exige existe para o caso contrario - RETURN no meio travaria a
        *-- flag ligada e mataria a busca pelo resto da vida do form.
        IF THIS.this_lEmValidacaoBusca
            RETURN
        ENDIF

        THIS.this_lEmValidacaoBusca = .T.

        THIS.this_oBusinessObject.BuscarPorBarra( ;
            THIS.cnt_4c__Procurar.txt_4c_Busca.Value)

        THIS.CarregarDados(.F.)

        THIS.this_lEmValidacaoBusca = .F.
    ENDPROC

    *==========================================================================
    * BtnSaidaClick - Legado: Sa?da.Click -> ThisForm.Release
    *==========================================================================
    PROCEDURE BtnSaidaClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnEtiquetasClick - Legado: btnEtiquetas.Valid -> Do Form SigOpIpE With ThisForm
    *
    * SigOpIpE.SCX esta em ProximasMigracoes\, AINDA NAO migrado: nao existe
    * FormSigOpIpE em projeto\app\, e nenhuma classe equivalente.
    *
    * Por que NAO fica "DO FORM SigOpIpE WITH THIS", que eh a transcricao
    * literal do legado: no sistema novo os forms sao DEFINE CLASS em .prg e
    * NAO existe .scx nenhum em projeto\. O DO FORM procura um .scx em disco,
    * nao acha, e estoura "File 'sigopipe.scx' does not exist" - ou seja, o
    * dialogo nunca abriria de qualquer modo, e a mensagem que o usuario
    * receberia culpa um ARQUIVO em vez de dizer o que de fato falta. O
    * mesmo DO FORM tambem deixa a classe filha fora do indice de carga sob
    * demanda (automation\GerarIndiceClasses.ps1 le CREATEOBJECT/NEWOBJECT/
    * AddObject, nunca DO FORM), entao um defeito esconderia o outro.
    *
    * Tambem NAO fica CREATEOBJECT("FormSigOpIpE"): a classe nao existe em
    * lugar nenhum e o CREATEOBJECT estouraria "Class definition ... is not
    * found", trocando uma mensagem obscura por outra.
    *
    * NAO eh o stub disfarcado que a regra CLAUDE.md "NUNCA Criar Stubs com
    * MsgAviso" proibe. Aquela regra ataca o migrador que avisa "sera
    * implementado" no lugar de portar logica que ESTA no dump e podia ser
    * portada. Aqui nao ha logica a portar: o btnEtiquetas.Valid do legado
    * tem UMA linha, e ela abre uma OUTRA TELA, com SCX proprio, que ainda
    * nao entrou em migracao. A dependencia que falta tem de ficar VISIVEL
    * (mesmo criterio da regra #27, que manda deixar ausencia aparecer em vez
    * de devolver valor inventado em silencio) - e eh o que a mensagem faz.
    *
    * QUANDO SigOpIpE for migrado: trocar este corpo pelo par canonico
    * CREATEOBJECT + Show(), com o Show() FORA do TRY (regra CLAUDE.md #29,
    * porque o dialogo eh modal) e passando THIS adiante, que eh o "With
    * ThisForm" do legado - as duas propriedades this_cTipo / this_cOpEscolha
    * existem exatamente para esse neto ler.
    *==========================================================================
    PROCEDURE BtnEtiquetasClick()
        MsgAviso("A tela de Etiquetas (SigOpIpE) ainda n" + CHR(227) + ;
            "o foi migrada para o novo sistema." + CHR(13) + ;
            "A consulta desta tela continua dispon" + CHR(237) + "vel, e o " + ;
            "bot" + CHR(227) + "o Imprimir funciona normalmente.", ;
            "Etiquetas")
    ENDPROC

    *==========================================================================
    * BtnImprimirClick - Legado: btnImprimir.Valid
    *
    *   If .f.
    *       Report Form SigOpEtq && Linha Colocada Apenas Para Compilacao
    *   EndIf
    *   Select csRelatorio
    *   Do Form SigMvDoc With 'SIGOPETQ', 'Impressao da Consulta de Etiquetas'
    *
    * O alvo eh o SigMvDoc, dialogo generico de destino do relatorio. O
    * migrado FormSIGMVDOC/SIGMVDOCBO existe, mas implementa SO o ramo
    * pRep = "SIGCDENT" (faixa de Nota Fiscal contra SigMvNfi - ver o
    * PrepararDados do BO). O ramo desta tela eh o OUTRO: com
    * pRep <> "SIGCDENT" o legado ESCONDE os campos de faixa de Nota e roda
    * "Report Form SIGOPETQ" sobre o cursor corrente. Reusar o FormSIGMVDOC
    * abriria o dialogo ERRADO, e ainda bateria em dois impedimentos: o Init
    * dele nao recebe parametro (nao ha como informar NomeRepo nem titulo) e
    * ele nasce com DataSession = 2, que nao alcanca o cursor desta tela.
    *
    * Por isso o ramo generico foi migrado em classe propria,
    * FormSigOpEtqDoc (forms\operacionais\FormSigOpEtqDoc.prg): a barra de 4
    * botoes do frmrelatorio - Visualizar / Imprimir / Arquivos Email /
    * Encerrar - na MESMA data session do cursor, delegando as tres acoes ao
    * SigOpEtqBO (Visualizar/Imprimir/GerarExcel), que conhece o nome-base do
    * FRX e o alias do cursor. O FRX legado foi portado para
    * projeto\app\reports\SigOpEtq.frx.
    *
    * CREATEOBJECT, nunca "DO FORM SigMvDoc": no sistema novo nao existe .scx
    * em projeto\, entao o DO FORM estouraria "File 'sigmvdoc.scx' does not
    * exist" e o dialogo nunca abriria - alem de deixar a classe filha fora
    * do indice de carga sob demanda, que le CREATEOBJECT e nao DO FORM.
    *
    * O Show() fica FORA do TRY (regra CLAUDE.md #29): o dialogo eh modal,
    * logo o Show() BLOQUEIA e todo o uso dele - cada Click - vive dentro
    * dessa chamada. Dentro do TRY, qualquer erro de runtime do filho cairia
    * neste CATCH, a referencia LOCAL morreria e a tela filha fecharia
    * sozinha, com o pai seguindo vivo.
    *
    * O "Select csRelatorio" que o legado faz ANTES do Do Form nao se repete
    * aqui: quem seleciona o alias eh o ExecutarReportForm do BO, junto do
    * Go Top, imediatamente antes do REPORT FORM - que eh onde isso importa,
    * porque o FRX le a work area corrente.
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oDialogo, loc_oErro

        loc_oDialogo = .NULL.

        TRY
            loc_oDialogo = CREATEOBJECT("FormSigOpEtqDoc", ;
                THIS.this_oBusinessObject, ;
                THIS.this_oBusinessObject.this_cTituloRelatorio)
        CATCH TO loc_oErro
            loc_oDialogo = .NULL.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao abrir Imprimir")
        ENDTRY

        IF VARTYPE(loc_oDialogo) = "O"
            loc_oDialogo.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - solta as referencias e devolve o controle ao chamador
    *
    * Legado (Saida.Click): ThisForm.Release e mais nada - esta tela nao
    * desabilita o chamador ao abrir, entao nao ha nada a reabilitar na saida.
    *
    * O cursor da grade NAO eh fechado aqui: ele pertence ao CHAMADOR, que
    * continua vivo depois desta tela e usa aquele alias (o relatorio de
    * inventario reabre este dialogo em cada um dos quatro caminhos de saida
    * dele). Fecha-lo derrubaria o cursor debaixo de quem segue precisando
    * dele. Quem distingue a origem eh o BO: o Destroy dele fecha apenas o
    * alias que ele mesmo criou, no caso de a tela ter sido aberta fora do
    * fluxo do chamador.
    *
    * A referencia ao chamador eh anulada ANTES do DODEFAULT() para nao
    * manter vivo um objeto que ja nao se usa; anular nao o destroi, porque
    * quem o criou segue com a propria referencia.
    *
    * DODEFAULT() eh a ULTIMA linha, obrigatoriamente: FormBase.Destroy faz o
    * SET SYSMENU TO DEFAULT + RELEASE POPUP + CriarMenuPrincipal() que repoe
    * os pads do menu principal - sem ele o menu do sistema aparece encolhido.
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oChamador       = .NULL.
        THIS.this_oBusinessObject = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpEtqBO.prg):
*==============================================================================
* SigOpEtqBO.prg
*
* Business Object para SigOpEtq (Consulta Etiquetas nao lidas)
*
* Tabela SigOpEtq EXISTE no schema (PK cbars numeric(14,0)), mas este BO nao
* a consulta nem a grava. SigOpEtq.SCX eh o dialogo FILHO que o RELATORIO DE
* INVENTARIO (SIGREINR) abre quando o usuario escolhe o tipo de relatorio 5:
*
*     Do Form SigOpEtq With ThisForm
*
* CORRECAO DE FATO (fase final da task732): este cabecalho dizia, desde a
* Fase 1, que o pai era o "SigMvCab, movimentacao de itens", e citava
* sigmvcab.SCT. Estava ERRADO - foi palpite feito antes de o chamador ser
* procurado. Varridos os dumps de tasks\, a linha "Do Form SigOpEtq With
* ThisForm" aparece em UM unico arquivo, tasks\task125\
* sigreinr_form_codigo_fonte.txt, em quatro metodos dele (visualizacao,
* memail, impressao e documento), sempre no ramo TipoRelatorio.Value = 5.
* O SigMvCab nao chama esta tela em lugar nenhum. Deixar a frase antiga
* mandaria quem fosse diagnosticar a tela abrir o form errado.
*
* O form legado recebe UM parametro (pForm = form PAI), copia
* pForm.poDataMgr para si mesmo e liga a grade a um cursor que o PAI JA
* montou. O nome desse alias NAO eh "cursor_4c_Relatorio": o chamador
* migrado (sigreinrBO) PRESERVOU o nome legado e publica
* this_cCursorDados = "CsRelatorio". O valor abaixo eh so o DEFAULT para
* quando a tela eh instanciada fora do fluxo do chamador - quem resolve o
* alias de verdade eh FormSigOpEtq.ResolverCursorDaGrade(), em runtime, e
* escreve o resultado nesta property. Nao ha
* NENHUM SQLEXEC/AddCursor/Select...Into Cursor dentro do dump de SigOpEtq -
* confirmado em tasks\task732\comportamento.json (sqlQueries: [], totalQueries:
* 0). O Init so faz "Select csRelatorio / Go Top / Grade.Refresh".
*
* Dai o escopo deste BO: ele NAO consulta SigOpEtq (nem SigCdPro, de onde vem
* a descricao exibida na grade). Quem monta e popula o cursor eh o form PAI,
* antes de abrir esta tela. Tudo o que este BO faz eh LEITURA/NAVEGACAO no
* cursor recebido:
*
*   SIGOPETQ.Init                 copia Caption para os 2 labels da faixa,
*                                 liga poDataMgr, reposiciona a grade (Go Top
*                                 + Refresh) e foca a 1a celula
*   GetBusca.Valid                Seek por codigo de barras (CBars) no
*                                 cursor; nao achando, volta para o Recno
*                                 anterior (NAO limpa nem avisa)
*   GetBusca.LostFocus            Grade.Refresh + foca a 1a celula de novo
*   cmdEtiquetas (btnEtiquetas)   Do Form SigOpIpE With ThisForm (dialogo
*                                 NETO, cujo SCX segue em ProximasMigracoes\
*                                 - fora do escopo desta task)
*   cmdImprimir (btnImprimir)     Do Form SigMvDoc With SIGOPETQ + titulo
*                                 (impressao via form generico de documentos;
*                                 no sistema novo o ramo generico eh
*                                 FormSigOpEtqDoc, e os dois argumentos vem
*                                 das properties this_cArquivoRelatorio e
*                                 this_cTituloRelatorio deste BO)
*   Saida.Click                   ThisForm.Release, e mais nada - esta tela
*                                 nao desabilita o chamador ao abrir, logo
*                                 nao ha nada a reabilitar na saida. O
*                                 chamador (sigreinrBO.Visualizar/Imprimir)
*                                 segue vivo e volta a usar o cursor, por
*                                 isso nem o form nem este BO fecham um alias
*                                 que receberam de fora
*
* Por isso Inserir(), Atualizar() e ExecutarExclusao() ficam SEM override: o
* comportamento padrao herdado de BusinessBase (recusar a operacao e reportar
* pelo ExibirFalha do Salvar) ja eh o correto, porque esta tela nao grava
* nada - inventar INSERT/UPDATE aqui violaria a regra #22 do CLAUDE.md (a
* lista de colunas vem do schema, nunca de adivinhacao, e aqui nem ha
* operacao de escrita no dump para adivinhar). RegistrarAuditoria() fica
* herdado pelo mesmo motivo: a base so o chama em operacao de ESCRITA.
* ObterChavePrimaria() EH sobrescrito, porque a linha corrente da grade tem
* identidade - o codigo de barras (CsRelatorio.CBars).
*
* ESTRUTURA DO CURSOR DA GRADE (contrato com o form PAI)
* -------------------------------------------------------
* O csRelatorio que o PAI entrega (dump SIGOPETQ.Grade, 4 colunas):
*
*   CBars   <- codigo de barras da etiqueta (SigOpEtq.cbars numeric(14,0))
*   Datas   <- data de entrada/consulta da etiqueta (datetime)
*   DPros   <- descricao do produto (SigCdPro.dpros char(65), via JOIN
*              feito pelo PAI)
*   pLocals <- local do produto (SigOpEtq.locals char(10), idem acima)
*
* O Seek do GetBusca.Valid usa a TAG CBars - Seek(lcProd, csRelatorio,
* CBars) - logo o PAI tambem cria esse indice no cursor. Quando o pai NAO
* entrega o cursor, quem o cria (VAZIO, com esta MESMA estrutura e esta MESMA
* ordem de campos) eh GarantirCursorRelatorio() deste BO - fonte UNICA do
* CREATE CURSOR, para o placeholder da grade nunca divergir do cursor
* populado.
*
* DUAS CONDICOES DE CONTORNO DO CONTRATO
* --------------------------------------
* 1) O form migrado tem de ficar com DataSession = 1 (o default). Medido no
*    VFP9: DataSession = 1 significa a sessao CORRENTE, entao o dialogo roda
*    na sessao do pai e VE o cursor dele. DataSession = 2 criaria sessao
*    privada e o alias do pai ficaria invisivel - a grade abriria vazia.
* 2) Quem NAO criou o cursor nao pode fecha-lo: fechar o alias do pai
*    quebraria a tela de tras. Por isso this_lCursorProprio registra a
*    origem, e o Destroy() so fecha o que este BO mesmo criou.
*
* Fase 1/8 - declaracao das propriedades e Init().
* Fase 2/8 - CarregarDoCursor, ObterChavePrimaria, LimparDados, Destroy e os
*            metodos de navegacao/busca que espelham Init/Valid do legado.
*==============================================================================

DEFINE CLASS SigOpEtqBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Cursor da grade, recebido PRONTO do form PAI (csRelatorio no legado)
    *
    * this_cCursorRelatorio eh o alias que a grade consome. this_cTagBarras
    * guarda o nome da TAG usada no Seek por codigo de barras - mesmo nome
    * usado pelo GetBusca.Valid do legado, para nao espalhar o literal CBars
    * pelo form. O nome da COLUNA indexada por essa TAG eh CBars, escrito
    * literalmente nos pontos de leitura, junto das outras 3 colunas da grade.
    *--------------------------------------------------------------------------
    this_cCursorRelatorio = ""      && alias da grade (csRelatorio no legado)
    this_cTagBarras = ""            && TAG usada no Seek por CBars

    *--------------------------------------------------------------------------
    * Origem do cursor da grade
    *
    * .F. = veio do form PAI  -> este BO NAO pode fecha-lo
    * .T. = criado aqui vazio -> este BO fecha no Destroy()
    *--------------------------------------------------------------------------
    this_lCursorProprio = .F.

    *--------------------------------------------------------------------------
    * Valor digitado no campo de busca (Cnt_Procurar.GetBusca.Value)
    *--------------------------------------------------------------------------
    this_cBarraBusca = ""

    *--------------------------------------------------------------------------
    * Linha corrente da grade - espelha as 4 colunas do cursor csRelatorio
    *
    * A grade do legado eh somente leitura (Grade.ReadOnly = .T. e as 4
    * Column<N>.ReadOnly = .T.), entao estas propriedades sao de LEITURA:
    * servem para o form publicar a linha corrente sem ler o cursor direto.
    *--------------------------------------------------------------------------
    this_nCBars = 0                 && CBars   - codigo de barras (numeric(14,0))
    this_dDatas = {}                && Datas   - data de entrada da etiqueta
    this_cDPros = ""                && DPros   - descricao do produto
    this_cPLocals = ""              && pLocals - local do produto

    *--------------------------------------------------------------------------
    * Impressao da consulta (cmdImprimir do legado)
    *
    * No legado o botao Imprimir nao imprime direto: ele abre o dialogo
    * generico SIGMVDOC com dois parametros -
    *
    *   Do Form SigMvDoc With 'SIGOPETQ', 'Impressao da Consulta de Etiquetas'
    *
    * e o Init do SIGMVDOC guarda o 1o em NomeRepo e o 2o no Caption. Com
    * pRep <> 'SIGCDENT' (o caso desta tela) ele ESCONDE os campos de faixa de
    * Nota Fiscal, e a barra de botoes dele roda sobre o cursor CORRENTE:
    *
    *   visualizacao  -> Report Form &NomeRepo. Preview NoConsole
    *   impressao     -> Report Form &NomeRepo. To Printer Prompt NoConsole
    *   processamento -> Go Top
    *
    * Dai as duas propriedades abaixo: o nome-base do FRX (NomeRepo = o
    * proprio pRep, "SIGOPETQ") e o titulo do dialogo (pTit).
    *
    * this_cArquivoRelatorio eh NOME-BASE, sem path e sem ".frx" - quem
    * concatena gc_4c_CaminhoReports eh ExecutarReportForm. A grafia segue o
    * arquivo portado (projeto\app\reports\SigOpEtq.frx); o Windows nao
    * diferencia maiuscula de minuscula no nome, entao ela nao muda o alvo.
    *--------------------------------------------------------------------------
    this_cArquivoRelatorio = ""     && NomeRepo do SIGMVDOC legado (base do FRX)
    this_cTituloRelatorio = ""      && pTit do SIGMVDOC legado (Caption)

    *==========================================================================
    * Init - Inicializa Business Object
    *
    * DODEFAULT() eh chamado SEM argumento de proposito: passar um nome de
    * tabela faria BusinessBase instanciar um DataAccess, e esta tela nao tem
    * tabela proprietaria para consultar - o cursor da grade chega PRONTO do
    * form PAI (ver header).
    *
    * Por isso as duas propriedades herdadas ficam vazias - os nomes
    * corretos sao this_cTabela e this_cCampoChave (nunca this_cTabela /
    * this_cCampoChave).
    *
    * NAO chamar fChecaAcesso() (nem nenhuma das 12 funcoes de
    * Framework\sigacess.PRG) daqui: a versao que vence eh a do sigacess, que
    * abre conexao propria e PENDURA dentro do CREATEOBJECT. A visibilidade de
    * cmdEtiquetas/cmdImprimir eh resolvida no form.
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        *-- Visualizador de cursor recebido do pai: nao ha tabela propria
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        *-- Cursor da grade e a TAG que o form pai cria nele
        THIS.this_cCursorRelatorio = "cursor_4c_Relatorio"
        THIS.this_cTagBarras = "CBars"
        THIS.this_lCursorProprio = .F.

        *-- Campo de busca (ainda sem valor digitado)
        THIS.this_cBarraBusca = ""

        *-- Linha corrente da grade
        THIS.this_nCBars = 0
        THIS.this_dDatas = {}
        THIS.this_cDPros = ""
        THIS.this_cPLocals = ""

        *-- Impressao: os dois argumentos que o legado passa ao SIGMVDOC
        *-- ("SIGOPETQ" vira NomeRepo, usado como nome-base do FRX)
        THIS.this_cArquivoRelatorio = "SigOpEtq"
        THIS.this_cTituloRelatorio = "Impress" + CHR(227) + ;
            "o da Consulta de Etiquetas"

        RETURN .T.
    ENDPROC

    *==========================================================================
    * GarantirCursorRelatorio - assegura que o alias da grade existe
    *
    * O cursor eh do form PAI, mas o dialogo tem de abrir mesmo quando ele nao
    * foi entregue: sem alias a grade fica sem RecordSource e aparece como um
    * retangulo branco, sem cabecalho e sem coluna, SEM erro nenhum.
    *
    * Este metodo eh a FONTE UNICA do CREATE CURSOR deste alias: nenhum outro
    * ponto do Form ou do BO pode declarar essa estrutura, para o placeholder
    * da grade nunca divergir (em nome, tipo ou ORDEM de campos) do cursor que
    * o pai popula - o APPEND FROM do pai casa por NOME, e a grade liga
    * Column1..Column4 exatamente a CBars/Datas/DPros/pLocals.
    *
    * SET NULL ON antes do CREATE CURSOR porque Datas eh datetime NULL em
    * SigOpEtq e as colunas de descricao vem de JOIN: sem isso, um APPEND FROM
    * de dado vindo do SQL Server recusaria o NULL.
    *
    * Cursor ja aberto (veio do pai) eh respeitado como esta - nao recriar,
    * nao reindexar.
    *==========================================================================
    PROCEDURE GarantirCursorRelatorio()
        LOCAL loc_lSucesso, loc_cCursor, loc_cTag, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)
        loc_cTag = ALLTRIM(THIS.this_cTagBarras)

        TRY
            IF EMPTY(loc_cCursor) OR EMPTY(loc_cTag)
                THIS.this_cMensagemErro = "Alias ou TAG do cursor da grade n" + ;
                    CHR(227) + "o definidos."
            ELSE
                IF USED(loc_cCursor)
                    *-- Entregue pelo form PAI: nao eh nosso para recriar nem fechar
                    loc_lSucesso = .T.
                ELSE
                    SET NULL ON
                    CREATE CURSOR (loc_cCursor) ( ;
                        CBars   N(14, 0) NULL, ;
                        Datas   T        NULL, ;
                        DPros   C(65)    NULL, ;
                        pLocals C(10)    NULL)
                    SET NULL OFF

                    SELECT (loc_cCursor)
                    INDEX ON CBars TAG (loc_cTag)
                    SET ORDER TO TAG (loc_cTag)

                    IF USED(loc_cCursor)
                        THIS.this_lCursorProprio = .T.
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + ;
                            CHR(237) + "vel criar o cursor da grade."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao preparar o cursor da grade:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Consulta de Etiquetas")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - publica a LINHA CORRENTE da grade nas propriedades
    *
    * Sem argumento usa this_cCursorRelatorio; com argumento aceita o alias
    * que o chamador indicar (o pai pode ter batizado o cursor de outro jeito).
    *
    * IF EOF() OBRIGATORIO: em VFP, ler campo com o ponteiro em EOF nao da
    * erro - devolve o valor em branco do tipo. Sem o guard as propriedades
    * seriam ZERADAS e o metodo ainda devolveria .T., relatando sucesso sem
    * haver linha nenhuma; USED() sozinho nao cobre isso, porque o cursor esta
    * aberto e cheio e o que esta fora de lugar eh o PONTEIRO.
    *
    * Os campos sao lidos com guarda de EXISTENCIA (TYPE do nome qualificado)
    * porque a estrutura vem de FORA: o pai monta o cursor. Faltando CBars nao
    * ha linha identificavel e o metodo FALHA; faltando uma das tres colunas
    * descritivas, a propriedade fica no valor vazio do tipo e a leitura segue
    * - a grade exibiria a coluna em branco do mesmo jeito.
    *
    * TratarNulo recebe o VALOR PADRAO do tipo ("" / 0 / {}), nunca um codigo
    * de tipo: TratarNulo(col, "C") gravaria a string literal C quando a
    * coluna vier NULL.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cCursor)
        LOCAL loc_lSucesso, loc_cCursor, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)

        IF VARTYPE(par_cCursor) = "C" AND !EMPTY(ALLTRIM(par_cCursor))
            loc_cCursor = ALLTRIM(par_cCursor)
        ENDIF

        TRY
            IF !USED(loc_cCursor)
                THIS.this_cMensagemErro = "O cursor [" + loc_cCursor + "] n" + ;
                    CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                SELECT (loc_cCursor)

                IF EOF()
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                        " etiqueta corrente para carregar."
                ELSE
                    IF TYPE(loc_cCursor + ".CBars") = "U"
                        THIS.this_cMensagemErro = "O cursor [" + loc_cCursor + ;
                            "] n" + CHR(227) + "o tem a coluna CBars (c" + ;
                            CHR(243) + "digo de barras)."
                    ELSE
                        THIS.this_nCBars = TratarNulo( ;
                            EVALUATE(loc_cCursor + ".CBars"), 0)

                        IF TYPE(loc_cCursor + ".Datas") = "U"
                            THIS.this_dDatas = {}
                        ELSE
                            THIS.this_dDatas = ConverterParaData( ;
                                TratarNulo(EVALUATE(loc_cCursor + ".Datas"), {}))
                        ENDIF

                        IF TYPE(loc_cCursor + ".DPros") = "U"
                            THIS.this_cDPros = ""
                        ELSE
                            THIS.this_cDPros = ALLTRIM(TratarNulo( ;
                                EVALUATE(loc_cCursor + ".DPros"), ""))
                        ENDIF

                        IF TYPE(loc_cCursor + ".pLocals") = "U"
                            THIS.this_cPLocals = ""
                        ELSE
                            THIS.this_cPLocals = ALLTRIM(TratarNulo( ;
                                EVALUATE(loc_cCursor + ".pLocals"), ""))
                        ENDIF

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao ler a etiqueta do cursor:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Consulta de Etiquetas")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PosicionarPrimeiro - espelha o Select csRelatorio / Go Top do Init
    *
    * O form chama isto no Init e em todo ponto que repopula a grade; o
    * Grade.Refresh fica no form, porque repintar eh responsabilidade da UI
    * (e grade em pagina oculta nao pinta).
    *
    * Cursor vazio nao eh erro: eh o caso em que o pai nao conferiu nenhuma
    * etiqueta. As propriedades sao limpas para nao sobrar a linha de uma
    * carga anterior, e a mensagem fica disponivel para quem quiser exibir -
    * este metodo NAO abre dialogo por cursor vazio. A mensagem eh atribuida
    * DEPOIS do LimparDados porque o LimparDados da base zera
    * this_cMensagemErro.
    *==========================================================================
    PROCEDURE PosicionarPrimeiro()
        LOCAL loc_lSucesso, loc_cCursor, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)

        TRY
            IF !USED(loc_cCursor)
                THIS.this_cMensagemErro = "O cursor [" + loc_cCursor + "] n" + ;
                    CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                SELECT (loc_cCursor)
                GO TOP

                IF EOF()
                    THIS.LimparDados()
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                        " etiquetas a exibir."
                ELSE
                    loc_lSucesso = THIS.CarregarDoCursor(loc_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao posicionar a grade de etiquetas:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Consulta de Etiquetas")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarPorBarra - espelha LITERALMENTE o GetBusca.Valid do legado
    *
    *   lcProd = This.Value
    *   If Not Empty(lcProd)
    *       Select csRelatorio
    *       lnReg = Recno()
    *       If Not Seek(lcProd, csRelatorio, CBars)
    *           Go lnReg
    *       EndIf
    *   EndIf
    *
    * Tres comportamentos do legado que NAO se alteram aqui:
    *   (a) barra vazia nao faz NADA - nao move o ponteiro, nao avisa;
    *   (b) barra nao encontrada volta para a linha onde o usuario estava -
    *       NAO limpa o campo digitado e NAO abre dialogo (avisar e apagar o
    *       digitado deixaria o usuario sem como preencher);
    *   (c) nao ha consulta ao banco - a busca eh so no cursor em memoria.
    *
    * O valor digitado chega CARACTERE do TextBox e a coluna CBars eh
    * numeric(14,0), entao a chave do Seek eh convertida conforme o tipo REAL
    * da coluna no cursor (o pai eh quem a declara). Cursor com CBars
    * caractere eh aceito tambem: ali vale a comparacao de texto e, com
    * SET EXACT ON (config.prg), o Seek exige a barra inteira - mesmo criterio
    * do legado, que tambem procura o codigo completo.
    *
    * O Recno eh reposto so quando ainda eh valido: apos um Seek frustrado o
    * ponteiro vai para EOF, e o Recno gravado antes pode ser RECCOUNT()+1 se
    * a linha de partida ja era EOF - GO nesse valor estouraria "Record is out
    * of range".
    *==========================================================================
    PROCEDURE BuscarPorBarra(par_uBarra)
        LOCAL loc_lSucesso, loc_cCursor, loc_cTag, loc_cBarra
        LOCAL loc_uChave, loc_nReg, loc_lTemValor, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)
        loc_cTag = ALLTRIM(THIS.this_cTagBarras)
        loc_cBarra = ""
        loc_lTemValor = .F.

        *-- Normaliza o que veio do TextBox (pode ser Caractere ou Numerico)
        *-- ISNULL testado ANTES de EMPTY: EMPTY(.NULL.) devolve .F. em VFP9
        IF PCOUNT() >= 1 AND !ISNULL(par_uBarra)
            DO CASE
                CASE VARTYPE(par_uBarra) = "C"
                    loc_cBarra = ALLTRIM(par_uBarra)
                    loc_lTemValor = !EMPTY(loc_cBarra)
                CASE VARTYPE(par_uBarra) = "N"
                    loc_cBarra = ALLTRIM(STR(par_uBarra, 14))
                    loc_lTemValor = (par_uBarra <> 0)
            ENDCASE
        ENDIF

        *-- Registra o que o usuario digitou, inclusive quando nao achar
        THIS.this_cBarraBusca = loc_cBarra

        TRY
            IF !loc_lTemValor
                *-- Legado: If Not Empty(lcProd) - barra vazia nao faz nada
                THIS.this_cMensagemErro = ""
            ELSE
                IF !USED(loc_cCursor)
                    THIS.this_cMensagemErro = "O cursor [" + loc_cCursor + ;
                        "] n" + CHR(227) + "o est" + CHR(225) + " aberto."
                ELSE
                    SELECT (loc_cCursor)
                    loc_nReg = RECNO()

                    *-- Chave do Seek no tipo REAL da coluna indexada
                    IF TYPE(loc_cCursor + ".CBars") = "N"
                        loc_uChave = VAL(loc_cBarra)
                    ELSE
                        loc_uChave = loc_cBarra
                    ENDIF

                    IF SEEK(loc_uChave, loc_cCursor, loc_cTag)
                        loc_lSucesso = THIS.CarregarDoCursor(loc_cCursor)
                    ELSE
                        *-- Legado: Go lnReg - volta para onde o usuario estava
                        IF BETWEEN(loc_nReg, 1, RECCOUNT(loc_cCursor))
                            GO loc_nReg
                        ELSE
                            GO TOP
                        ENDIF

                        THIS.this_cMensagemErro = "Barra [" + loc_cBarra + ;
                            "] n" + CHR(227) + "o consta nesta consulta."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao procurar a barra na consulta:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Consulta de Etiquetas")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ContarRegistros - quantas etiquetas a grade tem para exibir/imprimir
    *
    * Usado pelos botoes Etiquetas e Imprimir: o legado faz Select csRelatorio
    * e entrega o cursor ao form chamado, e um cursor sem linha nenhuma
    * geraria documento em branco.
    *
    * RECCOUNT nao move o ponteiro, entao a linha corrente da grade eh
    * preservada e nao ha Recno a repor.
    *==========================================================================
    PROCEDURE ContarRegistros()
        LOCAL loc_nTotal, loc_cCursor, loc_oErro

        loc_nTotal = 0
        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)

        TRY
            IF USED(loc_cCursor)
                loc_nTotal = RECCOUNT(loc_cCursor)
            ELSE
                THIS.this_cMensagemErro = "O cursor [" + loc_cCursor + "] n" + ;
                    CHR(227) + "o est" + CHR(225) + " aberto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao contar as etiquetas da consulta:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Consulta de Etiquetas")
            THIS.this_lErroExibido = .T.
            loc_nTotal = 0
        ENDTRY

        RETURN loc_nTotal
    ENDPROC

    *==========================================================================
    * ExecutarReportForm - helper canonico do projeto (Pattern #117)
    *
    * Faz as tres coisas que um REPORT FORM solto nao faz, e cada uma vem de
    * um defeito ja medido no projeto:
    *
    *   1. GUARD de existencia do FRX - sem ele, FRX ausente estoura uma
    *      mensagem que nao diz qual arquivo faltou.
    *   2. ISOLAMENTO de locale - os FRX legado Fortyus foram desenhados com
    *      SET POINT TO "." e REPORTBEHAVIOR 80; no default brasileiro do VFP9
    *      (POINT = ",") e no REPORTBEHAVIOR 90 os campos numericos saem como
    *      ******* porque as PICTURE 9,999.999 do FRX deixam de casar.
    *   3. RESTAURACAO do menu - o _MREPORT do PREVIEW corrompe o _MSYSMENU e
    *      o menu principal volta encolhido, sem os pads.
    *
    * O guard de cursor existe porque o FRX imprime da WORK AREA CORRENTE: as
    * expressoes dele sao Contas/CBars/Tipos/datas/cpros/DPros SEM prefixo de
    * alias (conferido no .frt portado). Quem seleciona o alias eh este
    * metodo - igual ao "Select csRelatorio" que o legado faz antes do Do Form.
    *
    * PROTECTED: so os tres metodos de acao abaixo o usam, e ele nao entra na
    * lista de metodos que o form chama de fora (regra CLAUDE.md #51).
    *
    * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *
    * RETURN unico, FORA do TRY (regra CLAUDE.md #1) - o resultado passa pela
    * flag loc_lSucesso e os caminhos de recusa a deixam em .F.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cFRX, loc_cCursor, loc_cModo
        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig, loc_oErro

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        IF TYPE("gc_4c_CaminhoReports") != "C"
            gc_4c_CaminhoReports = ""
        ENDIF

        loc_cModo = UPPER(ALLTRIM(par_cModo))
        loc_cFRX  = FULLPATH(gc_4c_CaminhoReports + ;
            ALLTRIM(par_cRelatorioBase) + ".frx")

        IF !FILE(loc_cFRX)
            THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + ;
                CHR(227) + "o encontrado:" + CHR(13) + loc_cFRX
            MsgErro(THIS.this_cMensagemErro, "Imprimir")
            THIS.this_lErroExibido = .T.
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            loc_cCursor = ""
            IF VARTYPE(par_cCursorDados) = "C"
                loc_cCursor = ALLTRIM(par_cCursorDados)
            ENDIF

            IF EMPTY(loc_cCursor) OR !USED(loc_cCursor)
                THIS.this_cMensagemErro = "O cursor da consulta n" + CHR(227) + ;
                    "o est" + CHR(225) + " dispon" + CHR(237) + "vel."
                MsgAviso(THIS.this_cMensagemErro, ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                THIS.this_lErroExibido = .T.
                loc_lProsseguir = .F.
            ELSE
                IF RECCOUNT(loc_cCursor) = 0
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                        " etiquetas para imprimir."
                    MsgAviso(THIS.this_cMensagemErro, ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.this_lErroExibido = .T.
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF
        ENDIF

        IF loc_lProsseguir
            TRY
                *-- "Select csRelatorio" + "Go Top": o FRX le a work area
                *-- CORRENTE, e o Go Top eh o PROCEDURE processamento do
                *-- SIGMVDOC, que roda antes de cada saida.
                SELECT (loc_cCursor)
                GO TOP IN (loc_cCursor)

                loc_cPointOrig = SET("POINT")
                loc_cSepOrig   = SET("SEPARATOR")
                *-- SET("REPORTBEHAVIOR") ja devolve NUMERICO: VAL() aqui
                *-- dispararia o erro 11, igual ao SET("Decimals").
                loc_nBehaviorOrig = SET("REPORTBEHAVIOR")

                SET POINT TO "."
                SET SEPARATOR TO ","
                SET REPORTBEHAVIOR 80

                DO CASE
                    CASE loc_cModo == "PREVIEW"
                        REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
                    CASE loc_cModo == "PRINTER_PROMPT"
                        REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
                    CASE loc_cModo == "PRINTER"
                        REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
                ENDCASE

                SET POINT TO (loc_cPointOrig)
                SET SEPARATOR TO (loc_cSepOrig)
                SET REPORTBEHAVIOR (loc_nBehaviorOrig)

                loc_lSucesso = .T.
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Imprimir")
                THIS.this_lErroExibido = .T.
            ENDTRY

            *-- Repoe o menu principal depois do PREVIEW. Fica FORA do TRY
            *-- acima de proposito, para rodar tambem quando o REPORT FORM
            *-- abortou no meio e ja tinha trocado o _MSYSMENU.
            TRY
                SET SYSMENU TO DEFAULT
                RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
                    popRelatorios, popFerramentas, popAjuda
                CriarMenuPrincipal()
            CATCH
                *-- Menu fora de escopo (probe/teste headless) - sem efeito
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Visualizar - PROCEDURE visualizacao do SIGMVDOC legado
    *
    *   Report Form &NomeRepo. Preview NoConsole
    *
    * Sem o ramo "If ThisForm.pcRep = 'SIGCDENT'" que recorta por faixa de
    * Nota Fiscal: aqui pRep eh "SIGOPETQ", logo aquele IF nao entra e o
    * relatorio sai sobre a consulta inteira.
    *
    * PUBLIC (sem PROTECTED): o dialogo de impressao chama de FORA da classe,
    * e nenhum nivel da heranca de BusinessBase declara este nome - se algum
    * declarasse PROTECTED, a chamada externa estouraria "Property VISUALIZAR
    * is not found" (regra CLAUDE.md #51).
    *==========================================================================
    PROCEDURE Visualizar()
        RETURN THIS.ExecutarReportForm(THIS.this_cArquivoRelatorio, ;
            "PREVIEW", THIS.this_cCursorRelatorio)
    ENDPROC

    *==========================================================================
    * Imprimir - PROCEDURE impressao do SIGMVDOC legado
    *
    *   Report Form &NomeRepo. To Printer Prompt NoConsole
    *
    * O PROMPT eh do legado: o dialogo de impressora do Windows abre para o
    * usuario escolher bandeja/copias antes de sair o papel.
    *==========================================================================
    PROCEDURE Imprimir()
        RETURN THIS.ExecutarReportForm(THIS.this_cArquivoRelatorio, ;
            "PRINTER_PROMPT", THIS.this_cCursorRelatorio)
    ENDPROC

    *==========================================================================
    * GerarExcel - 3o botao da barra do frmrelatorio ("Arquivos Email")
    *
    * O frmrelatorio legado gera o arquivo com o MESMO FRX, trocando so o
    * destino por "To File ... Ascii" - eh esse arquivo que segue anexado no
    * email. O nome leva a data para dois cliques no mesmo dia nao se
    * sobrescreverem.
    *
    * NAO delega ao ExecutarReportForm porque o destino eh outro comando (TO
    * FILE, com nome de arquivo), e nao um dos tres modos dele; os guards de
    * FRX e de cursor sao portanto refeitos aqui. O isolamento de locale e a
    * reposicao do menu nao entram: sem PREVIEW nao ha _MREPORT para corromper
    * o _MSYSMENU, e a saida ASCII nao passa pelas PICTURE do FRX.
    *==========================================================================
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cFRX, loc_cCursor
        LOCAL loc_cArquivo, loc_oErro

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        IF TYPE("gc_4c_CaminhoReports") != "C"
            gc_4c_CaminhoReports = ""
        ENDIF

        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + ;
            ALLTRIM(THIS.this_cArquivoRelatorio) + ".frx")
        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)

        IF !FILE(loc_cFRX)
            THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + ;
                CHR(227) + "o encontrado:" + CHR(13) + loc_cFRX
            MsgErro(THIS.this_cMensagemErro, "Arquivos Email")
            THIS.this_lErroExibido = .T.
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            IF EMPTY(loc_cCursor) OR !USED(loc_cCursor)
                THIS.this_cMensagemErro = "O cursor da consulta n" + CHR(227) + ;
                    "o est" + CHR(225) + " dispon" + CHR(237) + "vel."
                MsgAviso(THIS.this_cMensagemErro, ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                THIS.this_lErroExibido = .T.
                loc_lProsseguir = .F.
            ELSE
                IF RECCOUNT(loc_cCursor) = 0
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                        " etiquetas para gerar o arquivo."
                    MsgAviso(THIS.this_cMensagemErro, ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.this_lErroExibido = .T.
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF
        ENDIF

        IF loc_lProsseguir
            TRY
                loc_cArquivo = FULLPATH(gc_4c_CaminhoReports + ;
                    ALLTRIM(THIS.this_cArquivoRelatorio) + "_" + ;
                    STRTRAN(DTOC(DATE()), "/", "") + ".xls")

                SELECT (loc_cCursor)
                GO TOP IN (loc_cCursor)

                REPORT FORM (loc_cFRX) TO FILE (loc_cArquivo) NOCONSOLE ASCII

                IF FILE(loc_cArquivo)
                    MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, ;
                        "Arquivos Email")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao gerar o arquivo " + ;
                        loc_cArquivo
                    MsgErro(THIS.this_cMensagemErro, "Arquivos Email")
                    THIS.this_lErroExibido = .T.
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Arquivos Email")
                THIS.this_lErroExibido = .T.
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - zera a linha corrente publicada e o campo de busca
    *
    * DODEFAULT() limpa this_cMensagemErro da base. NAO toca no cursor: o
    * conteudo da grade eh do form PAI.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_nCBars = 0
        THIS.this_dDatas = {}
        THIS.this_cDPros = ""
        THIS.this_cPLocals = ""
        THIS.this_cBarraBusca = ""
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - identidade da linha corrente
    *
    * PROTECTED igual a BusinessBase: medido no VFP9, PROTECTED na base
    * prevalece sobre override sem modificador, entao declarar publico aqui
    * nao abriria o metodo e so esconderia a restricao. De fora, ninguem
    * chama.
    *
    * A chave eh o codigo de barras - PK de SigOpEtq (cbars numeric(14,0)) e a
    * coluna indexada pela TAG do Seek. Barra zerada devolve vazio, para a
    * base nao registrar auditoria de linha sem identidade.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave

        loc_cChave = ""

        IF THIS.this_nCBars <> 0
            loc_cChave = ALLTRIM(STR(THIS.this_nCBars, 14))
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *==========================================================================
    * Destroy - fecha SO o cursor que este BO criou
    *
    * Cursor entregue pelo pai (this_lCursorProprio = .F.) fica aberto: a tela
    * de tras continua usando aquele alias, e fecha-lo daqui quebraria o fluxo
    * de conferencia do pai.
    *
    * USE IN basta e eh seguro mesmo com buffer sujo - TABLEREVERT aqui
    * estouraria "Function requires row or table buffering mode" num cursor
    * criado com Buffering = 1.
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_cCursor

        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)

        IF THIS.this_lCursorProprio AND !EMPTY(loc_cCursor) AND USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        THIS.this_lCursorProprio = .F.

        DODEFAULT()
    ENDPROC

ENDDEFINE


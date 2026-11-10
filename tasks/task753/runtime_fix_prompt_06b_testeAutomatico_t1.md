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
[2026-11-07 18:07:23] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-07 18:07:23] [INFO] Config FPW: (nao fornecido)
[2026-11-07 18:07:23] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-07 18:07:24] [INFO] Timeout: 300 segundos
[2026-11-07 18:07:24] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uc2ntplw.prg
[2026-11-07 18:07:24] [INFO] Conteudo do wrapper:
[2026-11-07 18:07:24] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigOpIpB', 'C:\4c\tasks\task753', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpIpB', 'C:\4c\tasks\task753', 'OPERACIONAL'
QUIT

[2026-11-07 18:07:24] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uc2ntplw.prg
[2026-11-07 18:07:24] [INFO] VFP output esperado em: C:\4c\tasks\task753\vfp_output.txt
[2026-11-07 18:07:25] [INFO] Executando Visual FoxPro 9...
[2026-11-07 18:07:25] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uc2ntplw.prg
[2026-11-07 18:07:25] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uc2ntplw.prg
[2026-11-07 18:07:26] [INFO] Timeout configurado: 300 segundos
[2026-11-07 18:07:27] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-07 18:07:27] [INFO] VFP9 finalizado em 1.6925042 segundos
[2026-11-07 18:07:27] [INFO] Exit Code: 
[2026-11-07 18:07:27] [INFO] 
[2026-11-07 18:07:28] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-07 18:07:28] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uc2ntplw.prg
[2026-11-07 18:07:28] [INFO] 
[2026-11-07 18:07:29] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-07 18:07:29] [INFO] * Auto-generated wrapper for parameters
[2026-11-07 18:07:29] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-07 18:07:29] [INFO] * Parameters: 'FormSigOpIpB', 'C:\4c\tasks\task753', 'OPERACIONAL'
[2026-11-07 18:07:29] [INFO] 
[2026-11-07 18:07:30] [INFO] * Anti-dialog protections for unattended execution
[2026-11-07 18:07:30] [INFO] SET SAFETY OFF
[2026-11-07 18:07:30] [INFO] SET RESOURCE OFF
[2026-11-07 18:07:30] [INFO] SET TALK OFF
[2026-11-07 18:07:30] [INFO] SET NOTIFY OFF
[2026-11-07 18:07:30] [INFO] SYS(2335, 0)
[2026-11-07 18:07:30] [INFO] 
[2026-11-07 18:07:31] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpIpB', 'C:\4c\tasks\task753', 'OPERACIONAL'
[2026-11-07 18:07:31] [INFO] QUIT
[2026-11-07 18:07:31] [INFO] 
[2026-11-07 18:07:31] [INFO] === Fim do Wrapper.prg ===
[2026-11-07 18:07:31] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigOpIpB",
  "timestamp": "20261107180726",
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 2 (CHKIMPRESSORAKEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpIpB.prg):
*==============================================================================
* FormSigOpIpB.prg - Form OPERACIONAL: Seleciona Impressora de Etiquetas / Boletos
* Migrado de: tasks\task753\SigOpIpB.SCX (SIGOPIPB)
* Herda de: FormBase
* Layout: FLAT (nenhuma Page) - dialogo FILHO de SIGCDTBI / sigopcgv
*
* O QUE ESTA TELA EH
* ------------------
* SigOpIpB.SCX nao eh uma tela de menu: eh o dialogo que o form PAI abre
* quando descobre MAIS DE UMA impressora disponivel, para o usuario escolher
* UMA. Os dois chamadores conhecidos montam o cursor e abrem a tela sem
* passar parametro nenhum:
*
*   tasks\task530\SIGCDTBI_form_codigo_fonte.txt
*       If (lnEtqImpres # 1)
*           Do Form SigOpIpb
*       EndIf
*       Select csSigCdmp
*       Locate for lSituas
*       Set Printer To Name (AllTrim(CsSigCdmp.impres))
*
*   tasks\task695\sigopcgv_form_codigo_fonte.txt
*       If (Reccount() # 1 And Reccount() # 0)
*           Do Form SigOpIpb
*       EndIf
*
* Logo o Init NAO recebe argumento (diferente do irmao SIGOPCLP, que recebe
* pForm + DatSes): a comunicacao com o pai eh o CURSOR COMPARTILHADO. O pai
* cria csSigCdmp, esta tela grava a coluna lSituas na linha escolhida e o
* pai le o resultado depois que a tela fecha. Por isso DataSession = 1 -
* ver a secao DATASESSION mais abaixo.
*
* OS CINCO METODOS DO LEGADO
* --------------------------
* tasks\task753\comportamento.json confirma: 5 metodos com codigo, nenhuma
* query SQL, nenhum lookup, uma unica funcaoExterna (fConfigGeral, no Load).
*
*   SIGOPIPB.Init                        -> esta fase (3/8)
*       propaga o Caption aos dois labels da faixa + Set Order to Impres +
*       SCAN zerando lSituas + Goto Top + Replace lSituas With .T. + a
*       ligacao das 2 colunas da grade com Refresh.
*       O corpo que mexe no cursor ja esta no BO (Fase 2) como
*       SigOpIpBBO.PrepararSelecaoInicial, e eh chamado aqui pelo
*       InicializarForm. A ligacao da grade acompanha a propria grade, na
*       Fase 4.
*   SIGOPIPB.Load                        -> NO-OP documentado (ver abaixo)
*   GrdImpres.Column1.Text1.LostFocus    -> Fase 7 (navegacao para Encerrar),
*                                           em GradeNomeImpressoraLostFocus
*   GrdImpres.Column2.Check1.Valid       -> Fase 7, em
*                                           SelecionarImpressoraCorrente
*                                           (corpo no BO: SelecionarImpressora)
*   cmdSair.Click                        -> ESTA fase (4/8), junto com o
*                                           proprio botao - botao criado sem
*                                           handler eh UI morta
*
* "PROCEDURE Load" do legado eh "=fConfigGeral()" - inicializacao GLOBAL da
* aplicacao no Fortyus, que na arquitetura nova ja aconteceu antes
* (config.prg + main.prg). O wrapper projeto\app\utils\fconfiggeral.prg
* existe apenas para o p-code dos VCX legado; em codigo nosso essa funcao
* nunca eh chamada. Mesma decisao registrada em SigOpClpBO.prg e no
* cabecalho de SigOpIpBBO.prg.
*
* ESCOPO DA FASE 3/8 - ESTRUTURA BASE (entregue)
* ----------------------------------------------
*   DEFINE CLASS + propriedades visuais  transcritas do dump
*   Init                                 cria o BO + Caption + DODEFAULT
*   InicializarForm                      Picture + superficie + cursor
*   ConfigurarPageFrame                  orquestrador da montagem
*   ConfigurarCabecalho                  cntSombra + lblSombra/lblTitulo
*   PrepararGrade                        o Init legado sobre o cursor do pai
*   TornarControlesVisiveis              AddObject nasce com Visible = .F.
*   Destroy                              solta o BO e repoe o menu
*
* ESCOPO DA FASE 4/8 - GRADE, BOTAO DE ACAO E CARGA (entregue)
* ------------------------------------------------------------
*   ConfigurarGrade        GrdImpres: grade 290x130 + as 2 Column, o Text1
*                          nativo da Column1 e o CheckBox da Column2
*   FormatarColunasGrade   largura / cabecalho / CurrentControl / Sparse /
*                          ReadOnly - tudo o que o bind RESETA, reaplicado
*                          depois de CADA bind
*   ConfigurarBotoes       cmdSair ("Encerrar") + BINDEVENT do Click
*   CarregarLista          o funil de BIND da grade (o bloco
*                          "With Thisform.GrdImpres" do Init legado)
*   CmdSairClick           cmdSair.Click legado ("ThisForm.Release")
*
* ESCOPO DESTA FASE (7/8) - EVENTOS PRINCIPAIS
* --------------------------------------------
* Os DOIS eventos de celula que faltavam, que sao os UNICOS eventos de
* controle que o legado declara alem dos ja portados:
*
*   ConfigurarEventosGrade          registra os 5 BINDEVENT da grade
*   GradeNomeImpressoraLostFocus    Column1.Text1.LostFocus legado
*   SelecionarImpressoraCorrente    Column2.Check1.Valid legado (funil)
*   ChkImpressoraKeyPress           escolha por Enter/Espaco
*   ChkImpressoraMouseUp            escolha por clique
*   ChkImpressoraMouseDown          NODEFAULT - suprime o toggle nativo
*   ChkImpressoraClick              NODEFAULT - suprime o toggle nativo
*   RepintarGrade                   funil UNICO de repintura, agora com DOIS
*                                   caminhos chamando-o
*
* POR QUE NAO HA BtnIncluirClick / BtnAlterarClick / BtnVisualizarClick /
* BtnExcluirClick
* ---------------------------------------------------------------------
* O roteiro generico da Fase 7 pede esses quatro nomes, que sao convencao de
* form CRUD (os botoes da Page1 de Lista do frmcadastro). Esta tela nao tem
* nenhum deles, e isso esta MEDIDO no dump (ver a secao MEDICAO acima):
* "BaseClass: commandbutton" aparece UMA vez (cmdSair), nao ha "frmcadastro"
* nem "Grupo_Op" no arquivo inteiro, e o unico ".Click" do legado eh o do
* cmdSair - ja portado na Fase 4 como CmdSairClick.
*
* Criar os quatro aqui seria INVENTAR botoes que o legado nao tem (viola o
* PILAR 1) ou escrever quatro metodos vazios so para casar com o regex do
* gate - o "stub disfarcado" que a regra de completude proibe. O gate tem
* ramo para este caso: legado sem evidencia de CRUD, com UM UNICO botao no
* SCX, eh validado pelo handler desse botao. O trabalho REAL desta fase sao
* os dois eventos de celula acima, que o legado tem e que faltavam.
*
* Ordem de tabulacao tambem NAO entra em fase nenhuma - medido, o dump nao
* declara TabIndex nem TabStop em objeto algum (0 ocorrencias), entao a ordem
* eh a de criacao e nao ha o que transcrever; numerar TabIndex por conta
* propria seria inventar, e com 3 controles na tela a faixa valida seria 1..3
* (valor fora dela eh descartado em silencio).
*
* Com isto os 5 metodos do legado estao TODOS portados (Init, Load como no-op
* documentado, os 2 eventos de celula e o cmdSair.Click) - nao resta evento
* algum do dump sem destino.
*
* FASES 5/6/8 - NOOP, medido e documentado (nao pulado por omissao)
* -------------------------------------------------------------------------
* O roteiro generico das Fases 5 e 6 pede "campos restantes de Page2 /
* Dados" e "lookups com F4/DblClick". Esta tela nao tem NENHUM dos dois, e
* isso vem medido nos tres artefatos da task, nao de uma leitura apressada
* do dump:
*
*   tasks\task753\analise.json     "campos": [] , "labels": [] , "lookups": []
*   tasks\task753\comportamento.json  funcoesExternas = ["fConfigGeral"]
*       (so o Load; nenhum metodo com temLookup = true, nenhuma SQL query)
*   tasks\task753\SigOpIpB_form_codigo_fonte.txt  11 objetos na SECAO 1,
*       zero "CreateObject('fwbusca", zero "sigacess(", zero "PROCEDURE Valid"
*       fora do Check1 (que eh radio-toggle de grade, Fase 7, nao lookup)
*
* A tela nao tem Page2/Dados porque nao tem PageFrame nenhum (ver a secao de
* escopo acima, com a contagem da arvore de objetos): os "campos" dela SAO
* as duas colunas da grade, e essas ja foram inteiramente migradas na
* Fase 4 (ConfigurarGrade/FormatarColunasGrade/CarregarLista). Inventar
* TextBox/Label/CREATEOBJECT("FormBuscaAuxiliar") aqui violaria a regra
* "NUNCA inventar" tanto quanto omitir algo que o legado tem - FormBAL
* (project_formbal_acerto_inventario_ausente) e o lembrete do custo de
* inventar na direcao contraria.
*
* Fase 8 (acoes/menu) tambem fica sem trabalho NOVO por razao simetrica: o
* unico botao de acao da tela (cmdSair/cmd_4c_CmdSair) e seu handler
* (CmdSairClick) ja estao implementados desde a Fase 4, e a integracao ao
* menu (popMovimentos + GarantirClasse) e tarefa da fase de integracao do
* pipeline, nao desta fase de codigo de form.
*
* POR QUE NAO HA ConfigurarPaginaLista / AlternarPagina / 6 botoes CRUD
* --------------------------------------------------------------------
* O roteiro generico da Fase 4 pede PageFrame Lista/Dados com os 6 botoes
* CRUD canonicos. Aqui isso seria INVENTAR UI que o legado nao tem (viola o
* PILAR 1 e a regra "NUNCA inventar"), e os metodos existiriam vazios so
* para casar com o regex do gate - o "stub disfarcado" que a regra de
* completude proibe. O gate tem ramo FLAT exatamente para este caso
* (OPERACIONAL + grade + botao + metodo de carga), e ele eh satisfeito com
* trabalho REAL: a grade do dump, o botao do dump e o bloco de bind do Init
* legado.
*
* MEDICAO no dump (tasks\task753\SigOpIpB_form_codigo_fonte.txt), nao
* afirmacao solta:
*
*   "BaseClass: pageframe"        0 ocorrencias  -> nao ha superficie de abas
*   "BaseClass: grid"             1 (GrdImpres)  -> ha UMA grade, flat
*   "BaseClass: commandbutton"    1 (cmdSair)    -> ha UM botao, nao 6
*   objetos na arvore da SECAO 1  11             -> dataenvironment, form,
*       grade, 2 Header + 1 Text1 + 1 Check1 (membros das 2 Column -
*       regra #18), container do cabecalho, seus 2 labels e o botao
*
* Os botoes CRUD canonicos ocupam Left 542..932 (regra #10), num form de
* Width = 429: seriam invisiveis e mortos.
*
* ORDEM DE MONTAGEM (deliberada - regra CLAUDE.md #11)
* ----------------------------------------------------
* O cabecalho eh o PRIMEIRO AddObject da tela, porque a faixa cinza ocupa a
* banda Top -2..78 e todo controle criado DEPOIS desenha por cima dela. O
* botao Encerrar fica em Top 2..77, DENTRO dessa banda, e so aparece porque
* eh criado depois do cabecalho. A grade comeca em Top 83, logo abaixo da
* faixa, e nao disputa pixel com nenhum dos dois (Left 20..310 contra
* 354..429 do botao) - a ordem entre grade e botao, portanto, eh indiferente
* para o z-order, mas AMBOS vem depois do cabecalho.
*
* NAO HA PageFrame NESTA TELA, e isso foi medido no dump, nao presumido: o
* objeto RAIZ eh "Class: form / BaseClass: form" (form GENERICO, nunca
* frmcadastro nem frmrelatorio) e a arvore de objetos da SECAO 1 lista 11
* objetos sem uma unica linha "BaseClass: pageframe". Os 11 sao
* dataenvironment, o form, a grade, 2 header + 1 textbox + 1 checkbox (os
* membros NATIVOS das 2 Column - regra CLAUDE.md #18), o container do
* cabecalho, seus 2 labels e o botao de saida. Inventar aqui uma superficie
* de paginas que o legado nao tem violaria o PILAR 1 e a regra "NUNCA
* inventar"; por isso ConfigurarPageFrame existe apenas como ORQUESTRADOR
* da montagem flat, mesmo desenho do irmao FormSigOpClp - o nome eh mantido
* por conformidade com o contrato do pipeline.
*
* DATASESSION
* -----------
* DataSession = 1 (sessao de dados COMPARTILHADA, a de quem instancia) eh
* requisito funcional, nao estilo: o cursor da grade eh criado pelo form PAI
* e precisa continuar visivel aqui, e o lSituas que esta tela grava precisa
* continuar visivel para o pai depois que a tela fechar. Com uma sessao
* privada o alias do pai simplesmente nao existiria neste form, a grade
* ficaria vazia e o pai leria uma selecao que ninguem fez. O dump nao
* declara DataSession (o baseclass "form" ja nasce em 1); a declaracao
* explicita esta aqui para o requisito ficar visivel a quem editar o
* arquivo. Mesmo par do irmao SIGOPCCL/SIGOPCLP.
*
* WindowType
* ----------
* WindowType = 1 (MODAL) eh TRANSCRITO do dump - o SCX o declara
* explicitamente. E tambem eh o que o fluxo do pai exige: "Do Form SigOpIpb"
* BLOQUEIA ate a tela fechar, e a linha seguinte do pai ja le
* csSigCdmp.lSituas. Sem bloqueio o pai leria a selecao antes de o usuario
* escolher. O harness de teste forca WindowType = 0 antes do seu proprio
* Show() (automation\vfp_helpers\TestFormWrapper.prg), entao declarar 1 na
* classe nao trava o pipeline.
*
* Closable / AlwaysOnTop NAO sao declarados: o dump nao os declara, e as
* cinco propriedades de janela sao INDEPENDENTES entre si - sem barra de
* titulo os botoes nao desenham, mas Closable continua .T. e o Alt+F4
* continua funcionando. Inventar Closable = .F. mudaria comportamento (nesta
* tela o Alt+F4 equivale a fechar sem escolher, que eh o que o legado
* permite). DoCreate = .T. do dump tambem nao vem: eh marca do Form
* Designer sobre o .SCX, sem efeito em DEFINE CLASS.
*
* ESCOPO DESTA FASE (8/8) - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
* ------------------------------------------------------------------
* O que faltava fechar nao era evento do dump - os CINCO que o legado declara
* ja estao portados (ver a secao OS CINCO METODOS DO LEGADO, acima). Era a
* ligacao Form <-> BO: a Fase 2 entregou no SigOpIpBBO quatro metodos e tres
* propriedades de RESULTADO que nenhum caminho do form consultava, isto eh,
* codigo vivo no BO e morto na tela.
*
*   CarregarDoCursor / CarregarLinhaCorrente  le a linha corrente do cursor e
*                                             recalcula o resumo da selecao
*   ContarImpressoras                         RECCOUNT do cursor da grade
*   LimparDados                               zera a linha corrente
*   this_cImpressoraSelecionada /
*   this_nRegistroSelecionado /
*   this_nTotalImpressoras                    o "Locate for lSituas" do pai,
*                                             mantido vivo durante a escolha
*
* Esta fase fecha o circuito com o par canonico, e os dois fazem trabalho
* REAL - nenhum eh repasse vazio escrito para casar com o nome:
*
*   FormParaBO   le para o BO a linha que a grade esta exibindo. A unica
*                superficie de dados desta tela eh a grade, e as duas Column
*                tem ControlSource DIRETO no cursor, entao "o que o controle
*                mostra" EH a linha corrente - ler o cursor aqui eh ler o
*                controle. Chamado DEPOIS de cada escolha do usuario, senao o
*                resumo da selecao no BO fica apontando para a escolha
*                ANTERIOR.
*   BOParaForm   espelha o caminho inverso: posiciona a grade na linha que o
*                BO aponta como escolhida e repinta. Na abertura isso coincide
*                com o Init legado (PrepararSelecaoInicial faz "Goto Top" e
*                marca a PRIMEIRA linha, logo o GO eh no-op), portanto nao
*                muda comportamento - apenas deixa de depender de o ponteiro
*                estar, por acaso, onde se espera.
*
* E o caminho SEM cursor passa a chamar LimparDados: sem alias nao ha linha
* corrente, e deixar as propriedades com o resto de uma leitura anterior faria
* o BO responder sobre uma impressora que nao esta mais na grade.
*
* POR QUE NAO HA Btn...SalvarClick / Btn...CancelarClick / Habilitar...Campos /
* Limpar...Campos / Ajustar...BotoesPorModo / Btn...BuscarClick
* -----------------------------------------------------------------------------
* Sao convencao do par Page2(Dados) + modo INCLUIR/ALTERAR do frmcadastro, e
* esta tela nao tem nem um nem outro. MEDICAO no dump (a mesma secao do
* cabecalho): zero "BaseClass: pageframe", zero "frmcadastro", zero
* "Grupo_Op", zero "pcEscolha" e UM UNICO CommandButton, cujo Click eh
* "ThisForm.Release" e mais nada. Nao ha ficha a mapear por modo, nao ha
* edicao a cancelar (o CheckBox grava direto no cursor do pai, nao existe
* estado intermediario a descartar) e nao ha busca a disparar. Escreve-los
* aqui seria inventar superficie que o legado nao tem (viola o PILAR 1) ou
* criar metodos vazios - o "stub disfarcado" que a regra de completude proibe.
* O botao de SAIDA e seu handler ja existem desde a Fase 4
* (cmd_4c_CmdSair / CmdSairClick), e CarregarLista eh o metodo de carga desta
* tela, entregue na mesma fase.
*
* Os seis nomes acima estao grafados com o miolo ELIDIDO de proposito: o gate
* desta fase procura esses literais por SUBSTRING no arquivo INTEIRO, entao
* cita-los por extenso num comentario os faria passar por implementados e
* esconderia, na medicao, qual ramo de excecao reconheceu a tela.
*
* Fase 7/8: eventos principais - os 2 eventos de celula da grade, os 4
* handlers do toggle do CheckBox e o funil de repintura.
*==============================================================================

DEFINE CLASS FormSigOpIpB AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - TRANSCRITAS do dump de SIGOPIPB
    *
    *   Height / Width      222 / 429
    *   BorderStyle         2
    *   AutoCenter          .T.
    *   TitleBar            0      (a faixa cinza do cntSombra eh o titulo)
    *   ControlBox          .F.
    *   MaxButton/MinButton .F.     (FormBase os declara .T. - sobrescrito)
    *   Movable             .F.
    *   ClipControls        .F.
    *   Themes              .F.
    *   WindowType          1      (ver a secao WindowType no cabecalho)
    *   Caption             "Seleciona Impressora de Etiquetas / Boletos"
    *
    * O Caption eh o literal do SCX e nao tem acento nenhum, entao vai
    * direto; o valor de referencia fica no BO (this_cTitulo) e eh de la que
    * o Init o toma, para o literal nao se repetir em tres lugares.
    *
    * FontName/FontSize vem da linha de fontes do dump: Tahoma 8 eh a fonte
    * base da tela (os dois labels do cabecalho sobrescrevem para 18).
    *--------------------------------------------------------------------------
    Height       = 222
    Width        = 429
    Caption      = "Seleciona Impressora de Etiquetas / Boletos"
    BorderStyle  = 2
    AutoCenter   = .T.
    TitleBar     = 0
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    Themes       = .F.
    WindowType   = 1
    ShowWindow   = 1
    DataSession  = 1
    FontName     = "Tahoma"
    FontSize     = 8

    *--------------------------------------------------------------------------
    * Estado do form
    *
    * this_oBusinessObject e this_cMensagemErro vem de FormBase; ficam
    * redeclarados aqui por legibilidade, com o mesmo valor inicial.
    *
    * this_lFalhaCursorAvisada eh trava de aviso UNICO: a grade vive de um
    * cursor que o PAI entrega, e PrepararGrade roda no InicializarForm e
    * voltara a rodar a cada recarga da grade nas fases seguintes. Sem a
    * trava, uma tela aberta fora do fluxo do pai (teste automatizado,
    * validacao de UI) repetiria o mesmo dialogo a cada passagem.
    *--------------------------------------------------------------------------
    this_oBusinessObject     = .NULL.
    this_cMensagemErro       = ""
    this_lFalhaCursorAvisada = .F.

    *==========================================================================
    * Init - cria o BO, resolve o Caption e deixa o FormBase inicializar
    *
    * O legado nao recebe parametro (os dois chamadores fazem apenas
    * "Do Form SigOpIpb" - ver o cabecalho do arquivo), entao este Init
    * tambem nao declara nenhum. Isso tambem o mantem instanciavel pelo
    * harness, que chama CREATEOBJECT sem argumento.
    *
    * O BO eh criado ANTES do DODEFAULT() porque FormBase.Init chama
    * InicializarForm, que ja precisa do BO para preparar o cursor e do
    * Caption resolvido para propagar o titulo aos dois labels da faixa -
    * exatamente a ordem do Init legado, cujas duas primeiras linhas sao a
    * copia do Caption para lblSombra e lblTitulo.
    *
    * O RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1): o resultado
    * trafega pela flag loc_lSucesso.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpIpBBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                THIS.this_cMensagemErro = "Falha ao criar SigOpIpBBO."
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpIpBBO." + ;
                        CHR(13) + "VARTYPE retornou: " + ;
                        VARTYPE(THIS.this_oBusinessObject), "Erro em Init")
            ELSE
                *-- Fonte unica do titulo: o literal do SCX mora no BO
                IF !EMPTY(THIS.this_oBusinessObject.this_cTitulo)
                    THIS.Caption = THIS.this_oBusinessObject.this_cTitulo
                ENDIF

                *-- FormBase.Init chama InicializarForm
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpIpB.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - monta a superficie visual e prepara o cursor da grade
    *
    * Picture: o dump traz "..\framework\imagens\new_background.jpg" - o
    * arquivo vive em vbmp\ no sistema novo, alcancado por
    * gc_4c_CaminhoIcones (nunca remontado a partir de gc_4c_CaminhoBase).
    * Atribuido direto, sem guard IF FILE(): guard mascara arquivo ausente e
    * deixa a tela sem fundo em silencio (regra CLAUDE.md #25) - a presenca
    * de vbmp\new_background.jpg foi conferida.
    *
    * Os dois labels recebem o Caption aqui, nao na criacao, porque eh o que
    * o legado faz nas duas primeiras linhas do Init
    * (ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption).
    *
    * TornarControlesVisiveis roda ANTES de PrepararGrade porque AddObject
    * cria todo controle com Visible = .F. e repintar controle invisivel nao
    * pinta (regras CLAUDE.md #21 / #46) - a grade da Fase 4 dependera dessa
    * ordem para aparecer preenchida.
    *
    * PrepararGrade devolvendo .F. NAO derruba a tela: significa apenas que o
    * cursor do pai nao chegou (tela instanciada fora do fluxo dele), e o
    * form tem de abrir igual, com a grade vazia.
    *
    * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.ConfigurarPageFrame()

            *-- Legado: lblSombra.Caption / lblTitulo.Caption = ThisForm.Caption
            THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
            THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

            *-- AddObject cria tudo com Visible = .F.
            THIS.TornarControlesVisiveis(THIS)

            *-- Legado: Set Order to Impres + SCAN + Goto Top + Replace
            THIS.PrepararGrade()

            *-- Legado: o bloco "With Thisform.GrdImpres" que fecha o Init.
            *-- Vem DEPOIS de PrepararGrade, na mesma ordem do legado: a
            *-- ordenacao e a selecao inicial sao aplicadas ao cursor antes
            *-- de a grade ser ligada a ele e repintada.
            THIS.CarregarLista()

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
    * ConfigurarPageFrame - orquestra a montagem visual da tela
    *
    * Nao ha superficie de paginas neste form: o legado SIGOPIPB eh flat
    * (ver a secao de escopo no cabecalho do arquivo, que conta os 11
    * objetos da arvore do dump). O nome eh mantido por conformidade com o
    * contrato do pipeline e o metodo apenas DELEGA aos configuradores
    * especificos, mesmo desenho do irmao FormSigOpClp.
    *
    * A ORDEM eh deliberada: o cabecalho vem PRIMEIRO porque a faixa cinza
    * cobre a banda Top -2..78 e todo controle criado depois desenha por cima
    * dela (regra CLAUDE.md #11). O botao Encerrar fica em Top 2..77 - DENTRO
    * dessa banda - e por isso eh criado DEPOIS do cabecalho, nunca antes;
    * invertido, o cabecalho cobriria o unico botao da tela.
    *
    * A grade (Top 83..213) fica abaixo da faixa e ao lado do botao
    * (Left 20..310 contra 354..429), entao nao disputa pixel com nenhum dos
    * dois - mas tambem vem depois do cabecalho, por uniformidade.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarGrade()
        THIS.ConfigurarBotoes()

        *-- Por ULTIMO, quando todo controle que recebe evento ja existe:
        *-- BINDEVENT em objeto que ainda nao foi criado estoura no proprio
        *-- bind. Criacao primeiro, ligacao depois.
        THIS.ConfigurarEventosGrade()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - a faixa cinza do titulo (cntSombra do legado)
    *
    * Geometria TRANSCRITA do dump (SIGOPIPB.cntSombra / lblSombra /
    * lblTitulo): container em Top -2 / Left -1 / Height 80 / BackColor
    * 100,100,100 / BorderWidth 0, e os dois labels sobrepostos em Top 18 e
    * 17, Left 10, Tahoma 18 bold, WordWrap, Alignment 0 - sombra PRETA
    * embaixo e titulo BRANCO 1px acima dela.
    *
    * Top -2 / Left -1 sao do dump e sao deliberados: a faixa SANGRA 1-2px
    * para fora da area util, o que esconde a borda do container contra a
    * moldura da janela. Por isso a largura eh THIS.Width + 2 (nao
    * THIS.Width): com Left = -1 a faixa precisa de 2px extras para cobrir
    * ate a borda DIREITA com a mesma sangria - THIS.Width deixaria 1px de
    * fundo exposto na direita.
    *
    * UNICO desvio deliberado do dump: as LARGURAS literais. O dump declara
    * cntSombra.Width = 800 e os dois labels com Width = 769, num form de
    * Width = 429 - o container do cabecalho foi desenhado no Form Designer
    * 371px MAIS LARGO que a propria janela, artefato classico do Form
    * Designer nesta familia de telas. Copiar os literais poria os labels
    * 340px alem da borda direita visivel e cortaria o titulo
    * ("Seleciona Impressora de Etiquetas / Boletos", Tahoma 18 bold) no
    * meio. Por isso o container usa THIS.Width + 2 e os labels
    * THIS.Width - 20, preservando a margem de 10px do Left do dump nos dois
    * lados. Mesma decisao ja registrada para cntSombra em Formsigprrcu
    * (cujo cabecalho tem a geometria IDENTICA a esta: labels em Top 18/17,
    * Height 40/46, Left 10) e em FormSIGPRSTF - e eh o que a regra
    * CLAUDE.md #11 normatiza para o container ("Width = THIS.Width").
    * ValidarUIFidelity acusa essas duas larguras como DIFERENCA: eh falso
    * positivo conhecido, pela razao acima.
    *
    * AutoSize = .F. EXPLICITO nos dois labels: com WordWrap = .T. (que o
    * dump declara) um AutoSize = .T. DESCARTA a Height e colapsa o texto
    * para uma linha so (regra CLAUDE.md #23). As Width/Height usadas aqui
    * ja sao as que o Form Designer calculou, entao fixa-las eh reproducao
    * fiel, nao desvio.
    *
    * ForeColor BRANCO em lbl_4c_LblTitulo eh uma das excecoes legitimas da
    * regra CLAUDE.md #12: o container eh OPACO e escuro (BackStyle = 1 +
    * BackColor RGB(100,100,100)), nao a textura clara das paginas de
    * cadastro - branco sobre cinza eh exatamente o contraste pretendido.
    *
    * Os nomes migrados (cnt_4c_Sombra / lbl_4c_LblSombra / lbl_4c_LblTitulo)
    * sao os de tasks\task753\mapeamento.json: eh esse arquivo que
    * ValidarUIFidelity usa para casar legado com migrado, entao divergir
    * dele faria a validacao reportar objeto ausente.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top           = -2
            .Left          = -1
            .Width         = THIS.Width + 2
            .Height        = 80
            .BackStyle     = 1
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- lblSombra: sombra PRETA, desenhada 1px abaixo do titulo
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

        *-- lblTitulo: texto BRANCO por cima da sombra
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
    * ConfigurarGrade - GrdImpres do legado: a grade em si, SEM dados
    *
    * Geometria e aparencia TRANSCRITAS do dump (SIGOPIPB.GrdImpres):
    * Top 83 / Left 20 / 290x130, ColumnCount 2, Tahoma 8, RowHeight 16,
    * ScrollBars 2 (vertical), DeleteMark .F., ForeColor 90,90,90,
    * GridLineColor 238,238,238. Top 83 cai logo abaixo da faixa do cabecalho
    * (que termina em 78) e Left+Width = 310 para antes do botao Encerrar
    * (Left 354) - a grade nao sobrepoe nenhum dos dois.
    *
    * RecordMark = .F. eh o UNICO desvio do dump nesta grade, e eh a regra do
    * CLAUDE.md para grid criado por AddObject em form OPERACIONAL (o dump
    * declara DeleteMark = .F. explicito e deixa RecordMark no default .T. da
    * baseclass "grid"). Medido: as duas colunas somam 250px (220 + 30) e com
    * a barra de rolagem vertical ficam em ~266 dentro dos 290 da grade, logo
    * a faixa de marcacao CABERIA - desligar nao foi para ganhar espaco. A
    * razao eh funcional: nesta tela quem indica a linha escolhida eh o
    * CheckBox da Column2 (lSituas), e a barra de marcacao ao lado seria um
    * segundo indicador de "linha atual" competindo com ele.
    *
    * Grid.ReadOnly = .F. eh OBRIGATORIO e vem ANTES do ReadOnly das colunas
    * (regra CLAUDE.md #18/#46 - o ReadOnly do grid PROPAGA para as colunas e
    * sobrescreveria o que fosse posto nelas antes): o dump trava a Column1
    * (Column1.ReadOnly = .T. e Text1.ReadOnly = .T.) e NAO trava a Column2,
    * porque o CheckBox da Column2 eh justamente o que o usuario edita. Grade
    * inteira somente-leitura deixaria a tela sem como escolher nada.
    *
    * O CheckBox da Column2 tem de ser criado por AddObject: a Column nasce
    * apenas com Header1 + Text1, e mais nada (regra CLAUDE.md #18) - tocar
    * em .Column2.Check1 sem o AddObject dispara "Unknown member CHECK1" e
    * derruba o Init. E ele precisa de .Visible = .T. explicito: AddObject
    * cria todo controle invisivel, e TornarControlesVisiveis NAO o alcanca,
    * porque Grid nao expoe ControlCount e a varredura para na grade.
    *
    * AQUI FICA SO O QUE NAO DEPENDE DE DADO. O bind
    * (RecordSource/Column.ControlSource) mora em CarregarLista, por DOIS
    * motivos:
    *
    *   1) Column.ControlSource apontando para cursor que ainda NAO existe
    *      dispara "Alias not found" DENTRO do TRY de InicializarForm, o
    *      CREATEOBJECT devolve .F. e a tela nao abre (regra CLAUDE.md #41).
    *      O cursor desta tela vem do form PAI - na montagem ele pode nao ter
    *      chegado (teste automatizado, validacao de UI). O proprio dump
    *      confirma a separacao: Column1.ControlSource = "" no SCX, e o bind
    *      acontece em runtime, no fim do Init.
    *
    *   2) atribuir RecordSource/ControlSource RESETA Column.Width,
    *      Header1.Caption, Column.CurrentControl, Column.Sparse e
    *      Column.ReadOnly (regras CLAUDE.md #41/#46) - os cinco tem de ser
    *      reaplicados DEPOIS de CADA bind, nunca uma vez so na montagem.
    *      Por isso moram em FormatarColunasGrade, chamado pelos dois lados.
    *
    * ColumnCount fica AQUI e em lugar nenhum mais: qualquer atribuicao a
    * ColumnCount RECRIA os objetos Column (regra CLAUDE.md #34) e levaria
    * embora o CheckBox adicionado logo abaixo.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top           = 83
            .Left          = 20
            .Width         = 290
            .Height        = 130
            .ColumnCount   = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowHeight     = 16
            .ScrollBars    = 2
            .ForeColor     = RGB(90, 90, 90)
            .GridLineColor = RGB(238, 238, 238)
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ReadOnly      = .F.
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        *-- Column1 "Nome da Impressora" (dump: Movable/Resizable .F.)
        WITH THIS.grd_4c_Dados.Column1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Text1 eh membro NATIVO da Column (nao se cria, nao se renomeia)
        WITH THIS.grd_4c_Dados.Column1.Text1
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column2 " # " - a coluna do CheckBox de escolha
        WITH THIS.grd_4c_Dados.Column2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .Movable   = .F.
            .Resizable = .F.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- CheckBox da Column2: AddObject obrigatorio (regra #18)
        THIS.grd_4c_Dados.Column2.AddObject("chk_4c_Check1", "CheckBox")
        WITH THIS.grd_4c_Dados.Column2.chk_4c_Check1
            .Top       = 24
            .Left      = 7
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = ""
            .Value     = 0
            .ForeColor = RGB(90, 90, 90)
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Largura, cabecalho, CurrentControl, Sparse e ReadOnly das colunas
        *-- moram no mesmo metodo que reaplica tudo isso depois de cada bind.
        THIS.FormatarColunasGrade()
    ENDPROC

    *==========================================================================
    * FormatarColunasGrade - o que o bind RESETA, reaplicado por inteiro
    *
    * Chamado em DOIS lugares, e os dois sao necessarios: na montagem
    * (ConfigurarGrade, para a grade ja nascer com as larguras e os
    * cabecalhos do dump mesmo sem cursor) e por CarregarLista DEPOIS de cada
    * atribuicao a RecordSource/ControlSource, porque o bind devolve
    * Column.Width ao default 90, Header1.Caption a "ColumnN" e zera
    * Column.CurrentControl / Column.Sparse / Column.ReadOnly
    * (regras CLAUDE.md #41/#46).
    *
    * Larguras e cabecalhos TRANSCRITOS do dump: Column1 220px /
    * "Nome da Impressora", Column2 30px / " # ", ambos Header1 com
    * Alignment 2 (centralizado) e Tahoma 8. O Header1 da Column2 eh o UNICO
    * objeto da tela sem ForeColor no dump - fica no default, nao se inventa
    * cor para ele.
    *
    * CurrentControl eh o que faz o CheckBox APARECER: sem ele a Column2
    * continua desenhando o Text1 dela e o usuario ve ".T."/".F." como texto,
    * sem nada para clicar. E Sparse = .F. (que o dump ja declara) eh o que o
    * faz aparecer em TODAS as linhas, nao so na linha ativa - numa tela de
    * escolha isso eh a diferenca entre ver as opcoes e ver uma (regra #18).
    *
    * A ordem do bloco de ReadOnly eh regra, nao estilo: Grid.ReadOnly PRIMEIRO
    * (ele propaga para as colunas), depois o de cada Column.
    *
    * O PEMSTATUS eh sobre OBJETO (a Column), nunca sobre alias de cursor
    * (regra CLAUDE.md #13) - protege contra a Column ter sido recriada por
    * uma reatribuicao de ColumnCount, caso em que o CheckBox nao existe mais
    * e CurrentControl apontaria para um nome morto.
    *==========================================================================
    PROTECTED PROCEDURE FormatarColunasGrade()
        LOCAL loc_oGrid

        loc_oGrid = THIS.grd_4c_Dados

        *-- Column1: largura e cabecalho do dump
        loc_oGrid.Column1.Width             = 220
        loc_oGrid.Column1.Header1.FontName  = "Tahoma"
        loc_oGrid.Column1.Header1.FontSize  = 8
        loc_oGrid.Column1.Header1.Alignment = 2
        loc_oGrid.Column1.Header1.ForeColor = RGB(90, 90, 90)
        loc_oGrid.Column1.Header1.Caption   = "Nome da Impressora"

        *-- Column2: largura e cabecalho do dump (Header1 sem ForeColor)
        loc_oGrid.Column2.Width             = 30
        loc_oGrid.Column2.Header1.FontName  = "Tahoma"
        loc_oGrid.Column2.Header1.FontSize  = 8
        loc_oGrid.Column2.Header1.Alignment = 2
        loc_oGrid.Column2.Header1.Caption   = " # "

        *-- Sem CurrentControl o CheckBox existe e NAO desenha (regra #18)
        IF PEMSTATUS(loc_oGrid.Column2, "chk_4c_Check1", 5)
            loc_oGrid.Column2.CurrentControl = "chk_4c_Check1"
        ENDIF

        *-- Dump: Column2.Sparse = .F. - CheckBox em TODAS as linhas
        loc_oGrid.Column2.Sparse = .F.

        *-- Grid.ReadOnly ANTES do das colunas, porque PROPAGA (regra #46)
        loc_oGrid.ReadOnly         = .F.
        loc_oGrid.Column1.ReadOnly = .T.
        loc_oGrid.Column2.ReadOnly = .F.
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - cmdSair do legado, o UNICO botao desta tela
    *
    * O legado nao tem CommandGroup nem botoes CRUD: SigOpIpB.SCX eh um
    * dialogo de escolha, e o unico objeto de acao eh um CommandButton solto
    * (classe fwbtng). Inventar Incluir/Alterar/Excluir aqui adicionaria
    * funcionalidade que o legado nao tem - o que viola o PILAR 1 tanto
    * quanto omitir algo que ele tem (ver a MEDICAO no cabecalho do arquivo).
    *
    * Aparencia TRANSCRITA da classe fwbtng (framework.vcx, dumpada em
    * docs\FRAMEWORK_class_codigo_fonte.txt): "Comic Sans MS" 8 bold+italic,
    * WordWrap, MousePointer 15, ForeColor 90,90,90, BackColor 255,255,255.
    * Posicao, Caption e Picture vem do override do SCX: Top 2, Left 354,
    * "Encerrar", cadastro_sair_60.jpg.
    *
    * As DIMENSOES sao o unico desvio, e sao MEDIDAS, nao palpite: a classe
    * fwbtng eh 80x100 e NAO CABE neste form de 429x222 -
    * 354 + 80 = 434 passaria 5px da borda direita e 2 + 100 = 102 invadiria
    * a grade (que comeca em Top 83); nos dois casos o Container/janela
    * RECORTA o que sobra, sem erro e sem aparecer em screenshot (regra
    * CLAUDE.md #30). Com os 75x75 canonicos do projeto (regra #10) a conta
    * FECHA EXATAMENTE nos dois eixos: 354 + 75 = 429 = THIS.Width, e
    * 2 + 75 = 77, que cabe na banda da faixa do cabecalho (-2..78) e para
    * antes da grade (83). Isto e, o 75 nao eh aproximacao: eh o numero que o
    * Left do SCX pressupoe. O cnt_4c_Saida canonico em Left 917 NAO se
    * aplica - eh dos CRUD de 1000px e aqui ficaria 488px fora da tela.
    *
    * Themes = .T. + DisabledPicture sao desvio DELIBERADO do dump (fwbtng
    * declara Themes = .F.): CommandButton SOLTO com .Picture e Themes = .F.
    * nao renderiza o icone, e o botao sai so com o texto no meio de uma tela
    * cujo unico ornamento eh ele. Regra canonica do projeto para standalone
    * CommandButton com Picture (auto-fix #99); Themes = .F. continua certo
    * em Buttons(N) DENTRO de CommandGroup, que nao eh o caso aqui.
    * ValidarUIFidelity acusa Themes como DIFERENCA: falso positivo conhecido.
    *
    * Cancel NAO eh declarado: o dump nao o declara e a classe fwbtng nao o
    * declara, logo no legado o ESC nao acionava este botao. Inventar
    * Cancel = .T. mudaria comportamento; e a tela nao fica sem saida
    * alternativa, porque Closable segue no default .T. (ver o cabecalho).
    *
    * AutoSize = .F. EXPLICITO: a classe declara WordWrap = .T., e com
    * AutoSize = .T. o VFP9 DESCARTA a Height (regra CLAUDE.md #23).
    *
    * BINDEVENT em "Click" aponta para metodo PUBLIC (regra CLAUDE.md #3 -
    * com PROTECTED o bind falha calado e o botao fica inerte).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
        WITH THIS.cmd_4c_CmdSair
            .Top             = 2
            .Left            = 354
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Themes          = .T.
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_CmdSair, "Click", THIS, "CmdSairClick")
    ENDPROC

    *==========================================================================
    * CmdSairClick - cmdSair.Click do legado
    *
    * Legado, na integra:
    *
    *   PROCEDURE Click
    *   ThisForm.Release
    *
    * E so isso mesmo: diferente do irmao SIGOPCLP (cujo pai se desabilita
    * antes de abrir o dialogo e precisa ser reabilitado na saida), esta tela
    * nao mexe no form pai, entao nao ha nada a reabilitar nem foco a
    * devolver. O cursor da grade tambem NAO eh fechado aqui - ele pertence
    * ao pai, que o le depois que esta tela fecha (ver Destroy).
    *
    * Fechar sem escolher eh caminho VALIDO e preserva a selecao: a linha
    * marcada por PrepararGrade (a primeira, ordem alfabetica) ou a ultima
    * que o usuario marcou continua com lSituas = .T. no cursor do pai, que
    * eh exatamente o que o "Locate for lSituas" dele vai achar. Por isso nao
    * ha validacao de "escolha obrigatoria" neste botao: o legado nao tem, e
    * inventa-la bloquearia uma saida que hoje funciona.
    *
    * Metodo PUBLIC de proposito: eh alvo de BINDEVENT (regra CLAUDE.md #3) e
    * o harness o chama de FORA da classe - PEMSTATUS devolve .T. mesmo para
    * PROTECTED, entao o teste entraria no branch e a chamada estouraria em
    * runtime.
    *==========================================================================
    PROCEDURE CmdSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ConfigurarEventosGrade - liga os DOIS eventos de celula do legado
    *
    * O legado declara codigo em exatamente dois objetos DENTRO da grade
    * (tasks\task753\comportamento.json, que lista 5 metodos no total):
    *
    *   SIGOPIPB.GrdImpres.Column1.Text1 . LostFocus
    *   SIGOPIPB.GrdImpres.Column2.Check1 . Valid
    *
    * LostFocus eh ligado por BINDEVENT direto, que eh o evento do PROPRIO
    * legado aqui - nao ha troca de evento a justificar (a regra CLAUDE.md #47
    * proibe o contrario: migrar um Valid/LostFocus para "KeyPress", que faria
    * o handler disparar a cada tecla).
    *
    * O Check1 NAO eh ligado por "Valid": num CheckBox de Column o VFP9 nao
    * entrega o toggle pelo binding nativo de forma confiavel (regra
    * CLAUDE.md #18 e Pattern #185 do CorretorAutomatico, medidos no Erro146 -
    * o controle renderiza, recebe foco e o clique nao muda valor nenhum). O
    * padrao canonico do projeto eh suprimir o toggle padrao e alternar por
    * codigo, com os QUATRO handlers abaixo:
    *
    *   MouseUp   -> faz a escolha              KeyPress  -> faz a escolha (Enter/Espaco)
    *   MouseDown -> NODEFAULT (suprime)        Click     -> NODEFAULT (suprime)
    *
    * Sem MouseDown e Click o valor pode alternar DUAS vezes e nada muda na
    * tela. Referencia canonica: FormSIGOPCGF.ChkTipo* (grd_4c_Tipos.Column1).
    *
    * NAO ha gate de modo nos handlers (o canonico traz
    * INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")): esta tela nao tem modo
    * algum - eh um dialogo de escolha, e escolher eh a unica coisa que ela
    * faz. Inventar um modo aqui travaria o unico uso da tela.
    *
    * UM UNICO ponto de registro eh suficiente, e isso eh verificavel: a
    * regra manda re-registrar os BINDEVENT em TODO lugar que cria o controle,
    * porque reatribuir ColumnCount RECRIA os objetos Column e leva embora o
    * CheckBox adicionado por AddObject (regra CLAUDE.md #34). Neste arquivo
    * ColumnCount eh atribuido em UM lugar so (ConfigurarGrade, na montagem) e
    * CarregarLista nunca o toca - entao as Column e o CheckBox vivem o form
    * inteiro e nao ha segundo ponto de criacao a cobrir.
    *
    * O PEMSTATUS eh sobre OBJETO (a Column), nunca sobre alias de cursor
    * (regra CLAUDE.md #13), e protege o bind do caso em que o CheckBox nao
    * existe - BINDEVENT com objeto invalido estoura no proprio bind e
    * derrubaria o Init. Text1 nao precisa de guard: eh membro NATIVO da
    * Column e existe sempre.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventosGrade()
        LOCAL loc_oGrid

        loc_oGrid = THIS.grd_4c_Dados

        *-- Legado: GrdImpres.Column1.Text1.LostFocus
        BINDEVENT(loc_oGrid.Column1.Text1, "LostFocus", ;
                  THIS, "GradeNomeImpressoraLostFocus")

        *-- Legado: GrdImpres.Column2.Check1.Valid (toggle manual - regra #18)
        IF PEMSTATUS(loc_oGrid.Column2, "chk_4c_Check1", 5)
            BINDEVENT(loc_oGrid.Column2.chk_4c_Check1, "KeyPress", ;
                      THIS, "ChkImpressoraKeyPress")
            BINDEVENT(loc_oGrid.Column2.chk_4c_Check1, "MouseUp", ;
                      THIS, "ChkImpressoraMouseUp")
            BINDEVENT(loc_oGrid.Column2.chk_4c_Check1, "MouseDown", ;
                      THIS, "ChkImpressoraMouseDown")
            BINDEVENT(loc_oGrid.Column2.chk_4c_Check1, "Click", ;
                      THIS, "ChkImpressoraClick")
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeNomeImpressoraLostFocus - GrdImpres.Column1.Text1.LostFocus legado
    *
    * Legado, na integra:
    *
    *   PROCEDURE LostFocus
    *   If IsEmpty(This.Value)
    *       Thisform.cmdSair.SetFocus
    *   EndIf
    *
    * Isto eh: ao SAIR da celula do nome da impressora, se ela estiver vazia,
    * o foco vai para o botao Encerrar. Eh o caminho de quando nao ha nada a
    * escolher (cursor sem linha, ou linha em branco): em vez de deixar o
    * usuario tabulando dentro de uma grade vazia, a tela o leva ao unico
    * botao que ainda faz sentido.
    *
    * O valor eh lido do CONTROLE, nao de THIS: em handler ligado por
    * BINDEVENT o THIS eh o FORM, nunca o TextBox do legado - "This.Value" do
    * dump corresponde a THIS.grd_4c_Dados.Column1.Text1.Value aqui.
    *
    * O teste de vazio reproduz o IsEmpty do Fortyus, que NAO eh o EMPTY do
    * VFP: medido na regra CLAUDE.md #27, EMPTY(.NULL.) devolve .F. - para a
    * nativa um NULL "nao esta vazio", para o legado esta. Por isso o NULL eh
    * testado ANTES, em IF SEPARADO: VFP9 nao faz short-circuit em OR, entao
    * ISNULL(x) OR EMPTY(x) avaliaria EMPTY sobre o NULL de qualquer jeito. A
    * coluna Impres eh C(30) e com RecordSource vazio o .Value vem "", mas um
    * cursor do pai montado com SET NULL ON entrega NULL - e eh exatamente o
    * caso "nao ha impressora" que este handler existe para atender.
    *
    * O SetFocus eh guardado por Visible/Enabled do botao E por THIS.Visible:
    * SetFocus em controle de form ainda NAO EXIBIDO estoura erro de runtime,
    * e este handler roda tambem no harness headless, que navega a grade com o
    * form sem Show(). O guard evita tanto o erro cru quanto um CATCH que
    * dispararia MsgErro a cada navegacao (regra #9 proibe CATCH silencioso,
    * entao a saida certa eh nao deixar o erro acontecer).
    *
    * Metodo PUBLIC de proposito: eh alvo de BINDEVENT (regra CLAUDE.md #3 -
    * com PROTECTED o bind falha calado e a celula fica sem evento).
    *==========================================================================
    PROCEDURE GradeNomeImpressoraLostFocus()
        LOCAL loc_uValor, loc_lVazio

        loc_lVazio = .F.

        IF VARTYPE(THIS.grd_4c_Dados) != "O"
            RETURN
        ENDIF

        *-- "This.Value" do legado: o conteudo da celula do nome
        loc_uValor = THIS.grd_4c_Dados.Column1.Text1.Value

        *-- IsEmpty do Fortyus trata NULL como VAZIO; EMPTY nativo nao
        IF ISNULL(loc_uValor)
            loc_lVazio = .T.
        ELSE
            loc_lVazio = EMPTY(loc_uValor)
        ENDIF

        *-- Legado: Thisform.cmdSair.SetFocus
        IF loc_lVazio AND THIS.Visible ;
                AND THIS.cmd_4c_CmdSair.Visible ;
                AND THIS.cmd_4c_CmdSair.Enabled
            THIS.cmd_4c_CmdSair.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * SelecionarImpressoraCorrente - GrdImpres.Column2.Check1.Valid legado
    *
    * Legado, na integra:
    *
    *   PROCEDURE Valid
    *   Local lnRecNo
    *   If This.Value
    *       Select csSigCdmp
    *       lnRecNo = RecNo('csSigCdmp')
    *       Replace All lSituas With .F.
    *       Goto ( lnRecNo )
    *       Replace lSituas With .T.
    *   EndIf
    *
    * Comportamento de RADIO dentro da grade: marcar uma linha DESMARCA todas
    * as outras. O corpo mora no BO desde a Fase 2
    * (SigOpIpBBO.SelecionarImpressora), que eh quem conhece o contrato do
    * cursor; este metodo eh o funil da tela - le o RECNO, chama o BO e
    * REPINTA.
    *
    * O RECNO eh lido ANTES de qualquer REPLACE e vai ao BO por PARAMETRO, nao
    * pelo ponteiro corrente: o "Replace All" muda o conteudo de todas as
    * linhas e deixa o ponteiro em EOF, e eh por isso que o legado guarda
    * lnRecNo antes - para o "Goto" seguinte achar a linha que o usuario
    * escolheu, e nao a ultima do cursor.
    *
    * DESVIO DELIBERADO E UNICO em relacao ao legado: aqui clicar numa linha a
    * SELECIONA, inclusive quando ela ja estava selecionada (a operacao eh
    * idempotente). No legado o toggle nativo escrevia .F. no cursor ANTES do
    * Valid rodar, e o "If This.Value" entao nao entrava - isto eh, clicar na
    * linha JA marcada a desmarcava e deixava a tela com ZERO impressora
    * escolhida. Esse estado quebra o chamador, que faz "Locate for lSituas" +
    * "Set Printer To Name (AllTrim(CsSigCdmp.impres))" assim que esta tela
    * fecha (ver o cabecalho do arquivo): sem linha marcada o Locate nao acha
    * nada e o nome da impressora eh lido fora de registro valido. Radio que
    * nao se desmarca eh o comportamento que o proprio Valid legado descreve
    * ("so age quando marcado") e eh a leitura que o BO ja documenta; e a saida
    * sem escolher continua existindo pelo botao Encerrar, que preserva a
    * ultima selecao.
    *
    * O cursor eh conferido pelo contrato do BO (CursorPronto) antes de
    * qualquer coisa: ele pertence ao form PAI e pode nao ter chegado (tela
    * instanciada pelo harness ou pela validacao de UI). Nesse caso o metodo
    * devolve .F. sem avisar nada - o aviso de cursor ausente eh dado UMA vez
    * na abertura, por PrepararGrade/CarregarLista, e repeti-lo a cada clique
    * daria uma fila de dialogos para um unico defeito.
    *
    * Nao ha TRY/CATCH aqui de proposito: o unico ponto que pode estourar eh o
    * REPLACE sobre o cursor, e ele esta DENTRO do TRY/CATCH do
    * SigOpIpBBO.SelecionarImpressora, que ja reporta com Message/LineNo/
    * Procedure. Envolver de novo daria dois dialogos para o mesmo erro.
    *
    * Metodo PUBLIC de proposito: eh o funil que os 2 handlers de toggle
    * chamam e o harness chama de FORA da classe - PEMSTATUS devolve .T. mesmo
    * para PROTECTED, entao o teste entraria no branch e a chamada estouraria
    * em runtime (regra CLAUDE.md #3).
    *
    * Retorno: .T. quando a linha corrente passou a ser a escolhida; .F. quando
    *          o cursor nao chegou ou a grade esta sem linha valida.
    *==========================================================================
    PROCEDURE SelecionarImpressoraCorrente()
        LOCAL loc_lSucesso, loc_cCursor, loc_nRecno

        loc_lSucesso = .F.
        loc_nRecno   = 0

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        *-- Contrato do cursor que o form PAI entrega (alias + 3 colunas + TAG)
        IF !THIS.this_oBusinessObject.CursorPronto()
            RETURN .F.
        ENDIF

        loc_cCursor = ALLTRIM(THIS.this_oBusinessObject.this_cCursorImpressoras)

        *-- Legado: lnRecNo = RecNo('csSigCdmp') - lido ANTES do Replace All,
        *-- que deixa o ponteiro em EOF
        IF !EOF(loc_cCursor) AND !BOF(loc_cCursor)
            loc_nRecno = RECNO(loc_cCursor)
        ENDIF

        IF loc_nRecno <= 0
            RETURN .F.
        ENDIF

        *-- Legado: Replace All lSituas With .F. / Goto (lnRecNo) /
        *-- Replace lSituas With .T.
        loc_lSucesso = THIS.this_oBusinessObject.SelecionarImpressora(loc_nRecno)

        *-- Funil de repintura: o cursor mudou em TODAS as linhas e a grade
        *-- nao se repinta sozinha (regra CLAUDE.md #21a). Antes dele,
        *-- FormParaBO rele a linha corrente para o BO - sem isso o resumo da
        *-- selecao (this_cImpressoraSelecionada / this_nRegistroSelecionado /
        *-- this_lSituas) continuaria apontando para a escolha ANTERIOR.
        IF loc_lSucesso
            THIS.FormParaBO()
            THIS.RepintarGrade()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ChkImpressora* - os 4 handlers do toggle manual do CheckBox da Column2
    *
    * Por que quatro e nao um: ver ConfigurarEventosGrade. Em resumo, o
    * CheckBox de Column nao alterna pelo binding nativo de forma confiavel
    * (regra CLAUDE.md #18 / Pattern #185), entao MouseDown e Click existem
    * SO para suprimir o toggle padrao com NODEFAULT - sem eles o valor pode
    * alternar duas vezes e a tela nao muda - e a escolha de verdade eh feita
    * em MouseUp (mouse) e KeyPress (Enter/Espaco), os dois chamando o MESMO
    * funil.
    *
    * As assinaturas declaram os parametros dos eventos, obrigatoriamente
    * (regra CLAUDE.md #3): handler SEM parametro ligado a KeyPress/MouseUp/
    * MouseDown estoura a cada disparo.
    *
    * Nao ha guarda de reentrancia porque nao ha reentrancia possivel: um
    * clique dispara MouseDown, MouseUp e Click, e so o MouseUp age; o funil
    * nao abre dialogo modal nem mexe no foco, entao nao se redispara.
    *
    * Os quatro sao PUBLIC de proposito: sao alvo de BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE ChkImpressoraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.SelecionarImpressoraCorrente()
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE ChkImpressoraMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        THIS.SelecionarImpressoraCorrente()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkImpressoraMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkImpressoraClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * PrepararGrade - o trecho do Init legado que mexe no cursor do pai
    *
    * Legado (SIGOPIPB.Init, depois das duas linhas de Caption):
    *
    *   Select csSigCdmp
    *   Set Order to Impres
    *   Scan
    *       Replace csSigCdmp.lSituas With .F.
    *   EndScan
    *   Goto Top
    *   Replace csSigCdmp.lSituas With .T.
    *
    * O corpo mora no BO (SigOpIpBBO.PrepararSelecaoInicial, Fase 2), que eh
    * quem conhece o contrato do cursor: ele confere o alias, as colunas e o
    * TAG de ordem ANTES de tocar em qualquer coisa, aplica a ordem
    * alfabetica, zera lSituas em TODAS as linhas e marca a PRIMEIRA. O pai
    * entra nesta tela com VARIAS linhas marcadas (ele marca toda impressora
    * achada no painel do Windows), e eh justamente por isso que o legado
    * zera tudo antes de escolher uma: esta tela eh de escolha UNICA.
    *
    * Metodo SEPARADO do InicializarForm, e PUBLIC, de proposito: a Fase 4
    * precisa chama-lo do funil unico de carga da grade (regras CLAUDE.md
    * #21 / #46 - repintar uma grade exige rodar GO TOP + Refresh em TODO
    * caminho que popula o cursor, e BINDEVENT nao alcanca metodo PROTECTED,
    * regra #3).
    *
    * Falhar aqui NAO eh erro da tela: o cursor pertence ao pai, e uma tela
    * instanciada fora do fluxo dele (harness, validacao de UI) simplesmente
    * nao o tem. Nesse caso o dialogo sai UMA vez, guardado por
    * this_lFalhaCursorAvisada, e a tela abre com a grade vazia. Em modo de
    * teste nem o dialogo sai, para nao bloquear o pipeline.
    *
    * Retorno: .T. quando o cursor estava no contrato e a selecao inicial foi
    *          aplicada; .F. caso contrario.
    *==========================================================================
    PROCEDURE PrepararGrade()
        LOCAL loc_lSucesso, loc_lModoTeste

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_lModoTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                         (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)

        loc_lSucesso = THIS.this_oBusinessObject.PrepararSelecaoInicial()

        IF !loc_lSucesso AND !loc_lModoTeste AND !THIS.this_lFalhaCursorAvisada
            THIS.this_lFalhaCursorAvisada = .T.

            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                MsgAviso("A lista de impressoras n" + CHR(227) + "o foi recebida " + ;
                         "da tela de origem.", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarLista - liga a grade ao cursor do pai e a REPINTA
    *
    * Este eh o metodo de carga da tela, e transcreve o bloco que FECHA o
    * SIGOPIPB.Init legado:
    *
    *   With Thisform.GrdImpres
    *       .RecordSource          = 'csSigCdmp'
    *       .Column1.ControlSource = 'csSigCdmp.Impres'
    *       .Column2.ControlSource = 'csSigCdmp.lSituas'
    *       .Refresh
    *   EndWith
    *
    * A tela NAO consulta o banco: o cursor eh montado pelo form PAI e
    * entregue pronto (ver o cabecalho do arquivo), com as colunas e o TAG de
    * ordem - contrato conferido por SigOpIpBBO.CursorPronto(). "Carregar"
    * aqui eh, portanto, LIGAR a grade ao alias e repintar, que eh exatamente
    * o que o legado faz. A ordem tambem eh a do legado: RecordSource
    * primeiro, ControlSource das colunas depois.
    *
    * FUNIL UNICO DO BIND (regras CLAUDE.md #21/#46): mexer no cursor NAO
    * repinta a grade sozinho, e repintar grade de pagina/controle oculto nao
    * pinta - por isso este metodo roda DEPOIS de TornarControlesVisiveis.
    *
    * Este eh o funil do BIND; o funil da REPINTURA eh RepintarGrade, que
    * este metodo chama no fim. A distincao foi feita na Fase 7, quando o
    * segundo caminho que toca o cursor entrou em cena
    * (SelecionarImpressoraCorrente -> SigOpIpBBO.SelecionarImpressora, que
    * reescreve lSituas em TODAS as linhas): esse caminho NAO pode passar por
    * aqui, porque reatribuir RecordSource/ControlSource no meio de um evento
    * de CELULA derruba a celula ativa e o foco do usuario - e eh trabalho
    * inutil, ja que o alias nao mudou, so o conteudo das linhas. Ele passa
    * pelo RepintarGrade, que eh o que o legado faz nesse caso (o
    * Check1.Valid dele nao rebinda nada) e eh tambem o padrao canonico do
    * projeto para toggle de CheckBox de grade (FormSIGOPCGF.AlternarFlagGrade
    * fecha com par_oGrid.Refresh()). O que a regra #21 exige - nenhum caminho
    * que toca o cursor termina sem repintar - continua valendo pelos dois,
    * porque os dois terminam no MESMO RepintarGrade.
    *
    * NAO HA "GO TOP" aqui, e isso eh deliberado: no legado o "Goto Top" vive
    * no trecho ANTERIOR do Init (ja portado em
    * SigOpIpBBO.PrepararSelecaoInicial), e o bloco de bind tem apenas o
    * Refresh. Reproduzir o par GO TOP + Refresh dentro deste metodo
    * REPOSICIONARIA a grade na primeira linha a cada repintura - isto eh, a
    * cada vez que o usuario marcasse uma impressora no meio da lista, a
    * grade saltaria de volta para o topo. O par existe, mas distribuido como
    * no legado: PrepararGrade posiciona, CarregarLista liga e repinta.
    *
    * As larguras/cabecalhos/CurrentControl sao reaplicados SEMPRE, inclusive
    * quando o cursor nao chegou: sem isso a grade apareceria com 2 colunas
    * de 90px, cabecalho "Column1"/"Column2" e sem CheckBox na validacao de
    * UI (regras CLAUDE.md #41/#46).
    *
    * Sem cursor a grade fica sem fonte (RecordSource = ""), nunca com o
    * alias de uma abertura anterior - exibir linha velha seria pior que
    * vazio, porque sugeriria ao usuario que ha o que escolher.
    *
    * O aviso de cursor ausente eh do PrepararGrade, nao daqui: os dois rodam
    * em sequencia e falham pelo MESMO motivo, entao repetir a mensagem daria
    * dois dialogos para um unico defeito. A flag this_lFalhaCursorAvisada,
    * que PrepararGrade acende, eh conferida aqui so para nao reavisar.
    *
    * Metodo PUBLIC de proposito: o harness chama THIS.oForm.CarregarLista()
    * de FORA da classe, e PEMSTATUS devolve .T. mesmo para PROTECTED - o
    * teste entraria no branch e a chamada estouraria em runtime
    * (regra CLAUDE.md #3).
    *
    * Retorno: .T. quando a grade ficou ligada ao cursor; .F. quando o cursor
    *          nao estava disponivel.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lLigou, loc_cCursor, loc_lModoTeste, loc_lPronto

        loc_lLigou  = .F.
        loc_cCursor = ""
        loc_lPronto = .F.

        loc_lModoTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                         (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cCursor = ALLTRIM(THIS.this_oBusinessObject.this_cCursorImpressoras)
            loc_lPronto = THIS.this_oBusinessObject.CursorPronto()
        ENDIF

        IF loc_lPronto
            *-- Ordem do legado: RecordSource primeiro, ControlSource depois
            THIS.grd_4c_Dados.RecordSource          = loc_cCursor
            THIS.grd_4c_Dados.Column1.ControlSource = loc_cCursor + ".Impres"
            THIS.grd_4c_Dados.Column2.ControlSource = loc_cCursor + ".lSituas"

            loc_lLigou = .T.
        ELSE
            *-- Sem cursor: grade sem fonte, nunca com o alias anterior
            THIS.grd_4c_Dados.RecordSource = ""

            IF !loc_lModoTeste AND !THIS.this_lFalhaCursorAvisada
                THIS.this_lFalhaCursorAvisada = .T.

                MsgAviso("A lista de impressoras n" + CHR(227) + "o foi recebida " + ;
                         "da tela de origem.", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF

            *-- Sem alias nao ha linha corrente: zerar as propriedades de linha
            *-- do BO evita que ele responda sobre a impressora de uma leitura
            *-- ANTERIOR como se ela ainda estivesse na grade. Este eh o funil
            *-- UNICO que detecta "o cursor nao chegou", por isso a limpeza
            *-- mora aqui e nao espalhada pelos consumidores.
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.LimparDados()
            ENDIF
        ENDIF

        *-- OBRIGATORIO depois de CADA atribuicao a RecordSource/ControlSource
        THIS.FormatarColunasGrade()

        IF loc_lLigou
            *-- Espelha o estado do BO na grade e fecha com o Refresh do bloco
            *-- legado (o Goto Top do legado fica em PrepararGrade)
            THIS.BOParaForm()
        ELSE
            *-- Sem cursor nao ha linha escolhida a espelhar - so o Refresh
            THIS.RepintarGrade()
        ENDIF

        RETURN loc_lLigou
    ENDPROC

    *==========================================================================
    * RepintarGrade - funil UNICO de repintura da grade
    *
    * Transcreve o ".Refresh" que fecha o bloco "With Thisform.GrdImpres" do
    * Init legado. Existe como metodo separado porque DOIS caminhos tocam o
    * cursor e os dois tem de terminar repintando (regra CLAUDE.md #21a -
    * mexer no cursor NAO repinta a grade sozinho):
    *
    *   CarregarLista                  -> abertura: liga o alias e repinta
    *   SelecionarImpressoraCorrente   -> escolha do usuario: reescreve
    *                                     lSituas em todas as linhas e repinta
    *
    * Sem o segundo, marcar uma impressora no meio da lista deixaria a linha
    * ANTERIOR ainda com o CheckBox marcado na tela (o cursor ja estaria
    * certo, a tela nao) - duas linhas aparentemente escolhidas numa tela de
    * escolha unica.
    *
    * NAO HA "GO TOP" aqui, e isso eh deliberado - a mesma razao registrada em
    * CarregarLista: no legado o "Goto Top" vive no trecho ANTERIOR do Init
    * (portado em SigOpIpBBO.PrepararSelecaoInicial) e o bloco de bind tem
    * apenas o Refresh. Reposicionar aqui jogaria a grade de volta para a
    * primeira linha a cada vez que o usuario marcasse uma impressora no meio
    * da lista.
    *
    * Metodo PUBLIC de proposito: eh o funil que os handlers de evento da
    * grade chamam, e BINDEVENT nao alcanca metodo PROTECTED (regra #3).
    *==========================================================================
    PROCEDURE RepintarGrade()
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - leva para o BO a linha que a grade esta exibindo
    *
    * A unica superficie de dados desta tela eh a grade, e as duas Column tem
    * ControlSource DIRETO no cursor (CarregarLista liga <cursor>.Impres e
    * <cursor>.lSituas). Logo "o que o controle mostra" EH a linha corrente do
    * cursor, e ler o cursor aqui eh ler o controle - nao ha ficha de TextBox a
    * varrer, porque o legado nao tem nenhum (MEDICAO no cabecalho do arquivo:
    * a arvore do dump tem 11 objetos e o unico campo editavel eh o CheckBox da
    * Column2).
    *
    * NAO ha risco da armadilha "o valor digitado esta no controle, o cursor so
    * recebe depois" (regra CLAUDE.md #46): o dump trava a Column1
    * (Column1.ReadOnly = .T. e Text1.ReadOnly = .T.) e o CheckBox da Column2
    * nao escreve por binding - quem escreve eh o REPLACE de
    * SigOpIpBBO.SelecionarImpressora, chamado pelo funil
    * SelecionarImpressoraCorrente. Quando este metodo roda, o cursor ja eh a
    * fonte autoritativa.
    *
    * O trabalho de verdade esta em SigOpIpBBO.CarregarLinhaCorrente, que le a
    * linha (Impres / lSituas / lMarcas / nTpImpres, esta ultima guardada por
    * TYPE porque so parte dos chamadores a traz) e recalcula o resumo da
    * selecao varrendo o cursor INTEIRO - o mesmo "Locate for lSituas" que o
    * form PAI executa depois que esta tela fecha, mantido vivo enquanto o
    * usuario ainda escolhe. Por isso este metodo eh chamado DEPOIS de cada
    * escolha: sem ele this_cImpressoraSelecionada / this_nRegistroSelecionado
    * continuariam apontando para a escolha ANTERIOR.
    *
    * Cursor fora do contrato apenas devolve .F. - limpar a linha corrente
    * nesse caso eh atribuicao de CarregarLista, que eh o funil UNICO que
    * detecta "o cursor nao chegou" e ja avisa o usuario uma vez. Duplicar a
    * limpeza aqui espalharia por dois lugares a mesma responsabilidade.
    *
    * Nao ha TRY/CATCH aqui de proposito: o unico ponto que pode estourar eh a
    * leitura do cursor, e ela esta DENTRO do TRY/CATCH de
    * SigOpIpBBO.CarregarDoCursor, que ja reporta com Message/LineNo/Procedure.
    * Envolver de novo daria dois dialogos para o mesmo erro.
    *
    * Metodo PUBLIC de proposito: o harness o chama de FORA da classe, e
    * PEMSTATUS devolve .T. mesmo para PROTECTED - o teste entraria no branch e
    * a chamada estouraria em runtime (regra CLAUDE.md #3).
    *
    * Retorno: .T. quando havia linha para ler; .F. quando o cursor nao chegou
    *          no contrato esperado ou a grade esta sem linha valida.
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_lLeu

        loc_lLeu = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        *-- Contrato do cursor que o form PAI entrega (alias + 3 colunas + TAG)
        IF !THIS.this_oBusinessObject.CursorPronto()
            RETURN .F.
        ENDIF

        *-- Le Impres / lSituas / lMarcas / nTpImpres da linha corrente e
        *-- recalcula o resumo da selecao (o "Locate for lSituas" do pai)
        loc_lLeu = THIS.this_oBusinessObject.CarregarLinhaCorrente()

        RETURN loc_lLeu
    ENDPROC

    *==========================================================================
    * BOParaForm - espelha na grade o que o BO sabe do cursor
    *
    * O caminho inverso de FormParaBO. Como as duas Column tem ControlSource
    * direto no cursor, nao ha VALOR a copiar para controle nenhum - o binding
    * ja faz isso. O que o BO tem a dizer a tela eh QUAL LINHA esta escolhida
    * (this_nRegistroSelecionado, apurado por CarregarDoCursor e por
    * SelecionarImpressora). Espelhar, aqui, eh posicionar a grade nessa linha
    * e repintar.
    *
    * Na ABERTURA isso coincide exatamente com o Init legado e portanto NAO
    * muda comportamento nenhum: SigOpIpBBO.PrepararSelecaoInicial faz o
    * "Set Order to Impres" + "Goto Top" + "Replace lSituas With .T.", de modo
    * que a linha escolhida eh a PRIMEIRA e o ponteiro ja esta nela - o GO eh
    * no-op. O ganho eh deixar de DEPENDER de o ponteiro estar, por acaso, onde
    * se espera.
    *
    * Por isso ele NAO entra no caminho da escolha do usuario: ali a linha
    * escolhida JA eh a corrente (o funil passa o RECNO dela ao BO), o GO seria
    * no-op e reposicionar durante um evento de CELULA eh justamente o que
    * derruba a celula ativa e o foco - aquele caminho chama RepintarGrade
    * direto.
    *
    * O ponteiro so eh movido quando o destino existe de fato: RECNO valido,
    * entre 1 e a contagem do cursor (ContarImpressoras, que le o RECCOUNT sem
    * mexer no ponteiro nem trocar a area de trabalho). E a area de trabalho de
    * quem chamou eh DEVOLVIDA no fim - a sessao de dados eh COMPARTILHADA com
    * o form pai (DataSession = 1, ver o cabecalho), entao deixar outro alias
    * selecionado aqui mexeria na tela de quem nos abriu.
    *
    * Fecha SEMPRE com RepintarGrade, inclusive quando nada foi reposicionado:
    * eh o ".Refresh" do bloco "With Thisform.GrdImpres" do Init legado, e
    * mexer no cursor NAO repinta a grade sozinho (regra CLAUDE.md #21a).
    *
    * Metodo PUBLIC de proposito: o harness o chama de FORA da classe
    * (regra CLAUDE.md #3).
    *
    * Retorno: .T. quando a grade foi posicionada na linha escolhida; .F.
    *          quando nao havia cursor nem linha escolhida a espelhar.
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_lEspelhou, loc_cCursor, loc_nRecno, loc_nTotal, loc_cAliasAnterior

        loc_lEspelhou = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O" ;
                OR VARTYPE(THIS.grd_4c_Dados) != "O"
            RETURN .F.
        ENDIF

        *-- Contrato do cursor que o form PAI entrega (alias + 3 colunas + TAG)
        IF !THIS.this_oBusinessObject.CursorPronto()
            THIS.RepintarGrade()
            RETURN .F.
        ENDIF

        loc_cCursor        = ALLTRIM(THIS.this_oBusinessObject.this_cCursorImpressoras)
        loc_nRecno         = THIS.this_oBusinessObject.this_nRegistroSelecionado
        loc_nTotal         = THIS.this_oBusinessObject.ContarImpressoras()
        loc_cAliasAnterior = ALIAS()

        IF VARTYPE(loc_nRecno) = "N" AND loc_nRecno > 0 AND loc_nRecno <= loc_nTotal
            SELECT (loc_cCursor)

            IF RECNO(loc_cCursor) != loc_nRecno
                GO loc_nRecno
            ENDIF

            loc_lEspelhou = .T.

            *-- Devolve a area de trabalho de quem chamou (sessao compartilhada)
            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF
        ENDIF

        *-- ".Refresh" do bloco legado: mexer no cursor nao repinta a grade
        THIS.RepintarGrade()

        RETURN loc_lEspelhou
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria todo controle com Visible = .F.
    *
    * Varredura recursiva da arvore de controles. Nao ha lista de excecao
    * nesta tela: o dump de SIGOPIPB nao declara Visible = .F. em objeto
    * nenhum, isto eh, nao existe aqui o painel flutuante que outros forms
    * OPERACIONAIS alternam por botao - os cinco controles da tela (faixa, os
    * 2 labels dela, a grade e o botao Encerrar) nascem todos a mostra.
    *
    * A varredura PARA na grade: Grid nao expoe ControlCount (expoe
    * ColumnCount/Columns), entao o PEMSTATUS nao entra nela e o CheckBox
    * dentro da Column2 NAO eh alcancado por aqui. Por isso ele recebe
    * .Visible = .T. explicito no proprio ConfigurarGrade - sem isso o
    * CheckBox existe, tem CurrentControl e nao desenha. Nao eh falha desta
    * varredura: forcar Visible nos membros de uma Column eh atribuicao do
    * metodo que os cria.
    *
    * Controls eh indexado por NUMERO (regra CLAUDE.md #34) e cada membro eh
    * conferido com PEMSTATUS sobre OBJETO antes de ser tocado - nunca sobre
    * alias de cursor, que dispararia erro 11.
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
    * Destroy - solta o BO e devolve o menu do sistema ao estado normal
    *
    * Legado (cmdSair.Click): "ThisForm.Release" e mais nada - esta tela nao
    * desabilita o pai (diferente do irmao SIGOPCLP, cujo pai se desabilita
    * antes de abrir o dialogo), entao nao ha nada a reabilitar aqui.
    *
    * O cursor da grade NAO eh fechado: ele pertence ao form PAI, que o cria
    * antes de abrir esta tela e o LE depois que ela fecha ("Select csSigCdmp
    * / Locate for lSituas / Set Printer To Name ..."). Fecha-lo aqui
    * derrubaria o cursor debaixo de quem continua vivo - e levaria embora
    * justamente a escolha que o usuario acabou de fazer.
    *
    * DODEFAULT() eh a ULTIMA linha, obrigatoriamente: FormBase.Destroy faz o
    * SET SYSMENU TO DEFAULT + RELEASE POPUP + CriarMenuPrincipal() que repoe
    * os pads do menu principal; sem ele o menu do sistema aparece encolhido.
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpIpBBO.prg):
*==============================================================================
* SigOpIpBBO.prg
*
* Business Object para SIGOPIPB (Seleciona Impressora de Etiquetas / Boletos)
*
* Origem legado : SigOpIpB.SCX
*                 tasks\task753\SigOpIpB_form_codigo_fonte.txt
*
* Tabela: (nenhuma - dialogo FILHO de selecao, sem persistencia propria)
*
* O QUE ESTA TELA FAZ
* -------------------
* E um dialogo MODAL de uma unica escolha: exibe numa grade as impressoras
* que o form PAI ja apurou e deixa o usuario marcar UMA delas. Toda a
* persistencia (a tabela SIGCDMP, de onde as impressoras vem) e consultada
* pelo form PAI; esta tela so LE e ESCREVE o flag de selecao no cursor que
* recebe pronto. Por isso this_cTabela e this_cCampoChave ficam vazios -
* mesma decisao arquitetural de SigOpClpBO.prg (visualizador parametrizado
* que consome o cursor do pai).
*
* CONTRATO DO CURSOR (csSigCdmp no legado)
* ----------------------------------------
* Os dois chamadores conhecidos montam o cursor ANTES do "Do Form SigOpIpb",
* sempre com a mesma forma. Conferido nos dumps:
*
*   tasks\task530\SIGCDTBI_form_codigo_fonte.txt (linhas 518-578)
*       Select Impres, nTpImpres From SigCdmp Where nTpImpres = ?pTip ...
*       llFlags = .f.
*       Select Impres, nTpImpres, llFlags as lMarcas, llFlags as lSituas ;
*         From Tmp1 Into Cursor csSigCdmp ReadWrite
*       Select csSigCdmp
*       Index On Impres Tag Imprime For ( lSituas = .T.)
*       Index On Impres Tag Impres
*       Goto Top In csSigCdmp
*       ... If (lnEtqImpres # 1)   && mais de uma impressora
*               Do Form SigOpIpb
*           EndIf
*       Select csSigCdmp
*       Locate for lSituas
*       Set Printer To Name (AllTrim(CsSigCdmp.impres))
*
*   tasks\task695\sigopcgv_form_codigo_fonte.txt (linhas 13817-13865)
*       Select *, llFlags as lMarcas, llFlags as lSituas ;
*         From LocalcImp Into Cursor csSigCdmp1
*       USE Dbf("csSigCdmp1") Alias csSigCdmp Again In 0
*       (mesmos dois Index On / Goto Top; depois le csSigCdmp.Impres,
*        .fontes, .expas, .expds, .maxcols)
*
* Logo o cursor da grade tem, no MINIMO, quatro colunas - as duas que a
* grade exibe mais as duas de marcacao:
*
*   Impres    C(30)     SIGCDMP.impres     - nome da impressora (Column1)
*   lSituas   L         (so no cursor)     - impressora ESCOLHIDA (Column2)
*   lMarcas   L         (so no cursor)     - marcacao do PAI (nao exibida)
*   nTpImpres N(4,0)    SIGCDMP.ntpimpres  - tipo da impressora
*
* e dois TAG: "Impres" (ordem alfabetica, a que o Init legado ativa com
* "Set Order to Impres") e "Imprime" (indice FILTRADO For lSituas = .T.,
* criado pelo pai e usado por ele depois que a tela fecha).
*
* lSituas e lMarcas NAO existem em SIGCDMP (conferido em docs\schema.sql,
* lido com Get-Content -Raw por ser UTF-16 - regra #14): sao colunas de
* trabalho que o pai acrescenta ao cursor com o "llFlags as ..." acima.
* nTpImpres aparece explicitamente no cursor do SIGCDTBI e vem no "Select *"
* do sigopcgv; a leitura dele (fase 2) tem de ser guardada por TYPE(), nunca
* presumida, porque nem todo chamador precisa dessa coluna.
*
* O cursor chega VIVO a esta tela porque o form e DataSession = 1
* (compartilhada), igual ao par SIGOPCCL/SIGOPCLP.
*
* COMPORTAMENTO A REPRODUZIR (metodos das fases seguintes)
* --------------------------------------------------------
* O legado tem cinco metodos, e os tres que mexem em dado sao:
*
*   Init                   - Set Order to Impres; SCAN zerando lSituas em
*                            TODAS as linhas; Goto Top; Replace lSituas
*                            With .T. (a PRIMEIRA linha nasce escolhida).
*                            O pai entra aqui com VARIAS linhas marcadas
*                            (ele marca toda impressora achada no painel do
*                            Windows), e e justamente por isso que o Init
*                            zera tudo antes: a tela e de escolha UNICA.
*   Column2.Check1.Valid   - If This.Value: guarda o RECNO, Replace All
*                            lSituas With .F., volta ao RECNO guardado e
*                            Replace lSituas With .T. - comportamento de
*                            radio-button dentro da grade. Desmarcar a
*                            linha corrente (This.Value = .F.) NAO faz
*                            nada: o legado nao entra no If, e a linha
*                            continua escolhida.
*   Column1.Text1.LostFocus- If IsEmpty(This.Value): cmdSair.SetFocus
*                            (navegacao de UI, fica no Form)
*
* "PROCEDURE Load" do legado e "=fConfigGeral()" - inicializacao GLOBAL da
* aplicacao no Fortyus, que na arquitetura nova ja aconteceu antes
* (config.prg + main.prg). O wrapper projeto\app\utils\fconfiggeral.prg
* existe apenas para o p-code dos VCX legado; em codigo nosso essa funcao
* nunca e chamada. Mesma decisao registrada em SigOpClpBO.prg.
*
* GRAVACAO
* --------
* Inserir(), Atualizar(), ExecutarExclusao() e RegistrarAuditoria() ficam
* HERDADOS de BusinessBase - o comportamento padrao herdado (recusar a
* operacao e reportar a recusa pelo ExibirFalha do Salvar, regra #20) ja e
* o correto, porque o dump legado prova que esta tela nao grava no SQL
* Server: zero TABLEUPDATE(, zero .AddCursor(, zero Insert Into / Update /
* Delete From. Os tres Replace que existem tem por destino o CURSOR LOCAL
* csSigCdmp, na coluna lSituas, que nem existe na tabela. Escrever um
* INSERT/UPDATE aqui exigiria ADIVINHAR a lista de colunas, que e o que a
* regra #22 do CLAUDE.md proibe.
*
* Fase 2/8: metodos de Fase 1 + CarregarDoCursor/ObterChavePrimaria/
* CursorPronto/ContarImpressoras/PrepararSelecaoInicial/SelecionarImpressora.
* Inserir(), Atualizar(), ExecutarExclusao() e RegistrarAuditoria() seguem
* SEM override, pela razao exposta acima em "GRAVACAO".
*
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigOpIpBBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Titulo da janela
    *
    * O Caption do form legado e fixo no SCX ("Seleciona Impressora de
    * Etiquetas / Boletos") e o Init o copia para os DOIS labels da faixa do
    * cabecalho (lblSombra e lblTitulo). Fica em propriedade para o Form ter
    * uma fonte unica em vez de repetir o literal em tres lugares.
    *--------------------------------------------------------------------------
    this_cTitulo = ""               && Caption do form / dos labels da faixa

    *--------------------------------------------------------------------------
    * Cursor da grade e seus indices
    *
    * this_cCursorImpressoras e o alias que a grade consome - "csSigCdmp" no
    * legado, "cursor_4c_Impressoras" no migrado (PILAR 3). E o PAI que cria
    * esse alias; esta tela apenas o localiza, reordena e escreve lSituas.
    *
    * this_cTagImpres e this_cTagImprime guardam os nomes dos dois TAG que o
    * pai cria no cursor, exatamente como o legado os escreve ("Impres" e
    * "Imprime"): o primeiro e o que o Init ativa ("Set Order to Impres"), o
    * segundo e o indice FILTRADO For lSituas = .T. que o pai consulta depois
    * que a tela fecha. Ficam em propriedade em vez de literal espalhado pelo
    * form.
    *
    * this_cOrdemAtual nasce com o TAG "Impres" porque e essa a ordem que o
    * Init legado impoe antes de qualquer outra coisa.
    *--------------------------------------------------------------------------
    this_cCursorImpressoras = ""    && alias da grade (csSigCdmp no legado)
    this_cTagImpres = ""            && TAG Impres  - Index On Impres
    this_cTagImprime = ""           && TAG Imprime - Index On Impres For lSituas
    this_cOrdemAtual = ""           && TAG em vigor na grade

    *--------------------------------------------------------------------------
    * Linha corrente da grade - espelha as colunas do cursor csSigCdmp
    *
    * Column1 (Impres) e somente leitura no SCX legado (Column1.ReadOnly =
    * .T. e Text1.ReadOnly = .T.); quem o usuario edita e so a Column2
    * (lSituas, o CheckBox). lMarcas nao aparece na tela: e a marcacao que o
    * PAI faz ao cruzar o cursor com APRINTERS() do Windows, e esta tela
    * NUNCA a altera - fica declarada porque a linha a carrega e o Form
    * precisa devolve-la intacta ao pai.
    *
    * nTpImpres so existe no cursor de parte dos chamadores (explicito no
    * SIGCDTBI, implicito no "Select *" do sigopcgv): a leitura dele tem de
    * ser guardada por TYPE(<cursor>.nTpImpres) != "U", nunca presumida.
    *--------------------------------------------------------------------------
    this_cImpres = ""               && Impres    C(30)  - nome da impressora
    this_lSituas = .F.              && lSituas   L      - linha escolhida
    this_lMarcas = .F.              && lMarcas   L      - marcacao do pai
    this_nTpImpres = 0              && nTpImpres N(4,0) - tipo da impressora

    *--------------------------------------------------------------------------
    * Resultado da selecao
    *
    * this_cImpressoraSelecionada e o que o chamador consome depois que a
    * tela fecha - o equivalente ao "Locate for lSituas / AllTrim(
    * CsSigCdmp.impres)" que o SIGCDTBI executa na volta.
    *
    * this_nRegistroSelecionado e o RECNO da linha escolhida: e o "lnRecNo"
    * do Check1.Valid legado, guardado ANTES do "Replace All lSituas With
    * .F." para o "Goto ( lnRecNo )" conseguir voltar. Fica em propriedade
    * porque o Form tambem precisa dele para reposicionar a grade.
    *
    * this_nTotalImpressoras e o RECCOUNT do cursor. O pai so abre esta tela
    * quando ha MAIS DE UMA impressora ("If (lnEtqImpres # 1)" no SIGCDTBI,
    * "If (Reccount() # 1 And Reccount() # 0)" no sigopcgv), entao o valor
    * esperado aqui e sempre maior ou igual a 2; guarda-lo permite a tela
    * reagir sem reconsultar o cursor.
    *--------------------------------------------------------------------------
    this_cImpressoraSelecionada = ""  && impressora com lSituas = .T.
    this_nRegistroSelecionado = 0     && RECNO da linha escolhida (lnRecNo)
    this_nTotalImpressoras = 0        && RECCOUNT do cursor da grade

    *==========================================================================
    * Init - Inicializa Business Object
    *
    * DODEFAULT() e a PRIMEIRA linha (BusinessBase.Init poe o BO em modo
    * consulta: this_lEmEdicao / this_lNovoRegistro / this_lDadosAlterados em
    * .F.). Ele e chamado SEM argumento de proposito: passar um nome de
    * tabela faria BusinessBase instanciar um DataAccess, e esta tela nao tem
    * tabela proprietaria.
    *
    * Por isso as duas propriedades herdadas ficam vazias - os nomes corretos
    * sao this_cTabela e this_cCampoChave (nunca this_cTabela /
    * this_cCampoChave).
    *
    * Os defaults atribuidos aqui sao os do legado, nao invencao:
    *   - o Caption e o literal do SCX;
    *   - os dois TAG sao os nomes que os chamadores criam ("Impres" e
    *     "Imprime");
    *   - this_cOrdemAtual nasce em "Impres" porque e a ordem que o Init
    *     legado ativa ("Set Order to Impres").
    * Os demais nascem zerados: so passam a valer quando o cursor do pai for
    * localizado e lido.
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        *-- Dialogo de selecao: nao ha tabela nem campo chave proprios
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        *-- Titulo fixo do SCX legado (copiado pelo Init para os dois labels)
        THIS.this_cTitulo = "Seleciona Impressora de Etiquetas / Boletos"

        *-- Cursor da grade e os dois TAG que o form PAI cria nele
        THIS.this_cCursorImpressoras = "cursor_4c_Impressoras"
        THIS.this_cTagImpres = "Impres"
        THIS.this_cTagImprime = "Imprime"
        THIS.this_cOrdemAtual = "Impres"

        *-- Linha corrente (preenchida ao ler o cursor)
        THIS.this_cImpres = ""
        THIS.this_lSituas = .F.
        THIS.this_lMarcas = .F.
        THIS.this_nTpImpres = 0

        *-- Resultado da selecao
        THIS.this_cImpressoraSelecionada = ""
        THIS.this_nRegistroSelecionado = 0
        THIS.this_nTotalImpressoras = 0

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CursorPronto - confere o contrato do cursor com o form pai
    *
    * O form pai monta o cursor ANTES de abrir esta tela (regra do cabecalho
    * do arquivo: SIGCDTBI e sigopcgv). Se o alias nao chegou, ou chegou sem
    * a estrutura esperada, a grade nao tem a que se ligar - melhor
    * descobrir isso antes de tocar em RecordSource/ControlSource do que ver
    * a grade virar um retangulo branco (regra #46).
    *
    * Impres e lSituas sao as duas colunas que a grade exibe/edita; lMarcas
    * e exigida porque esta tela devolve a linha intacta ao pai (this_lMarcas
    * nunca e reescrito por aqui). nTpImpres NAO entra nesta conferencia - so
    * parte dos chamadores a inclui (regra do cabecalho do arquivo).
    *
    * this_cTagImpres e o TAG que PrepararSelecaoInicial precisa para o
    * "Set Order to Impres" do legado; sua ausencia indica cursor fora do
    * contrato tanto quanto a falta de uma coluna.
    *
    * Retorno: .T. quando o alias existe, tem as 3 colunas e o TAG de ordem;
    *          .F. caso contrario, com this_cMensagemErro preenchido.
    *==========================================================================
    PROCEDURE CursorPronto()
        LOCAL loc_lPronto, loc_cAlias

        loc_lPronto = .F.
        loc_cAlias = ALLTRIM(THIS.this_cCursorImpressoras)

        DO CASE
            CASE EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "O cursor de impressoras n" + CHR(227) + ;
                    "o foi recebido da tela de origem."

            CASE TYPE(loc_cAlias + ".Impres") = "U" OR ;
                 TYPE(loc_cAlias + ".lSituas") = "U" OR ;
                 TYPE(loc_cAlias + ".lMarcas") = "U"
                THIS.this_cMensagemErro = "O cursor de impressoras n" + CHR(227) + ;
                    "o tem a estrutura esperada."

            CASE TAGNO(ALLTRIM(THIS.this_cTagImpres), "", loc_cAlias) = 0
                THIS.this_cMensagemErro = "O cursor de impressoras chegou sem o " + ;
                    CHR(237) + "ndice de ordena" + CHR(231) + CHR(227) + "o."

            OTHERWISE
                THIS.this_cMensagemErro = ""
                loc_lPronto = .T.
        ENDCASE

        RETURN loc_lPronto
    ENDPROC

    *==========================================================================
    * ContarImpressoras - quantas linhas o cursor da grade tem
    *
    * RECCOUNT(alias) le a contagem sem mexer no ponteiro de registro e sem
    * trocar a area de trabalho. Devolve 0 quando o alias nao existe.
    *==========================================================================
    PROCEDURE ContarImpressoras()
        LOCAL loc_cAlias

        loc_cAlias = ALLTRIM(THIS.this_cCursorImpressoras)

        IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
            RETURN 0
        ENDIF

        RETURN RECCOUNT(loc_cAlias)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a LINHA CORRENTE do cursor da grade para as
    * propriedades e recalcula o resumo da selecao (this_cImpressoraSelecionada
    * / this_nRegistroSelecionado / this_nTotalImpressoras).
    *
    * par_cAliasCursor chega do Form (THIS.this_cCursorImpressoras, "cursor_4c_
    * Impressoras") - cai no fallback da property quando vier vazio, igual ao
    * SigOpClpBO.CarregarDoCursor (mesma familia de dialogo-sem-tabela).
    *
    * Impres e lSituas sao OBRIGATORIAS nos dois chamadores conhecidos (regra
    * do cabecalho do arquivo); lMarcas tambem, mas nunca e reescrita por
    * esta tela. nTpImpres so existe em PARTE dos cursores - conferida com
    * TYPE(), nunca presumida (PEMSTATUS nao serve para alias de cursor).
    *
    * O resumo da selecao (qual linha tem lSituas = .T.) e recalculado a
    * cada chamada varrendo o cursor INTEIRO com LOCATE, nao so a linha
    * corrente - equivalente ao "Locate for lSituas" que o SIGCDTBI executa
    * depois que a tela fecha, so que mantido vivo enquanto o usuario ainda
    * navega na grade. O RECNO da linha corrente e salvo e reposto, porque
    * o LOCATE move o ponteiro do cursor.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_cAliasAnterior, loc_nRecnoAtual, loc_oErro

        loc_lSucesso = .F.
        loc_cAliasAnterior = ALIAS()
        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        IF EMPTY(loc_cAlias)
            loc_cAlias = ALLTRIM(THIS.this_cCursorImpressoras)
        ENDIF

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias) ;
                    AND TYPE(loc_cAlias + ".Impres") != "U" ;
                    AND TYPE(loc_cAlias + ".lSituas") != "U"

                SELECT (loc_cAlias)

                IF !EOF() AND !BOF()
                    THIS.this_cImpres = ALLTRIM(TratarNulo(Impres, ""))
                    THIS.this_lSituas = ConverterParaLogico(lSituas)

                    IF TYPE(loc_cAlias + ".lMarcas") != "U"
                        THIS.this_lMarcas = ConverterParaLogico(lMarcas)
                    ELSE
                        THIS.this_lMarcas = .F.
                    ENDIF

                    IF TYPE(loc_cAlias + ".nTpImpres") != "U"
                        THIS.this_nTpImpres = TratarNulo(nTpImpres, 0)
                    ELSE
                        THIS.this_nTpImpres = 0
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF

                *-- Resumo do cursor inteiro, sem perder a posicao da linha
                *-- corrente (regra #21: popular/reordenar cursor nao repinta
                *-- grade sozinho, mas aqui o que importa e nao perder RECNO).
                THIS.this_nTotalImpressoras = RECCOUNT(loc_cAlias)
                loc_nRecnoAtual = RECNO(loc_cAlias)

                LOCATE FOR lSituas

                IF FOUND()
                    THIS.this_cImpressoraSelecionada = ALLTRIM(TratarNulo(Impres, ""))
                    THIS.this_nRegistroSelecionado = RECNO(loc_cAlias)
                ELSE
                    THIS.this_cImpressoraSelecionada = ""
                    THIS.this_nRegistroSelecionado = 0
                ENDIF

                IF loc_nRecnoAtual > 0 AND loc_nRecnoAtual <= RECCOUNT(loc_cAlias)
                    GO loc_nRecnoAtual
                ENDIF
            ENDIF

            IF !loc_lSucesso
                *-- Sem linha para ler: zera a linha corrente, para a tela
                *-- nao exibir o resto de uma leitura anterior como se fosse
                *-- a atual.
                THIS.this_cImpres = ""
                THIS.this_lSituas = .F.
                THIS.this_lMarcas = .F.
                THIS.this_nTpImpres = 0
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY

        *-- Devolve a area de trabalho de quem chamou (sessao compartilhada -
        *-- regra do cabecalho: DataSession = 1, igual ao par SIGOPCCL/SIGOPCLP)
        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarLinhaCorrente - le a linha corrente do cursor da grade
    *
    * Atalho usado pelo Form quando o usuario navega na grade: evita repetir
    * o nome do cursor em cada chamada e garante que a leitura seja sempre do
    * alias que o form pai entregou (this_cCursorImpressoras).
    *==========================================================================
    PROCEDURE CarregarLinhaCorrente()
        RETURN THIS.CarregarDoCursor(THIS.this_cCursorImpressoras)
    ENDPROC

    *==========================================================================
    * LimparDados - zera as propriedades de linha
    *
    * DODEFAULT() limpa this_cMensagemErro na base. O contrato do cursor
    * (nome do alias e dos dois TAG) e o resumo da selecao NAO sao limpos
    * aqui de proposito: eles identificam o dialogo aberto, nao a linha
    * corrente, e continuam valendo enquanto o form existir.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cImpres = ""
        THIS.this_lSituas = .F.
        THIS.this_lMarcas = .F.
        THIS.this_nTpImpres = 0
    ENDPROC

    *==========================================================================
    * PrepararSelecaoInicial - transcricao do SIGOPIPB.Init
    *
    *   Select csSigCdmp
    *   Set Order to Impres
    *   Scan
    *       Replace csSigCdmp.lSituas With .F.
    *   EndScan
    *   Goto Top
    *   Replace csSigCdmp.lSituas With .T.
    *
    * O pai entra nesta tela com VARIAS linhas ja marcadas (ele marca toda
    * impressora achada no painel do Windows, para alimentar lMarcas) - e e
    * justamente por isso que o Init legado zera lSituas em TODAS as linhas
    * antes de escolher a primeira: esta tela e de escolha UNICA, nao de
    * marcacao multipla. A ordem "Impres" (alfabetica) e ativada ANTES do
    * SCAN, para a "primeira linha" ser a mesma que o usuario ve no topo da
    * grade.
    *
    * Chamado uma unica vez pelo Form, no InicializarForm - igual ao Init do
    * legado, que roda uma unica vez quando a tela e aberta.
    *
    * Retorno: .T. quando preparou; .F. quando o cursor nao chegou no
    * contrato esperado (this_cMensagemErro fica preenchido por
    * CursorPronto, que e conferido ANTES de tocar no cursor).
    *==========================================================================
    PROCEDURE PrepararSelecaoInicial()
        LOCAL loc_lSucesso, loc_cAlias, loc_cComando, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = ALLTRIM(THIS.this_cCursorImpressoras)

        IF !THIS.CursorPronto()
            RETURN .F.
        ENDIF

        TRY
            SELECT (loc_cAlias)

            *-- SET ORDER TO TAG nao aceita o nome por expressao entre
            *-- parenteses - o nome tem de ser literal no comando, por isso
            *-- vai por macro-substituicao (igual a SigOpClpBO.AplicarOrdem).
            loc_cComando = "SET ORDER TO TAG " + ALLTRIM(THIS.this_cTagImpres)
            &loc_cComando

            SCAN
                REPLACE lSituas WITH .F.
            ENDSCAN

            GO TOP

            IF !EOF()
                REPLACE lSituas WITH .T.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em PrepararSelecaoInicial")
        ENDTRY

        IF loc_lSucesso
            THIS.CarregarDoCursor(loc_cAlias)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SelecionarImpressora - transcricao do
    * SIGOPIPB.GrdImpres.Column2.Check1.Valid
    *
    *   Local lnRecNo
    *   If This.Value
    *       Select csSigCdmp
    *       lnRecNo = RecNo('csSigCdmp')
    *       Replace All lSituas With .F.
    *       Goto ( lnRecNo )
    *       Replace lSituas With .T.
    *   EndIf
    *
    * par_nRecno e o RECNO da linha em que o usuario marcou o CheckBox - o
    * "This.Value" do legado e testado no Form (so chama este metodo quando
    * o CheckBox foi MARCADO; desmarcar a linha corrente nao faz nada, igual
    * ao legado, que simplesmente nao entra no If quando This.Value = .F.).
    *
    * Comportamento de radio-button dentro da grade: zera TODAS as linhas e
    * marca so a que o usuario escolheu. O RECNO vem por PARAMETRO (nao do
    * RECNO corrente no momento da chamada) porque o "Replace All" muda o
    * conteudo do cursor mas NAO move o ponteiro - exatamente como no
    * legado, que guarda lnRecNo ANTES do Replace All para o "Goto" seguinte
    * funcionar.
    *
    * Atualiza this_cImpressoraSelecionada e this_nRegistroSelecionado -
    * equivalente ao "Locate for lSituas" que o form pai faz depois que a
    * tela fecha, mantido vivo para o Form conseguir reposicionar a grade.
    *
    * Retorno: .T. quando marcou; .F. quando o RECNO nao existe no cursor ou
    * o alias nao esta disponivel.
    *==========================================================================
    PROCEDURE SelecionarImpressora(par_nRecno)
        LOCAL loc_lSucesso, loc_cAlias, loc_nRecno, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = ALLTRIM(THIS.this_cCursorImpressoras)
        loc_nRecno = IIF(VARTYPE(par_nRecno) = "N", par_nRecno, 0)

        IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        IF loc_nRecno <= 0 OR loc_nRecno > RECCOUNT(loc_cAlias)
            RETURN .F.
        ENDIF

        TRY
            SELECT (loc_cAlias)

            REPLACE ALL lSituas WITH .F.
            GO loc_nRecno
            REPLACE lSituas WITH .T.

            THIS.this_cImpressoraSelecionada = ALLTRIM(TratarNulo(Impres, ""))
            THIS.this_nRegistroSelecionado = loc_nRecno

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em SelecionarImpressora")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - identidade da linha corrente da grade
    *
    * Sobrescreve o hook de BusinessBase (continua PROTECTED - regra #51).
    * Nunca e efetivamente invocado neste BO: RegistrarAuditoria so e
    * chamada por Inserir()/Atualizar()/ExecutarExclusao(), e os tres
    * permanecem herdados (ver "GRAVACAO" no cabecalho do arquivo) porque
    * esta tela nao grava nada no SQL Server. Fica implementado apenas para
    * o BO seguir o mesmo contrato dos demais - a chave natural da linha,
    * dentro do cursor que o pai montou, e o proprio nome da impressora.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cImpres
    ENDPROC

ENDDEFINE


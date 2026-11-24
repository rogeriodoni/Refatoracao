*==============================================================================
* FORMSIGOPTRP.PRG - Dialogo "Transportadoras" (SIGOPTRP)
* Tipo: OPERACIONAL (dialogo modal FILHO, layout FLAT - sem PageFrame)
* Migrado de Sigoptrp.SCX (task815)
*
* Pilares:
*   UX   -> layout identico ao legado (800x400, TitleBar=0, ControlBox=.F.,
*           Movable=.F., ClipControls=.F., AutoCenter=.T., cabecalho cinza
*           no topo com o Caption "Transportadoras <operacao>")
*   BD   -> SigOpTrp/SigPrTrp (ver cabecalho de SigoptrpBO.prg para o
*           detalhamento completo da tabela/chave/queries); tela EDITAVEL
*           (apaga tudo da operacao e reinsere em lote ao Confirmar, mesmo
*           padrao dos irmaos editaveis SigOpTrf)
*   CODE -> arquitetura em camadas (FormBase / SigoptrpBO)
*
* O QUE ESTA TELA EH
*   Dialogo FILHO que o form pai SigCdOpe (Cadastro de Operacoes do Caixa)
*   abre para o usuario DEFINIR as transportadoras habilitadas para a
*   operacao-pai (crSigCdOpe.Dopes no legado). O legado recebe "poForm" (o
*   form pai) e "pnDataSes" (DataSession do pai) no Init, troca para a
*   DataSession do pai (Set DataSession To pnDataSes) para ler
*   crSigCdOpe.Dopes direto do cursor do pai, monta o Caption
*   ('Transportadoras ' + AllTrim(crSigCdOpe.Dopes)) e carrega a grade
*   unica (GradeOpe, 2 colunas: Itras/Razaos) a partir das transportadoras
*   ja habilitadas em SigOpTrp para esta operacao, resolvendo a descricao
*   via JOIN com SigPrTrp.
*
*   GradeOpe.Column1.Text1 (Itras) tem Valid com lookup fwbuscaext em
*   SigPrTrp pela chave Itras - achando, preenche Razaos; nao achando,
*   abre o browse de selecao. GradeOpe.Column2.Text1 (Razaos) tem
*   When = Return .F. - e SOMENTE EXIBICAO, nunca editado digitando.
*
*   Botoes: cmdInserir (linha nova em xOpe, Space(10)), cmdExcluir (apaga a
*   linha corrente de xOpe), cmdSair ("Confirmar" - SE GravaDados, valida
*   duplicata de Itras, apaga TODAS as linhas de SigOpTrp desta operacao e
*   regrava uma por xOpe.Itras nao-vazio, reabilita o pai e libera o
*   dialogo) e Cancela (so reabilita o pai e libera o dialogo, sem gravar).
*
*   No migrado, o form roda com DataSession = 1 (sessao CORRENTE,
*   compartilhada), reproduzindo o mesmo efeito do "Set DataSession To
*   pnDataSes" sem a troca manual de sessao - mesmo padrao adotado nos
*   dialogos irmaos desta familia (FormSigOpTrf.prg/FormSigOpTop.prg/
*   FormSIGOPTOR.prg/FormSigOpTot.prg). O codigo da operacao
*   (crSigCdOpe.Dopes) eh passado explicitamente pelo chamador, em vez de
*   lido direto de um cursor do pai (PILAR 3 - o BO consulta SQL Server
*   direto, nao reusa cursor do form pai) - mesma decisao documentada no
*   cabecalho de FormSigOpTrf.prg.
*
*   "PROCEDURE Load" do legado ("=fConfigGeral()") fica de fora: no
*   Fortyus era inicializacao GLOBAL da aplicacao, ja coberta pelo startup
*   do sistema novo (config.prg) - mesma decisao documentada no cabecalho
*   de SigOpTrfBO.prg/SigOpTopBO.prg (familia SigOp*).
*
* CHAMADA (equivale ao "Do Form Sigoptrp With ThisForm, ThisForm.
* DataSessionId" do legado, onde o proprio form pai eh "poForm" e
* "crSigCdOpe.Dopes" vem da linha corrente da Lista do pai):
*   loForm = CREATEOBJECT("FormSigoptrp", THISFORM, loc_cOperacaoAtual, ;
*       THISFORM.DataSessionId)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()          && modal: so volta quando o dialogo fecha
*   ENDIF
*
*   Como no legado, o Release eh do PROPRIO dialogo (botao Confirmar/
*   Cancelar, fase futura), nao do chamador.
*
* PARAMETROS DO INIT (legado: LParameters poForm, pnDataSes)
*   par_oFormPai         - legado: poForm/ThisForm.ParentForm (property
*                          CUSTOM da classe - RESERVED3/ClassInfo do dump
*                          lista "parentform" como custom property, NAO a
*                          nativa de container MDI). Form pai SigCdOpe
*                          (Cadastro de Operacoes do Caixa), que precisa
*                          expor .Enabled - desabilitado enquanto este
*                          dialogo esta aberto (legado: .ParentForm.
*                          Enabled = .f.), reabilitado ao sair.
*   par_cDopes           - legado: crSigCdOpe.Dopes, lido direto do cursor
*                          do pai (ja na DataSession dele). Como o migrado
*                          nao troca de DataSession, o codigo da operacao
*                          e passado explicitamente pelo chamador.
*   par_nDataSessionPai  - legado: pnDataSes. Informativo - DataSession = 1
*                          ja unifica a sessao com o pai; mantido so para
*                          auditoria/paridade com o legado.
*
* METODOS DE DADOS (ja implementados no BO - fases 1-2, ver cabecalho de
* SigoptrpBO.prg para o detalhamento completo): CarregarDoCursor/
* ObterChavePrimaria/Inserir/ApagarItensDaOperacao/CarregarItens/
* FecharCursoresTrabalho. NAO sobrescreve Atualizar() nem
* ExecutarExclusao(): nao ha alteracao nem exclusao unitaria no legado - a
* remocao de uma linha e so o efeito colateral de ela nao ser reinserida
* no lote seguinte, igual ao SigOpTrfBO.
*
* FASE 8 (esta fase): "Eventos Auxiliares e Consolidacao Final" - NAO SE
* APLICA ao roteiro generico de CRUD Lista/Dados deste pipeline, pela MESMA
* razao estrutural ja registrada na FASE 5 abaixo: este dialogo e FLAT
* (sem PageFrame Lista/Dados) e nao tem modos INCLUIR/ALTERAR/VISUALIZAR -
* so edita uma grade local (xOpe) e persiste em lote ao Confirmar. O
* roteiro padrao da Fase 8 pede 8 itens; cada um foi conferido contra o
* dump (Sigoptrp_form_codigo_fonte.txt) e contra o que as Fases 3-7 JA
* entregaram:
*
*   | item do roteiro            | por que nao se aplica / onde ja esta |
*   |-----------------------------|----------------------------------------|
*   | BtnBuscarClick()            | NAO HA botao de busca/filtro no dump (so cmdInserir/cmdExcluir/cmdSair/Cancela) - inventar violaria a REGRA FUNDAMENTAL (proibido inventar funcionalidade) |
*   | BtnEncerrarClick()          | NAO HA botao "Encerrar" - a saida sem gravar e o Cancela ("Cancelar"), ja implementado como BtnCancelarClick() (Fase 7) |
*   | BtnSalvarClick()            | equivalente real e BtnSairClick() (cmdSair, Caption "\<Confirmar") - Fase 7. Nome generico nao foi criado porque o legado chama esse botao "cmdSair", nao "cmdSalvar"/"cmdGravar" (regra do pipeline sobre handler nomeado pela ACAO, nao pelo nome do objeto legado, se aplica ao INVERSO aqui: o botao JA tem nome de acao verdadeiro no dump) |
*   | FormParaBO()/BOParaForm()   | NAO HA um unico "registro corrente" editado por TextBoxes de pagina Dados (perfil GRADE+BOTOES, nao DESPACHANTE - ver FASE 5). O mapeamento linha-a-linha equivalente e GravarUmaTransportadora() (Fase 7: Form -> BO) e SigoptrpBO.CarregarDoCursor() (BO: cursor -> BO, Fases 1-2) |
*   | HabilitarCampos()           | NAO HA modos de tela (sem INCLUIR/ALTERAR/VISUALIZAR): Column1 (Itras) e SEMPRE editavel e Column2 (Razaos) e SEMPRE ReadOnly, fixado em AplicarFormatoGrade (Fase 4) - igual ao legado, que tambem nao alterna isso em runtime |
*   | LimparCampos()              | NAO HA pagina de dados para limpar. Limpar uma linha e CmdExcluirClick() (apaga a linha da grade); limpar a tela toda e o proprio fechamento do dialogo (BtnSairClick/BtnCancelarClick), que nunca reabre sem recriar o form - mesmo raciocinio do irmao FormSigOpTrf.prg |
*   | CarregarLista()             | JA EXISTE (Fase 4) - funil de carga do grid a partir de SigoptrpBO.CarregarItens() |
*   | AjustarBotoesPorModo()      | NAO HA modo de tela (ver HabilitarCampos acima); os 4 botoes ficam SEMPRE habilitados, igual ao legado (nenhum Enabled condicional no dump) |
*
*   Reinventar esses 8 nomes so para "cumprir o roteiro" seria a mesma
*   violacao que a FASE 5 ja evitou: inventar UI/API que o legado nao tem
*   (REGRA FUNDAMENTAL) e criar alias morto de CRUD sob nome enganoso
*   (regra do pipeline sobre alias CRUD disparando transacao real sob nome
*   que ninguem chama).
*
*   Validado por compilacao limpa (COMPILE sem .err gerado) de
*   FormSigoptrp.prg e SigoptrpBO.prg - prova de sintaxe apos a
*   consolidacao desta fase.
*
* FASE 7: eventos principais dos 4 botoes (cmdInserir/
* cmdExcluir/cmdSair/Cancela)
*
*   | metodo                       | conteudo |
*   |------------------------------|----------|
*   | ConfigurarBINDEVENTs()       | liga os 4 Click (regra #3 - BINDEVENT so com metodo PUBLIC) |
*   | MarcarDadosAlterados()       | legado: ThisForm.GravaDados = .t. - sincroniza Form + BO |
*   | CmdInserirClick()            | cmdInserir.Click: linha em branco em xOpe + foco na coluna Itras |
*   | CmdExcluirClick()            | cmdExcluir.Click: apaga a linha corrente de xOpe |
*   | BtnSairClick()                | cmdSair.Click ("Confirmar"): valida duplicata, regrava o lote, fecha |
*   | PersistirItens()             | PROTECTED, corpo do "apaga tudo e reinsere" do Confirmar |
*   | GravarUmaTransportadora()    | PROTECTED, NovoRegistro()+Salvar() por linha nao-vazia (regra #51) |
*   | BtnCancelarClick()           | Cancela.Click: fecha sem gravar |
*
*   NAO ha BtnIncluirClick()/BtnAlterarClick()/BtnVisualizarClick()/
*   BtnExcluirClick() (nomenclatura generica de CRUD Lista/Dados): este
*   dialogo NAO tem CRUD, Alterar nem Visualizar - o dump legado so
*   prova os 4 botoes acima (cmdInserir/cmdExcluir sao toolbar de LINHA
*   da grade, cmdSair/Cancela sao saida), igual ao irmao
*   FormSigOpTrf.prg. Inventar os 4 metodos genericos delegando para
*   estes 4 reais violaria a regra do pipeline sobre alias CRUD que
*   dispara transacao real sob nome enganoso (aqui NENHUM dos 4 nomes
*   genericos corresponde a um botao de verdade, entao nem o alias
*   inerte se justifica - eh pura invencao de API que o legado nao tem).
*
*   cmdInserir/cmdExcluir usam o prefixo "Cmd" (nao "Btn"), mesma
*   convencao do irmao FormSigOpTrf.prg (CmdInserirClick/CmdExcluirClick
*   la tambem operam linha de grade, nao CRUD). cmdSair ("Confirmar") e
*   Cancela ("Cancelar") usam o prefixo "Btn" (BtnSairClick no irmao;
*   BtnCancelarClick aqui existe porque, diferente do irmao, este
*   dialogo TEM um botao Cancelar de verdade no dump).
*
*   DUPLICATA (so neste form - o irmao nao tem): "Select Itras, Sum(1)
*   ... Group By 1 ... Having Sum(1) > 1" aborta o Confirmar com
*   MessageBox ANTES de tocar no banco - "Return .f." no legado, que
*   SAI do metodo sem reabilitar o pai nem fechar o dialogo (regra #17 -
*   transcrever o early-exit, nao so a mensagem).
*
*   "GravaDados = .t." no cmdExcluir.Click do legado fica FORA do "If
*   Not Eof()" - sempre marcado, mesmo clicando Excluir com a grade
*   vazia (regra #17 - nao "corrigir" a assimetria do legado).
*
* FASE 6: lookup de celula da coluna "Transportadora"
*
*   | metodo                   | conteudo |
*   |--------------------------|----------|
*   | GuardarItrasAnterior()   | PUBLIC, legado: GradeOpe.Column1.Text1.When -> Thisform.AntValue = This.Value |
*   | ValidarItrasGridExec()   | PUBLIC, legado: Column1.Text1.Valid - vazio limpa, senao delega ao lookup |
*   | AbrirLookupItras()       | PUBLIC, funil com guarda de reentrancia (regra #47) |
*   | AbrirLookupItrasExec()   | PROTECTED, fwbuscaext em SigPrTrp -> FormBuscaAuxiliar (regra #37) |
*
*   TextBoxTransportadoraTrp_4c (classes\textboxgridlookup.PRG) instalada em
*   Column1 por AplicarFormatoGrade (AddObject + CurrentControl + Sparse,
*   regra #18/#46) - When/Valid/KeyPress(F4,F5)/DblClick da classe delegam
*   para os 4 metodos acima. Sem recusa de duplicata (diferente do irmao
*   TextBoxOperacaoTrf_4c de FormSigOpTrf): o legado deste dialogo nao
*   confere Itras repetido entre as linhas de xOpe.
*
* FASE 4: a grade + os 4 botoes + carga inicial
*
*   | metodo                | conteudo |
*   |------------------------|----------|
*   | ConfigurarGrade()      | grd_4c_Dados (GradeOpe) - so o que nao depende de dado (regra #41) |
*   | AplicarFormatoGrade()  | PUBLIC, FONTE UNICA de Column.Width/Header1.Caption - reaplicada por CarregarLista (Problema 48) |
*   | ConfigurarBotoes()     | cmd_4c_CmdInserir/CmdExcluir/CmdSair/Cancela, nesta ordem (dump) |
*   | CarregarLista()        | PUBLIC, funil: BO.CarregarItens() + bind do grid + GO TOP + Refresh |
*
*   grd_4c_Dados eh EDITAVEL (sem ReadOnly = .T. no grid nem na Column1 -
*   diferente do irmao SOMENTE LEITURA FormSigOpTop): cmdInserir insere
*   linha em branco e o usuario digita o codigo da transportadora
*   (Column1/Itras). Column2 (Razaos) recebe .ReadOnly = .T.: o legado
*   bloqueia a edicao com "Column2.Text1.When / Return .f." - efeito
*   estrutural equivalente, sem calculo nenhum ali (mesmo raciocinio do
*   col_dpros de FormSigOpTrf).
*
*   Header1.ForeColor = RGB(36, 84, 155) nas DUAS colunas eh TRANSCRITO do
*   dump (Sigoptrp_form_codigo_fonte.txt declara ForeColor = 36,84,155 nos
*   dois Header1) - NAO eh o canonico cinza (90,90,90) que se usa quando o
*   dump OMITE a propriedade (regra #12); aqui o legado declara
*   explicitamente, e o literal prevalece.
*
*   Os 4 botoes (cmdInserir/cmdExcluir/cmdSair/Cancela) sao fwbtng no SCX
*   (Width/Height nao constam do dump - canonico 75x75 de icone 60px,
*   mesma convencao dos irmaos desta familia). 725 + 75 = 800 = Form.Width
*   (fecha exatamente na borda). Todos ficam dentro da faixa do cabecalho
*   (Top 4..79, dentro de Top 0..80 de cnt_4c_Cabecalho) e por isso sao
*   criados DEPOIS dela em InicializarForm, igual ao SCX (regra #11).
*
*   NENHUM BINDEVENT de Click nesta fase: ControlBox = .F. mas sem
*   Closable/MinButton declarados (regra closable_inventado_tira_a_unica_
*   saida), o Alt+F4 continua disponivel como saida enquanto os botoes nao
*   estao cablados - mesma decisao do irmao FormSigOpTrf (que tem mais de
*   um botao). cmd_4c_Cancela.Cancel = .T. (transcrito do dump) so ativa o
*   ESC quando o Click correspondente existir (Fase 7); nao chama Click
*   nenhum por si so.
*
*   A carga inicial (CarregarLista) e pulada em modo teste/validacao de UI
*   (padrao FormSigOpTrf/FormSigOpTop): sem gnConnHandle nem operacao, a
*   consulta so produziria ruido de erro no log do harness. O grid fica
*   vazio, com as colunas ja formatadas por AplicarFormatoGrade.
*
* FASE 5: NAO SE APLICA a este form - sem stub vazio
*   O roteiro padrao pede ConfigurarPaginaDados() com cnt_4c_Cabecalho +
*   metade dos TextBoxes/Labels da Page2. Este form NAO TEM Page2/PageFrame
*   (eh FLAT, igual ao legado - zero "BaseClass: pageframe" no dump,
*   confirmado em layout.json/totalObjects=15) e o SCX nao declara NENHUM
*   TextBox FORA da grade: os 15 objetos do dump
*   (Sigoptrp_form_codigo_fonte.txt / layout.json) sao cntSombra + 2
*   labels, GradeOpe (2 Column, cada uma so com Header1+Text1) e os 4
*   botoes (cmdInserir/cmdExcluir/cmdSair/Cancela) - confirmado tambem em
*   analise.json ("campos": []). Os unicos controles de entrada de dado
*   sao os Text1 de GradeOpe.Column1/Column2 (Itras/Razaos), com Parent
*   terminando em ".ColumnN" (perfil GRADE+BOTOES, nao DESPACHANTE) - ja
*   criados em ConfigurarGrade/AplicarFormatoGrade, Fase 4, nao TextBoxes
*   soltos numa pagina de dados.
*
*   Repetir o roteiro aqui seria (a) duplicar cnt_4c_Cabecalho, que
*   ConfigurarPageFrame ja criou -> "object already exists" (regra #11/
*   CLAUDE.md), e (b) inventar campos digitaveis que o legado nao tem
*   (REGRA FUNDAMENTAL - proibido inventar UI). Um metodo
*   ConfigurarPaginaDados() vazio so para "cumprir o roteiro" seria o stub
*   disfarcado que a regra de completude proibe. Mesma decisao documentada
*   no cabecalho de FormSigOpTrf.prg/FormSigOpTop.prg (familia SigOp*).
*
* FASE 3: estrutura base do form
*   - Propriedades que espelham o contexto recebido do form pai
*     (this_oFormPai/this_cDopes/this_nDataSessionPai), o estado dos
*     lookups de celula (Fase 6 - this_cValorAnteriorItras/
*     this_lEmLookupItras) e o estado de edicao (Fase 7/8 -
*     this_lDadosAlterados, FONTE UNICA no FORM, nao no BO - mesma razao
*     documentada no cabecalho de FormSigOpTrf.prg: BusinessBase.
*     NovoRegistro()/Salvar() zerariam o flag do BO no meio do proprio
*     lote de gravacao).
*   - Init (LParameters do legado, com 1 parametro extra - par_cDopes -
*     mesma convencao do irmao FormSigOpTrf.prg) + ValidarParametros
*     (precondicao: sem form pai e sem operacao de origem nao ha o que
*     editar).
*   - InicializarForm (cria o BO, desabilita o form pai, monta o Caption,
*     aplica o fundo e cria o cabecalho cinza). Grade/botoes/carga agora na
*     Fase 4 (ver acima).
*   - CarregarContextoFormPai (legado: .ParentForm.Enabled = .f.).
*   - ConfigurarDecoracao (Picture do form - new_background.jpg).
*   - ConfigurarPageFrame (cntSombra do legado -> cnt_4c_Cabecalho; nome do
*     metodo mantido por paridade com os demais dialogos filhos desta
*     familia, mesmo sem PageFrame real: este form eh FLAT, igual ao
*     legado - SIGOPTRP nao tem PageFrame no SCX, so form + cntSombra +
*     1 grid + 4 botoes).
*   - TornarControlesVisiveis / Destroy (reabilita o form pai ao fechar -
*     rede de seguranca, igual ao cmdSair.Click do legado; fecha tambem o
*     cursor de trabalho do BO, se ja estiver aberto).
*==============================================================================

DEFINE CLASS FormSigoptrp AS FormBase

    *--------------------------------------------------------------------------
    * CONTEXTO RECEBIDO DO FORM PAI (LParameters do Init legado)
    *--------------------------------------------------------------------------

    *-- poForm / ThisForm.ParentForm do legado - o form SigCdOpe (Cadastro
    *-- de Operacoes do Caixa) que abriu este dialogo
    this_cMensagemErro = ""
    this_oFormPai = .NULL.

    *-- crSigCdOpe.Dopes do legado - codigo da operacao cujas
    *-- transportadoras habilitadas serao editadas. Repassado ao BO em
    *-- InicializarForm (THIS.this_oBusinessObject.this_cDopes)
    this_cDopes = ""

    *-- pnDataSes do legado - informativo (DataSession = 1 ja unifica a
    *-- sessao com o pai, ver comentario de DataSession abaixo)
    this_nDataSessionPai = 0

    *--------------------------------------------------------------------------
    * ESTADO DO LOOKUP DE CELULA (FASE 6) - ver AplicarFormatoGrade
    * (instalacao do TextBox customizado) e os metodos GuardarItrasAnterior/
    * ValidarItrasGridExec/AbrirLookupItras/AbrirLookupItrasExec.
    *--------------------------------------------------------------------------

    *-- Legado: Thisform.AntValue - snapshot do valor da celula
    *-- "Transportadora" ANTES da edicao (GradeOpe.Column1.Text1.When),
    *-- usado pela validacao para saber se o usuario realmente mudou o
    *-- codigo digitado
    this_cValorAnteriorItras = ""

    *-- Guarda de reentrancia (regra #47): o picker eh MODAL, tira o foco
    *-- da celula e redispara o proprio Valid/KeyPress que o chamou
    this_lEmLookupItras = .F.

    *--------------------------------------------------------------------------
    * ESTADO DE EDICAO (FASE 7/8)
    *--------------------------------------------------------------------------

    *-- Legado: ThisForm.GravaDados (property customizada do SCX - ver
    *-- RESERVED3/ClassInfo no fim do dump: antvalue/gravadados/
    *-- parentform/podatamgr). Ligada por TODO caminho que muda a lista de
    *-- transportadoras (os 2 botoes de grade e o Valid da celula) e LIDA
    *-- pelo cmdSair.Click ("If ThisForm.GravaDados") para decidir se o
    *-- lote precisa ser regravado.
    *--
    *-- DECLARACAO OBRIGATORIA, nao decorativa (mesmo raciocinio do
    *-- cabecalho de FormSigOpTrf.prg): a property do FORM eh a fonte da
    *-- verdade, NAO a do BO (this_oBusinessObject.this_lDadosAlterados) -
    *-- BusinessBase.NovoRegistro()/Salvar() zerariam a do BO a cada linha
    *-- gravada, perdendo o flag no meio do proprio lote de gravacao em
    *-- lote do Confirmar.
    this_lDadosAlterados = .F.

    *--------------------------------------------------------------------------
    * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
    *--------------------------------------------------------------------------

    *-- SIGOPTRP: BorderStyle = 2 / Height = 400 / Width = 800 /
    *-- DoCreate = .T. (default do Form, nao precisa declarar)
    BorderStyle = 2
    Height      = 400
    Width       = 800

    *-- Caption do SCX ("Tabelas de Desconto" - literal estatico do Form
    *-- Designer, nunca chega a ser exibido) - sobrescrito em
    *-- InicializarForm com o codigo da operacao, igual ao legado
    *-- (.Caption = 'Transportadoras ' + AllTrim(crSigCdOpe.Dopes))
    Caption = "Tabelas de Desconto"

    *-- ControlBox = .F. / Movable = .F. / TitleBar = 0 / ClipControls = .F.
    *-- - literais do dump. MaxButton/Closable/MinButton NAO declarados no
    *-- SCX -> NAO inventar (regra closable_inventado_tira_a_unica_saida):
    *-- o default .T. deixa o Alt+F4 funcionando, que eh uma das saidas
    *-- alem do Confirmar/Cancelar (sem barra de titulo nao ha X na
    *-- janela, so o ControlBox = .F. remove o icone de sistema)
    ControlBox   = .F.
    Movable      = .F.
    TitleBar     = 0
    ClipControls = .F.

    *-- AutoCenter = .T. do SCX - centraliza na tela, sem calculo manual
    *-- de posicao relativa ao pai
    AutoCenter = .T.

    *-- WindowType = 1 (modal): o pai abre este dialogo e precisa que o
    *-- Show() bloqueie ate o usuario Confirmar/Cancelar (legado:
    *-- .ParentForm.Enabled = .f. enquanto este form esta aberto, emulando
    *-- modalidade)
    WindowType = 1

    *-- ShowWindow = 1 ("In Top-Level Form"): canonico do projeto
    ShowWindow = 1

    *-- Fonte base (os controles do cabecalho declaram a propria fonte -
    *-- Tahoma 16 - transcrita em ConfigurarPageFrame)
    FontName = "Tahoma"
    FontSize = 8

    *-- DataSession = 1 (sessao CORRENTE, NAO privada). O legado declara
    *-- DataSession = 2 no SCX mas o proprio Init sobrescreve com "Set
    *-- DataSession To pnDataSes", ou seja: na pratica este dialogo roda
    *-- SEMPRE na sessao do form pai. DataSession = 1 eh a reproducao
    *-- direta desse resultado, sem a troca manual de sessao - mesmo
    *-- padrao adotado em FormSigOpTrf.prg/FormSigOpTop.prg/
    *-- FormSIGOPTOR.prg/FormSigOpTot.prg
    DataSession = 1

    *==========================================================================
    * Init - LParameters poForm, pnDataSes do legado (com 1 parametro
    * extra - par_cDopes - necessario porque o migrado nao troca de
    * DataSession para ler crSigCdOpe.Dopes direto do cursor do pai; mesma
    * convencao dos dialogos irmaos desta familia).
    *==========================================================================
    PROCEDURE Init
        LPARAMETERS par_oFormPai, par_cDopes, par_nDataSessionPai

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        THIS.this_cDopes          = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")
        THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSessionPai) = "N", par_nDataSessionPai, 0)

        *-- DODEFAULT chama FormBase.Init (fix SET DATE/CENTURY) e em
        *-- seguida THIS.InicializarForm()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ValidarParametros - precondicao deste dialogo: sem form pai nao ha
    * quem reabilitar, e sem operacao nao ha transportadora nenhuma para
    * editar (o legado tambem depende dessas referencias em todo o Init -
    * crSigCdOpe.Dopes/ThisForm.ParentForm.*).
    *
    * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
    * de fora, e PROTECTED faria a chamada externa estourar em runtime.
    *
    * Bypass em modo teste/validacao de UI no TOPO: o ValidarUIFidelity e o
    * TesteAutomatico instanciam o form SEM ARGUMENTO NENHUM, e sem o
    * bypass a instanciacao reprovaria sempre.
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
            MsgErro("Esta tela s" + CHR(243) + " pode ser aberta a partir do " + ;
                    "Cadastro de Opera" + CHR(231) + CHR(245) + "es do Caixa.", ;
                    "Transportadoras")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(THIS.this_cDopes)
            MsgErro("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada.", ;
                    "Transportadoras")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * InicializarForm - estrutura base do dialogo
    *
    * Hook chamado pelo FormBase.Init. Retorna .T. em sucesso e .F. em falha
    * (nesse caso o CREATEOBJECT do chamador devolve logico, nao objeto).
    *
    * Grade/botoes/carga inicial ficam para a Fase 4 (os metodos
    * ConfigurarGradeOperacoes/ConfigurarBotoes/CarregarLista ainda nao
    * existem nesta fase) - a Fase 4 acrescenta as chamadas correspondentes
    * aqui, apos THIS.ConfigurarPageFrame().
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
            *-- Business Object das Fases 1-2
            THIS.this_oBusinessObject = CREATEOBJECT("SigoptrpBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigoptrpBO.", "Transportadoras")
            ELSE
                *-- Contexto no BO (operacao - this_cDopes do BO eh a
                *-- mesma property declarada em SigoptrpBO.prg)
                THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes

                *-- Legado: .ParentForm.Enabled = .f.
                THIS.CarregarContextoFormPai()

                *-- Legado: .Caption = 'Transportadoras ' +
                *-- AllTrim(crSigCdOpe.Dopes)
                THIS.Caption = "Transportadoras " + ALLTRIM(THIS.this_cDopes)

                THIS.this_oBusinessObject.this_cTituloDialogo = THIS.Caption

                *-- Fundo do form (Picture do SCX)
                THIS.ConfigurarDecoracao()

                *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO
                *-- AddObject do form, igual ao SCX
                THIS.ConfigurarPageFrame()

                *-- GradeOpe, depois os 4 botoes - nesta ordem (dump).
                *-- Os botoes ficam DENTRO da faixa do cabecalho
                *-- (Top 4..79) e por isso sao criados DEPOIS dela
                THIS.ConfigurarGrade()
                THIS.ConfigurarBotoes()

                *-- FASE 7: Click dos 4 botoes. DEPOIS dos AddObject -
                *-- sem o controle criado, o BINDEVENT estouraria no bind
                THIS.ConfigurarBINDEVENTs()

                *-- AddObject cria controle com Visible = .F.
                THIS.TornarControlesVisiveis(THIS)

                *-- Legado: o Init termina consultando SigOpTrp/SigPrTrp e
                *-- ligando a grade ao resultado. Pulado em modo
                *-- teste/validacao de UI (padrao FormSigOpTrf/
                *-- FormSigOpTop): la nao ha gnConnHandle nem operacao,
                *-- entao a carga so produziria ruido de erro no log do
                *-- harness. A grade fica vazia, com as colunas ja
                *-- formatadas por AplicarFormatoGrade. O harness chama
                *-- CarregarLista de fora quando quer exercita-la
                IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) AND ;
                   !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar FormSigoptrp: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarContextoFormPai - migra para o form o que o Init legado faz
    * com o form pai:
    *
    *     ThisForm.ParentForm = poForm
    *     ThisForm.ParentForm.Enabled = .f.
    *
    * (crSigCdOpe.Dopes ja foi recebido via parametro no Init deste form -
    * ver cabecalho do arquivo). Protegido por PEMSTATUS/VARTYPE: em modo
    * teste (gb_4c_ModoTeste/gb_4c_ValidandoUI) o form pai pode ser .NULL.
    * ou um stub sem essa property, e a ausencia aqui NAO eh falha de
    * inicializacao (ValidarParametros ja fez o bypass acima).
    *==========================================================================
    PROTECTED PROCEDURE CarregarContextoFormPai
        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = .F.
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarDecoracao - Picture do form (new_background.jpg do legado)
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
    * ConfigurarPageFrame - cntSombra do legado -> cnt_4c_Cabecalho. Nome do
    * metodo mantido por paridade com os demais dialogos filhos desta
    * familia (FormSigOpTrf.prg/FormSigOpTop.prg/FormSIGOPTOR.prg/
    * FormSigOpTot.prg usam o mesmo nome), mesmo sem PageFrame real - este
    * form eh FLAT, igual ao legado (SIGOPTRP nao tem PageFrame no SCX).
    *
    * Transcricao do dump (Sigoptrp_form_codigo_fonte.txt):
    *   cntSombra  Top=0  Left=-1  Width=800  Height=80  BorderWidth=0
    *              BackColor=100,100,100
    *   lblSombra  Top=25 Left=10 Width=769 Height=40 ForeColor=0,0,0
    *              Tahoma 16 bold, FontUnderline=.F., WordWrap=.T.,
    *              Alignment=0, BackStyle=0
    *   lblTitulo  Top=24 Left=10 Width=769 Height=46 ForeColor=255,255,255
    *              Tahoma 16 bold, WordWrap=.T., Alignment=0, BackStyle=0
    *
    * O Init legado sobrescreve os dois Caption com ThisForm.Caption
    * ("Transportadoras <operacao>"), por isso .Caption = THIS.Caption
    * (dinamico) - o literal do dump ("Cadastro de Testes") eh so o default
    * do Form Designer, nunca chega a ser exibido.
    *
    * Width do container usa THIS.Width (padrao canonico da faixa, regra
    * #11), igual ao literal do dump (800 = Form.Width, sem divergencia
    * aqui - diferente do irmao FormSigOpTrf, onde o SCX declarava o
    * container mais largo que o form). Os labels usam THIS.Width - 20,
    * mesma margem de 10px dos dois lados aplicada pelos irmaos
    * FormSigOpTrf.prg/FormSigOpTop.prg (o literal 769 do dump extrapolaria
    * os 800px do form se usado ao pe da letra com Left=10).
    *
    * AutoSize = .F. explicito nos dois labels: com WordWrap = .T. o
    * AutoSize DESCARTA a Height e colapsa o texto para uma linha (regra
    * #23), e os 40/46 do dump sao o tamanho ja calculado pelo Form
    * Designer.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
        *-- Container da faixa (cntSombra)
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
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
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .AutoSize      = .F.
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 16
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Top           = 25
            .Left          = 10
            .Width         = THIS.Width - 20
            .Height        = 40
            .ForeColor     = RGB(0, 0, 0)
            .Rotation      = 0
            .Visible       = .T.
        ENDWITH

        *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
        *-- aqui porque o container eh OPACO e escuro (excecao prevista na
        *-- regra #12)
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = THIS.Caption
            .Top       = 24
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .ForeColor = RGB(255, 255, 255)
            .Rotation  = 0
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - GradeOpe do legado -> grd_4c_Dados (unica grade
    * desta tela: transportadoras habilitadas para a operacao corrente).
    *
    * Transcricao do dump (SIGOPTRP.GradeOpe):
    *   ColumnCount=2  FontName="Tahoma"  FontSize=8  DeleteMark=.F.
    *   Height=307  Left=236  RowHeight=16  ScrollBars=2  TabIndex=1
    *   Top=87  Width=313  ForeColor=90,90,90  GridLineColor=238,238,238
    *
    * RecordMark = .F. nao consta do dump (legado herda o default): posto
    * pela regra do projeto para grade de form OPERACIONAL criada por
    * AddObject.
    *
    * SEM ReadOnly = .T.: esta grade EH editavel (cmdInserir insere linha
    * em branco, o usuario digita o codigo da transportadora - diferente
    * do irmao FormSigOpTop, somente leitura).
    *
    * So o que NAO depende de dado (regra #41): ControlSource/RecordSource
    * moram em CarregarLista. Column.Width/Header1.Caption moram em
    * AplicarFormatoGrade, chamada ao final.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .ColumnCount   = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Top           = 87
            .Left          = 236
            .Height        = 307
            .Width         = 313
            .RowHeight     = 16
            .ScrollBars    = 2
            .TabIndex      = 1
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .GridLineColor = RGB(238, 238, 238)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        THIS.AplicarFormatoGrade()
    ENDPROC

    *==========================================================================
    * AplicarFormatoGrade - FONTE UNICA da geometria das colunas da grade
    * (regra do Problema 48 - RecordSource zera Column.Width e
    * Header1.Caption, entao este metodo e chamado de novo em
    * CarregarLista, depois do bind).
    *
    * Transcricao do dump:
    *   Column1 (Itras)  - Width=80,  Movable=.F., Resizable=.F., Tahoma 8
    *     Header1  Tahoma 8 Alignment=2 Caption="Transportadora" ForeColor=36,84,155
    *     Text1    BorderStyle=0 Margin=0 ForeColor=90,90,90 BackColor=255,255,255
    *   Column2 (Razaos) - Width=200, Movable=.F., Resizable=.F., Tahoma 8
    *     Header1  Tahoma 8 Alignment=2 Caption="Descricao" ForeColor=36,84,155
    *     Text1    (identico ao da Column1)
    *
    * Column2 recebe .ReadOnly = .T. (grid e Text1): o legado bloqueia a
    * edicao com "Column2.Text1.When / Return .f." - efeito estrutural
    * equivalente, SOMENTE EXIBICAO, nunca persistida em SigOpTrp (so
    * aparece na grade via JOIN com SigPrTrp - ver cabecalho de
    * SigoptrpBO.prg).
    *
    * Header1.ForeColor = RGB(36, 84, 155) nas DUAS colunas eh TRANSCRITO
    * do dump - aqui o legado DECLARA a cor explicitamente, entao o
    * literal prevalece sobre o canonico cinza (90,90,90) que se usa so
    * quando o dump OMITE a propriedade (regra #12).
    *
    * Column1 (Itras) recebe o TextBox customizado de lookup
    * (TextBoxTransportadoraTrp_4c, classes\textboxgridlookup.PRG) via
    * Column.AddObject + CurrentControl + Sparse = .F. (regra #18) -
    * BINDEVENT em evento de celula de Grid nao eh confiavel (regra #46).
    * Guard IF !PEMSTATUS(...) antes do AddObject: este metodo roda de
    * novo em CarregarLista (Problema 48, RecordSource reseta
    * Column.Width/Header1.Caption/CurrentControl) e o 2o AddObject
    * estouraria "Object ... is already defined".
    *
    * Metodo PUBLIC: chamado pela montagem (ConfigurarGrade) E pela
    * recarga (CarregarLista), e o harness de teste o alcanca de fora.
    *==========================================================================
    PROCEDURE AplicarFormatoGrade
        LOCAL loc_lAplicou
        loc_lAplicou = .F.

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            WITH THIS.grd_4c_Dados
                *-- Column1 (Itras) - "Transportadora", EDITAVEL
                .Column1.Width             = 80
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.FontName          = "Tahoma"
                .Column1.FontSize          = 8
                .Column1.Header1.Caption   = "Transportadora"
                .Column1.Header1.FontName  = "Tahoma"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(36, 84, 155)
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.FontName    = "Tahoma"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.ForeColor   = RGB(90, 90, 90)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                *-- Lookup de transportadora (legado: GradeOpe.Column1.
                *-- Text1.Valid/When, fwbuscaext contra SigPrTrp pela chave
                *-- Itras)
                IF !PEMSTATUS(.Column1, "txt_4c_CelItras", 5)
                    .Column1.AddObject("txt_4c_CelItras", "TextBoxTransportadoraTrp_4c")
                ENDIF
                .Column1.CurrentControl = "txt_4c_CelItras"
                .Column1.Sparse         = .F.
                .Column1.ReadOnly       = .F.

                *-- Column2 (Razaos) - "Descricao", SOMENTE EXIBICAO
                *-- (legado: Column2.Text1.When retorna .F.)
                .Column2.Width             = 200
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.FontName          = "Tahoma"
                .Column2.FontSize          = 8
                .Column2.ReadOnly          = .T.
                .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                .Column2.Header1.FontName  = "Tahoma"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(36, 84, 155)
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ReadOnly    = .T.
                .Column2.Text1.FontName    = "Tahoma"
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.ForeColor   = RGB(90, 90, 90)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            loc_lAplicou = .T.
        ENDIF

        RETURN loc_lAplicou
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - cmdInserir/cmdExcluir/cmdSair/Cancela do legado,
    * nesta ordem (dump).
    *
    * Transcricao do dump (Width/Height nao constam - vem da classe fwbtng,
    * canonico 75x75 de icone 60px, mesma convencao dos irmaos desta
    * familia): 725 + 75 = 800 = Form.Width (fecha exatamente na borda).
    *
    *   cmdInserir  Top=4 Left=500 Picture=cadastro_inserir_60.jpg  Caption="\<Inserir"  TabIndex=4
    *   cmdExcluir  Top=4 Left=575 Picture=cadastro_excluir_60.jpg  Caption="\<Excluir"  TabIndex=2
    *   cmdSair     Top=4 Left=650 Picture=cadastro_salvar_60.jpg   Caption="\<Confirmar" TabIndex=7
    *   Cancela     Top=4 Left=725 Picture=cadastro_cancelar_60.jpg Caption="Cancelar"   Cancel=.T. TabIndex=8
    *
    * Todos os 4 ficam dentro da faixa do cabecalho (Top 4..79, dentro de
    * Top 0..80 de cnt_4c_Cabecalho) e por isso sao criados DEPOIS dela em
    * InicializarForm, igual ao SCX (regra #11).
    *
    * Themes = .T. + DisabledPicture: standalone CommandButton com Picture
    * exige isso para desenhar o icone (regra #99). Picture so eh
    * atribuido se o arquivo existir - .Picture inexistente falha em
    * SILENCIO (regra #25).
    *
    * cmd_4c_Cancela.Cancel = .T. eh transcrito do dump, mas so ativa o ESC
    * de fato quando o Click correspondente existir (Fase 7) - sem
    * BINDEVENT, a propriedade por si so nao chama Click nenhum.
    *
    * NENHUM BINDEVENT de Click aqui - fica para a Fase 7 (ver cabecalho
    * do arquivo). ControlBox = .F. mas sem Closable/MinButton declarados
    * (regra closable_inventado_tira_a_unica_saida): o Alt+F4 continua
    * disponivel como saida enquanto os botoes nao estao cablados.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
        LOCAL loc_cIconeInserir, loc_cIconeExcluir, loc_cIconeConfirmar, loc_cIconeCancelar
        loc_cIconeInserir   = ""
        loc_cIconeExcluir   = ""
        loc_cIconeConfirmar = ""
        loc_cIconeCancelar  = ""

        IF TYPE("gc_4c_CaminhoIcones") = "C"
            loc_cIconeInserir   = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            loc_cIconeExcluir   = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            loc_cIconeConfirmar = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            loc_cIconeCancelar  = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
        ENDIF

        *-- cmdInserir -> cmd_4c_CmdInserir (linha nova em xOpe)
        THIS.AddObject("cmd_4c_CmdInserir", "CommandButton")
        WITH THIS.cmd_4c_CmdInserir
            .Top          = 4
            .Left         = 500
            .Width        = 75
            .Height       = 75
            .Caption      = "\<Inserir"
            .TabIndex     = 4
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .FontBold     = .T.
            .FontItalic   = .T.
            .WordWrap     = .T.
            .AutoSize     = .F.
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .MousePointer = 15
            .Themes       = .T.

            IF !EMPTY(loc_cIconeInserir) AND FILE(loc_cIconeInserir)
                .Picture         = loc_cIconeInserir
                .DisabledPicture = loc_cIconeInserir
                .PicturePosition = 13
            ENDIF

            .Visible = .T.
        ENDWITH

        *-- cmdExcluir -> cmd_4c_CmdExcluir (apaga a linha corrente de xOpe)
        THIS.AddObject("cmd_4c_CmdExcluir", "CommandButton")
        WITH THIS.cmd_4c_CmdExcluir
            .Top          = 4
            .Left         = 575
            .Width        = 75
            .Height       = 75
            .Caption      = "\<Excluir"
            .TabIndex     = 2
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .FontBold     = .T.
            .FontItalic   = .T.
            .WordWrap     = .T.
            .AutoSize     = .F.
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .MousePointer = 15
            .Themes       = .T.

            IF !EMPTY(loc_cIconeExcluir) AND FILE(loc_cIconeExcluir)
                .Picture         = loc_cIconeExcluir
                .DisabledPicture = loc_cIconeExcluir
                .PicturePosition = 13
            ENDIF

            .Visible = .T.
        ENDWITH

        *-- cmdSair ("Confirmar") -> cmd_4c_CmdSair (grava o lote)
        THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
        WITH THIS.cmd_4c_CmdSair
            .Top          = 4
            .Left         = 650
            .Width        = 75
            .Height       = 75
            .Caption      = "\<Confirmar"
            .TabIndex     = 7
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .FontBold     = .T.
            .FontItalic   = .T.
            .WordWrap     = .T.
            .AutoSize     = .F.
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .MousePointer = 15
            .Themes       = .T.

            IF !EMPTY(loc_cIconeConfirmar) AND FILE(loc_cIconeConfirmar)
                .Picture         = loc_cIconeConfirmar
                .DisabledPicture = loc_cIconeConfirmar
                .PicturePosition = 13
            ENDIF

            .Visible = .T.
        ENDWITH

        *-- Cancela -> cmd_4c_Cancela (so reabilita o pai e libera o dialogo)
        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top          = 4
            .Left         = 725
            .Width        = 75
            .Height       = 75
            .Caption      = "Cancelar"
            .Cancel       = .T.
            .TabIndex     = 8
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .FontBold     = .T.
            .FontItalic   = .T.
            .WordWrap     = .T.
            .AutoSize     = .F.
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .MousePointer = 15
            .Themes       = .T.

            IF !EMPTY(loc_cIconeCancelar) AND FILE(loc_cIconeCancelar)
                .Picture         = loc_cIconeCancelar
                .DisabledPicture = loc_cIconeCancelar
                .PicturePosition = 13
            ENDIF

            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - liga os 4 Click que a Fase 4 ainda nao ligava
    * (cmdInserir/cmdExcluir/cmdSair/Cancela). Chamado em InicializarForm
    * DEPOIS de ConfigurarBotoes - BINDEVENT com objeto inexistente estoura
    * no proprio bind.
    *
    * Handlers PUBLIC (regra #3): PROTECTED faz BINDEVENT falhar em
    * SILENCIO.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs
        BINDEVENT(THIS.cmd_4c_CmdInserir, "Click", THIS, "CmdInserirClick")
        BINDEVENT(THIS.cmd_4c_CmdExcluir, "Click", THIS, "CmdExcluirClick")
        BINDEVENT(THIS.cmd_4c_CmdSair,    "Click", THIS, "BtnSairClick")
        BINDEVENT(THIS.cmd_4c_Cancela,    "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *==========================================================================
    * CarregarLista - funil de carga da grade. Reproduz o trecho final do
    * Init legado:
    *
    *     With Thisform.GradeOpe
    *         .RecordSource          = 'xOpe'
    *         .Column1.ControlSource = 'xOpe.Itras'
    *         .Column2.ControlSource = 'xOpe.Razaos'
    *         .Refresh
    *     EndWith
    *     ... (Select a.*, b.Razaos From SigOpTrp a, SigPrTrp b ... Scan /
    *     Scatter Memvar / Append Blank In xOpe / Gather Memvar) ...
    *     Select xOpe / Set Order to / Go Top
    *     ThisForm.GradeOpe.Refresh
    *
    * A consulta e a expansao moram no BO (SigoptrpBO.CarregarItens, Fases
    * 1-2), que popula this_cCursorItens. Aqui fica o que eh do FORM: o
    * binding, a reaplicacao de formato e a repintura.
    *
    * Tres cuidados do projeto, todos presentes no legado ou exigidos por
    * regra:
    *   1. ColumnCount e RecordSource FORA do WITH (GRID-WITH): acessar
    *      .Column dentro do mesmo WITH que atribui RecordSource estoura
    *      'Unknown member COLUMN1' - mesma cautela dos irmaos desta
    *      familia.
    *   2. AplicarFormatoGrade roda DEPOIS do RecordSource, que zera
    *      Column.Width e Header1.Caption (Problema 48).
    *   3. GO TOP + Refresh no fim (regra #21a): popular/ligar cursor NAO
    *      repinta a grade sozinho - eh o ".Refresh" do With legado.
    *
    * Metodo PUBLIC (regra #3): o harness o chama de FORA da classe, sem
    * argumento algum - a operacao corrente vem de THIS.this_cDopes,
    * guardado no Init.
    *
    * RETURN unico, FORA do TRY/CATCH (regra #1).
    *==========================================================================
    PROCEDURE CarregarLista
        LOCAL loc_lCarregou, loc_cAlias, loc_oErro
        loc_lCarregou = .F.

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_cAlias = THIS.this_oBusinessObject.this_cCursorItens

        IF VARTYPE(loc_cAlias) != "C" OR EMPTY(loc_cAlias)
            RETURN .F.
        ENDIF

        TRY
            *-- Legado: Select a.*, b.Razaos From SigOpTrp a, SigPrTrp b
            *-- Where a.Dopes=... And a.Itras=b.Itras / Scan+Scatter+Append
            IF THIS.this_oBusinessObject.CarregarItens() AND USED(loc_cAlias)

                THIS.grd_4c_Dados.ColumnCount  = 2
                THIS.grd_4c_Dados.RecordSource = loc_cAlias

                WITH THIS.grd_4c_Dados
                    .Column1.ControlSource = loc_cAlias + ".Itras"
                    .Column2.ControlSource = loc_cAlias + ".Razaos"
                ENDWITH

                *-- Reaplica largura/cabecalho, que o RecordSource zerou
                THIS.AplicarFormatoGrade()

                *-- Legado: Select xOpe / Set Order to / Go Top / .Refresh
                SELECT (loc_cAlias)
                GO TOP
                THIS.grd_4c_Dados.Refresh()

                loc_lCarregou = .T.
            ELSE
                *-- Sem dado nao ha binding (regra #41). A mensagem do BO
                *-- so eh exibida quando houve FALHA de verdade: operacao
                *-- sem transportadora nenhuma eh resultado valido
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
                    MsgErro(THIS.this_cMensagemErro, THIS.Caption)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar as transportadoras: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Procedure: " + loc_oErro.Procedure, THIS.Caption)
            loc_lCarregou = .F.
        ENDTRY

        RETURN loc_lCarregou
    ENDPROC

    *==========================================================================
    * GuardarItrasAnterior - snapshot do valor da celula "Transportadora"
    * ANTES da edicao (legado: GradeOpe.Column1.Text1.When -> Thisform.
    * AntValue = This.Value). Usado por ValidarItrasGridExec/pela classe
    * TextBoxTransportadoraTrp_4c (classes\textboxgridlookup.PRG) - nesta
    * tela o valor anterior fica so para paridade estrutural com o legado,
    * ja que o Valid daqui (diferente do irmao SigOpTrf) nao compara
    * contra ele (regra #17 - o legado nao faz essa comparacao aqui).
    *
    * PUBLIC: chamado de fora da classe (THISFORM) pelo TextBox da coluna.
    *==========================================================================
    PROCEDURE GuardarItrasAnterior(par_oTxt)
        IF VARTYPE(par_oTxt) = "O"
            THIS.this_cValorAnteriorItras = par_oTxt.Value
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarItrasGridExec - Valid da celula "Transportadora" (Column1) de
    * grd_4c_Dados. par_oTxt eh o TextBox da coluna (regra #46): dentro do
    * Valid, o valor digitado esta em par_oTxt.Value e AINDA NAO chegou ao
    * cursor.
    *
    * Equivalente ao legado (GradeOpe.Column1.Text1.Valid):
    *   If Not Empty(This.Value)
    *       <lookup fwbuscaext em SigPrTrp, delegado abaixo>
    *   Else
    *       This.Value = ''
    *   EndIf
    *   This.Refresh
    *
    * PUBLIC: chamado de fora da classe pelo TextBox da coluna.
    *==========================================================================
    FUNCTION ValidarItrasGridExec(par_oTxt)
        IF VARTYPE(par_oTxt) != "O"
            RETURN .T.
        ENDIF

        *-- Legado: If Not Empty(This.Value) ... Else This.Value = ''
        IF EMPTY(ALLTRIM(par_oTxt.Value))
            par_oTxt.Value = ""
        ELSE
            THIS.AbrirLookupItras(par_oTxt)
        ENDIF

        *-- Legado: This.Refresh (fora do If/Else, sempre executado)
        par_oTxt.Refresh()

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * AbrirLookupItras - FUNIL do lookup de transportadora. Duas portas de
    * entrada desaguam aqui: o Valid da celula (ValidarItrasGridExec) e o
    * F4/F5/duplo clique (TextBoxTransportadoraTrp_4c.KeyPress/DblClick).
    *
    * Wrapper so para a guarda de reentrancia (regra #47): o picker eh
    * MODAL, tira o foco da celula e redispara o Valid que o chamou. O
    * corpo vive em AbrirLookupItrasExec.
    *
    * PUBLIC: chamado de fora da classe pelo TextBox da coluna.
    *==========================================================================
    PROCEDURE AbrirLookupItras(par_oTxt)
        IF THIS.this_lEmLookupItras
            RETURN
        ENDIF

        THIS.this_lEmLookupItras = .T.
        THIS.AbrirLookupItrasExec(par_oTxt)
        THIS.this_lEmLookupItras = .F.
    ENDPROC

    *==========================================================================
    * AbrirLookupItrasExec - corpo do lookup de transportadora. Equivalente
    * ao legado:
    *
    *   loLista = CreateObject('fwbuscaext', <conn>, 'SigPrTrp',
    *       'CrListaRemota', 'Itras', This.Value, 'Selecao', .t.)
    *   If Not loLista.plAchouRegistro
    *       loLista.mAddColuna('Itras', '', 'Transportadora', .t.)
    *       loLista.mAddColuna('Razaos', '', 'Descricao', .t.)
    *       loLista.Show()
    *   EndIf
    *   This.Value = CrListaRemota.Itras
    *   Replace Razaos with CrListaRemota.Razaos In xOpe
    *   Use In CrListaRemota
    *
    * Migrado: FormBuscaAuxiliar direto contra SigPrTrp (regra #37), que ja
    * tenta o match exato antes de abrir o picker (regra #37 - Init testa
    * this_lAchouRegistro). Achando (exato ou pelo picker), grava o codigo
    * na celula E a descricao na MESMA linha de this_cCursorItens (xOpe) -
    * "Replace Razaos with CrListaRemota.Razaos In xOpe" eh direto no
    * cursor local, sem FormParaBO/BOParaForm (ainda nao existem nesta
    * fase). Cancelar (ESC) ou nao selecionar nada LIMPA a celula, igual ao
    * legado - This.Value = CrListaRemota.Itras sempre executa no legado, e
    * sem selecao o cursor fica sem linha corrente (equivale a limpar,
    * mesmo raciocinio do irmao AbrirLookupOperacaoTrfGradeExec de
    * FormSigOpTrf.prg).
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupItrasExec(par_oTxt)
        LOCAL loc_cValorDigitado, loc_oBusca, loc_oErro, loc_cCodigoResolvido, ;
              loc_cDescricaoResolvida, loc_cAliasItens
        loc_cAliasItens = ""

        IF VARTYPE(par_oTxt) != "O"
            RETURN
        ENDIF

        loc_cValorDigitado = ALLTRIM(par_oTxt.Value)

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cAliasItens = THIS.this_oBusinessObject.this_cCursorItens
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrTrp", "cursor_4c_BuscaTransportadora", "Itras", loc_cValorDigitado, ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                *-- Init ja tentou o match exato (regra #37) - so abre o
                *-- picker se nao achou
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Itras", "", "Transportadora")
                    loc_oBusca.mAddColuna("Razaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTransportadora") AND ;
                   RECCOUNT("cursor_4c_BuscaTransportadora") > 0
                    SELECT cursor_4c_BuscaTransportadora
                    loc_cCodigoResolvido    = ALLTRIM(NVL(Itras, ""))
                    loc_cDescricaoResolvida = ALLTRIM(NVL(Razaos, ""))

                    *-- Legado: This.Value = CrListaRemota.Itras
                    par_oTxt.Value = loc_cCodigoResolvido

                    *-- Legado: Replace Razaos with CrListaRemota.Razaos In xOpe
                    IF !EMPTY(loc_cAliasItens) AND USED(loc_cAliasItens)
                        REPLACE Razaos WITH loc_cDescricaoResolvida IN (loc_cAliasItens)
                    ENDIF
                ELSE
                    *-- Legado: This.Value = CrListaRemota.Itras (sem
                    *-- selecao, o cursor local fica sem linha corrente -
                    *-- equivale a limpar a celula)
                    par_oTxt.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigoptrp.AbrirLookupItrasExec")
        ENDTRY

        IF USED("cursor_4c_BuscaTransportadora")
            USE IN cursor_4c_BuscaTransportadora
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * MarcarDadosAlterados - legado: ThisForm.GravaDados = .t. Sincroniza
    * this_lDadosAlterados do FORM (fonte unica da verdade, ver property no
    * topo do arquivo) e o espelho na mesma property do BO, para quem
    * consultar this_oBusinessObject.this_lDadosAlterados diretamente.
    *
    * PUBLIC: chamado pelos handlers dos botoes desta classe.
    *==========================================================================
    PROCEDURE MarcarDadosAlterados
        THIS.this_lDadosAlterados = .T.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lDadosAlterados = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdInserirClick - cmdInserir.Click do legado, transcrito:
    *
    *     Insert Into xOpe (Itras) Values ( Space(10))
    *     Select xOpe
    *     ThisForm.GravaDados = .t.
    *     Thisform.GradeOpe.Column1.SetFocus
    *
    * Insere a linha EM BRANCO na grade (so Itras, com o espacamento do
    * legado) e joga o foco na celula do codigo - quem valida, resolve a
    * descricao e abre o picker eh o Valid da celula (Fase 6,
    * ValidarItrasGridExec).
    *
    * Grava SO no cursor LOCAL (this_cCursorItens). A persistencia em
    * SigOpTrp eh em LOTE, no Confirmar (PersistirItens), igual ao legado.
    *
    * Column1.SetFocus() eh o que o legado chama ("Column1" eh o NOME
    * interno da unica coluna digitavel - a API eh sempre por POSICAO,
    * regra #34).
    *
    * O "Select xOpe" do legado nao vira efeito colateral permanente: este
    * form roda na DataSession do PAI (DataSession = 1), e o alias
    * anterior eh restaurado no fim para nao atrapalhar quem chamou.
    *
    * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
    *==========================================================================
    PROCEDURE CmdInserirClick
        LOCAL loc_cAliasAnterior, loc_cAlias, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cAlias = THIS.this_oBusinessObject.this_cCursorItens

                IF VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)

                    loc_cAliasAnterior = ALIAS()

                    *-- Legado: Insert Into xOpe (Itras) Values (Space(10))
                    INSERT INTO (loc_cAlias) (Itras) VALUES (SPACE(10))

                    *-- Legado: Select xOpe
                    SELECT (loc_cAlias)

                    *-- Legado: ThisForm.GravaDados = .t.
                    THIS.MarcarDadosAlterados()

                    *-- Legado: Thisform.GradeOpe.Column1.SetFocus
                    IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                        THIS.grd_4c_Dados.Refresh()
                        THIS.grd_4c_Dados.Column1.SetFocus()
                    ENDIF

                    IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                        SELECT (loc_cAliasAnterior)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CmdInserirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdExcluirClick - cmdExcluir.Click do legado, transcrito:
    *
    *     Select xOpe
    *     If Not Eof()
    *         Select xOpe
    *         Delete
    *         Skip
    *         If Eof()
    *             Go Bott
    *         Endif
    *     Endif
    *     Thisform.GradeOpe.SetFocus
    *     ThisForm.GravaDados = .t.
    *
    * O par "Skip / If Eof() Go Bott" reposiciona o ponteiro numa linha
    * VIVA depois da marcacao: com SET DELETED ON (config.prg) a linha
    * excluida desaparece da grade de imediato.
    *
    * "ThisForm.GravaDados = .t." fica FORA do "If Not Eof()" no legado -
    * SEMPRE marcado, mesmo clicando Excluir com a grade vazia.
    * Transcricao literal da assimetria (regra #17) - nao se "corrige"
    * aqui.
    *
    * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
    *==========================================================================
    PROCEDURE CmdExcluirClick
        LOCAL loc_cAliasAnterior, loc_cAlias, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cAlias = THIS.this_oBusinessObject.this_cCursorItens

                IF VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)

                    loc_cAliasAnterior = ALIAS()

                    *-- Legado: Select xOpe / If Not Eof()
                    SELECT (loc_cAlias)

                    IF !EOF()
                        *-- Legado: Delete / Skip / If Eof() Go Bott
                        DELETE
                        SKIP
                        IF EOF()
                            GO BOTTOM
                        ENDIF
                    ENDIF

                    *-- Legado: Thisform.GradeOpe.SetFocus
                    IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                        THIS.grd_4c_Dados.Refresh()
                        THIS.grd_4c_Dados.SetFocus()
                    ENDIF

                    *-- Legado: ThisForm.GravaDados = .t. (fora do If Not
                    *-- Eof())
                    THIS.MarcarDadosAlterados()

                    IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                        SELECT (loc_cAliasAnterior)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CmdExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSairClick - cmdSair.Click do legado ("Confirmar"), transcrito:
    *
    *   If ThisForm.GravaDados
    *       Select Itras, Sum(1) as Qt From xOpe Group by 1 Into Cursor
    *           Selecao where Itras <> ' ' having Sum(1) > 1
    *       If Reccount('Selecao') > 0
    *           MessageBox('Existem lancamentos de Transportadoras Em
    *               Duplicidade!!!',0+16,'')
    *           Return .f.
    *       EndIf
    *       <apaga tudo de SigOpTrp desta operacao e regrava uma linha
    *       por Itras nao-vazio de xOpe - PersistirItens>
    *       <Delete+UpDate+Commit/RollBack, com MessageBox no erro>
    *   EndIf
    *   Thisform.ParentForm.Enabled = .T.
    *   ThisForm.Release
    *
    * "Return .f." do legado, achando duplicata, sai do metodo SEM chegar
    * nas duas ultimas linhas - o dialogo fica ABERTO e o pai continua
    * desabilitado, para o usuario corrigir a duplicata antes de sair
    * (regra #17 - o early-exit eh regra de negocio, nao detalhe). Por
    * isso o RETURN de saida fica FORA do TRY/CATCH (regra #1) - a
    * checagem de duplicata roda DENTRO do TRY, mas so AVALIA a flag; a
    * decisao de sair acontece depois do ENDTRY.
    *
    * "Thisform.ParentForm.Enabled = .T." roda no Destroy() deste form,
    * que o Release() dispara - mesma decisao do irmao FormSigOpTrf.prg.
    *
    * A mensagem generica "Erro na Gravacao dos Dados!!!" do legado vai
    * GUARDADA por this_lErroExibido (regra #20): ApagarItensDaOperacao/
    * Inserir do BO ja exibem a propria falha com o texto do SQL Server -
    * repetir aqui daria dois dialogos para o mesmo erro.
    *
    * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
    *==========================================================================
    PROCEDURE BtnSairClick
        LOCAL loc_cAlias, loc_lDuplicado, loc_lGravou, loc_lErroExibido, loc_oErro

        loc_lDuplicado   = .F.
        loc_lGravou      = .T.
        loc_lErroExibido = .F.

        *-- Legado: If ThisForm.GravaDados
        IF THIS.this_lDadosAlterados AND VARTYPE(THIS.this_oBusinessObject) = "O"

            TRY
                loc_cAlias = THIS.this_oBusinessObject.this_cCursorItens

                IF VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)

                    *-- Legado: Select Itras, Sum(1) as Qt From xOpe
                    *-- Group by 1 Into Cursor Selecao where Itras <> ' '
                    *-- having Sum(1) > 1
                    SELECT Itras, COUNT(*) AS Qt FROM (loc_cAlias) ;
                        WHERE ALLTRIM(NVL(Itras, "")) <> "" ;
                        GROUP BY Itras ;
                        HAVING COUNT(*) > 1 ;
                        INTO CURSOR cursor_4c_Duplicadas

                    IF RECCOUNT("cursor_4c_Duplicadas") > 0
                        loc_lDuplicado = .T.
                    ENDIF

                    IF USED("cursor_4c_Duplicadas")
                        USE IN cursor_4c_Duplicadas
                    ENDIF
                ENDIF

                IF !loc_lDuplicado
                    loc_lGravou = THIS.PersistirItens()

                    IF VARTYPE(THIS.this_oBusinessObject) = "O"
                        loc_lErroExibido = THIS.this_oBusinessObject.this_lErroExibido
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                loc_lGravou      = .F.
                loc_lErroExibido = .T.
                MsgErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, ;
                        "Erro em BtnSairClick")
            ENDTRY

            *-- Legado: MessageBox('Existem lancamentos de
            *-- Transportadoras Em Duplicidade!!!',0+16,'') + Return .f.
            *-- - sai SEM reabilitar o pai nem fechar o dialogo
            IF loc_lDuplicado
                MsgErro("Existem lan" + CHR(231) + CHR(227) + "mentos de " + ;
                        "Transportadoras Em Duplicidade!!!", THIS.Caption)
                RETURN
            ENDIF

            *-- Legado: = MessageBox('Erro na Gravacao dos Dados!!!',48)
            *-- - so quando ninguem mais reportou (regra #20)
            IF !loc_lGravou AND !loc_lErroExibido
                MsgErro("Erro na Grava" + CHR(231) + CHR(227) + "o dos Dados!!!", THIS.Caption)
            ENDIF
        ENDIF

        *-- Legado: Thisform.ParentForm.Enabled = .T. / ThisForm.Release -
        *-- a reabilitacao roda no Destroy(), que o Release() dispara
        THIS.Release()
    ENDPROC

    *==========================================================================
    * PersistirItens - corpo do "apaga tudo e regrava" do Confirmar
    * (depois da checagem de duplicata, que fica em BtnSairClick).
    * Transcricao:
    *
    *   Select CrSigOpTrp
    *   Zap
    *   Select xOpe
    *   Scan
    *       If Not Empty(Itras)
    *           Insert Into CrSigOpTrp (Dopes, Itras, cIdChaves) ;
    *               Values (crSigCdOpe.Dopes, xOpe.Itras, fUniqueIds())
    *       Endif
    *   EndScan
    *   <UpDate('CrSigOpTrp') + Commit(), com RollBack e MessageBox no
    *   erro>
    *
    * "APAGA TUDO E REGRAVA" eh o desenho da tela: toda linha regravada
    * ganha PK NOVA (fUniqueIds(), regra #22) - por isso o laco usa
    * NovoRegistro()+Salvar() com this_cCidChaves VAZIO
    * (GravarUmaTransportadora), nunca Atualizar(). Mesmo padrao do irmao
    * FormSigOpTrf.prg (PersistirRegras/GravarUmaRegra).
    *
    * SEM transacao SQL explicita: BEGIN/COMMIT via SQLEXEC NAO dao
    * atomicidade nesta conexao (a conexao ja nasce com Transactions=2 e
    * @@TRANCOUNT=1, entao so aninharia) - mesma decisao do irmao
    * FormSigOpTrf.prg, que tambem nao protege o lote.
    *
    * PROTECTED: funil interno do Confirmar, nao se chama de fora deste
    * form. RETURN unico, FORA de TRY/CATCH (regra #1).
    *==========================================================================
    PROTECTED FUNCTION PersistirItens
        LOCAL loc_lSucesso, loc_cAliasAnterior, loc_cAliasItens, loc_cItrasLinha, loc_oErro
        loc_lSucesso = .T.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_cAliasItens    = THIS.this_oBusinessObject.this_cCursorItens
        loc_cAliasAnterior = ALIAS()

        TRY
            *-- Legado: Select CrSigOpTrp / Zap - apaga so as
            *-- transportadoras desta operacao (ApagarItensDaOperacao ja
            *-- filtra por dopes)
            IF !THIS.this_oBusinessObject.ApagarItensDaOperacao()
                loc_lSucesso = .F.
            ENDIF

            *-- Legado: Select xOpe / Scan / If Not Empty(Itras) / Insert
            IF loc_lSucesso AND VARTYPE(loc_cAliasItens) = "C" AND ;
               !EMPTY(loc_cAliasItens) AND USED(loc_cAliasItens)

                SELECT (loc_cAliasItens)
                GO TOP

                SCAN
                    loc_cItrasLinha = ALLTRIM(NVL(Itras, ""))

                    IF !EMPTY(loc_cItrasLinha)
                        IF !THIS.GravarUmaTransportadora(loc_cItrasLinha)
                            loc_lSucesso = .F.
                        ENDIF

                        *-- O BO grava por SQLEXEC sem cursor de destino,
                        *-- a area de trabalho nao muda - reafirmado por
                        *-- seguranca para o SCAN nao depender disso
                        SELECT (loc_cAliasItens)
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PersistirItens")
        ENDTRY

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GravarUmaTransportadora - grava UMA transportadora do lote em
    * SigOpTrp. Equivale ao par "Insert Into CrSigOpTrp (Dopes, Itras,
    * cIdChaves) Values (...)" do cmdSair.Click legado.
    *
    * SEMPRE INSERT, nunca UPDATE (ver cabecalho de PersistirItens).
    * this_cCidChaves vai VAZIO de proposito - Inserir() do BO chama
    * fUniqueIds() (regra #22). this_cDopes vem do CONTEXTO da operacao
    * (THIS.this_cDopes), NAO da coluna Dopes da linha de xOpe - igual ao
    * legado (crSigCdOpe.Dopes, nao xOpe.Dopes, que nem existe
    * preenchida - ver CmdInserirClick).
    *
    * PROTECTED: primitiva interna do lote do Confirmar.
    *==========================================================================
    PROTECTED FUNCTION GravarUmaTransportadora(par_cItras)
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        THIS.this_oBusinessObject.NovoRegistro()

        THIS.this_oBusinessObject.this_cCidChaves = ""
        THIS.this_oBusinessObject.this_cDopes     = ALLTRIM(THIS.this_cDopes)
        THIS.this_oBusinessObject.this_cItras     = IIF(VARTYPE(par_cItras) = "C", ALLTRIM(par_cItras), "")
        THIS.this_oBusinessObject.this_cRazaos    = ""

        RETURN THIS.this_oBusinessObject.Salvar()
    ENDFUNC

    *==========================================================================
    * BtnCancelarClick - Cancela.Click do legado:
    *
    *   Thisform.parentform.enabled = .T.
    *   Thisform.release
    *
    * So fecha o dialogo, SEM gravar nada (nenhuma chamada ao BO) - mesmo
    * quando o usuario incluiu/excluiu linhas na grade: o legado nunca
    * consulta GravaDados aqui, so no cmdSair.Click. "Thisform.
    * parentform.enabled = .T." roda no Destroy() deste form, que o
    * Release() dispara.
    *
    * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
    *==========================================================================
    PROCEDURE BtnCancelarClick
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controle com Visible = .F.
    * Percorre recursivamente Controls (containers/paginas) para garantir
    * que tudo que foi adicionado fique visivel.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
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
    ENDPROC

    *==========================================================================
    * Destroy - Reabilita o form pai ao fechar este dialogo (legado:
    * cmdSair.Click/Cancela.Click fazem .ParentForm.Enabled = .t. antes do
    * ThisForm.Release; aqui tambem fica como rede de seguranca para
    * qualquer caminho de fechamento que nao passe pelos botoes -
    * ESC/Alt+F4/erro).
    *
    * Fecha tambem o cursor de trabalho do BO (this_cCursorItens - ver
    * cabecalho de SigoptrpBO.prg), se ja estiver aberto: nesta fase
    * (estrutura base) ele ainda nao existe (a carga eh Fase 4), mas o
    * guard USED() torna este bloco seguro desde ja e evita ter que
    * revisitar o Destroy quando a carga for acrescentada. Como o form
    * roda na DataSession do pai (DataSession = 1), deixar algum alias
    * aberto poluiria a sessao compartilhada.
    *
    * O TABLEREVERT vai GUARDADO por CURSORGETPROP("Buffering") > 1: sem
    * buffering ele nao eh no-op, dispara o erro 1586 (regra #52).
    *==========================================================================
    PROCEDURE Destroy
        LOCAL loc_cAlias

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cAlias = THIS.this_oBusinessObject.this_cCursorItens

            IF VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                IF CURSORGETPROP("Buffering", loc_cAlias) > 1
                    TABLEREVERT(.T., loc_cAlias)
                ENDIF
                USE IN (loc_cAlias)
            ENDIF
        ENDIF

        IF VARTYPE(THIS.this_oFormPai) = "O"
            *-- PEMSTATUS pela MESMA razao de CarregarContextoFormPai: em
            *-- modo teste o "form pai" pode ser um objeto simples, sem a
            *-- property Enabled. Sem a guarda, o teardown estoura
            *-- "Property ENABLED is not found" depois de o dialogo ja ter
            *-- fechado
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF

            THIS.this_oFormPai = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

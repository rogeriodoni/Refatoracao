*==============================================================================
* FORMSIGOPTRF.PRG - Dialogo "Operacoes Automaticas" (regras de TRANSFERENCIA
* de produtos entre operacoes)
* Tipo: OPERACIONAL (dialogo modal FILHO, layout FLAT - sem PageFrame)
* Migrado de SigOpTrf.SCX (task814)
*
* Pilares:
*   UX   -> layout identico ao legado (530x367, TitleBar=0, ControlBox=.F.,
*           Movable=.F., ClipControls=.F., AutoCenter=.T., cabecalho cinza
*           no topo com o Caption "Operacoes Automaticas P/ <operacao>")
*   BD   -> SigOpTrf (ver cabecalho de SigOpTrfBO.prg para o detalhamento
*           completo da tabela/chave/queries); tela EDITAVEL (INSERT/UPDATE
*           em lote ao Encerrar, diferente dos irmaos somente-leitura
*           SigOpTop/SigOpTor/SigOpTot)
*   CODE -> arquitetura em camadas (FormBase / SigOpTrfBO)
*
* O QUE ESTA TELA EH
*   Dialogo FILHO que o form pai SigCdOpe (Cadastro de Operacoes do Caixa)
*   abre para o usuario DEFINIR regras de transferencia automatica de
*   produtos da operacao-pai (crSigCdOpe.Dopes no legado) para OUTRAS
*   operacoes de destino. O legado recebe "poForm" (o form pai) e
*   "pnDataSes" (DataSession do pai) no Init, troca para a DataSession do
*   pai (Set DataSession To pnDataSes) para ler crSigCdOpe.Dopes direto do
*   cursor do pai, monta o Caption e expande as regras ja gravadas em
*   SigOpTrf para duas grades mestre-detalhe:
*
*     - GradeOpe (grade superior, 1 coluna "Operacoes") <- xOpe (lista
*       DISTINTA das operacoes de DESTINO ja usadas nesta operacao de
*       origem). O Valid do Text1 da coluna valida o codigo digitado contra
*       TmpOpe (Select Dopes,nDopes From SigCdOpe Where Dopes <>
*       <crSigCdOpe.Dopes>), abre fwBuscaInt quando nao encontra, e recusa
*       duplicata apagando a linha repetida com aviso.
*     - GradePro (grade inferior, 2 colunas "Produto"/"Descricao") <- xTrf
*       (produtos que migram para a operacao de destino selecionada na
*       grade de cima). AfterRowColChange de GradeOpe filtra xTrf por
*       "Set Key To crSigCdOpe.Dopes+xOpe.Dopes" (mestre-detalhe). O Valid
*       de txt_cpros valida o produto contra SigCdPro (fwBuscaExt quando
*       nao encontra) e recusa duplicata na MESMA operacao de destino.
*
*   Botoes: cmdInserir/cmdExcluir operam a grade de OPERACOES (GradeOpe);
*   Command2/Command1 operam a grade de PRODUTOS (GradePro); cmdSair
*   ("Encerrar") grava o lote inteiro (Delete All + Scan + Insert em
*   crSigOpTrf, ou uma linha por operacao-destino sem produto especifico se
*   nenhuma linha de xTrf for valida), faz UpDate+Commit via poDataMgr,
*   reabilita o form pai e libera o dialogo.
*
*   No migrado, o form roda com DataSession = 1 (sessao CORRENTE,
*   compartilhada), reproduzindo o mesmo efeito do "Set DataSession To
*   pnDataSes" sem a troca manual de sessao - mesmo padrao adotado nos
*   dialogos irmaos desta familia (FormSigOpTop.prg/FormSigOpSts.prg/
*   FormSigOpSqn.prg/FormSigOpSlc.prg/FormSigOpSpr.prg). O codigo da
*   operacao (crSigCdOpe.Dopes) eh passado explicitamente pelo chamador,
*   em vez de lido direto de um cursor do pai (PILAR 3 - o BO consulta SQL
*   Server direto, nao reusa cursor do form pai).
*
*   "PROCEDURE Load" do legado ("=fConfigGeral()") fica de fora: no
*   Fortyus era inicializacao GLOBAL da aplicacao, ja coberta pelo startup
*   do sistema novo (config.prg) - mesma decisao documentada no cabecalho
*   de SigOpTopBO.prg/SigOpClpBO.prg (familia SigOp*).
*
* DIFERENCA-CHAVE COM O IRMAO FormSigOpTop.prg (AMBOS LIDOS ANTES DE
* ESCREVER ESTE ARQUIVO)
*   SigOpTop eh SOMENTE LEITURA (Column.ReadOnly = .T., sem AutoCenter, com
*   posicionamento manual relativo a grade do pai). SigOpTrf EH EDITAVEL
*   (AutoCenter = .T. no SCX, SEM posicionamento manual) e grava em lote no
*   Encerrar - por isso nesta fase (estrutura base) nao ha
*   ConfigurarPosicionamento, e as fases seguintes (4+) vao precisar de
*   DUAS grades com nomes distintos (nunca grd_4c_Dados duplicado - o
*   mapeamento.json automatico colide os dois grids legados no mesmo nome
*   "grd_4c_Dados", o que seria "object already exists" na 2a grade).
*
* CHAMADA (equivale ao "Do Form SigOpTrf With ThisForm, ThisForm.
* DataSessionId" do legado, onde o proprio form pai eh "poForm" e
* "crSigCdOpe.Dopes" vem da linha corrente da Lista do pai):
*   loForm = CREATEOBJECT("FormSigOpTrf", THISFORM, loc_cOperacaoAtual, ;
*       THISFORM.DataSessionId)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()          && modal: so volta quando o dialogo fecha
*   ENDIF
*
*   Como no legado, o Release eh do PROPRIO dialogo (botao Encerrar, fase
*   futura), nao do chamador. Esta tela nao devolve nenhum resultado ao
*   chamador via property lida apos o Show() - nao se aplica o risco de
*   "Release mata referencia" (release_mata_referencia_dialogo_usa_hide).
*
* PARAMETROS DO INIT (legado: LParameters poForm, pnDataSes)
*   par_oFormPai         - legado: poForm/ThisForm.ParentForm. O form pai
*                          SigCdOpe (CRUD), que precisa expor:
*                            .Enabled - desabilitado enquanto este dialogo
*                                       esta aberto
*   par_cDopes           - legado: crSigCdOpe.Dopes, lido direto do cursor
*                          do pai (ja na DataSession dele). Como o migrado
*                          nao troca de DataSession, o codigo da operacao
*                          de ORIGEM eh passado explicitamente pelo
*                          chamador.
*   par_nDataSessionPai  - legado: pnDataSes. Informativo - DataSession = 1
*                          ja unifica a sessao com o pai; mantido so para
*                          auditoria/paridade com o legado.
*
* METODOS DE DADOS (ja implementados no BO - fases 1-2, ver cabecalho de
* SigOpTrfBO.prg para o detalhamento completo): CarregarDoCursor/
* ObterChavePrimaria/Inserir/Atualizar. NAO sobrescreve ExecutarExclusao():
* nao ha exclusao unitaria no legado, a remocao de uma regra eh so o
* efeito colateral de ela nao ser reinserida no lote do Encerrar.
*
* FASE 3 (anterior): estrutura base do form
*   - Propriedades que espelham o contexto recebido do form pai
*     (this_oFormPai/this_cDopes/this_nDataSessionPai).
*   - Init (LParameters do legado) + ValidarParametros (precondicao: sem
*     form pai e sem operacao de origem nao ha o que editar).
*   - InicializarForm (cria o BO, desabilita o form pai, monta o Caption,
*     aplica o fundo e cria o cabecalho cinza).
*   - CarregarContextoFormPai (legado: .ParentForm.Enabled = .f.).
*   - ConfigurarDecoracao (Picture do form - new_background.jpg).
*   - ConfigurarPageFrame (cntSombra do legado -> cnt_4c_Cabecalho; nome do
*     metodo mantido por paridade com os demais dialogos filhos desta
*     familia, mesmo sem PageFrame real: este form eh FLAT, igual ao
*     legado - SIGOPTRF nao tem PageFrame no SCX, so form + cntSombra +
*     2 grids + 5 botoes + 1 shape).
*   - TornarControlesVisiveis / Destroy (reabilita o form pai ao fechar -
*     rede de seguranca, igual ao cmdSair.Click do legado; fecha tambem os
*     4 cursores de trabalho do BO, se algum ja estiver aberto).
*
* FASE 4 (anterior): as duas grades + Shape1 + os 5 botoes + carga inicial
*
*   Nomes DISTINTOS para as duas grades (GradeOpe -> grd_4c_Operacoes,
*   GradePro -> grd_4c_Itens) - o mapeamento.json gerado colidia os dois
*   legados no mesmo "grd_4c_Dados" (object already exists na 2a grade);
*   corrigido tambem em tasks\task814\mapeamento.json (mesmo ajuste feito
*   em tasks\task811\mapeamento.json para o irmao FormSigOpTop).
*
*   | metodo                      | conteudo |
*   |-----------------------------|----------|
*   | ConfigurarGradeOperacoes()  | grd_4c_Operacoes (GradeOpe) - so o que nao depende de dado (regra #41) |
*   | ConfigurarBotoes()          | shp_4c_Shape1 (ANTES, regra #30) + cmd_4c_CmdSair/CmdInserir/CmdExcluir/Command2/Command1 |
*   | ConfigurarGradeItens()      | grd_4c_Itens (GradePro) + chama AplicarFormatoGrade() |
*   | AplicarFormatoGrade()       | PUBLIC, FONTE UNICA de Column.Width/Header1.Caption das DUAS grades |
*   | CarregarLista()             | PUBLIC, funil: BO.CarregarRegras + bind das 2 grades + filtro inicial + Refresh |
*   | FiltrarItensPorOperacaoCorrente() | SET KEY TO do legado (mestre-detalhe, so a carga INICIAL) |
*
*   Ordem de criacao = ordem do dump (SECAO 1): GradeOpe, Shape1+botoes,
*   GradePro - igual ao legado, embora nenhum destes controles se
*   sobreponha de fato (conferido Left+Width/Top+Height de todos contra
*   os vizinhos).
*
*   cmd_4c_CmdSair eh fwbtng (75x75, canonico de icone 60px - Width/Height
*   nao constam do dump, propriedade da classe de framework.vcx); os
*   outros 4 sao fwbtnp (36x36, canonico de icone 26px) - mesma convencao
*   de FormSigOpMpn.prg/FormSigOpMpd.prg. 455+75=530=Form.Width (igual ao
*   irmao FormSigOpTop, cmd_4c_Encerrar fechando exatamente na borda).
*   ToolTipText = "Inserir" nos 4 botoes fwbtnp (inclusive CmdExcluir e
*   Command1, que EXCLUEM) eh LITERAL do dump - artefato de copia do Form
*   Designer no legado, transcrito sem correcao por fidelidade (PILAR 1).
*
*   GradePro.Column2 (col_dpros, "Descricao") recebe .ReadOnly = .T.: o
*   legado bloqueia a edicao com "txt_dpros.When / Return(.f.)", que
*   produz o mesmo efeito estrutural - nao e logica de negocio computada,
*   so travar o campo (diferente do caso que a regra #46 cobre).
*
*   CarregarLista() chama BO.CarregarRegras() (SQLEXEC de crSigOpTrf/TmpOpe
*   + CREATE CURSOR + SCAN de expansao - ver cabecalho de SigOpTrfBO.prg)
*   e faz so o que e do FORM: bind das duas grades, reaplicacao do formato
*   (RecordSource zera Column.Width/Header1.Caption - Problema 48) e o
*   filtro mestre-detalhe INICIAL (SET KEY TO do fim do Init legado). O
*   refiltro ao TROCAR de linha na grade superior (AfterRowColChange) fica
*   para a Fase 7/8 (regra #46), que tambem cobre os Click dos 5 botoes e
*   a gravacao em lote do Encerrar.
*
*   Nenhum BINDEVENT de Click fica nesta fase: ControlBox = .F. mas sem
*   Closable/MinButton declarados (regra closable_inventado_tira_a_unica_
*   saida), o Alt+F4 continua disponivel como saida enquanto o Encerrar
*   nao esta cablado - diferente do irmao FormSigOpTop, cujo cmdSair e o
*   UNICO botao da tela e por isso ganhou o Click junto com o AddObject.
*
* FASE 5 (esta fase): NAO SE APLICA a este form - sem stub vazio
*   O roteiro padrao pede ConfigurarPaginaDados() com cnt_4c_Cabecalho +
*   metade dos TextBoxes/Labels da Page2. Este form NAO TEM Page2/PageFrame
*   (eh FLAT, igual ao legado - zero "BaseClass: pageframe" no dump,
*   confirmado em layout.json) e o SCX nao declara NENHUM TextBox FORA das
*   duas grades: os 20 objetos do dump (SigOpTrf_form_codigo_fonte.txt /
*   layout.json) sao cntSombra+2 labels, GradeOpe (1 Column), Shape1, os 5
*   botoes e GradePro (2 Column) - confirmado tambem em analise.json
*   ("campos": []). Os unicos controles de entrada de dado sao Text1/
*   txt_cpros/txt_dpros DENTRO das Columns das grades (ja criados em
*   ConfigurarGradeOperacoes/ConfigurarGradeItens/AplicarFormatoGrade,
*   Fase 4), nao TextBoxes soltos numa pagina de dados.
*
*   Repetir o roteiro aqui seria (a) duplicar cnt_4c_Cabecalho, que
*   ConfigurarPageFrame ja criou -> "object already exists" (regra #11/
*   CLAUDE.md), e (b) inventar campos digitaveis que o legado nao tem
*   (REGRA FUNDAMENTAL - proibido inventar UI). Um metodo
*   ConfigurarPaginaDados() vazio so para "cumprir o roteiro" seria o stub
*   disfarcado que a regra de completude proibe.
*
* FASE 6 (esta fase): lookups das DUAS celulas digitaveis das grades
*   Este form nao tem TextBox solto numa pagina de dados (Fase 5) - os
*   unicos controles de entrada sao as celulas Column1 das duas grades
*   (GradeOpe."Operacoes" / GradePro."Produto"). BINDEVENT em evento de
*   celula de Grid nao eh confiavel (regra #46/CLAUDE.md): os dois
*   lookups foram instalados como TextBox customizado
*   (TextBoxOperacaoTrf_4c/TextBoxProdutoOpTrf_4c, em
*   classes\TextBoxGridLookup.prg), via Column.AddObject + CurrentControl +
*   Sparse = .F. (regra #18), em AplicarFormatoGrade - FONTE UNICA das
*   DUAS colunas, chamada tanto na montagem (ConfigurarGradeItens) quanto
*   na recarga (CarregarLista, que reseta Column.Width/CurrentControl via
*   RecordSource - Problema 48).
*
*   | metodo (FormSigOpTrf)              | equivalente legado |
*   |-------------------------------------|---------------------|
*   | GuardarOperacaoTrfAnterior()        | GradeOpe.Column2.Text1.When (AntValue) |
*   | ValidarOperacaoTrfGridExec()        | GradeOpe.Column2.Text1.Valid |
*   | AbrirLookupOperacaoTrfGrade(Exec)   | fwBuscaInt contra TmpOpe -> FormBuscaAuxiliar contra SigCdOpe (regra #37) |
*   | RecusarOperacaoTrfDuplicada()       | recusa duplicata em xOpe (Seek+Skip+Delete+MessageBox) |
*   | ValidarProdutoTrfGridExec()         | GradePro.col_cpros.txt_cpros.Valid |
*   | AbrirLookupProdutoTrfGrade(Exec)    | fwBuscaExt contra SigCdPro -> FormBuscaAuxiliar (regra #37) |
*   | RecusarProdutoTrfDuplicado()        | recusa duplicata em xTrf (Seek+Skip, GLOBAL entre operacoes) |
*   | AplicarFiltroItensPorDestino()      | fatorado de FiltrarItensPorOperacaoCorrente (Fase 4) - reaplica o SET KEY apos a edicao de Produto sem mover o cursor de operacoes |
*
*   As duas rotinas de "recusar duplicata" sao TRANSCRICAO LITERAL
*   (regra #17) da sequencia Seek+Skip do legado, mesmo parecendo so
*   capturar duplicatas quando ja ha 2+ linhas pre-existentes com o mesmo
*   codigo - nao e para "corrigir" aqui. A de Produto, em especial, e
*   GLOBAL entre todas as operacoes de destino (o legado troca para o
*   indice "Cpros" e "Set Order to" cancela o SET KEY ativo - fato
*   documentado do VFP9), apesar do resumo do cabecalho deste arquivo
*   dizer "na MESMA operacao".
*
*   Cancelar o picker (ESC)/nao selecionar: na celula de Operacao o
*   legado zera explicitamente (This.Value = Iif(Lastkey()==27,'',...)),
*   reproduzido tal e qual; na celula de Produto o legado NAO tem esse
*   zeramento (preserva o digitado) - regra #50 tambem se aplica aqui.
*
* FASE 7 (esta fase): eventos principais - os 5 botoes do legado, o filtro
* mestre-detalhe ao trocar de linha e a gravacao em LOTE do Encerrar
*
*   | metodo (FormSigOpTrf)           | equivalente legado |
*   |---------------------------------|---------------------|
*   | ConfigurarBINDEVENTs()          | liga os 5 Click + AfterRowColChange |
*   | GradeOperacoesAfterRowColChange | GradeOpe.AfterRowColChange (SET KEY mestre-detalhe) |
*   | CmdInserirClick()               | cmdInserir.Click  - linha nova em xOpe (Space(20)) |
*   | CmdExcluirClick()               | cmdExcluir.Click  - apaga a operacao de destino E os produtos dela |
*   | CmdInserirItemClick()           | Command2.Click    - linha nova em xTrf (origem+destino preenchidos) |
*   | CmdExcluirItemClick()           | Command1.Click    - apaga a linha corrente de xTrf |
*   | MarcarDadosAlterados()          | ThisForm.GravaDados = .t. (FONTE UNICA dos 6 sites) |
*   | BtnSairClick()                  | cmdSair.Click     - grava o lote e libera o dialogo |
*   | PersistirRegras()               | corpo do cmdSair.Click (Delete All + 2 Scan + UpDate/Commit) |
*   | GravarUmaRegra()                | Insert Into crSigOpTrf + Replace cIdChaves WITH fUniqueIds() |
*
*   TRES pontos que esta fase tinha de acertar e que ficam registrados aqui
*   porque sao fonte conhecida de defeito silencioso:
*
*   1. this_lDadosAlterados (o GravaDados do legado) passou a ser DECLARADO
*      como property do form. A Fase 6 ja o ATRIBUIA sem declarar: em VFP9 a
*      atribuicao cria a property dinamicamente, mas a LEITURA numa
*      instancia que nunca atribuiu - Encerrar numa tela onde o usuario nao
*      editou celula alguma - estouraria "Property THIS_LDADOSALTERADOS is
*      not found". Ver o comentario da declaracao para o porque de a
*      property do FORM, e nao a do BO, ser a fonte da verdade.
*
*   2. O fallback "uma linha por operacao de destino, sem produto" do
*      cmdSair.Click eh guardado por "Reccount([crSigOpTrf]) = 0" DEPOIS do
*      Delete All - e RECCOUNT conta registro MARCADO como excluido. Ou
*      seja, no legado ele so dispara na PRIMEIRA gravacao da operacao de
*      origem. O criterio foi reproduzido como (regras pre-existentes +
*      linhas gravadas agora) = 0; detalhe completo no cabecalho de
*      PersistirRegras.
*
*   3. O "DELETE for Dopeds = xOpe.Dopes" do cmdExcluir roda sob o SET KEY
*      ativo de xTrf, logo depende de a faixa filtrada ser a do destino que
*      esta sendo excluido. O filtro eh reafirmado antes do DELETE (unica
*      precaucao acrescentada ao handler, justificada no cabecalho de
*      CmdExcluirClick): sem ela, ponteiro movido por codigo deixaria
*      produtos orfaos, que o lote do Encerrar REGRAVARIA - a exclusao
*      pareceria nao funcionar, sem erro algum na tela.
*
*   Acrescentado ao BO nesta fase: ApagarRegrasDaOrigem() - o "SELECT
*   crSigOpTrf / DELETE ALL" do legado. Fica no BO porque eh SQL (PILAR 3);
*   Excluir() por cidchaves nao serve (o legado nao tem exclusao unitaria e
*   este BO nao sobrescreve ExecutarExclusao).
*
* FASE 8 (esta fase): o TRANSPORTE da linha da grade e a CONSOLIDACAO
*
*   Esta tela nao tem campo nenhum fora das duas grades, entao a FICHA dela
*   eh UMA LINHA de this_cCursorItens (xTrf: Dopes + Dopeds + Cpros + Dpros).
*   Os dois hooks de transferencia transportam essa linha, e nao um bloco de
*   TextBox de Page2 - que esta tela nao possui.
*
*   | metodo (FormSigOpTrf)   | o que faz / equivalente legado |
*   |-------------------------|---------------------------------|
*   | FormParaBO()            | LINHA corrente de xTrf -> properties do BO. Dentro do Valid da celula o valor digitado esta em par_oTxt.Value e o cursor so o recebe depois (regra #46), por isso a CELULA vence o cursor no campo Cpros |
*   | BOParaForm()            | properties do BO -> LINHA corrente + celula + Refresh. Eh a transcricao do "This.Value = evaluate('crSigCdPro.CPROS') / txt_dpros.Value = crSigCdPro.Dpros / Refresh" do Valid legado |
*   | LimparCampos()          | zera a ficha da linha no funil de carga, para a linha de uma sessao nunca vazar para a seguinte |
*   | HabilitarCampos()       | ponto UNICO que aplica a editabilidade das celulas e dos 4 botoes de linha. Existe porque o rebind das grades RESETA Column.ReadOnly (Problema 48 / regra #41) e quem desabilita tem de reabilitar no FUNIL (regra #40) |
*   | AjustarBotoesPorModo()  | nome canonico do projeto apontando para a reaplicacao real desta tela (HabilitarCampos), para o caminho canonico alcancar UM fluxo so |
*
*   AbrirLookupProdutoTrfGradeExec passou a usar os DOIS hooks em vez de
*   repetir o REPLACE inline: FormParaBO carrega a identidade da linha mais
*   o codigo escolhido, e BOParaForm devolve cada metade para onde o legado
*   manda - o CODIGO para a celula (no legado quem o grava no cursor eh o
*   bind da coluna, depois do Valid) e a DESCRICAO para a linha ("txt_dpros.
*   Value = crSigCdPro.Dpros", TextBox com ControlSource na coluna).
*   Escrever tambem o codigo na linha aqui pareceria mais seguro e MUDARIA a
*   regra: o SEEK de RecusarProdutoTrfDuplicado passaria a ver a propria
*   linha e recusaria com UMA duplicata pre-existente, no lugar das DUAS que
*   o legado exige (regra #17) - ver o cabecalho de BOParaForm.
*
*   FormParaBO/BOParaForm/LimparCampos sao PROTECTED EXPLICITOS: FormBase
*   declara os mesmos tres nomes como PROTECTED (formbase.prg:276/280/285) e
*   em VFP9 a subclasse NAO alarga escopo herdado - omitir o modificador nao
*   os tornaria publicos, so esconderia o fato. Sao chamados por THIS. de
*   dentro da classe (regra #8). HabilitarCampos/AjustarBotoesPorModo NAO
*   existem em FormBase, logo sao publicos de verdade e o harness os alcanca
*   de fora (regra #3/#51).
*
*   O lote do Encerrar (PersistirRegras + GravarUmaRegra) continua com os
*   parametros EXPLICITOS da Fase 7, e nao passa por FormParaBO: o 2o laco
*   do legado - o fallback "uma linha por operacao de destino, sem produto"
*   - varre xOpe, onde NAO existe linha de xTrf para transportar, e o
*   criterio de validade do 1o laco le os campos do cursor diretamente,
*   igual ao legado. Os dois lacos ficam simetricos na mesma primitiva.
*
* O QUE NAO SE APLICA A ESTA TELA (e por que inventar violaria o PILAR 1)
*   - BtnSalvarClick / BtnConfirmarClick: o SCX nao tem botao de gravar. A
*     gravacao desta tela mora no cmdSair.Click ("Encerrar"), migrado na
*     Fase 7 em BtnSairClick -> PersistirRegras. O handler leva o nome do
*     OBJETO do legado, nao o da acao - renomea-lo faria o nome mentir
*     sobre o botao que o usuario ve, e criar um segundo botao de gravar
*     inventaria controle que o legado nao tem.
*   - BtnCancelarClick: o SCX nao tem Cancelar nem modo de edicao
*     cancelavel (nao ha Page2 de Dados). O unico caminho de saida eh o
*     Encerrar, e ele NAO cancela - grava. O ESC cai nele porque o botao
*     tem Cancel = .T. (transcrito em ConfigurarBotoes). Um "cancelar"
*     aqui DESCARTARIA em silencio edicoes que o legado sempre grava.
*   - BtnBuscarClick: o SCX nao tem botao de busca. A busca desta tela sao
*     os lookups de CELULA (fwBuscaInt na grade de operacoes e fwBuscaExt
*     na de produtos), migrados na Fase 6 em AbrirLookupOperacaoTrfGrade e
*     AbrirLookupProdutoTrfGrade.
*   - AlternarPagina: o form eh FLAT (herda de "form" puro, nao de
*     frmcadastro) e nao tem PageFrame - nao ha pagina para alternar.
*
* Integracao (fora de escopo desta fase - documentado para a fase de
* integracao final, mesmo padrao do FormSigOpTop.prg):
*   - config.prg: NADA a acrescentar (carga sob demanda, GarantirClasse).
*   - menu.prg: NADA a acrescentar - dialogo FILHO, sem item de menu
*     proprio, aberto so pelo form pai SigCdOpe.
*==============================================================================

DEFINE CLASS FormSigOpTrf AS FormBase

    *--------------------------------------------------------------------------
    * CONTEXTO RECEBIDO DO FORM PAI (LParameters do Init legado)
    *--------------------------------------------------------------------------

    this_cMensagemErro = ""

    *-- poForm / ThisForm.ParentForm do legado - o form SigCdOpe (Cadastro
    *-- de Operacoes do Caixa) que abriu este dialogo
    this_oFormPai = .NULL.

    *-- crSigCdOpe.Dopes do legado - codigo da operacao de ORIGEM cujas
    *-- regras de transferencia serao editadas. Repassado ao BO em
    *-- InicializarForm (THIS.this_oBusinessObject.this_cDopes)
    this_cDopes = ""

    *-- pnDataSes do legado - informativo (DataSession = 1 ja unifica a
    *-- sessao com o pai, ver comentario de DataSession abaixo)
    this_nDataSessionPai = 0

    *--------------------------------------------------------------------------
    * ESTADO DOS LOOKUPS DE CELULA (FASE 6) - ver ConfigurarGradeOperacoes/
    * ConfigurarGradeItens (instalacao dos TextBox customizados em
    * classes\TextBoxGridLookup.prg) e os metodos Validar*/AbrirLookup*
    * abaixo.
    *--------------------------------------------------------------------------

    *-- Legado: Thisform.AntValue - snapshot do valor da celula "Operacoes"
    *-- ANTES da edicao (GradeOpe.Column2.Text1.When), usado por
    *-- ValidarOperacaoTrfGridExec para saber se o usuario realmente mudou
    *-- o codigo digitado
    this_cValorAnteriorOperacao = ""

    *-- Guardas de reentrancia (regra #47): o picker eh MODAL, tira o foco
    *-- da celula e redispara o proprio Valid/KeyPress que o chamou
    this_lEmLookupOperacao = .F.
    this_lEmLookupProduto  = .F.

    *--------------------------------------------------------------------------
    * ESTADO DE EDICAO (FASE 7)
    *--------------------------------------------------------------------------

    *-- Legado: ThisForm.GravaDados (property customizada do SCX - ver
    *-- RESERVED3/ClassInfo no fim do dump: antvalue/gravadados/parentform/
    *-- podatamgr). Ligada por TODO caminho que muda a lista de operacoes de
    *-- destino ou a de produtos (os 4 botoes de grade e os dois Valid de
    *-- celula) e LIDA pelo cmdSair.Click ("If ThisForm.GravaDados") para
    *-- decidir se o lote precisa ser regravado.
    *--
    *-- DECLARACAO OBRIGATORIA, nao decorativa: a Fase 6 ja ATRIBUIA
    *-- THIS.this_lDadosAlterados (ValidarOperacaoTrfGridExec/
    *-- ValidarProdutoTrfGridExec) sem que a property existisse. Em VFP9 a
    *-- ATRIBUICAO cria a property dinamicamente e passa limpo, mas a
    *-- LEITURA numa instancia que ainda nao atribuiu nada - exatamente o
    *-- caso de Encerrar numa tela onde o usuario nao editou celula alguma -
    *-- estoura "Property THIS_LDADOSALTERADOS is not found". Nem FormBase
    *-- nem este form a declaravam: FormBase tem a homonima no BO
    *-- (this_oBusinessObject.this_lDadosAlterados), nao no Form.
    *--
    *-- A property do FORM eh a fonte da verdade do GravaDados, NAO a do BO:
    *-- BusinessBase.NovoRegistro()/Salvar() zeram this_lDadosAlterados do
    *-- BO a cada linha gravada, entao o BO perderia o flag no meio do
    *-- proprio lote de PersistirRegras. A do BO segue sendo mantida em
    *-- paralelo (Fase 6) para quem consultar o BO isoladamente.
    this_lDadosAlterados = .F.

    *--------------------------------------------------------------------------
    * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
    *--------------------------------------------------------------------------

    *-- SIGOPTRF: BorderStyle = 2 / Height = 367 / Width = 530 /
    *-- DoCreate = .T. (default do Form, nao precisa declarar)
    BorderStyle = 2
    Height      = 367
    Width       = 530

    *-- Caption do SCX ("Opera??es Autom?ticas") - sobrescrito em
    *-- InicializarForm com o codigo da operacao de origem, igual ao
    *-- legado (.Caption = 'Operacoes Automaticas P/ ' +
    *-- AllTrim(crSigCdOpe.Dopes))
    Caption = "Opera" + CHR(231) + CHR(245) + "es Autom" + CHR(225) + "ticas"

    *-- ControlBox = .F. / Movable = .F. / TitleBar = 0 / ClipControls = .F.
    *-- - literais do dump. MaxButton/Closable/MinButton NAO declarados no
    *-- SCX -> NAO inventar (regra closable_inventado_tira_a_unica_saida):
    *-- o default .T. deixa o Alt+F4 funcionando, que eh uma das saidas
    *-- alem do Encerrar (sem barra de titulo nao ha X na janela, so o
    *-- ControlBox = .F. remove o icone de sistema)
    ControlBox   = .F.
    Movable      = .F.
    TitleBar     = 0
    ClipControls = .F.

    *-- AutoCenter = .T. do SCX - DIFERENTE do irmao FormSigOpTop (que
    *-- calcula Top/Left manualmente a partir da grade do pai). SigOpTrf
    *-- nao faz esse calculo no Init legado - centraliza na tela.
    AutoCenter = .T.

    *-- WindowType = 1 (modal): o pai abre este dialogo e precisa que o
    *-- Show() bloqueie ate o usuario Encerrar (legado: .ParentForm.Enabled
    *-- = .f. enquanto este form esta aberto, emulando modalidade)
    WindowType = 1

    *-- ShowWindow = 1 ("In Top-Level Form"): canonico do projeto
    ShowWindow = 1

    *-- Fonte base (os controles do cabecalho declaram a propria fonte -
    *-- Tahoma 18 - transcrita em ConfigurarPageFrame)
    FontName = "Tahoma"
    FontSize = 8

    *-- DataSession = 1 (sessao CORRENTE, NAO privada). O legado declara
    *-- DataSession = 2 no SCX mas o proprio Init sobrescreve com "Set
    *-- DataSession To pnDataSes", ou seja: na pratica este dialogo roda
    *-- SEMPRE na sessao do form pai. DataSession = 1 eh a reproducao
    *-- direta desse resultado, sem a troca manual de sessao - mesmo
    *-- padrao adotado em FormSigOpTop.prg/FormSigOpSts.prg/
    *-- FormSigOpSqn.prg/FormSigOpSlc.prg/FormSigOpSpr.prg
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
    * quem reabilitar, e sem operacao de origem nao ha regra de
    * transferencia nenhuma para editar (o legado tambem depende dessas
    * referencias em todo o Init - crSigCdOpe.Dopes/ThisForm.ParentForm.*).
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
                    "Opera" + CHR(231) + CHR(245) + "es Autom" + CHR(225) + "ticas")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(THIS.this_cDopes)
            MsgErro("Opera" + CHR(231) + CHR(227) + "o de origem n" + CHR(227) + "o informada.", ;
                    "Opera" + CHR(231) + CHR(245) + "es Autom" + CHR(225) + "ticas")
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
            *-- Business Object das Fases 1-2
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpTrfBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigOpTrfBO.", "Opera" + CHR(231) + CHR(245) + "es Autom" + CHR(225) + "ticas")
            ELSE
                *-- Contexto no BO (operacao de origem - this_cDopes do BO
                *-- eh a mesma property declarada em SigOpTrfBO.prg)
                THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes

                *-- Legado: .ParentForm.Enabled = .f.
                THIS.CarregarContextoFormPai()

                *-- Legado: .Caption = 'Operacoes Automaticas P/ ' +
                *-- AllTrim(crSigCdOpe.Dopes)
                THIS.Caption = "Opera" + CHR(231) + CHR(245) + "es Autom" + CHR(225) + "ticas P/ " + ;
                               ALLTRIM(THIS.this_cDopes)

                THIS.this_oBusinessObject.this_cTituloDialogo = THIS.Caption

                *-- Fundo do form (Picture do SCX)
                THIS.ConfigurarDecoracao()

                *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO
                *-- AddObject do form, igual ao SCX
                THIS.ConfigurarPageFrame()

                *-- GradeOpe, Shape1+botoes, GradePro - nesta ordem (dump)
                THIS.ConfigurarGradeOperacoes()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarGradeItens()

                *-- FASE 7: Click dos 5 botoes + AfterRowColChange da grade
                *-- superior (mestre-detalhe). DEPOIS dos AddObject - sem o
                *-- controle criado, o BINDEVENT estouraria no bind
                THIS.ConfigurarBINDEVENTs()

                *-- AddObject cria controle com Visible = .F.
                THIS.TornarControlesVisiveis(THIS)

                *-- Legado: o Init termina consultando SigOpTrf/SigCdOpe e
                *-- ligando as duas grades ao resultado. Pulado em modo
                *-- teste/validacao de UI (padrao FormCor/FormSigOpTop): la
                *-- nao ha gnConnHandle nem operacao de origem, entao a
                *-- carga so produziria ruido de erro no log do harness. As
                *-- grades ficam vazias, com as colunas ja formatadas por
                *-- AplicarFormatoGrade. O harness chama CarregarLista de
                *-- fora quando quer exercita-la
                IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) AND ;
                   !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar FormSigOpTrf: " + loc_oErro.Message + ;
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
    * familia (FormSigOpTop.prg/FormSigOpSts.prg/FormSigOpSqn.prg/
    * FormSigOpSlc.prg/FormSigOpSpr.prg usam o mesmo nome), mesmo sem
    * PageFrame real - este form eh FLAT, igual ao legado (SIGOPTRF nao
    * tem PageFrame no SCX).
    *
    * Transcricao do dump (SigOpTrf_form_codigo_fonte.txt):
    *   cntSombra  Top=0  Left=0  Width=800  Height=80  BorderWidth=0
    *              BackColor=100,100,100
    *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
    *              Tahoma 18 bold, FontUnderline=.F., WordWrap=.T.,
    *              Alignment=0, BackStyle=0
    *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
    *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
    *
    * O Init legado sobrescreve os dois Caption com ThisForm.Caption
    * ("Operacoes Automaticas P/ <operacao>"), por isso .Caption =
    * THIS.Caption (dinamico) - o literal do dump ("Cadastro de Testes") eh
    * so o default do Form Designer, nunca chega a ser exibido.
    *
    * Width do container usa THIS.Width - padrao canonico da faixa, regra
    * #11 - em vez do literal 800: o SCX declara o CONTAINER mais largo que
    * o proprio form (530), artefato do Form Designer ja catalogado
    * (cabecalho_label_width_dump_maior_que_form) - copiar o literal 769
    * nos labels extrapolaria os 530px visiveis e cortaria o titulo. Os
    * labels usam THIS.Width - 20, mesma margem de 10px dos dois lados
    * aplicada pelo irmao FormSigOpTop.prg.
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
            .FontSize      = 18
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
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = THIS.Caption
            .Top       = 17
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
    * ConfigurarGradeOperacoes - GradeOpe do legado -> grd_4c_Operacoes
    * (grade superior, mestre: lista DISTINTA das operacoes de destino).
    *
    * Transcricao do dump (SIGOPTRF.GradeOpe):
    *   ColumnCount=1  FontName="Tahoma"  DeleteMark=.F.  Height=221
    *   Left=5  ScrollBars=2  Top=133  Width=180  GridLineColor=238,238,238
    *
    * RecordMark = .F. nao consta do dump (legado herda o default): posto
    * pela regra do projeto para grade de form OPERACIONAL criada por
    * AddObject.
    *
    * O Column1 do dump chama-se "Column2" (Column1.Name = "Column2" -
    * renome interno do Form Designer, SEM efeito na API): a Column eh
    * SEMPRE acessada por POSICAO (regra #34, Controls/Columns indexado
    * por numero) - NAO renomear nada aqui.
    *
    * Sem ReadOnly = .T.: esta grade EH editavel (cmdInserir insere linha
    * em branco, o usuario digita o codigo - diferente do irmao
    * FormSigOpTop, somente leitura).
    *
    * So o que NAO depende de dado (regra #41): ControlSource/RecordSource
    * moram em CarregarLista. Column.Width/Header1.Caption moram em
    * AplicarFormatoGrade, chamada ao final de ConfigurarGradeItens (apos
    * as DUAS grades existirem).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeOperacoes
        THIS.AddObject("grd_4c_Operacoes", "Grid")
        WITH THIS.grd_4c_Operacoes
            .ColumnCount   = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Top           = 133
            .Left          = 5
            .Height        = 221
            .Width         = 180
            .ScrollBars    = 2
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .GridLineColor = RGB(238, 238, 238)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Shape1 + cmdSair/cmdInserir/cmdExcluir/Command2/
    * Command1 do legado.
    *
    * Shape1 PRIMEIRO (ordem do dump): BackStyle=0 + BorderStyle=0 (nao
    * desenha nada), mas a area dele (Top 12..122 / Left 432..522) invade
    * o canto do botao Encerrar (Top 3..78 / Left 455..530) - criado
    * depois, o retangulo invisivel ficaria por cima e bloquearia o
    * clique sem aparecer em screenshot (regra #30).
    *
    * Transcricao do dump:
    *   Shape1    Top=12 Left=432 Height=110 Width=90 BorderColor=136,189,188
    *   cmdSair   Top=3  Left=455 Picture=cadastro_sair_60.jpg Cancel=.T.
    *             Caption="Encerrar" TabIndex=8 (classe fwbtng)
    *   cmdInserir Top=91 Left=5   Picture=cadastro_inserir_26.jpg (fwbtnp)
    *   cmdExcluir Top=91 Left=45  Picture=cadastro_excluir_26.jpg (fwbtnp)
    *   Command2   Top=91 Left=190 Picture=cadastro_inserir_26.jpg (fwbtnp)
    *   Command1   Top=91 Left=230 Picture=cadastro_excluir_26.jpg (fwbtnp)
    *
    * Width/Height NAO constam do dump (propriedade da classe de
    * framework.vcx) - canonicos do projeto: fwbtng=75x75 (icone 60px),
    * fwbtnp=36x36 (icone 26px), mesma convencao de FormSigOpMpn.prg/
    * FormSigOpMpd.prg. 455+75=530=Form.Width (fecha exatamente na borda,
    * igual ao irmao FormSigOpTop). Os 4 fwbtnp com Left 5/45/190/230 e
    * Width=36 nunca se tocam (vao de 5..41, 45..81, 190..226, 230..266) e
    * ficam 6px acima do Top=133 das grades (91+36=127).
    *
    * ToolTipText = "Inserir" nos 4 fwbtnp (inclusive CmdExcluir e
    * Command1, que EXCLUEM) eh LITERAL do dump - artefato de copia do
    * Form Designer no legado, transcrito sem correcao (PILAR 1).
    *
    * Themes = .T. + DisabledPicture: standalone CommandButton com
    * Picture exige isso para desenhar o icone (regra #99). Picture so eh
    * atribuido se o arquivo existir - .Picture inexistente falha em
    * SILENCIO (regra #25).
    *
    * NENHUM BINDEVENT de Click aqui - fica para a Fase 7/8 (ver cabecalho
    * do arquivo).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
        LOCAL loc_cIconeInserir, loc_cIconeExcluir, loc_cIconeSair
        loc_cIconeInserir = ""
        loc_cIconeExcluir = ""
        loc_cIconeSair    = ""

        IF TYPE("gc_4c_CaminhoIcones") = "C"
            loc_cIconeInserir = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            loc_cIconeExcluir = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            loc_cIconeSair    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
        ENDIF

        *-- Shape1 (decoracao invisivel) - PRIMEIRO, ver acima
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 12
            .Left        = 432
            .Height      = 110
            .Width       = 90
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- cmdSair ("Encerrar") -> cmd_4c_CmdSair
        THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
        WITH THIS.cmd_4c_CmdSair
            .Top          = 3
            .Left         = 455
            .Width        = 75
            .Height       = 75
            .Caption      = "Encerrar"
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

            IF !EMPTY(loc_cIconeSair) AND FILE(loc_cIconeSair)
                .Picture         = loc_cIconeSair
                .DisabledPicture = loc_cIconeSair
                .PicturePosition = 13
            ENDIF

            .Visible = .T.
        ENDWITH

        *-- cmdInserir -> cmd_4c_CmdInserir (opera a grade de OPERACOES)
        THIS.AddObject("cmd_4c_CmdInserir", "CommandButton")
        WITH THIS.cmd_4c_CmdInserir
            .Top          = 91
            .Left         = 5
            .Width        = 36
            .Height       = 36
            .Caption      = ""
            .ToolTipText  = "Inserir"
            .FontName     = "Verdana"
            .FontSize     = 8
            .ForeColor    = RGB(36, 84, 155)
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

        *-- cmdExcluir -> cmd_4c_CmdExcluir (opera a grade de OPERACOES)
        THIS.AddObject("cmd_4c_CmdExcluir", "CommandButton")
        WITH THIS.cmd_4c_CmdExcluir
            .Top          = 91
            .Left         = 45
            .Width        = 36
            .Height       = 36
            .Caption      = ""
            .ToolTipText  = "Inserir"
            .FontName     = "Verdana"
            .FontSize     = 8
            .ForeColor    = RGB(36, 84, 155)
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

        *-- Command2 -> cmd_4c_Command2 (opera a grade de PRODUTOS - insere)
        THIS.AddObject("cmd_4c_Command2", "CommandButton")
        WITH THIS.cmd_4c_Command2
            .Top          = 91
            .Left         = 190
            .Width        = 36
            .Height       = 36
            .Caption      = ""
            .ToolTipText  = "Inserir"
            .FontName     = "Verdana"
            .FontSize     = 8
            .ForeColor    = RGB(36, 84, 155)
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

        *-- Command1 -> cmd_4c_Command1 (opera a grade de PRODUTOS - exclui)
        THIS.AddObject("cmd_4c_Command1", "CommandButton")
        WITH THIS.cmd_4c_Command1
            .Top          = 91
            .Left         = 230
            .Width        = 36
            .Height       = 36
            .Caption      = ""
            .ToolTipText  = "Inserir"
            .FontName     = "Verdana"
            .FontSize     = 8
            .ForeColor    = RGB(36, 84, 155)
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
    ENDPROC

    *==========================================================================
    * ConfigurarGradeItens - GradePro do legado -> grd_4c_Itens (grade
    * inferior, detalhe: produtos que migram para a operacao de destino
    * selecionada na grade de cima).
    *
    * Transcricao do dump (SIGOPTRF.GradePro):
    *   ColumnCount=2  DeleteMark=.F.  Height=220  Left=190  RecordMark=.F.
    *   ScrollBars=2  TabIndex=8  Top=133  Width=335
    *
    * ZOrderSet = 8 do dump NAO e transcrito: e bookkeeping do Form
    * Designer (indice de z-order), sem equivalente em runtime - o
    * equivalente real e o METODO ZOrder(), que o legado nao chama aqui
    * (regra #33).
    *
    * So o que NAO depende de dado (regra #41): ControlSource/RecordSource
    * moram em CarregarLista. AplicarFormatoGrade (chamada ao final) e a
    * FONTE UNICA de Column.Width/Header1.Caption/ReadOnly das DUAS
    * grades - CarregarLista reaplica depois do RecordSource, que os zera
    * (Problema 48).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeItens
        THIS.AddObject("grd_4c_Itens", "Grid")
        WITH THIS.grd_4c_Itens
            .ColumnCount = 2
            .Top         = 133
            .Left        = 190
            .Height      = 220
            .Width       = 335
            .ScrollBars  = 2
            .TabIndex    = 8
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .Visible     = .T.
        ENDWITH

        THIS.AplicarFormatoGrade()
    ENDPROC

    *==========================================================================
    * AplicarFormatoGrade - FONTE UNICA da geometria das colunas das DUAS
    * grades (regra do Problema 48 - RecordSource zera Column.Width e
    * Header1.Caption, entao este metodo e chamado de novo em
    * CarregarLista, depois do bind).
    *
    * Transcricao do dump:
    *   GradeOpe.Column2 ("Operacoes")      - Width=150, Tahoma 8
    *     Header1  Tahoma 8 Alignment=2 Caption="Operacoes"
    *     Text1    BorderStyle=0 Margin=0 ForeColor=0,0,0 BackColor=255,255,255
    *   GradePro.col_cpros ("Produto")      - Width=108, Courier New, Alignment=3
    *     hdr_cpros Tahoma 8 Alignment=2 Caption="Produto"
    *     txt_cpros Courier New BorderStyle=0 Format="!" Margin=0 MaxLength=10
    *               ForeColor=0,0,0 BackColor=255,255,255
    *   GradePro.col_dpros ("Descricao")    - Width=205, Courier New 9
    *     hdr_dpros Tahoma 8 Alignment=2 Caption="Descricao"
    *     txt_dpros Courier New 9 BorderStyle=0 Format="!" Margin=0 MaxLength=40
    *               ForeColor=0,0,0 BackColor=255,255,255
    *
    * Column1 do dump (GradeOpe) chama-se "Column2"; Column1/Column2 de
    * GradePro chamam-se "col_cpros"/"col_dpros" - renomes internos do
    * Form Designer sem efeito na API (regra #34): sempre .Column1/
    * .Column2, por POSICAO.
    *
    * .Column2 (col_dpros, "Descricao") de grd_4c_Itens recebe .ReadOnly =
    * .T.: o legado bloqueia a edicao com "txt_dpros.When / Return(.f.)",
    * efeito estrutural equivalente - nao ha calculo nenhum ali.
    *
    * ForeColor dos Header1: RGB(90, 90, 90) - canonico do projeto para
    * rotulo sobre fundo claro (regra #12). O dump nao declara ForeColor
    * nos Header1 (classe header do Form Designer).
    *
    * FASE 6: Column1 das DUAS grades recebe o TextBox customizado de
    * lookup (classes\TextBoxGridLookup.prg) via AddObject + CurrentControl
    * + Sparse = .F. (regra #18) - BINDEVENT em evento de celula de Grid
    * nao eh confiavel (regra #46). Guard IF !PEMSTATUS(...) antes do
    * AddObject: este metodo roda de novo em CarregarLista (Problema 48,
    * RecordSource reseta Column.Width/Header1.Caption) e o 2o AddObject
    * estouraria "Object ... is already defined".
    *
    * Metodo PUBLIC: chamado pela montagem (ConfigurarGradeItens) E pela
    * recarga (CarregarLista), e o harness de teste o alcanca de fora.
    *==========================================================================
    PROCEDURE AplicarFormatoGrade
        LOCAL loc_lAplicou
        loc_lAplicou = .F.

        IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
            WITH THIS.grd_4c_Operacoes
                .Column1.Width             = 150
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.FontName          = "Tahoma"
                .Column1.FontSize          = 8
                .Column1.Header1.Caption   = "Opera" + CHR(231) + CHR(245) + "es"
                .Column1.Header1.FontName  = "Tahoma"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(90, 90, 90)

                *-- Lookup de operacao de destino (legado:
                *-- GradeOpe.Column2.Text1.Valid/When, fwBuscaInt contra
                *-- TmpOpe + recusa duplicata em xOpe)
                IF !PEMSTATUS(.Column1, "txt_4c_CelOperacao", 5)
                    .Column1.AddObject("txt_4c_CelOperacao", "TextBoxOperacaoTrf_4c")
                ENDIF
                .Column1.CurrentControl = "txt_4c_CelOperacao"
                .Column1.Sparse         = .F.
                .Column1.ReadOnly       = .F.
            ENDWITH

            loc_lAplicou = .T.
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
            WITH THIS.grd_4c_Itens
                *-- Column1 (col_cpros) - "Produto", EDITAVEL (Valid com
                *-- lookup contra SigCdPro)
                .Column1.Width             = 108
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.FontName          = "Courier New"
                .Column1.Alignment         = 3
                .Column1.Header1.Caption   = "Produto"
                .Column1.Header1.FontName  = "Tahoma"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(90, 90, 90)

                *-- Lookup de produto (legado: GradePro.col_cpros.txt_cpros.
                *-- Valid, fwBuscaExt contra SigCdPro + recusa duplicata)
                IF !PEMSTATUS(.Column1, "txt_4c_CelProduto", 5)
                    .Column1.AddObject("txt_4c_CelProduto", "TextBoxProdutoOpTrf_4c")
                ENDIF
                .Column1.CurrentControl = "txt_4c_CelProduto"
                .Column1.Sparse         = .F.
                .Column1.ReadOnly       = .F.

                *-- Column2 (col_dpros) - "Descricao", READONLY (legado:
                *-- txt_dpros.When retorna .F.)
                .Column2.Width             = 205
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.FontName          = "Courier New"
                .Column2.FontSize          = 9
                .Column2.ReadOnly          = .T.
                .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                .Column2.Header1.FontName  = "Tahoma"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(90, 90, 90)
                .Column2.Text1.FontName    = "Courier New"
                .Column2.Text1.FontSize    = 9
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Format      = "!"
                .Column2.Text1.Margin      = 0
                .Column2.Text1.MaxLength   = 40
                .Column2.Text1.ReadOnly    = .T.
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            loc_lAplicou = .T.
        ENDIF

        RETURN loc_lAplicou
    ENDPROC

    *==========================================================================
    * CarregarLista - funil de carga das duas grades. Reproduz o trecho
    * final do Init legado:
    *
    *     With Thisform.GradeOpe
    *         .RecordSource          = 'xOpe'
    *         .Column2.ControlSource = 'xOpe.Dopes'
    *         .Refresh
    *     EndWith
    *     With Thisform.GradePro
    *         .RecordSource = 'xTrf'
    *         .col_cpros.ControlSource = 'xTrf.Cpros'
    *         .col_dpros.Controlsource = 'xTrf.Dpros'
    *     ENDWITH
    *     ... (expansao de crSigOpTrf para xTrf/xOpe - THIS.this_oBusinessObject.CarregarRegras()) ...
    *     Select xOpe / Set Order to / Go Top
    *     Select xTrf / Set Order to Dopes / Go Top
    *     SET KEY TO crSigCdOpe.Dopes+xOpe.Dopes
    *     Go Top
    *     ThisForm.GradePro.Refresh
    *
    * A consulta e a expansao moram no BO (SigOpTrfBO.CarregarRegras,
    * Fase 4), que popula this_cCursorOperacoes/this_cCursorItens. Aqui
    * fica o que e do FORM: o binding, a reaplicacao de formato e a
    * repintura.
    *
    * Tres cuidados do projeto, todos presentes no legado ou exigidos por
    * regra:
    *   1. ColumnCount e RecordSource FORA do WITH (GRID-WITH): acessar
    *      .Column dentro do mesmo WITH que atribui RecordSource estoura
    *      'Unknown member COLUMN1' - mesma cautela do irmao FormSigOpTop.
    *   2. AplicarFormatoGrade roda DEPOIS do RecordSource das duas
    *      grades, que zera Column.Width e Header1.Caption (Problema 48).
    *   3. GO TOP + Refresh no fim das duas grades (regra #21a): popular/
    *      ligar cursor NAO repinta a grade sozinho.
    *
    * FiltrarItensPorOperacaoCorrente() reproduz o SET KEY TO final do
    * Init legado - filtro mestre-detalhe so da carga INICIAL (o refiltro
    * ao trocar de linha na grade superior fica em AfterRowColChange,
    * Fase 7/8, regra #46).
    *
    * Metodo PUBLIC (regra #3): o harness o chama de FORA da classe, sem
    * argumento algum - a operacao de origem vem de THIS.this_cDopes,
    * guardado no Init.
    *
    * RETURN unico, FORA do TRY/CATCH (regra #1).
    *==========================================================================
    PROCEDURE CarregarLista
        LOCAL loc_lCarregou, loc_cAliasOperacoes, loc_cAliasItens, loc_oErro
        loc_lCarregou = .F.

        IF !PEMSTATUS(THIS, "grd_4c_Operacoes", 5) OR !PEMSTATUS(THIS, "grd_4c_Itens", 5)
            RETURN .F.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_cAliasOperacoes = THIS.this_oBusinessObject.this_cCursorOperacoes
        loc_cAliasItens     = THIS.this_oBusinessObject.this_cCursorItens

        IF VARTYPE(loc_cAliasOperacoes) != "C" OR EMPTY(loc_cAliasOperacoes) OR ;
           VARTYPE(loc_cAliasItens) != "C" OR EMPTY(loc_cAliasItens)
            RETURN .F.
        ENDIF

        TRY
            *-- FASE 8: zera a ficha da LINHA no funil de carga, para a linha
            *-- de uma sessao nunca vazar para a seguinte (e repoe a operacao
            *-- de origem no BO, que eh de onde CarregarRegras a le)
            THIS.LimparCampos()

            *-- Legado: AddCursor/CursorQuery + expansao (crSigOpTrf -> xTrf/xOpe)
            IF THIS.this_oBusinessObject.CarregarRegras() AND ;
               USED(loc_cAliasOperacoes) AND USED(loc_cAliasItens)

                THIS.grd_4c_Operacoes.ColumnCount  = 1
                THIS.grd_4c_Operacoes.RecordSource = loc_cAliasOperacoes

                WITH THIS.grd_4c_Operacoes
                    .Column1.ControlSource = loc_cAliasOperacoes + ".Dopes"
                ENDWITH

                THIS.grd_4c_Itens.ColumnCount  = 2
                THIS.grd_4c_Itens.RecordSource = loc_cAliasItens

                WITH THIS.grd_4c_Itens
                    .Column1.ControlSource = loc_cAliasItens + ".Cpros"
                    .Column2.ControlSource = loc_cAliasItens + ".Dpros"
                ENDWITH

                *-- Reaplica largura/cabecalho/readonly, que o RecordSource zerou
                THIS.AplicarFormatoGrade()

                *-- FASE 8: o rebind acabou de resetar Column.ReadOnly junto
                *-- com Width/Caption/CurrentControl (Problema 48 / regra #41),
                *-- e quem desabilita tem de reabilitar no FUNIL (regra #40) -
                *-- este eh o funil
                THIS.HabilitarCampos()

                *-- Legado: Set Key To crSigCdOpe.Dopes+xOpe.Dopes (carga INICIAL)
                THIS.FiltrarItensPorOperacaoCorrente()

                *-- Legado: Select xOpe / Go Top / .Refresh (GradeOpe) e
                *-- ThisForm.GradePro.Refresh
                SELECT (loc_cAliasOperacoes)
                GO TOP
                THIS.grd_4c_Operacoes.Refresh()
                THIS.grd_4c_Itens.Refresh()

                loc_lCarregou = .T.
            ELSE
                *-- Sem dado nao ha binding (regra #41). Operacao sem
                *-- regra nenhuma gravada ainda e resultado valido (o
                *-- legado tambem nao avisa nada nesse caso - regra #50)
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
                    MsgErro(THIS.this_cMensagemErro, THIS.Caption)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar as regras de transfer" + CHR(234) + "ncia: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Procedure: " + loc_oErro.Procedure, THIS.Caption)
            loc_lCarregou = .F.
        ENDTRY

        RETURN loc_lCarregou
    ENDPROC

    *==========================================================================
    * FiltrarItensPorOperacaoCorrente - reproduz o filtro mestre-detalhe
    * do FIM do Init legado:
    *
    *     Select xOpe   / Set Order to       / Go Top
    *     Select xTrf   / Set Order to Dopes
    *     SET KEY TO crSigCdOpe.Dopes+xOpe.Dopes
    *     Go Top
    *
    * crSigCdOpe.Dopes e xOpe.Dopes no legado sao campos CHAR(20) (largura
    * fixa) e a concatenacao direta ja produz os 40 chars da chave
    * indexada ("Dopes + Dopeds Tag Dopes" criado em CarregarRegras) - a
    * mesma chave POSICIONAL da regra #42. THIS.this_cDopes, aqui, e uma
    * variavel ALLTRIM'd (nao um campo), por isso precisa de PADR(...,20)
    * explicito; this_cCursorOperacoes.Dopes e lido SEM ALLTRIM (mantendo
    * o padding do CHAR(20) de origem) para reproduzir a mesma largura.
    *
    * So filtra quando ha pelo menos 1 operacao de destino (xOpe nao
    * vazio) - com xOpe vazio, xTrf tambem esta vazio (toda linha de xTrf
    * nasce com um Dopeds correspondente em xOpe, em CarregarRegras), e
    * "SET KEY TO" sem argumento (limpa o filtro) e o equivalente seguro.
    *==========================================================================
    PROTECTED PROCEDURE FiltrarItensPorOperacaoCorrente
        LOCAL loc_cAliasOperacoes, loc_cAliasItens, loc_cDopedsAtual

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cAliasOperacoes = THIS.this_oBusinessObject.this_cCursorOperacoes
        loc_cAliasItens      = THIS.this_oBusinessObject.this_cCursorItens

        IF VARTYPE(loc_cAliasOperacoes) != "C" OR EMPTY(loc_cAliasOperacoes) OR !USED(loc_cAliasOperacoes) OR ;
           VARTYPE(loc_cAliasItens) != "C" OR EMPTY(loc_cAliasItens) OR !USED(loc_cAliasItens)
            RETURN
        ENDIF

        SELECT (loc_cAliasOperacoes)
        SET ORDER TO
        GO TOP

        loc_cDopedsAtual = IIF(!EOF(loc_cAliasOperacoes), dopes, "")

        THIS.AplicarFiltroItensPorDestino(loc_cDopedsAtual)
    ENDPROC

    *==========================================================================
    * AplicarFiltroItensPorDestino - FONTE UNICA do "SET KEY TO
    * crSigCdOpe.Dopes+xOpe.Dopes" do legado (fatorado de
    * FiltrarItensPorOperacaoCorrente, FASE 6): quem muda a operacao de
    * destino corrente (carga inicial - par_cDopesDestino vem do GO TOP de
    * this_cCursorOperacoes - ou RecusarProdutoTrfDuplicado, que reaplica o
    * filtro com o Dopes da linha ATIVA sem mover o cursor de operacoes)
    * chama este metodo, em vez de duplicar o SET ORDER/SET KEY.
    *
    * PADR(...,20) - mesma chave POSICIONAL do metodo que o chama (regra
    * #42): THIS.this_cDopes e variavel ALLTRIM'd, por isso precisa do
    * padding explicito; par_cDopesDestino vem direto do campo CHAR(20) do
    * cursor, ja com o padding original.
    *==========================================================================
    PROTECTED PROCEDURE AplicarFiltroItensPorDestino(par_cDopesDestino)
        LOCAL loc_cAliasItens

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cAliasItens = THIS.this_oBusinessObject.this_cCursorItens

        IF VARTYPE(loc_cAliasItens) != "C" OR EMPTY(loc_cAliasItens) OR !USED(loc_cAliasItens)
            RETURN
        ENDIF

        SELECT (loc_cAliasItens)
        SET ORDER TO Dopes

        IF VARTYPE(par_cDopesDestino) = "C" AND !EMPTY(ALLTRIM(NVL(par_cDopesDestino, "")))
            SET KEY TO PADR(ALLTRIM(THIS.this_cDopes), 20) + par_cDopesDestino
        ELSE
            SET KEY TO
        ENDIF

        GO TOP
    ENDPROC

    *==========================================================================
    * GuardarOperacaoTrfAnterior - snapshot do valor da celula "Operacoes"
    * ANTES da edicao (legado: GradeOpe.Column2.Text1.When -> Thisform.
    * AntValue = This.Value). Usado por ValidarOperacaoTrfGridExec para
    * saber se o usuario realmente mudou o codigo digitado.
    *
    * PUBLIC: chamado de fora da classe (THISFORM) pelo TextBox da coluna
    * (TextBoxOperacaoTrf_4c.When, em classes\TextBoxGridLookup.prg).
    *==========================================================================
    PROCEDURE GuardarOperacaoTrfAnterior(par_oTxt)
        IF VARTYPE(par_oTxt) = "O"
            THIS.this_cValorAnteriorOperacao = par_oTxt.Value
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarOperacaoTrfGridExec - Valid da celula "Operacoes" (Column1) de
    * grd_4c_Operacoes. par_oTxt eh o TextBox da coluna (regra #46): dentro
    * do Valid, o valor digitado esta em par_oTxt.Value e AINDA NAO chegou
    * ao cursor.
    *
    * Equivalente ao legado (GradeOpe.Column2.Text1.Valid):
    *   If IsEmpty(This.Value) / Return .f. (nao deixa a celula em branco -
    *   cmdInserir insere a linha vazia e foca aqui, Fase 7/8)
    *   If Not IsEmpty(This.Value) And Thisform.AntValue # This.Value
    *       ThisForm.GravaDados = .t.
    *       <lookup + recusa de duplicata, delegados abaixo>
    *   EndIf
    *
    * PUBLIC: chamado de fora da classe pelo TextBox da coluna.
    *==========================================================================
    FUNCTION ValidarOperacaoTrfGridExec(par_oTxt)
        IF VARTYPE(par_oTxt) != "O"
            RETURN .T.
        ENDIF

        *-- Legado: If IsEmpty(This.Value) / Return .f.
        IF EMPTY(ALLTRIM(par_oTxt.Value))
            RETURN .F.
        ENDIF

        *-- Legado: If Not IsEmpty(This.Value) And Thisform.AntValue # This.Value
        IF par_oTxt.Value == THIS.this_cValorAnteriorOperacao
            RETURN .T.
        ENDIF

        THIS.this_lDadosAlterados = .T.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lDadosAlterados = .T.
        ENDIF

        *-- Legado: If Not Seek(This.Value, 'TmpOpe', 'Dopes') -> fwBuscaInt.
        *-- Migrado: consulta direto SigCdOpe (regra #37) - o Init do
        *-- FormBuscaAuxiliar ja tenta o match exato antes de abrir o
        *-- picker, equivalente ao Seek local do legado
        THIS.AbrirLookupOperacaoTrfGrade(par_oTxt)

        *-- Legado: recusa duplicata em xOpe (Seek+Skip+Delete+MessageBox) -
        *-- TRANSCRITO literal (regra #17)
        THIS.RecusarOperacaoTrfDuplicada(par_oTxt)

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * AbrirLookupOperacaoTrfGrade - FUNIL do lookup da operacao de destino.
    * Tres portas de entrada desaguam aqui: o Valid da celula
    * (ValidarOperacaoTrfGridExec) e o F4/F5/duplo clique
    * (TextBoxOperacaoTrf_4c.KeyPress/DblClick).
    *
    * Wrapper so para a guarda de reentrancia (regra #47): o picker eh
    * MODAL, tira o foco da celula e redispara o Valid que o chamou. O
    * corpo vive em AbrirLookupOperacaoTrfGradeExec.
    *
    * PUBLIC: chamado de fora da classe pelo TextBox da coluna.
    *==========================================================================
    PROCEDURE AbrirLookupOperacaoTrfGrade(par_oTxt)
        IF THIS.this_lEmLookupOperacao
            RETURN
        ENDIF

        THIS.this_lEmLookupOperacao = .T.
        THIS.AbrirLookupOperacaoTrfGradeExec(par_oTxt)
        THIS.this_lEmLookupOperacao = .F.
    ENDPROC

    *==========================================================================
    * AbrirLookupOperacaoTrfGradeExec - corpo do lookup da operacao de
    * destino. Equivalente ao legado:
    *
    *   loBrowse = CreateObject('fwBuscaInt','TmpOpe','Dopes',This.Value,
    *       'Operacoes',.t.)
    *   loBrowse.mAddColuna('Dopes', '', 'Operacao', .t.)
    *   loBrowse.mAddColuna('nDopes', '9999', ' Cod ',.f.)
    *   loBrowse.Show
    *   This.Value = Iif( Lastkey() == 27, '', TmpOpe.Dopes )
    *
    * Migrado: FormBuscaAuxiliar direto contra SigCdOpe (regra #37), com o
    * mesmo filtro de exclusao da operacao de ORIGEM que populou TmpOpe no
    * legado ("Where Dopes <> crSigCdOpe.Dopes", ver SigOpTrfBO.
    * CarregarRegras). Cancelar (ESC) ou nao selecionar nada limpa a
    * celula, igual ao legado - diferente da regra #50 (que NUNCA apaga o
    * digitado quando o universo esta vazio): aqui o legado EXPLICITAMENTE
    * zera no cancelamento, entao o caso nao se aplica.
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupOperacaoTrfGradeExec(par_oTxt)
        LOCAL loc_cValorDigitado, loc_oBusca, loc_oErro

        IF VARTYPE(par_oTxt) != "O"
            RETURN
        ENDIF

        loc_cValorDigitado = ALLTRIM(par_oTxt.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOpe", "cursor_4c_BuscaOperacaoTrf", "dopes", loc_cValorDigitado, ;
                "Opera" + CHR(231) + CHR(245) + "es", .F., .F., ;
                "dopes <> " + EscaparSQL(THIS.this_cDopes))

            IF VARTYPE(loc_oBusca) = "O"
                *-- Init ja tentou o match exato (regra #37) - so abre o
                *-- picker se nao achou
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("ndopes", "9999", " Cod ")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOperacaoTrf") AND ;
                   RECCOUNT("cursor_4c_BuscaOperacaoTrf") > 0
                    SELECT cursor_4c_BuscaOperacaoTrf
                    par_oTxt.Value = ALLTRIM(NVL(dopes, ""))
                ELSE
                    *-- Legado: This.Value = Iif(Lastkey()==27,'',TmpOpe.Dopes)
                    par_oTxt.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigOpTrf.AbrirLookupOperacaoTrfGradeExec")
        ENDTRY

        IF USED("cursor_4c_BuscaOperacaoTrf")
            USE IN cursor_4c_BuscaOperacaoTrf
        ENDIF

        par_oTxt.Refresh()
    ENDPROC

    *==========================================================================
    * RecusarOperacaoTrfDuplicada - equivalente literal (regra #17) ao
    * trecho final do legado (GradeOpe.Column2.Text1.Valid):
    *
    *   lcdope = This.Value
    *   If !IsEmpty(lcDope)
    *       Select xOpe
    *       lnRecNo = IIf(Not Eof() Or Bof(), RecNo('xope'), 0)
    *       Set Order to Dopes
    *       Seek (lcDope)
    *       If Not Eof()
    *           Skip
    *           If xOpe.Dopes = lcDope
    *               This.Value = ''
    *               Delete
    *               Skip
    *               Skip -1
    *               MessageBox('Operacao ja Digitada ... ',48,'')
    *           EndIf
    *       Endif
    *       Select xOpe / Set Order to Dopes
    *       Goto (lnRecNo) ou Goto Bottom
    *   EndIf
    *
    * SEEK em VFP9 ignora SET EXACT e faz busca por PREFIXO (documentado) -
    * com lcDope ja resolvido pelo lookup, o SKIP so acusa duplicata
    * quando ja existem DUAS linhas com o mesmo codigo ANTES desta edicao
    * (a achada pelo Seek e a seguinte, em ordem de indice) - mesma
    * sequencia do legado, nao "corrigida" aqui (regra #17).
    *==========================================================================
    PROTECTED PROCEDURE RecusarOperacaoTrfDuplicada(par_oTxt)
        LOCAL loc_cAliasOperacoes, loc_cDope, loc_nRecNo

        IF VARTYPE(par_oTxt) != "O" OR VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cAliasOperacoes = THIS.this_oBusinessObject.this_cCursorOperacoes

        IF VARTYPE(loc_cAliasOperacoes) != "C" OR EMPTY(loc_cAliasOperacoes) OR !USED(loc_cAliasOperacoes)
            RETURN
        ENDIF

        loc_cDope = ALLTRIM(par_oTxt.Value)
        IF EMPTY(loc_cDope)
            RETURN
        ENDIF

        *-- Legado: Select xOpe / lnRecNo = IIf(Not Eof() Or Bof(), RecNo(), 0)
        SELECT (loc_cAliasOperacoes)
        IF !EOF() OR BOF()
            loc_nRecNo = RECNO()
        ELSE
            loc_nRecNo = 0
        ENDIF

        *-- Legado: Set Order to Dopes / Seek (lcDope)
        SET ORDER TO Dopes
        SEEK loc_cDope

        *-- Legado: If Not Eof() / Skip / If xOpe.Dopes = lcDope -> ja
        *-- existem DUAS linhas com este codigo
        IF !EOF()
            SKIP
            IF !EOF() AND ALLTRIM(Dopes) == loc_cDope
                par_oTxt.Value = ""
                DELETE
                SKIP
                SKIP -1
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o j" + CHR(225) + " Digitada ... ", THIS.Caption)
            ENDIF
        ENDIF

        *-- Legado: Select xOpe / Set Order to Dopes / Goto (lnRecNo) ou Bottom
        SELECT (loc_cAliasOperacoes)
        SET ORDER TO Dopes
        IF loc_nRecNo != 0
            GOTO (loc_nRecNo)
        ELSE
            GOTO BOTTOM
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
            THIS.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarProdutoTrfGridExec - Valid da celula "Produto" (Column1/
    * col_cpros) de grd_4c_Itens. par_oTxt eh o TextBox da coluna (regra
    * #46): dentro do Valid, o valor digitado esta em par_oTxt.Value e
    * AINDA NAO chegou ao cursor.
    *
    * Equivalente ao legado (GradePro.col_cpros.txt_cpros.Valid):
    *   If !IsEmpty(this.value)
    *       ThisForm.GravaDados = .t.
    *       <lookup + recusa de duplicata, delegados abaixo>
    *   EndIf
    *
    * Produto pode ficar VAZIO - regra de negocio documentada no cabecalho
    * de SigOpTrfBO.prg (operacao de destino sem produto especifico migra
    * tudo) - por isso, igual ao legado, o Valid so age quando o valor
    * NAO esta vazio.
    *
    * PUBLIC: chamado de fora da classe pelo TextBox da coluna.
    *==========================================================================
    FUNCTION ValidarProdutoTrfGridExec(par_oTxt)
        IF VARTYPE(par_oTxt) != "O"
            RETURN .T.
        ENDIF

        IF EMPTY(ALLTRIM(par_oTxt.Value))
            RETURN .T.
        ENDIF

        THIS.this_lDadosAlterados = .T.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lDadosAlterados = .T.
        ENDIF

        THIS.AbrirLookupProdutoTrfGrade(par_oTxt)

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * AbrirLookupProdutoTrfGrade - FUNIL do lookup de produto. Tres portas
    * de entrada desaguam aqui: o Valid da celula
    * (ValidarProdutoTrfGridExec) e o F4/F5/duplo clique
    * (TextBoxProdutoOpTrf_4c.KeyPress/DblClick).
    *
    * Wrapper so para a guarda de reentrancia (regra #47). O corpo vive em
    * AbrirLookupProdutoTrfGradeExec.
    *
    * PUBLIC: chamado de fora da classe pelo TextBox da coluna.
    *==========================================================================
    PROCEDURE AbrirLookupProdutoTrfGrade(par_oTxt)
        IF THIS.this_lEmLookupProduto
            RETURN
        ENDIF

        THIS.this_lEmLookupProduto = .T.
        THIS.AbrirLookupProdutoTrfGradeExec(par_oTxt)
        THIS.this_lEmLookupProduto = .F.
    ENDPROC

    *==========================================================================
    * AbrirLookupProdutoTrfGradeExec - corpo do lookup de produto.
    * Equivalente ao legado:
    *
    *   xBrox = CreateObject('fwBuscaExt',<conn>,'SigCdPro','crSigCdPro',
    *       'cPros',This.Value,'Cadastro de Produtos',.t.,'cPros')
    *   xBrox.mAddColuna('CPros', '', 'Codigo', .t.)
    *   xBrox.mAddColuna('DPros', '', 'Descricao', .t.)
    *   xBrox.Show()
    *   This.Value = Evaluate('crSigCdPro.CPROS')
    *   This.Parent.Parent.col_dpros.txt_dpros.Value = crSigCdPro.Dpros
    *
    * Cancelar (ESC) ou nao selecionar nada NAO apaga o digitado (regra
    * #50 - universo vazio/sem match nao e erro, apagar impediria o
    * usuario de corrigir) - diferente da celula de Operacao acima, cujo
    * legado zera explicitamente no cancelamento.
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupProdutoTrfGradeExec(par_oTxt)
        LOCAL loc_cValorDigitado, loc_oBusca, loc_oErro, loc_cCodigoResolvido, ;
              loc_cDescricaoResolvida

        IF VARTYPE(par_oTxt) != "O"
            RETURN
        ENDIF

        loc_cValorDigitado = ALLTRIM(par_oTxt.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProdutoOpTrf", "cpros", loc_cValorDigitado, ;
                "Cadastro de Produtos")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProdutoOpTrf") AND ;
                   RECCOUNT("cursor_4c_BuscaProdutoOpTrf") > 0
                    SELECT cursor_4c_BuscaProdutoOpTrf
                    loc_cCodigoResolvido    = ALLTRIM(NVL(cpros, ""))
                    loc_cDescricaoResolvida = ALLTRIM(NVL(dpros, ""))

                    *-- Legado: This.Value = Evaluate([crSigCdPro.CPROS]) +
                    *-- This.Parent.Parent.col_dpros.txt_dpros.Value =
                    *-- crSigCdPro.Dpros - a descricao vai para a MESMA
                    *-- linha de this_cCursorItens (col_dpros eh so espelho,
                    *-- ReadOnly).
                    *--
                    *-- FASE 8: o write-back passou a usar o par de hooks de
                    *-- transporte em vez do REPLACE inline. FormParaBO leva a
                    *-- identidade da LINHA (Dopes/Dopeds) mais o codigo
                    *-- ESCOLHIDO no picker - que ainda nao chegou ao cursor
                    *-- (regra #46) -, e BOParaForm devolve o CODIGO para a
                    *-- celula e a DESCRICAO para a linha, que eh a divisao
                    *-- do legado (ver o cabecalho de BOParaForm: escrever o
                    *-- codigo na linha aqui mudaria o criterio do SEEK de
                    *-- RecusarProdutoTrfDuplicado, logo abaixo)
                    par_oTxt.Value = loc_cCodigoResolvido

                    IF THIS.FormParaBO(par_oTxt)
                        THIS.this_oBusinessObject.this_cDpros = loc_cDescricaoResolvida
                        THIS.BOParaForm(par_oTxt)
                    ENDIF

                    *-- Legado: recusa duplicata do produto (Seek+Skip,
                    *-- TRANSCRITO literal, regra #17)
                    THIS.RecusarProdutoTrfDuplicado(par_oTxt)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigOpTrf.AbrirLookupProdutoTrfGradeExec")
        ENDTRY

        IF USED("cursor_4c_BuscaProdutoOpTrf")
            USE IN cursor_4c_BuscaProdutoOpTrf
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
            THIS.grd_4c_Itens.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * RecusarProdutoTrfDuplicado - equivalente literal (regra #17) ao
    * trecho final do legado (GradePro.col_cpros.txt_cpros.Valid):
    *
    *   cPro = This.Value
    *   Select xTrf
    *   _Recno = Recno()
    *   Set Order to Cpros
    *   Seek cPro
    *   If !Eof()
    *       lcdope = xTrf.Dopeds
    *       Skip
    *       If Cpros = Cpro
    *           This.Value = ''
    *           Messagebox('Produto ja Digitado na Operacao '+lcDope,48,'')
    *       Endif
    *   Endif
    *   Set Order to Dopes
    *   Set Key to crSigCdOpe.Dopes + xOpe.Dopes
    *   If _Recno # 0 / go _Recno / Endif
    *
    * O legado troca para o indice "Cpros" (SEM filtro de operacao de
    * destino - SET ORDER TO cancela o SET KEY ativo, fato documentado do
    * VFP9), entao a checagem de duplicata e GLOBAL entre TODAS as
    * operacoes de destino, nao so a corrente - transcrito assim de
    * proposito (regra #17), mesmo o cabecalho deste arquivo resumindo
    * como "na MESMA operacao".
    *
    * O filtro mestre-detalhe e restaurado com o Dopes da linha ATIVA de
    * this_cCursorOperacoes (a operacao de destino selecionada no momento),
    * sem mover esse cursor - AplicarFiltroItensPorDestino, NAO
    * FiltrarItensPorOperacaoCorrente (que usa GO TOP, so valido na carga
    * inicial).
    *==========================================================================
    PROTECTED PROCEDURE RecusarProdutoTrfDuplicado(par_oTxt)
        LOCAL loc_cAliasItens, loc_cAliasOperacoes, loc_cPro, loc_nRecNo, ;
              loc_cDopedsAchado, loc_cDopesCorrente

        IF VARTYPE(par_oTxt) != "O" OR VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cAliasItens     = THIS.this_oBusinessObject.this_cCursorItens
        loc_cAliasOperacoes = THIS.this_oBusinessObject.this_cCursorOperacoes

        IF VARTYPE(loc_cAliasItens) != "C" OR EMPTY(loc_cAliasItens) OR !USED(loc_cAliasItens)
            RETURN
        ENDIF

        loc_cPro = ALLTRIM(par_oTxt.Value)
        IF EMPTY(loc_cPro)
            RETURN
        ENDIF

        *-- Legado: Select xTrf / _Recno = Recno() / Set Order to Cpros
        SELECT (loc_cAliasItens)
        loc_nRecNo = RECNO()
        SET ORDER TO Cpros

        *-- Legado: Seek cPro / If !Eof() / lcdope = xTrf.Dopeds / Skip /
        *-- If Cpros = Cpro -> ja existem DUAS linhas com este produto
        loc_cDopedsAchado = ""
        SEEK loc_cPro

        IF !EOF()
            loc_cDopedsAchado = ALLTRIM(Dopeds)
            SKIP
            IF !EOF() AND ALLTRIM(Cpros) == loc_cPro
                par_oTxt.Value = ""
                MsgAviso("Produto j" + CHR(225) + " Digitado na Opera" + CHR(231) + CHR(227) + "o " + ;
                          loc_cDopedsAchado, THIS.Caption)
            ENDIF
        ENDIF

        *-- Legado: Set Order to Dopes / Set Key to crSigCdOpe.Dopes + xOpe.Dopes
        loc_cDopesCorrente = ""
        IF VARTYPE(loc_cAliasOperacoes) = "C" AND !EMPTY(loc_cAliasOperacoes) AND USED(loc_cAliasOperacoes)
            SELECT (loc_cAliasOperacoes)
            IF !EOF()
                loc_cDopesCorrente = Dopes
            ENDIF
        ENDIF
        THIS.AplicarFiltroItensPorDestino(loc_cDopesCorrente)

        *-- Legado: If _Recno # 0 / go _Recno
        IF loc_nRecNo != 0
            SELECT (loc_cAliasItens)
            GOTO (loc_nRecNo)
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
            THIS.grd_4c_Itens.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - liga os eventos que a Fase 4 ainda nao ligava
    * (os 5 botoes do legado) e o AfterRowColChange da grade superior.
    *
    * Chamado em InicializarForm DEPOIS dos AddObject das grades e dos
    * botoes: BINDEVENT com objeto inexistente estoura no proprio bind.
    *
    * Todos os delegates sao PUBLIC (regra #3): metodo PROTECTED falha em
    * SILENCIO no BINDEVENT.
    *
    * | controle (legado)          | delegate                        |
    * |----------------------------|---------------------------------|
    * | cmdInserir  (xOpe)         | CmdInserirClick                 |
    * | cmdExcluir  (xOpe)         | CmdExcluirClick                 |
    * | Command2    (xTrf)         | CmdInserirItemClick             |
    * | Command1    (xTrf)         | CmdExcluirItemClick             |
    * | cmdSair     ("Encerrar")   | BtnSairClick                    |
    * | GradeOpe.AfterRowColChange | GradeOperacoesAfterRowColChange |
    *
    * Os Valid/When/KeyPress/DblClick das CELULAS nao entram aqui: sao
    * servidos pelos TextBox customizados da Fase 6 (TextBoxOperacaoTrf_4c/
    * TextBoxProdutoOpTrf_4c), porque BINDEVENT em evento de celula de Grid
    * nao eh confiavel (regra #46).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs
        BINDEVENT(THIS.cmd_4c_CmdInserir, "Click", THIS, "CmdInserirClick")
        BINDEVENT(THIS.cmd_4c_CmdExcluir, "Click", THIS, "CmdExcluirClick")
        BINDEVENT(THIS.cmd_4c_Command2,   "Click", THIS, "CmdInserirItemClick")
        BINDEVENT(THIS.cmd_4c_Command1,   "Click", THIS, "CmdExcluirItemClick")
        BINDEVENT(THIS.cmd_4c_CmdSair,    "Click", THIS, "BtnSairClick")

        BINDEVENT(THIS.grd_4c_Operacoes, "AfterRowColChange", ;
                  THIS, "GradeOperacoesAfterRowColChange")
    ENDPROC

    *==========================================================================
    * GradeOperacoesAfterRowColChange - GradeOpe.AfterRowColChange do
    * legado, transcrito:
    *
    *     LPARAMETERS nColIndex
    *     Select xTrf
    *     Set Order to Dopes
    *     SET KEY TO crSigCdOpe.Dopes+xOpe.Dopes
    *     Go Top
    *     ThisForm.GradePro.Refresh
    *     Select xOpe
    *
    * Este eh o uso CORRETO de AfterRowColChange que a regra #46 descreve:
    * refiltrar o DETALHE da linha corrente, SEM filtro por coluna - a regra
    * proibe o outro uso (validar celula, que vai no Valid do TextBox da
    * coluna e neste form ja esta na Fase 6). Por isso par_nColIndex eh
    * RECEBIDO (obrigatorio pela regra #3 - handler ligado por BINDEVENT tem
    * de declarar os parametros do evento) e nao eh testado: o que importa eh
    * a troca de LINHA, nao a coluna de destino.
    *
    * O "Select xOpe" final do legado eh reproduzido: o SET KEY deixa xTrf
    * selecionado e o resto da tela trabalha sobre a grade de operacoes.
    *
    * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
    *==========================================================================
    PROCEDURE GradeOperacoesAfterRowColChange(par_nColIndex)
        LOCAL loc_cAliasOperacoes, loc_cDopesCorrente, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cAliasOperacoes = THIS.this_oBusinessObject.this_cCursorOperacoes

                IF VARTYPE(loc_cAliasOperacoes) = "C" AND !EMPTY(loc_cAliasOperacoes) AND ;
                   USED(loc_cAliasOperacoes)

                    *-- Dopes da linha ATIVA, lido SEM ALLTRIM: a chave do
                    *-- filtro eh POSICIONAL (regra #42) e o padding do
                    *-- CHAR(20) faz parte dela
                    SELECT (loc_cAliasOperacoes)
                    loc_cDopesCorrente = IIF(!EOF(), Dopes, "")

                    *-- Legado: Select xTrf / Set Order to Dopes /
                    *-- SET KEY TO crSigCdOpe.Dopes+xOpe.Dopes / Go Top
                    THIS.AplicarFiltroItensPorDestino(loc_cDopesCorrente)

                    *-- Legado: ThisForm.GradePro.Refresh - filtrar cursor
                    *-- NAO repinta a grade sozinho (regra #21a)
                    IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                        THIS.grd_4c_Itens.Refresh()
                    ENDIF

                    *-- Legado: Select xOpe
                    SELECT (loc_cAliasOperacoes)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em GradeOperacoesAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdInserirClick - cmdInserir.Click do legado (botao "+" da grade de
    * OPERACOES DE DESTINO, Left = 5), transcrito:
    *
    *     Insert Into xOpe (Dopes) Values ( Space(20))
    *     Select xOpe
    *     ThisForm.GravaDados = .t.
    *     Thisform.GradeOpe.Column2.SetFocus
    *
    * Insere a linha EM BRANCO e joga o foco na celula, para o usuario
    * digitar o codigo da operacao de destino - quem valida, abre o picker e
    * recusa duplicata eh o Valid da celula (Fase 6,
    * ValidarOperacaoTrfGridExec).
    *
    * SEM GUARD de linha em branco repetida: o legado insere SEMPRE,
    * diferente do irmao SIGMVCXS/FormSigOpSqn (que faz um LOCATE antes para
    * reaproveitar a linha vazia ainda nao preenchida) - transcricao
    * literal, nao se "melhora" aqui (regra #17).
    *
    * Grava SO no cursor LOCAL. A persistencia eh em LOTE, no Encerrar
    * (PersistirRegras), igual ao legado - que trabalha sobre a view
    * bufferizada e so chama UpDate+Commit no cmdSair.Click.
    *
    * Column1.SetFocus() eh o que o legado chama ("Column2" eh o NOME
    * interno da unica coluna de GradeOpe - a API eh sempre por POSICAO,
    * regra #34) e Column TEM esse metodo. NAO usar Grid.ActiveColumn = 1 no
    * lugar: ActiveColumn eh READ-ONLY em runtime e derrubaria o handler.
    *
    * O "Select xOpe" do legado nao vira efeito colateral permanente: este
    * form roda na DataSession do PAI (DataSession = 1), onde deixar outro
    * alias selecionado atrapalharia quem chamou - por isso o alias anterior
    * eh restaurado no fim.
    *
    * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
    *==========================================================================
    PROCEDURE CmdInserirClick
        LOCAL loc_cAliasAnterior, loc_cAliasOperacoes, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cAliasOperacoes = THIS.this_oBusinessObject.this_cCursorOperacoes

                IF VARTYPE(loc_cAliasOperacoes) = "C" AND !EMPTY(loc_cAliasOperacoes) AND ;
                   USED(loc_cAliasOperacoes)

                    loc_cAliasAnterior = ALIAS()

                    *-- Legado: Insert Into xOpe (Dopes) Values (Space(20))
                    INSERT INTO (loc_cAliasOperacoes) (Dopes) VALUES (SPACE(20))

                    *-- Legado: Select xOpe
                    SELECT (loc_cAliasOperacoes)

                    *-- Legado: ThisForm.GravaDados = .t.
                    THIS.MarcarDadosAlterados()

                    *-- Legado: Thisform.GradeOpe.Column2.SetFocus
                    IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
                        THIS.grd_4c_Operacoes.Refresh()
                        THIS.grd_4c_Operacoes.Column1.SetFocus()
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
    * CmdExcluirClick - cmdExcluir.Click do legado (botao "-" da grade de
    * OPERACOES DE DESTINO, Left = 45), transcrito:
    *
    *     Select xOpe
    *     If Not Eof()
    *         SELECT xTrf
    *         DELETE for Dopeds = xOpe.Dopes
    *         SELECT xOpe
    *         DELETE
    *         SKIP
    *         IF EOF()
    *             GO Bott
    *         Endif
    *     ENDIF
    *     Thisform.GradeOpe.SetFocus
    *     ThisForm.GradePro.Refresh
    *     SELECT xTrf
    *     SET KEY TO crSigCdOpe.Dopes+xOpe.Dopes
    *     ThisForm.GravaDados = .t.
    *
    * Excluir a operacao de DESTINO leva embora os PRODUTOS dela - eh o
    * "DELETE for Dopeds = xOpe.Dopes" em xTrf, feito ANTES de apagar a
    * linha de xOpe (enquanto o ponteiro de xOpe ainda esta nela).
    *
    * O par "SKIP / IF EOF() GO Bott" eh o que reposiciona o ponteiro numa
    * linha VIVA depois da marcacao: com SET DELETED ON (config.prg) a linha
    * marcada desaparece da grade de imediato. Note a assimetria com o irmao
    * FormSigOpSqn ("Skip / Skip -1"): sao sequencias DIFERENTES nos dois
    * legados e cada uma fica como esta (regra #17).
    *
    * UMA precaucao acrescentada, e o motivo: o "DELETE for" do legado roda
    * com o SET KEY de xTrf ATIVO, logo so varre a faixa da operacao de
    * destino corrente. No fluxo normal essa faixa eh exatamente a do
    * destino sendo excluido (o AfterRowColChange a fixou quando o usuario
    * selecionou a linha), mas se o ponteiro de xOpe tiver sido movido por
    * CODIGO - CmdInserirClick acabou de inserir uma linha, por exemplo - a
    * chave fica DEFASADA e o DELETE nao alcanca linha alguma, EM SILENCIO:
    * os produtos orfaos sobreviveriam e seriam REGRAVADOS no Encerrar
    * (PersistirRegras varre xTrf sem filtro), fazendo a exclusao parecer
    * nao ter funcionado. Por isso o filtro eh reafirmado com o Dopes da
    * linha que esta sendo excluida ANTES do DELETE FOR: no caminho normal eh
    * exatamente a mesma faixa do legado, e no caminho defasado eh a faixa
    * que o legado PRETENDIA varrer.
    *
    * A comparacao usa ALLTRIM nos DOIS lados em vez do "=" do legado: com
    * SET EXACT ON (config.prg) o "=" entre dois CHAR(20) depende de o
    * padding de ambos coincidir. Aqui nao eh chave posicional concatenada e
    * sim comparacao de UM campo, entao o ALLTRIM eh seguro e NAO cai na
    * regra #42.
    *
    * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
    *==========================================================================
    PROCEDURE CmdExcluirClick
        LOCAL loc_cAliasAnterior, loc_cAliasOperacoes, loc_cAliasItens, ;
              loc_cDopedsExcluir, loc_cDopesCorrente, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cAliasOperacoes = THIS.this_oBusinessObject.this_cCursorOperacoes
                loc_cAliasItens     = THIS.this_oBusinessObject.this_cCursorItens

                IF VARTYPE(loc_cAliasOperacoes) = "C" AND !EMPTY(loc_cAliasOperacoes) AND ;
                   USED(loc_cAliasOperacoes)

                    loc_cAliasAnterior = ALIAS()

                    *-- Legado: Select xOpe / If Not Eof()
                    SELECT (loc_cAliasOperacoes)

                    IF !EOF()
                        *-- Dopes da linha a excluir, CRU (CHAR(20) com o
                        *-- padding): entra na chave POSICIONAL do filtro
                        *-- (regra #42)
                        loc_cDopedsExcluir = Dopes

                        IF VARTYPE(loc_cAliasItens) = "C" AND !EMPTY(loc_cAliasItens) AND ;
                           USED(loc_cAliasItens)

                            *-- Reafirma a faixa que o legado pretende varrer
                            *-- (ver cabecalho deste metodo)
                            THIS.AplicarFiltroItensPorDestino(loc_cDopedsExcluir)

                            *-- Legado: SELECT xTrf /
                            *-- DELETE for Dopeds = xOpe.Dopes
                            SELECT (loc_cAliasItens)
                            DELETE FOR ALLTRIM(NVL(Dopeds, "")) == ALLTRIM(loc_cDopedsExcluir)
                        ENDIF

                        *-- Legado: SELECT xOpe / DELETE / SKIP /
                        *-- IF EOF() GO Bott
                        SELECT (loc_cAliasOperacoes)
                        DELETE
                        SKIP
                        IF EOF()
                            GO BOTTOM
                        ENDIF
                    ENDIF

                    *-- Legado: SELECT xTrf / SET KEY TO crSigCdOpe.Dopes +
                    *-- xOpe.Dopes - agora com a linha CORRENTE (a que o
                    *-- SKIP/GO BOTTOM deixou ativa), nao com a excluida
                    SELECT (loc_cAliasOperacoes)
                    loc_cDopesCorrente = IIF(!EOF() AND !BOF(), Dopes, "")
                    THIS.AplicarFiltroItensPorDestino(loc_cDopesCorrente)

                    *-- Legado: ThisForm.GravaDados = .t.
                    THIS.MarcarDadosAlterados()

                    *-- Legado: Thisform.GradeOpe.SetFocus /
                    *-- ThisForm.GradePro.Refresh (fora do IF, como no dump)
                    IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
                        THIS.grd_4c_Operacoes.Refresh()
                    ENDIF
                    IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                        THIS.grd_4c_Itens.Refresh()
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
                    "Erro em CmdExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdInserirItemClick - Command2.Click do legado (botao "+" da grade de
    * PRODUTOS, Left = 190), transcrito:
    *
    *     Insert Into xTrf (Dopes, Dopeds) Values ( crSigCdOpe.Dopes, xOpe.Dopes)
    *     Select xTrf
    *     ThisForm.GravaDados = .t.
    *     ThisForm.GradePro.col_cpros.SetFocus
    *
    * A linha nova nasce com a operacao de ORIGEM e a de DESTINO ja
    * preenchidas - eh o par que o SET KEY filtra, por isso ela aparece de
    * imediato na grade - e com o PRODUTO em branco, para o usuario digitar.
    * Quem valida, abre o picker e recusa duplicata eh o Valid da celula
    * (Fase 6, ValidarProdutoTrfGridExec).
    *
    * SEM GUARD de "ha operacao de destino selecionada": o legado referencia
    * xOpe.Dopes direto, que em cursor vazio/EOF devolve branco, e insere a
    * linha com Dopeds vazio do mesmo jeito. Transcricao literal (regra #17)
    * - e inofensivo no lote, porque PersistirRegras exige Dopes, Dopeds E
    * Cpros preenchidos para gravar a linha (o mesmo criterio do legado).
    *
    * PADR(...,20) na origem: this_cDopes eh variavel ALLTRIM'd e a chave
    * "Dopes + Dopeds" do cursor eh POSICIONAL (regra #42) - mesma forma
    * usada em AplicarFiltroItensPorDestino. O Dopes de
    * this_cCursorOperacoes vem CRU, do campo CHAR(20), ja com o padding.
    *
    * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
    *==========================================================================
    PROCEDURE CmdInserirItemClick
        LOCAL loc_cAliasAnterior, loc_cAliasOperacoes, loc_cAliasItens, ;
              loc_cDopesDestino, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cAliasOperacoes = THIS.this_oBusinessObject.this_cCursorOperacoes
                loc_cAliasItens     = THIS.this_oBusinessObject.this_cCursorItens

                IF VARTYPE(loc_cAliasItens) = "C" AND !EMPTY(loc_cAliasItens) AND ;
                   USED(loc_cAliasItens)

                    loc_cAliasAnterior = ALIAS()

                    *-- Legado: xOpe.Dopes (linha corrente da grade de cima)
                    loc_cDopesDestino = SPACE(20)
                    IF VARTYPE(loc_cAliasOperacoes) = "C" AND !EMPTY(loc_cAliasOperacoes) AND ;
                       USED(loc_cAliasOperacoes)
                        SELECT (loc_cAliasOperacoes)
                        IF !EOF()
                            loc_cDopesDestino = Dopes
                        ENDIF
                    ENDIF

                    *-- Legado: Insert Into xTrf (Dopes, Dopeds) Values
                    *-- (crSigCdOpe.Dopes, xOpe.Dopes)
                    INSERT INTO (loc_cAliasItens) (Dopes, Dopeds) ;
                        VALUES (PADR(ALLTRIM(THIS.this_cDopes), 20), loc_cDopesDestino)

                    *-- Legado: Select xTrf
                    SELECT (loc_cAliasItens)

                    *-- Legado: ThisForm.GravaDados = .t.
                    THIS.MarcarDadosAlterados()

                    *-- Legado: ThisForm.GradePro.col_cpros.SetFocus
                    *-- ("col_cpros" eh o NOME interno da 1a coluna - a API
                    *-- eh sempre por POSICAO, regra #34)
                    IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                        THIS.grd_4c_Itens.Refresh()
                        THIS.grd_4c_Itens.Column1.SetFocus()
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
                    "Erro em CmdInserirItemClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdExcluirItemClick - Command1.Click do legado (botao "-" da grade de
    * PRODUTOS, Left = 230), transcrito:
    *
    *     Select xTrf
    *     If Not Eof()
    *         Delete
    *     Endif
    *     ThisForm.GravaDados = .t.
    *     Thisform.GradePro.Refresh
    *
    * SEM o "SKIP / GO Bott" que o cmdExcluir da grade de cima tem: sao
    * sequencias diferentes nos dois handlers do legado e cada uma fica como
    * esta (regra #17). Com SET DELETED ON (config.prg) a linha marcada
    * desaparece da grade no Refresh.
    *
    * So MARCA a linha no cursor LOCAL - nenhum DELETE no SQL Server aqui. A
    * remocao efetiva eh consequencia de a linha nao ser reinserida no lote
    * do Encerrar (PersistirRegras apaga as regras da origem e regrava as
    * linhas vivas), que eh exatamente o desenho do legado.
    *
    * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
    *==========================================================================
    PROCEDURE CmdExcluirItemClick
        LOCAL loc_cAliasAnterior, loc_cAliasItens, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cAliasItens = THIS.this_oBusinessObject.this_cCursorItens

                IF VARTYPE(loc_cAliasItens) = "C" AND !EMPTY(loc_cAliasItens) AND ;
                   USED(loc_cAliasItens)

                    loc_cAliasAnterior = ALIAS()

                    *-- Legado: Select xTrf / If Not Eof() / Delete
                    SELECT (loc_cAliasItens)
                    IF !EOF()
                        DELETE
                    ENDIF

                    *-- Legado: ThisForm.GravaDados = .t.
                    THIS.MarcarDadosAlterados()

                    IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                        SELECT (loc_cAliasAnterior)
                    ENDIF
                ENDIF
            ENDIF

            *-- Legado: Thisform.GradePro.Refresh (fora do IF, como no dump)
            IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                THIS.grd_4c_Itens.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CmdExcluirItemClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * MarcarDadosAlterados - FONTE UNICA do "ThisForm.GravaDados = .t." do
    * legado, que aparece em SEIS handlers (os 4 botoes de grade e os 2 Valid
    * de celula).
    *
    * Mantem a property do FORM - a que o Encerrar LE, ver a declaracao de
    * this_lDadosAlterados - e espelha no BO. As DUAS, e nao so a do BO,
    * porque BusinessBase.NovoRegistro()/Salvar() zeram a do BO a cada linha
    * gravada no laco de PersistirRegras.
    *
    * PUBLIC: usado pelos handlers deste form e alcancavel pelo harness.
    *==========================================================================
    PROCEDURE MarcarDadosAlterados
        THIS.this_lDadosAlterados = .T.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lDadosAlterados = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSairClick - cmdSair.Click do legado (botao "Encerrar", Cancel = .T.,
    * logo tambem dispara no ESC). Transcrito:
    *
    *     If ThisForm.GravaDados
    *         <apaga e regrava o lote - PersistirRegras>
    *         If Not m.lnErro1>0
    *             = MessageBox('Erro na Gravacao dos Dados do Cadastro de
    *                 Operacoes.',48)
    *         EndIf
    *     EndIf
    *     Thisform.ParentForm.Enabled = .T.
    *     ThisForm.Release
    *
    * FLUXO DE SAIDA - transcrito, nao "melhorado": NADA aborta o
    * fechamento. Diferente do irmao FormSigOpSqn (cujo cmdSair tem duas
    * validacoes com "Return .f."), aqui o legado nao valida nada e, mesmo
    * quando a gravacao FALHA, exibe a mensagem e FECHA - porque o RollBack
    * ja desfez tudo. Manter o dialogo aberto convidaria a um segundo
    * Encerrar, que tentaria reinserir linha ja gravada (cidchaves eh PK).
    *
    * Nada a gravar (GravaDados = .F., usuario so olhou a tela) fecha
    * direto, sem SQL algum, igual ao legado.
    *
    * A mensagem generica do legado vai GUARDADA por this_lErroExibido
    * (regra #20): BusinessBase.Salvar() e o Inserir()/ApagarRegrasDaOrigem()
    * do BO ja exibem a falha com o texto do SQL Server, e repetir aqui daria
    * dois dialogos para o mesmo erro. Se nenhum erro foi exibido, a mensagem
    * do legado aparece - falha nunca pode ser muda.
    *
    * "Thisform.ParentForm.Enabled = .T." roda no Destroy() deste form, que o
    * Release() dispara - e que tambem fecha os cursores de trabalho na
    * DataSession compartilhada com o pai.
    *
    * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
    *==========================================================================
    PROCEDURE BtnSairClick
        LOCAL loc_lGravou, loc_lErroExibido, loc_oErro

        loc_lGravou      = .T.
        loc_lErroExibido = .F.

        TRY
            *-- Legado: If ThisForm.GravaDados
            IF THIS.this_lDadosAlterados
                loc_lGravou = THIS.PersistirRegras()

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

        *-- Legado: MessageBox('Erro na Gravacao dos Dados do Cadastro de
        *-- Operacoes.', 48) - so quando ninguem mais reportou (regra #20)
        IF !loc_lGravou AND !loc_lErroExibido
            MsgErro("Erro na Grava" + CHR(231) + CHR(227) + "o dos Dados do Cadastro de " + ;
                    "Opera" + CHR(231) + CHR(245) + "es.", THIS.Caption)
        ENDIF

        *-- Legado: ThisForm.Release (SEMPRE, inclusive apos falha)
        THIS.Release()
    ENDPROC

    *==========================================================================
    * PersistirRegras - gravacao em LOTE do Encerrar. Corpo do cmdSair.Click
    * do legado, transcrito:
    *
    *     SELECT crSigOpTrf
    *     DELETE ALL
    *     Select xTrf
    *     SET KEY TO
    *     Set Order To
    *     Scan
    *         If !IsEmpty(xTrf.Dopes) And !IsEmpty(xTrf.Dopeds) And !IsEmpty(xTrf.Cpros)
    *             Scatter memvar
    *             Insert Into crSigOpTrf From memvar
    *             Replace crSigOpTrf.cIdChaves WITH fUniqueIds()
    *         EndIf
    *     EndScan
    *     If (Reccount([crSigOpTrf]) = 0)
    *         Select xOpe
    *         Scan
    *             Insert Into crSigOpTrf (Dopes, DopeDs, cIdChaves) ;
    *                 Values (crSigCdOpe.Dopes, xOpe.Dopes, fUniqueIds())
    *         EndScan
    *     EndIf
    *     <UpDate('crSigOpTrf') + Commit(), com RollBack e MessageBox>
    *
    * TRES pontos que se perdem quando nao sao transcritos com cuidado:
    *
    * 1. "APAGA TUDO E REGRAVA" eh o desenho da tela, nao uma otimizacao: o
    *    legado nao faz UPDATE de linha alguma nem preserva cidchaves - toda
    *    linha regravada ganha uma PK NOVA (fUniqueIds(), regra #22). Por
    *    isso os lacos usam NovoRegistro()+Salvar() com this_cCidChaves
    *    VAZIO (Inserir() do BO gera a chave quando ela chega vazia), e nunca
    *    Atualizar().
    *
    * 2. O CRITERIO de cada laco eh regra de negocio (regra #17), inclusive a
    *    ASSIMETRIA entre eles: o laco dos PRODUTOS exige Dopes, Dopeds E
    *    Cpros preenchidos (linha de produto incompleta eh descartada), mas o
    *    laco de FALLBACK insere TODA linha de xOpe, sem conferir se o codigo
    *    da operacao de destino esta em branco. Nenhum dos dois eh
    *    "corrigido" aqui.
    *
    * 3. O "Reccount([crSigOpTrf]) = 0" que dispara o fallback NAO significa
    *    "nenhuma linha de produto valida": RECCOUNT conta tambem registro
    *    MARCADO como excluido, e o DELETE ALL de duas linhas acima acabou de
    *    marcar todas as regras que ja existiam. Ou seja, no legado o
    *    fallback so dispara quando a view nasceu VAZIA - primeira gravacao
    *    desta operacao de origem - E nenhuma linha de produto era valida. O
    *    equivalente exato aqui eh (regras pre-existentes + linhas gravadas
    *    agora) = 0, com as pre-existentes contadas em this_cCursorRegras,
    *    que eh o mesmo "Select * From SigOpTrf Where Dopes = <origem>" do
    *    crSigOpTrf legado e ninguem altera depois da carga.
    *
    * O filtro mestre-detalhe de this_cCursorItens eh DESFEITO aqui (SET KEY
    * TO / SET ORDER TO do legado) e nao eh restaurado: a tela esta fechando
    * (BtnSairClick chama Release() em seguida, inclusive quando a gravacao
    * falha) e o Destroy fecha os cursores.
    *
    * PROTECTED: funil interno do Encerrar, nao se chama de fora deste form.
    * O RETURN de guarda fica FORA de TRY/CATCH, e o RETURN final eh unico
    * e tambem fora (regra #1).
    *==========================================================================
    PROTECTED FUNCTION PersistirRegras
        LOCAL loc_lSucesso, loc_cAliasAnterior, loc_cAliasRegras, loc_cAliasItens, ;
              loc_cAliasOperacoes, loc_nRegrasAnteriores, loc_nGravadas, ;
              loc_cDopesLinha, loc_cDopedsLinha, loc_cProsLinha, loc_oErro

        loc_lSucesso = .T.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_cAliasRegras    = THIS.this_oBusinessObject.this_cCursorRegras
        loc_cAliasItens     = THIS.this_oBusinessObject.this_cCursorItens
        loc_cAliasOperacoes = THIS.this_oBusinessObject.this_cCursorOperacoes
        loc_cAliasAnterior  = ALIAS()
        loc_nGravadas       = 0

        TRY
            *-- Legado: Reccount([crSigOpTrf]) APOS o Delete All, que conta as
            *-- regras que JA existiam (ponto 3 do cabecalho)
            loc_nRegrasAnteriores = 0
            IF VARTYPE(loc_cAliasRegras) = "C" AND !EMPTY(loc_cAliasRegras) AND ;
               USED(loc_cAliasRegras)
                loc_nRegrasAnteriores = RECCOUNT(loc_cAliasRegras)
            ENDIF

            *-- Legado: SELECT crSigOpTrf / DELETE ALL. A view ja nasce
            *-- filtrada por Dopes = <origem>, logo apaga so as regras desta
            *-- operacao de origem - que eh o que ApagarRegrasDaOrigem faz
            IF !THIS.this_oBusinessObject.ApagarRegrasDaOrigem()
                loc_lSucesso = .F.
            ENDIF

            *-- Legado: Select xTrf / SET KEY TO / Set Order To / Scan
            IF loc_lSucesso AND VARTYPE(loc_cAliasItens) = "C" AND ;
               !EMPTY(loc_cAliasItens) AND USED(loc_cAliasItens)

                SELECT (loc_cAliasItens)

                *-- Legado: SET KEY TO / Set Order To - nesta ORDEM (limpa a
                *-- faixa com o indice ainda ativo e so depois solta o
                *-- indice). O guard por ORDER() nao eh zelo: medido no VFP9
                *-- (automation\ProbeF7SigOpTrfCursores.prg), "SET KEY TO"
                *-- sem indice ativo NAO eh no-op - dispara o erro 26,
                *-- "Table has no index order set.". No fluxo normal o
                *-- indice esta em Dopes (AplicarFiltroItensPorDestino o
                *-- fixa), igual ao legado, mas sem indice nao pode haver
                *-- faixa para limpar e pular eh exatamente equivalente
                IF !EMPTY(ORDER())
                    SET KEY TO
                ENDIF
                SET ORDER TO
                GO TOP

                SCAN
                    loc_cDopesLinha  = ALLTRIM(NVL(Dopes, ""))
                    loc_cDopedsLinha = ALLTRIM(NVL(Dopeds, ""))
                    loc_cProsLinha   = ALLTRIM(NVL(Cpros, ""))

                    *-- Legado: If !IsEmpty(Dopes) And !IsEmpty(Dopeds) And
                    *-- !IsEmpty(Cpros)
                    IF !EMPTY(loc_cDopesLinha) AND !EMPTY(loc_cDopedsLinha) AND ;
                       !EMPTY(loc_cProsLinha)

                        IF THIS.GravarUmaRegra(loc_cDopesLinha, loc_cDopedsLinha, loc_cProsLinha)
                            loc_nGravadas = loc_nGravadas + 1
                        ELSE
                            loc_lSucesso = .F.
                        ENDIF

                        *-- O BO grava por SQLEXEC sem cursor de destino,
                        *-- entao a area de trabalho nao muda - reafirmada
                        *-- aqui para o SCAN nunca depender disso
                        SELECT (loc_cAliasItens)
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Legado: If (Reccount([crSigOpTrf]) = 0) / Select xOpe / Scan /
            *-- Insert ... ("operacao de destino sem produto especifico migra
            *-- tudo"). Ver ponto 3 do cabecalho para o porque do criterio
            IF loc_lSucesso AND (loc_nRegrasAnteriores + loc_nGravadas) = 0 AND ;
               VARTYPE(loc_cAliasOperacoes) = "C" AND !EMPTY(loc_cAliasOperacoes) AND ;
               USED(loc_cAliasOperacoes)

                SELECT (loc_cAliasOperacoes)
                SET ORDER TO
                GO TOP

                SCAN
                    *-- Legado: Values (crSigCdOpe.Dopes, xOpe.Dopes,
                    *-- fUniqueIds()) - Cpros fica VAZIO, e o legado NAO
                    *-- confere se xOpe.Dopes esta em branco (ponto 2)
                    loc_cDopedsLinha = ALLTRIM(NVL(Dopes, ""))

                    IF !THIS.GravarUmaRegra(ALLTRIM(THIS.this_cDopes), loc_cDopedsLinha, "")
                        loc_lSucesso = .F.
                    ENDIF

                    SELECT (loc_cAliasOperacoes)
                ENDSCAN
            ENDIF

        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PersistirRegras")
        ENDTRY

        *-- Os lacos sobrescreveram this_cDopes do BO com o Dopes de cada
        *-- linha (sempre a propria origem, por desenho desta tela - ver
        *-- cabecalho de SigOpTrfBO.prg). Reposto por seguranca: eh o
        *-- contexto de que CarregarRegras/ApagarRegrasDaOrigem dependem
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes
        ENDIF

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GravarUmaRegra - grava UMA linha do lote em SigOpTrf. Equivale ao par
    * "Insert Into crSigOpTrf ... / Replace cIdChaves WITH fUniqueIds()" do
    * cmdSair.Click legado, e eh usada pelos DOIS lacos de PersistirRegras.
    *
    * SEMPRE INSERT, nunca UPDATE: o legado apaga o lote inteiro e regrava
    * cada linha com uma PK nova (ponto 1 do cabecalho de PersistirRegras).
    * this_cCidChaves vai VAZIO de proposito - Inserir() do BO eh quem chama
    * fUniqueIds(), que eh exatamente o "Replace cIdChaves WITH fUniqueIds()"
    * do legado, e a chave NUNCA pode ficar em branco (regra #22: a 2a linha
    * do lote colidiria no indice unico).
    *
    * NovoRegistro() ANTES das properties, nao depois: ele passa por
    * LimparDados() e liga this_lNovoRegistro, que eh o que faz
    * BusinessBase.Salvar() escolher Inserir() em vez de Atualizar().
    *
    * this_cDpros nao eh persistido (nao existe em SigOpTrf - eh a descricao
    * que a grade exibe, resolvida em SigCdPro na carga), por isso vai limpo.
    *
    * PROTECTED: primitiva interna do lote do Encerrar.
    *==========================================================================
    PROTECTED FUNCTION GravarUmaRegra(par_cDopes, par_cDopeds, par_cCpros)
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        THIS.this_oBusinessObject.NovoRegistro()

        THIS.this_oBusinessObject.this_cCidChaves = ""
        THIS.this_oBusinessObject.this_cDopes     = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")
        THIS.this_oBusinessObject.this_cDopeds    = IIF(VARTYPE(par_cDopeds) = "C", ALLTRIM(par_cDopeds), "")
        THIS.this_oBusinessObject.this_cCpros     = IIF(VARTYPE(par_cCpros) = "C", ALLTRIM(par_cCpros), "")
        THIS.this_oBusinessObject.this_cDpros     = ""

        RETURN THIS.this_oBusinessObject.Salvar()
    ENDFUNC

    *==========================================================================
    * FASE 8 - TRANSPORTE DA LINHA DA GRADE <-> BO E CONSOLIDACAO
    *
    * Esta tela nao tem campo nenhum fora das duas grades: a FICHA dela eh UMA
    * LINHA de this_cCursorItens (xTrf no legado - Dopes + Dopeds + Cpros +
    * Dpros). Por isso FormParaBO/BOParaForm transportam a LINHA CORRENTE, e
    * nao um bloco de TextBox de Page2 - que esta tela nao possui.
    *==========================================================================

    *==========================================================================
    * FormParaBO - leva a LINHA CORRENTE da grade de produtos para as
    * properties do BO.
    *
    * Equivale, nesta tela, ao que num form CRUD seria "ler os TextBox da
    * Page2": a linha de this_cCursorItens EH a ficha. Preenche:
    *
    *   this_cDopes   <- Dopes  da linha (operacao de ORIGEM)
    *   this_cDopeds  <- Dopeds da linha (operacao de DESTINO)
    *   this_cCpros   <- a CELULA, quando ela esta em edicao; senao o cursor
    *   this_cDpros   <- Dpros  da linha (exibicao, Column2 - nao persistido)
    *
    * POR QUE A CELULA VENCE O CURSOR no produto: dentro do Valid da celula o
    * valor digitado esta em par_oTxt.Value e o cursor da grade so o recebe
    * DEPOIS que o Valid devolve .T. (regra #46) - ler o cursor ali carregaria
    * o valor ANTIGO. Chamado sem par_oTxt (fora de edicao), le o cursor.
    *
    * this_cCidChaves vai VAZIO e this_lNovoRegistro fica .T. porque esta tela
    * NUNCA atualiza linha: o legado apaga o lote inteiro no Encerrar e regrava
    * cada linha com uma PK nova (fUniqueIds() - ver o ponto 1 do cabecalho de
    * PersistirRegras e a regra #22). A linha de xTrf nem tem o campo
    * cidchaves (CREATE CURSOR em SigOpTrfBO.CarregarRegras), logo nao ha de
    * onde ler uma chave existente.
    *
    * NAO muda a area de trabalho corrente: le tudo qualificado pelo alias,
    * sem SELECT. Este form roda na DataSession do PAI (DataSession = 1), onde
    * trocar o alias corrente sem necessidade atrapalha quem chamou.
    *
    * PROTECTED EXPLICITO, e nao por escolha de estilo: FormBase declara
    * PROTECTED PROCEDURE FormParaBO (formbase.prg:285) e em VFP9 a subclasse
    * NAO pode ALARGAR o escopo herdado - escrever o metodo sem o modificador
    * nao o torna publico, so esconde o fato de quem le. Por isso eh chamado
    * por THIS. de dentro da classe (regra #8), a partir de
    * AbrirLookupProdutoTrfGradeExec.
    *
    * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1) - este metodo nao
    * abre bloco algum.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO(par_oTxt)
        LOCAL loc_cAliasItens, loc_cCpros

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_cAliasItens = THIS.this_oBusinessObject.this_cCursorItens

        IF VARTYPE(loc_cAliasItens) != "C" OR EMPTY(loc_cAliasItens) OR ;
           !USED(loc_cAliasItens)
            RETURN .F.
        ENDIF

        IF EOF(loc_cAliasItens)
            RETURN .F.
        ENDIF

        *-- Identidade e vinculo da linha: SEMPRE do cursor (a unica celula
        *-- editavel desta grade eh a do produto)
        THIS.this_oBusinessObject.this_cDopes  = ALLTRIM(NVL(EVALUATE(loc_cAliasItens + ".Dopes"), ""))
        THIS.this_oBusinessObject.this_cDopeds = ALLTRIM(NVL(EVALUATE(loc_cAliasItens + ".Dopeds"), ""))
        THIS.this_oBusinessObject.this_cDpros  = ALLTRIM(NVL(EVALUATE(loc_cAliasItens + ".Dpros"), ""))

        loc_cCpros = ALLTRIM(NVL(EVALUATE(loc_cAliasItens + ".Cpros"), ""))

        IF VARTYPE(par_oTxt) = "O"
            IF PEMSTATUS(par_oTxt, "Value", 5)
                loc_cCpros = ALLTRIM(NVL(par_oTxt.Value, ""))
            ENDIF
        ENDIF

        THIS.this_oBusinessObject.this_cCpros = loc_cCpros

        *-- Toda linha deste lote nasce com PK nova (ponto 1 de PersistirRegras)
        THIS.this_oBusinessObject.this_cCidChaves    = ""
        THIS.this_oBusinessObject.this_lNovoRegistro = .T.

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - devolve as properties do BO para a LINHA CORRENTE da grade
    * de produtos. Sentido inverso do FormParaBO e transcricao do trecho do
    * Valid legado que escreve de volta:
    *
    *   This.Value = evaluate([crSigCdPro.CPROS])
    *   This.Parent.Parent.col_dpros.txt_dpros.Value = crSigCdPro.Dpros
    *   This.Parent.Parent.col_dpros.txt_dpros.Refresh
    *
    * CADA METADE VAI PARA ONDE O LEGADO MANDA, e essa divisao NAO eh detalhe
    * de estilo:
    *   - o CODIGO (Cpros) vai para a CELULA. No legado quem o grava no cursor
    *     eh o bind da coluna, DEPOIS que o Valid devolve .T.
    *   - a DESCRICAO (Dpros) vai para o CURSOR. No legado ela eh escrita no
    *     TextBox da col_dpros, que tem ControlSource na coluna - ou seja,
    *     chega a linha no ato.
    *
    * POR QUE NAO GRAVAR Cpros NO CURSOR AQUI (medido, nao preferencia): logo
    * depois deste metodo roda RecusarProdutoTrfDuplicado, que eh TRANSCRICAO
    * LITERAL (regra #17) do "Set Order to Cpros / Seek cPro / Skip / If
    * Cpros = Cpro" do legado. No legado esse SEEK varre o cursor SEM o codigo
    * recem-escolhido - ele ainda esta so na celula -, e por isso o criterio
    * de duplicata do legado exige DUAS linhas pre-existentes com o mesmo
    * produto (quirk ja registrado no cabecalho deste arquivo desde a Fase 6).
    * Escrever Cpros na linha corrente antes do SEEK faria a propria linha
    * entrar na varredura e passaria a recusar com UMA linha pre-existente -
    * mudanca silenciosa de regra de negocio, que eh exatamente o que a regra
    * #17 proibe. Grava-se, entao, so o que o legado grava neste instante.
    *
    * Grava SO no cursor LOCAL - igual ao legado, que persiste em SigOpTrf
    * apenas no Encerrar (BtnSairClick -> PersistirRegras).
    *
    * LEFT() pela largura da COLUNA, nunca pelo Width em pixels do controle
    * (regra #19): Cpros = 14 (SigOpTrf.cpros char(14), a mesma largura do
    * campo no cursor) e Dpros = 60 (largura do campo no CREATE CURSOR,
    * transcrita do "Dpros c(60)" do legado). Assim o que a celula e a linha
    * recebem eh exatamente o que cabe na coluna do SQL Server no INSERT do
    * Encerrar.
    *
    * par_oTxt eh OPCIONAL: durante o lookup a celula precisa exibir o codigo
    * escolhido (o "This.Value =" do legado); chamado sem ela, so o cursor e a
    * grade sao atualizados.
    *
    * Repinta ao fim (regra #21): gravar no cursor NAO repinta a grade, e sem
    * o Refresh a Column2 continuaria mostrando a descricao anterior.
    *
    * Deixa this_cCursorItens como alias corrente, igual ao legado, que termina
    * o Valid trabalhando sobre xTrf (Set Order to Dopes / Set Key to ...).
    *
    * PROTECTED EXPLICITO pela MESMA razao do FormParaBO acima (FormBase
    * declara PROTECTED PROCEDURE BOParaForm em formbase.prg:280).
    *
    * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm(par_oTxt)
        LOCAL loc_lSucesso, loc_cAliasItens, loc_cCpros, loc_cDpros

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_cAliasItens = THIS.this_oBusinessObject.this_cCursorItens

        IF VARTYPE(loc_cAliasItens) != "C" OR EMPTY(loc_cAliasItens)
            RETURN .F.
        ENDIF

        loc_lSucesso = .F.
        loc_cCpros   = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCpros, "")), 14)
        loc_cDpros   = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDpros, "")), 60)

        IF USED(loc_cAliasItens)
            *-- Legado: o Valid termina trabalhando sobre xTrf
            SELECT (loc_cAliasItens)

            IF !EOF()
                *-- Legado: "txt_dpros.Value = crSigCdPro.Dpros" - o TextBox
                *-- da col_dpros tem ControlSource na coluna, entao a
                *-- descricao chega a linha no ato. O CODIGO nao entra aqui
                *-- (ver o cabecalho): quem o grava eh o bind da coluna,
                *-- depois do Valid
                REPLACE Dpros WITH loc_cDpros
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        *-- Legado: This.Value = evaluate([crSigCdPro.CPROS]) / This.Refresh
        IF VARTYPE(par_oTxt) = "O"
            IF PEMSTATUS(par_oTxt, "Value", 5)
                par_oTxt.Value = loc_cCpros
                par_oTxt.Refresh()
            ENDIF
        ENDIF

        *-- Regra #21: gravar no cursor nao repinta a grade
        IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
            THIS.grd_4c_Itens.Refresh()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparCampos - zera a ficha da linha (as properties de entidade do BO)
    *
    * Esta tela nao tem campo fora das grades para limpar: o que se limpa eh a
    * ficha que FormParaBO/BOParaForm transportam, de modo que a linha lida
    * numa sessao nunca vaze para a seguinte. Sem esse reset no FUNIL de carga,
    * a primeira linha tocada deixaria Dopeds/Cpros/Dpros presos no BO e um
    * BOParaForm disparado antes de qualquer FormParaBO regravaria a linha
    * corrente com os valores da ANTERIOR.
    *
    * this_cDopes eh REPOSTO com a operacao de origem (THIS.this_cDopes), nao
    * zerado: eh o CONTEXTO do dialogo - vive do Init ao Release - e eh dele
    * que CarregarRegras/ApagarRegrasDaOrigem dependem. Zera-lo faria a carga
    * recusar o trabalho com "Operacao de origem nao informada".
    *
    * NAO mexe em this_lDadosAlterados: o GravaDados do legado acompanha a
    * SESSAO do dialogo (o Encerrar o le para decidir se regrava o lote), e
    * zera-lo aqui faria uma recarga descartar em silencio a edicao que o
    * usuario acabou de fazer.
    *
    * LimparDados() do BO entra para zerar this_cMensagemErro (eh o que a
    * implementacao de BusinessBase faz); as properties de entidade sao
    * zeradas aqui, uma a uma, com o valor-tipo de cada coluna.
    *
    * PROTECTED EXPLICITO pela MESMA razao do FormParaBO/BOParaForm (FormBase
    * declara PROTECTED PROCEDURE LimparCampos em formbase.prg:276): eh
    * chamado por THIS. de dentro da classe - aqui, por CarregarLista.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.LimparDados()

            THIS.this_oBusinessObject.this_cCidChaves    = ""
            THIS.this_oBusinessObject.this_cDopeds       = ""
            THIS.this_oBusinessObject.this_cCpros        = ""
            THIS.this_oBusinessObject.this_cDpros        = ""
            THIS.this_oBusinessObject.this_lNovoRegistro = .F.

            *-- Contexto do dialogo - reposto, nunca zerado (ver cabecalho)
            THIS.this_oBusinessObject.this_cDopes = ALLTRIM(THIS.this_cDopes)
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - abre ou fecha a edicao da tela
    *
    * O legado nao tem um metodo com este nome nem modo de so-leitura: as duas
    * celulas editaveis (o codigo da operacao de destino e o do produto) e os
    * quatro botoes de linha estao SEMPRE ativos no SCX - o Init nao esconde
    * nem desabilita nada, e nao ha fChecaAcesso aqui (diferente do irmao
    * SIGOPSTS). Por isso, sem argumento, este metodo deriva .T.: eh a
    * reproducao fiel de "nao ha modo".
    *
    * Ele existe por um motivo concreto, nao por convencao: o rebind das
    * grades em CarregarLista RESETA Column.ReadOnly junto com Width/Caption/
    * CurrentControl (Problema 48 / regra #41), entao a cada recarga a
    * editabilidade das celulas tem de ser REAPLICADA - e quem desabilita tem
    * de reabilitar no FUNIL, nunca so no caminho de ida (regra #40). Este eh
    * o ponto UNICO onde esse estado chega aos controles.
    *
    * Column.ReadOnly vai DEPOIS do ReadOnly do Grid (regra #46): o do grid
    * propaga para as colunas e sobrescreveria o da coluna.
    *
    * Column2 de grd_4c_Itens nao aparece aqui: ela eh somente leitura em
    * qualquer modo (legado: txt_dpros.When retorna .F.) e quem a trava eh
    * AplicarFormatoGrade.
    *
    * cmd_4c_CmdSair fica SEMPRE habilitado: com TitleBar = 0 e
    * ControlBox = .F. o Encerrar eh a saida da tela, e desabilita-lo
    * prenderia o usuario - e perderia o lote, que so eh gravado por ele.
    *
    * Metodo PUBLIC (regra #3/#51): o harness de teste o alcanca de fora.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        *-- PCOUNT() eh OBRIGATORIO aqui: em VFP9 parametro declarado e NAO
        *-- passado chega como .F. LOGICO, entao VARTYPE(par_lHabilitar) = "L"
        *-- eh verdade tanto para "nao passou" quanto para "passou .F." - o
        *-- guard so por VARTYPE travaria as celulas ao chamar
        *-- HabilitarCampos() sem argumento, em vez de derivar o modo
        loc_lHabilitar = .T.

        IF PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L"
            loc_lHabilitar = par_lHabilitar
        ENDIF

        *-- Celula do codigo da operacao de destino (grade de cima). Column1
        *-- so existe com a grade VINCULADA - grade sem alias fica com
        *-- ColumnCount = 0, e tocar .Column1 ali estouraria "Unknown member
        *-- COLUMN1"
        IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
            IF PEMSTATUS(THIS.grd_4c_Operacoes, "Column1", 5)
                THIS.grd_4c_Operacoes.Column1.ReadOnly = !loc_lHabilitar
            ENDIF
        ENDIF

        *-- Celula do codigo do produto (grade de baixo)
        IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
            IF PEMSTATUS(THIS.grd_4c_Itens, "Column1", 5)
                THIS.grd_4c_Itens.Column1.ReadOnly = !loc_lHabilitar
            ENDIF
        ENDIF

        *-- Os 4 botoes de linha do legado (cmdInserir/cmdExcluir da grade de
        *-- operacoes e Command2/Command1 da de produtos)
        IF PEMSTATUS(THIS, "cmd_4c_CmdInserir", 5)
            THIS.cmd_4c_CmdInserir.Enabled = loc_lHabilitar
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_CmdExcluir", 5)
            THIS.cmd_4c_CmdExcluir.Enabled = loc_lHabilitar
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Command2", 5)
            THIS.cmd_4c_Command2.Enabled = loc_lHabilitar
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Command1", 5)
            THIS.cmd_4c_Command1.Enabled = loc_lHabilitar
        ENDIF

        *-- Saida da tela - nunca desabilitada
        IF PEMSTATUS(THIS, "cmd_4c_CmdSair", 5)
            THIS.cmd_4c_CmdSair.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - nome canonico do projeto para "reaplicar o estado
    * dos botoes conforme o modo", apontando para o metodo que faz esse
    * trabalho nesta tela: HabilitarCampos.
    *
    * Esta tela nao tem modo (ver o cabecalho de HabilitarCampos): o SCX deixa
    * os quatro botoes de linha sempre ativos. O metodo existe para que o
    * caminho canonico - o harness de teste automatizado e qualquer chamada
    * externa que siga a convencao do projeto - alcance a logica real em vez de
    * nao encontrar metodo algum, e para que exista UM unico ponto de
    * reaplicacao em vez de uma segunda copia que pode divergir.
    *
    * PUBLIC pelo mesmo motivo (regra #3): PEMSTATUS devolve .T. para metodo
    * PROTECTED e a chamada externa estouraria em runtime.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo
        THIS.HabilitarCampos()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controle com Visible = .F.
    * por padrao; percorre recursivamente o container repondo Visible = .T.
    * Este form nao tem container flutuante (Visible = .F. proposital) a
    * filtrar - todos os controles devem ficar visiveis.
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
    * cmdSair.Click faz .ParentForm.Enabled = .t. antes do ThisForm.Release;
    * aqui tambem fica como rede de seguranca para qualquer caminho de
    * fechamento que nao passe pelo botao Encerrar - ESC/Alt+F4/erro).
    *
    * Fecha tambem os 4 cursores de trabalho do BO (this_cCursorRegras/
    * this_cCursorOperacoesDestino/this_cCursorOperacoes/this_cCursorItens -
    * ver cabecalho de SigOpTrfBO.prg), se algum ja estiver aberto: nesta
    * fase (estrutura base) nenhum deles existe ainda (a carga eh Fase 4),
    * mas o guard USED() torna este laco seguro desde ja e evita ter que
    * revisitar o Destroy quando a carga for acrescentada. Como o form roda
    * na DataSession do pai (DataSession = 1), deixar algum alias aberto
    * poluiria a sessao compartilhada.
    *
    * O TABLEREVERT vai GUARDADO por CURSORGETPROP("Buffering") > 1: sem
    * buffering ele nao eh no-op, dispara o erro 1586 (regra #52).
    *==========================================================================
    PROCEDURE Destroy
        LOCAL loc_nI, loc_aCursores(4), loc_cAlias

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_aCursores(1) = THIS.this_oBusinessObject.this_cCursorRegras
            loc_aCursores(2) = THIS.this_oBusinessObject.this_cCursorOperacoesDestino
            loc_aCursores(3) = THIS.this_oBusinessObject.this_cCursorOperacoes
            loc_aCursores(4) = THIS.this_oBusinessObject.this_cCursorItens

            FOR loc_nI = 1 TO 4
                loc_cAlias = loc_aCursores(loc_nI)
                IF VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                    IF CURSORGETPROP("Buffering", loc_cAlias) > 1
                        TABLEREVERT(.T., loc_cAlias)
                    ENDIF
                    USE IN (loc_cAlias)
                ENDIF
            ENDFOR
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

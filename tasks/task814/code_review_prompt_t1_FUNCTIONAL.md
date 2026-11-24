# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (11)
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [METODO-INEXISTENTE] Metodo 'THIS.this_lDadosAlterados()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Caption()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.PersistirRegras()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.GravarUmaRegra()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH Thisform.GradeOpe define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: Thisform.GradeOpe.RecordSource).
- [GRID-HEADER] Header Caption 'Produto' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Operações. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Operações. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpTrf.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3034 linhas total):

*-- Linhas 53 a 160:
53: *   em vez de lido direto de um cursor do pai (PILAR 3 - o BO consulta SQL
54: *   Server direto, nao reusa cursor do form pai).
55: *
56: *   "PROCEDURE Load" do legado ("=fConfigGeral()") fica de fora: no
57: *   Fortyus era inicializacao GLOBAL da aplicacao, ja coberta pelo startup
58: *   do sistema novo (config.prg) - mesma decisao documentada no cabecalho
59: *   de SigOpTopBO.prg/SigOpClpBO.prg (familia SigOp*).
60: *
61: * DIFERENCA-CHAVE COM O IRMAO FormSigOpTop.prg (AMBOS LIDOS ANTES DE
62: * ESCREVER ESTE ARQUIVO)
63: *   SigOpTop eh SOMENTE LEITURA (Column.ReadOnly = .T., sem AutoCenter, com
64: *   posicionamento manual relativo a grade do pai). SigOpTrf EH EDITAVEL
65: *   (AutoCenter = .T. no SCX, SEM posicionamento manual) e grava em lote no
66: *   Encerrar - por isso nesta fase (estrutura base) nao ha
67: *   ConfigurarPosicionamento, e as fases seguintes (4+) vao precisar de
68: *   DUAS grades com nomes distintos (nunca grd_4c_Dados duplicado - o
69: *   mapeamento.json automatico colide os dois grids legados no mesmo nome
70: *   "grd_4c_Dados", o que seria "object already exists" na 2a grade).
71: *
72: * CHAMADA (equivale ao "Do Form SigOpTrf With ThisForm, ThisForm.
73: * DataSessionId" do legado, onde o proprio form pai eh "poForm" e
74: * "crSigCdOpe.Dopes" vem da linha corrente da Lista do pai):
75: *   loForm = CREATEOBJECT("FormSigOpTrf", THISFORM, loc_cOperacaoAtual, ;
76: *       THISFORM.DataSessionId)
77: *   IF VARTYPE(loForm) = "O"
78: *       loForm.Show()          && modal: so volta quando o dialogo fecha
79: *   ENDIF
80: *
81: *   Como no legado, o Release eh do PROPRIO dialogo (botao Encerrar, fase
82: *   futura), nao do chamador. Esta tela nao devolve nenhum resultado ao
83: *   chamador via property lida apos o Show() - nao se aplica o risco de
84: *   "Release mata referencia" (release_mata_referencia_dialogo_usa_hide).
85: *
86: * PARAMETROS DO INIT (legado: LParameters poForm, pnDataSes)
87: *   par_oFormPai         - legado: poForm/ThisForm.ParentForm. O form pai
88: *                          SigCdOpe (CRUD), que precisa expor:
89: *                            .Enabled - desabilitado enquanto este dialogo
90: *                                       esta aberto
91: *   par_cDopes           - legado: crSigCdOpe.Dopes, lido direto do cursor
92: *                          do pai (ja na DataSession dele). Como o migrado
93: *                          nao troca de DataSession, o codigo da operacao
94: *                          de ORIGEM eh passado explicitamente pelo
95: *                          chamador.
96: *   par_nDataSessionPai  - legado: pnDataSes. Informativo - DataSession = 1
97: *                          ja unifica a sessao com o pai; mantido so para
98: *                          auditoria/paridade com o legado.
99: *
100: * METODOS DE DADOS (ja implementados no BO - fases 1-2, ver cabecalho de
101: * SigOpTrfBO.prg para o detalhamento completo): CarregarDoCursor/
102: * ObterChavePrimaria/Inserir/Atualizar. NAO sobrescreve ExecutarExclusao():
103: * nao ha exclusao unitaria no legado, a remocao de uma regra eh so o
104: * efeito colateral de ela nao ser reinserida no lote do Encerrar.
105: *
106: * FASE 3 (anterior): estrutura base do form
107: *   - Propriedades que espelham o contexto recebido do form pai
108: *     (this_oFormPai/this_cDopes/this_nDataSessionPai).
109: *   - Init (LParameters do legado) + ValidarParametros (precondicao: sem
110: *     form pai e sem operacao de origem nao ha o que editar).
111: *   - InicializarForm (cria o BO, desabilita o form pai, monta o Caption,
112: *     aplica o fundo e cria o cabecalho cinza).
113: *   - CarregarContextoFormPai (legado: .ParentForm.Enabled = .f.).
114: *   - ConfigurarDecoracao (Picture do form - new_background.jpg).
115: *   - ConfigurarPageFrame (cntSombra do legado -> cnt_4c_Cabecalho; nome do
116: *     metodo mantido por paridade com os demais dialogos filhos desta
117: *     familia, mesmo sem PageFrame real: este form eh FLAT, igual ao
118: *     legado - SIGOPTRF nao tem PageFrame no SCX, so form + cntSombra +
119: *     2 grids + 5 botoes + 1 shape).
120: *   - TornarControlesVisiveis / Destroy (reabilita o form pai ao fechar -
121: *     rede de seguranca, igual ao cmdSair.Click do legado; fecha tambem os
122: *     4 cursores de trabalho do BO, se algum ja estiver aberto).
123: *
124: * FASE 4 (anterior): as duas grades + Shape1 + os 5 botoes + carga inicial
125: *
126: *   Nomes DISTINTOS para as duas grades (GradeOpe -> grd_4c_Operacoes,
127: *   GradePro -> grd_4c_Itens) - o mapeamento.json gerado colidia os dois
128: *   legados no mesmo "grd_4c_Dados" (object already exists na 2a grade);
129: *   corrigido tambem em tasks\task814\mapeamento.json (mesmo ajuste feito
130: *   em tasks\task811\mapeamento.json para o irmao FormSigOpTop).
131: *
132: *   | metodo                      | conteudo |
133: *   |-----------------------------|----------|
134: *   | ConfigurarGradeOperacoes()  | grd_4c_Operacoes (GradeOpe) - so o que nao depende de dado (regra #41) |
135: *   | ConfigurarBotoes()          | shp_4c_Shape1 (ANTES, regra #30) + cmd_4c_CmdSair/CmdInserir/CmdExcluir/Command2/Command1 |
136: *   | ConfigurarGradeItens()      | grd_4c_Itens (GradePro) + chama AplicarFormatoGrade() |
137: *   | AplicarFormatoGrade()       | PUBLIC, FONTE UNICA de Column.Width/Header1.Caption das DUAS grades |
138: *   | CarregarLista()             | PUBLIC, funil: BO.CarregarRegras + bind das 2 grades + filtro inicial + Refresh |
139: *   | FiltrarItensPorOperacaoCorrente() | SET KEY TO do legado (mestre-detalhe, so a carga INICIAL) |
140: *
141: *   Ordem de criacao = ordem do dump (SECAO 1): GradeOpe, Shape1+botoes,
142: *   GradePro - igual ao legado, embora nenhum destes controles se
143: *   sobreponha de fato (conferido Left+Width/Top+Height de todos contra
144: *   os vizinhos).
145: *
146: *   cmd_4c_CmdSair eh fwbtng (75x75, canonico de icone 60px - Width/Height
147: *   nao constam do dump, propriedade da classe de framework.vcx); os
148: *   outros 4 sao fwbtnp (36x36, canonico de icone 26px) - mesma convencao
149: *   de FormSigOpMpn.prg/FormSigOpMpd.prg. 455+75=530=Form.Width (igual ao
150: *   irmao FormSigOpTop, cmd_4c_Encerrar fechando exatamente na borda).
151: *   ToolTipText = "Inserir" nos 4 botoes fwbtnp (inclusive CmdExcluir e
152: *   Command1, que EXCLUEM) eh LITERAL do dump - artefato de copia do Form
153: *   Designer no legado, transcrito sem correcao por fidelidade (PILAR 1).
154: *
155: *   GradePro.Column2 (col_dpros, "Descricao") recebe .ReadOnly = .T.: o
156: *   legado bloqueia a edicao com "txt_dpros.When / Return(.f.)", que
157: *   produz o mesmo efeito estrutural - nao e logica de negocio computada,
158: *   so travar o campo (diferente do caso que a regra #46 cobre).
159: *
160: *   CarregarLista() chama BO.CarregarRegras() (SQLEXEC de crSigOpTrf/TmpOpe

*-- Linhas 166 a 278:
166: *   para a Fase 7/8 (regra #46), que tambem cobre os Click dos 5 botoes e
167: *   a gravacao em lote do Encerrar.
168: *
169: *   Nenhum BINDEVENT de Click fica nesta fase: ControlBox = .F. mas sem
170: *   Closable/MinButton declarados (regra closable_inventado_tira_a_unica_
171: *   saida), o Alt+F4 continua disponivel como saida enquanto o Encerrar
172: *   nao esta cablado - diferente do irmao FormSigOpTop, cujo cmdSair e o
173: *   UNICO botao da tela e por isso ganhou o Click junto com o AddObject.
174: *
175: * FASE 5 (esta fase): NAO SE APLICA a este form - sem stub vazio
176: *   O roteiro padrao pede ConfigurarPaginaDados() com cnt_4c_Cabecalho +
177: *   metade dos TextBoxes/Labels da Page2. Este form NAO TEM Page2/PageFrame
178: *   (eh FLAT, igual ao legado - zero "BaseClass: pageframe" no dump,
179: *   confirmado em layout.json) e o SCX nao declara NENHUM TextBox FORA das
180: *   duas grades: os 20 objetos do dump (SigOpTrf_form_codigo_fonte.txt /
181: *   layout.json) sao cntSombra+2 labels, GradeOpe (1 Column), Shape1, os 5
182: *   botoes e GradePro (2 Column) - confirmado tambem em analise.json
183: *   ("campos": []). Os unicos controles de entrada de dado sao Text1/
184: *   txt_cpros/txt_dpros DENTRO das Columns das grades (ja criados em
185: *   ConfigurarGradeOperacoes/ConfigurarGradeItens/AplicarFormatoGrade,
186: *   Fase 4), nao TextBoxes soltos numa pagina de dados.
187: *
188: *   Repetir o roteiro aqui seria (a) duplicar cnt_4c_Cabecalho, que
189: *   ConfigurarPageFrame ja criou -> "object already exists" (regra #11/
190: *   CLAUDE.md), e (b) inventar campos digitaveis que o legado nao tem
191: *   (REGRA FUNDAMENTAL - proibido inventar UI). Um metodo
192: *   ConfigurarPaginaDados() vazio so para "cumprir o roteiro" seria o stub
193: *   disfarcado que a regra de completude proibe.
194: *
195: * FASE 6 (esta fase): lookups das DUAS celulas digitaveis das grades
196: *   Este form nao tem TextBox solto numa pagina de dados (Fase 5) - os
197: *   unicos controles de entrada sao as celulas Column1 das duas grades
198: *   (GradeOpe."Operacoes" / GradePro."Produto"). BINDEVENT em evento de
199: *   celula de Grid nao eh confiavel (regra #46/CLAUDE.md): os dois
200: *   lookups foram instalados como TextBox customizado
201: *   (TextBoxOperacaoTrf_4c/TextBoxProdutoOpTrf_4c, em
202: *   classes\TextBoxGridLookup.prg), via Column.AddObject + CurrentControl +
203: *   Sparse = .F. (regra #18), em AplicarFormatoGrade - FONTE UNICA das
204: *   DUAS colunas, chamada tanto na montagem (ConfigurarGradeItens) quanto
205: *   na recarga (CarregarLista, que reseta Column.Width/CurrentControl via
206: *   RecordSource - Problema 48).
207: *
208: *   | metodo (FormSigOpTrf)              | equivalente legado |
209: *   |-------------------------------------|---------------------|
210: *   | GuardarOperacaoTrfAnterior()        | GradeOpe.Column2.Text1.When (AntValue) |
211: *   | ValidarOperacaoTrfGridExec()        | GradeOpe.Column2.Text1.Valid |
212: *   | AbrirLookupOperacaoTrfGrade(Exec)   | fwBuscaInt contra TmpOpe -> FormBuscaAuxiliar contra SigCdOpe (regra #37) |
213: *   | RecusarOperacaoTrfDuplicada()       | recusa duplicata em xOpe (Seek+Skip+Delete+MessageBox) |
214: *   | ValidarProdutoTrfGridExec()         | GradePro.col_cpros.txt_cpros.Valid |
215: *   | AbrirLookupProdutoTrfGrade(Exec)    | fwBuscaExt contra SigCdPro -> FormBuscaAuxiliar (regra #37) |
216: *   | RecusarProdutoTrfDuplicado()        | recusa duplicata em xTrf (Seek+Skip, GLOBAL entre operacoes) |
217: *   | AplicarFiltroItensPorDestino()      | fatorado de FiltrarItensPorOperacaoCorrente (Fase 4) - reaplica o SET KEY apos a edicao de Produto sem mover o cursor de operacoes |
218: *
219: *   As duas rotinas de "recusar duplicata" sao TRANSCRICAO LITERAL
220: *   (regra #17) da sequencia Seek+Skip do legado, mesmo parecendo so
221: *   capturar duplicatas quando ja ha 2+ linhas pre-existentes com o mesmo
222: *   codigo - nao e para "corrigir" aqui. A de Produto, em especial, e
223: *   GLOBAL entre todas as operacoes de destino (o legado troca para o
224: *   indice "Cpros" e "Set Order to" cancela o SET KEY ativo - fato
225: *   documentado do VFP9), apesar do resumo do cabecalho deste arquivo
226: *   dizer "na MESMA operacao".
227: *
228: *   Cancelar o picker (ESC)/nao selecionar: na celula de Operacao o
229: *   legado zera explicitamente (This.Value = Iif(Lastkey()==27,'',...)),
230: *   reproduzido tal e qual; na celula de Produto o legado NAO tem esse
231: *   zeramento (preserva o digitado) - regra #50 tambem se aplica aqui.
232: *
233: * FASE 7 (esta fase): eventos principais - os 5 botoes do legado, o filtro
234: * mestre-detalhe ao trocar de linha e a gravacao em LOTE do Encerrar
235: *
236: *   | metodo (FormSigOpTrf)           | equivalente legado |
237: *   |---------------------------------|---------------------|
238: *   | ConfigurarBINDEVENTs()          | liga os 5 Click + AfterRowColChange |
239: *   | GradeOperacoesAfterRowColChange | GradeOpe.AfterRowColChange (SET KEY mestre-detalhe) |
240: *   | CmdInserirClick()               | cmdInserir.Click  - linha nova em xOpe (Space(20)) |
241: *   | CmdExcluirClick()               | cmdExcluir.Click  - apaga a operacao de destino E os produtos dela |
242: *   | CmdInserirItemClick()           | Command2.Click    - linha nova em xTrf (origem+destino preenchidos) |
243: *   | CmdExcluirItemClick()           | Command1.Click    - apaga a linha corrente de xTrf |
244: *   | MarcarDadosAlterados()          | ThisForm.GravaDados = .t. (FONTE UNICA dos 6 sites) |
245: *   | BtnSairClick()                  | cmdSair.Click     - grava o lote e libera o dialogo |
246: *   | PersistirRegras()               | corpo do cmdSair.Click (Delete All + 2 Scan + UpDate/Commit) |
247: *   | GravarUmaRegra()                | Insert Into crSigOpTrf + Replace cIdChaves WITH fUniqueIds() |
248: *
249: *   TRES pontos que esta fase tinha de acertar e que ficam registrados aqui
250: *   porque sao fonte conhecida de defeito silencioso:
251: *
252: *   1. this_lDadosAlterados (o GravaDados do legado) passou a ser DECLARADO
253: *      como property do form. A Fase 6 ja o ATRIBUIA sem declarar: em VFP9 a
254: *      atribuicao cria a property dinamicamente, mas a LEITURA numa
255: *      instancia que nunca atribuiu - Encerrar numa tela onde o usuario nao
256: *      editou celula alguma - estouraria "Property THIS_LDADOSALTERADOS is
257: *      not found". Ver o comentario da declaracao para o porque de a
258: *      property do FORM, e nao a do BO, ser a fonte da verdade.
259: *
260: *   2. O fallback "uma linha por operacao de destino, sem produto" do
261: *      cmdSair.Click eh guardado por "Reccount([crSigOpTrf]) = 0" DEPOIS do
262: *      Delete All - e RECCOUNT conta registro MARCADO como excluido. Ou
263: *      seja, no legado ele so dispara na PRIMEIRA gravacao da operacao de
264: *      origem. O criterio foi reproduzido como (regras pre-existentes +
265: *      linhas gravadas agora) = 0; detalhe completo no cabecalho de
266: *      PersistirRegras.
267: *
268: *   3. O "DELETE for Dopeds = xOpe.Dopes" do cmdExcluir roda sob o SET KEY
269: *      ativo de xTrf, logo depende de a faixa filtrada ser a do destino que
270: *      esta sendo excluido. O filtro eh reafirmado antes do DELETE (unica
271: *      precaucao acrescentada ao handler, justificada no cabecalho de
272: *      CmdExcluirClick): sem ela, ponteiro movido por codigo deixaria
273: *      produtos orfaos, que o lote do Encerrar REGRAVARIA - a exclusao
274: *      pareceria nao funcionar, sem erro algum na tela.
275: *
276: *   Acrescentado ao BO nesta fase: ApagarRegrasDaOrigem() - o "SELECT
277: *   crSigOpTrf / DELETE ALL" do legado. Fica no BO porque eh SQL (PILAR 3);
278: *   Excluir() por cidchaves nao serve (o legado nao tem exclusao unitaria e

*-- Linhas 359 a 402:
359: 
360:     *-- crSigCdOpe.Dopes do legado - codigo da operacao de ORIGEM cujas
361:     *-- regras de transferencia serao editadas. Repassado ao BO em
362:     *-- InicializarForm (THIS.this_oBusinessObject.this_cDopes)
363:     this_cDopes = ""
364: 
365:     *-- pnDataSes do legado - informativo (DataSession = 1 ja unifica a
366:     *-- sessao com o pai, ver comentario de DataSession abaixo)
367:     this_nDataSessionPai = 0
368: 
369:     *--------------------------------------------------------------------------
370:     * ESTADO DOS LOOKUPS DE CELULA (FASE 6) - ver ConfigurarGradeOperacoes/
371:     * ConfigurarGradeItens (instalacao dos TextBox customizados em
372:     * classes\TextBoxGridLookup.prg) e os metodos Validar*/AbrirLookup*
373:     * abaixo.
374:     *--------------------------------------------------------------------------
375: 
376:     *-- Legado: Thisform.AntValue - snapshot do valor da celula "Operacoes"
377:     *-- ANTES da edicao (GradeOpe.Column2.Text1.When), usado por
378:     *-- ValidarOperacaoTrfGridExec para saber se o usuario realmente mudou
379:     *-- o codigo digitado
380:     this_cValorAnteriorOperacao = ""
381: 
382:     *-- Guardas de reentrancia (regra #47): o picker eh MODAL, tira o foco
383:     *-- da celula e redispara o proprio Valid/KeyPress que o chamou
384:     this_lEmLookupOperacao = .F.
385:     this_lEmLookupProduto  = .F.
386: 
387:     *--------------------------------------------------------------------------
388:     * ESTADO DE EDICAO (FASE 7)
389:     *--------------------------------------------------------------------------
390: 
391:     *-- Legado: ThisForm.GravaDados (property customizada do SCX - ver
392:     *-- RESERVED3/ClassInfo no fim do dump: antvalue/gravadados/parentform/
393:     *-- podatamgr). Ligada por TODO caminho que muda a lista de operacoes de
394:     *-- destino ou a de produtos (os 4 botoes de grade e os dois Valid de
395:     *-- celula) e LIDA pelo cmdSair.Click ("If ThisForm.GravaDados") para
396:     *-- decidir se o lote precisa ser regravado.
397:     *--
398:     *-- DECLARACAO OBRIGATORIA, nao decorativa: a Fase 6 ja ATRIBUIA
399:     *-- THIS.this_lDadosAlterados (ValidarOperacaoTrfGridExec/
400:     *-- ValidarProdutoTrfGridExec) sem que a property existisse. Em VFP9 a
401:     *-- ATRIBUICAO cria a property dinamicamente e passa limpo, mas a
402:     *-- LEITURA numa instancia que ainda nao atribuiu nada - exatamente o

*-- Linhas 423 a 466:
423:     Width       = 530
424: 
425:     *-- Caption do SCX ("Opera??es Autom?ticas") - sobrescrito em
426:     *-- InicializarForm com o codigo da operacao de origem, igual ao
427:     *-- legado (.Caption = 'Operacoes Automaticas P/ ' +
428:     *-- AllTrim(crSigCdOpe.Dopes))
429:     Caption = "Opera" + CHR(231) + CHR(245) + "es Autom" + CHR(225) + "ticas"
430: 
431:     *-- ControlBox = .F. / Movable = .F. / TitleBar = 0 / ClipControls = .F.
432:     *-- - literais do dump. MaxButton/Closable/MinButton NAO declarados no
433:     *-- SCX -> NAO inventar (regra closable_inventado_tira_a_unica_saida):
434:     *-- o default .T. deixa o Alt+F4 funcionando, que eh uma das saidas
435:     *-- alem do Encerrar (sem barra de titulo nao ha X na janela, so o
436:     *-- ControlBox = .F. remove o icone de sistema)
437:     ControlBox   = .F.
438:     Movable      = .F.
439:     TitleBar     = 0
440:     ClipControls = .F.
441: 
442:     *-- AutoCenter = .T. do SCX - DIFERENTE do irmao FormSigOpTop (que
443:     *-- calcula Top/Left manualmente a partir da grade do pai). SigOpTrf
444:     *-- nao faz esse calculo no Init legado - centraliza na tela.
445:     AutoCenter = .T.
446: 
447:     *-- WindowType = 1 (modal): o pai abre este dialogo e precisa que o
448:     *-- Show() bloqueie ate o usuario Encerrar (legado: .ParentForm.Enabled
449:     *-- = .f. enquanto este form esta aberto, emulando modalidade)
450:     WindowType = 1
451: 
452:     *-- ShowWindow = 1 ("In Top-Level Form"): canonico do projeto
453:     ShowWindow = 1
454: 
455:     *-- Fonte base (os controles do cabecalho declaram a propria fonte -
456:     *-- Tahoma 18 - transcrita em ConfigurarPageFrame)
457:     FontName = "Tahoma"
458:     FontSize = 8
459: 
460:     *-- DataSession = 1 (sessao CORRENTE, NAO privada). O legado declara
461:     *-- DataSession = 2 no SCX mas o proprio Init sobrescreve com "Set
462:     *-- DataSession To pnDataSes", ou seja: na pratica este dialogo roda
463:     *-- SEMPRE na sessao do form pai. DataSession = 1 eh a reproducao
464:     *-- direta desse resultado, sem a troca manual de sessao - mesmo
465:     *-- padrao adotado em FormSigOpTop.prg/FormSigOpSts.prg/
466:     *-- FormSigOpSqn.prg/FormSigOpSlc.prg/FormSigOpSpr.prg

*-- Linhas 472 a 730:
472:     * DataSession para ler crSigCdOpe.Dopes direto do cursor do pai; mesma
473:     * convencao dos dialogos irmaos desta familia).
474:     *==========================================================================
475:     PROCEDURE Init
476:         LPARAMETERS par_oFormPai, par_cDopes, par_nDataSessionPai
477: 
478:         IF VARTYPE(par_oFormPai) = "O"
479:             THIS.this_oFormPai = par_oFormPai
480:         ENDIF
481: 
482:         THIS.this_cDopes          = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")
483:         THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSessionPai) = "N", par_nDataSessionPai, 0)
484: 
485:         *-- DODEFAULT chama FormBase.Init (fix SET DATE/CENTURY) e em
486:         *-- seguida THIS.InicializarForm()
487:         RETURN DODEFAULT()
488:     ENDPROC
489: 
490:     *==========================================================================
491:     * ValidarParametros - precondicao deste dialogo: sem form pai nao ha
492:     * quem reabilitar, e sem operacao de origem nao ha regra de
493:     * transferencia nenhuma para editar (o legado tambem depende dessas
494:     * referencias em todo o Init - crSigCdOpe.Dopes/ThisForm.ParentForm.*).
495:     *
496:     * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
497:     * de fora, e PROTECTED faria a chamada externa estourar em runtime.
498:     *
499:     * Bypass em modo teste/validacao de UI no TOPO: o ValidarUIFidelity e o
500:     * TesteAutomatico instanciam o form SEM ARGUMENTO NENHUM, e sem o
501:     * bypass a instanciacao reprovaria sempre.
502:     *
503:     * Os RETURN ficam FORA de TRY/CATCH (regra #1) - este metodo nao abre
504:     * bloco algum.
505:     *==========================================================================
506:     PROCEDURE ValidarParametros
507:         LOCAL loc_lValido
508:         loc_lValido = .T.
509: 
510:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
511:             RETURN .T.
512:         ENDIF
513: 
514:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
515:             RETURN .T.
516:         ENDIF
517: 
518:         IF VARTYPE(THIS.this_oFormPai) != "O"
519:             MsgErro("Esta tela s" + CHR(243) + " pode ser aberta a partir do " + ;
520:                     "Cadastro de Opera" + CHR(231) + CHR(245) + "es do Caixa.", ;
521:                     "Opera" + CHR(231) + CHR(245) + "es Autom" + CHR(225) + "ticas")
522:             loc_lValido = .F.
523:         ENDIF
524: 
525:         IF EMPTY(THIS.this_cDopes)
526:             MsgErro("Opera" + CHR(231) + CHR(227) + "o de origem n" + CHR(227) + "o informada.", ;
527:                     "Opera" + CHR(231) + CHR(245) + "es Autom" + CHR(225) + "ticas")
528:             loc_lValido = .F.
529:         ENDIF
530: 
531:         RETURN loc_lValido
532:     ENDPROC
533: 
534:     *==========================================================================
535:     * InicializarForm - estrutura base do dialogo
536:     *
537:     * Hook chamado pelo FormBase.Init. Retorna .T. em sucesso e .F. em falha
538:     * (nesse caso o CREATEOBJECT do chamador devolve logico, nao objeto).
539:     *==========================================================================
540:     PROTECTED PROCEDURE InicializarForm
541:         LOCAL loc_lSucesso, loc_oErro
542:         loc_lSucesso = .F.
543: 
544:         *-- Guarda de precondicao ANTES do TRY, para o RETURN nao ficar
545:         *-- dentro de TRY/CATCH (regra #1)
546:         IF !THIS.ValidarParametros()
547:             RETURN .F.
548:         ENDIF
549: 
550:         TRY
551:             *-- Business Object das Fases 1-2
552:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpTrfBO")
553: 
554:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
555:                 MsgErro("Falha ao criar SigOpTrfBO.", "Opera" + CHR(231) + CHR(245) + "es Autom" + CHR(225) + "ticas")
556:             ELSE
557:                 *-- Contexto no BO (operacao de origem - this_cDopes do BO
558:                 *-- eh a mesma property declarada em SigOpTrfBO.prg)
559:                 THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes
560: 
561:                 *-- Legado: .ParentForm.Enabled = .f.
562:                 THIS.CarregarContextoFormPai()
563: 
564:                 *-- Legado: .Caption = 'Operacoes Automaticas P/ ' +
565:                 *-- AllTrim(crSigCdOpe.Dopes)
566:                 THIS.Caption = "Opera" + CHR(231) + CHR(245) + "es Autom" + CHR(225) + "ticas P/ " + ;
567:                                ALLTRIM(THIS.this_cDopes)
568: 
569:                 THIS.this_oBusinessObject.this_cTituloDialogo = THIS.Caption
570: 
571:                 *-- Fundo do form (Picture do SCX)
572:                 THIS.ConfigurarDecoracao()
573: 
574:                 *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO
575:                 *-- AddObject do form, igual ao SCX
576:                 THIS.ConfigurarPageFrame()
577: 
578:                 *-- GradeOpe, Shape1+botoes, GradePro - nesta ordem (dump)
579:                 THIS.ConfigurarGradeOperacoes()
580:                 THIS.ConfigurarBotoes()
581:                 THIS.ConfigurarGradeItens()
582: 
583:                 *-- FASE 7: Click dos 5 botoes + AfterRowColChange da grade
584:                 *-- superior (mestre-detalhe). DEPOIS dos AddObject - sem o
585:                 *-- controle criado, o BINDEVENT estouraria no bind
586:                 THIS.ConfigurarBINDEVENTs()
587: 
588:                 *-- AddObject cria controle com Visible = .F.
589:                 THIS.TornarControlesVisiveis(THIS)
590: 
591:                 *-- Legado: o Init termina consultando SigOpTrf/SigCdOpe e
592:                 *-- ligando as duas grades ao resultado. Pulado em modo
593:                 *-- teste/validacao de UI (padrao FormCor/FormSigOpTop): la
594:                 *-- nao ha gnConnHandle nem operacao de origem, entao a
595:                 *-- carga so produziria ruido de erro no log do harness. As
596:                 *-- grades ficam vazias, com as colunas ja formatadas por
597:                 *-- AplicarFormatoGrade. O harness chama CarregarLista de
598:                 *-- fora quando quer exercita-la
599:                 IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) AND ;
600:                    !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
601:                     THIS.CarregarLista()
602:                 ENDIF
603: 
604:                 loc_lSucesso = .T.
605:             ENDIF
606: 
607:         CATCH TO loc_oErro
608:             THIS.this_cMensagemErro = loc_oErro.Message
609:             MsgErro("Erro ao inicializar FormSigOpTrf: " + loc_oErro.Message + ;
610:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
611:                     " | Procedure: " + loc_oErro.Procedure, "Erro")
612:             loc_lSucesso = .F.
613:         ENDTRY
614: 
615:         RETURN loc_lSucesso
616:     ENDPROC
617: 
618:     *==========================================================================
619:     * CarregarContextoFormPai - migra para o form o que o Init legado faz
620:     * com o form pai:
621:     *
622:     *     ThisForm.ParentForm = poForm
623:     *     ThisForm.ParentForm.Enabled = .f.
624:     *
625:     * (crSigCdOpe.Dopes ja foi recebido via parametro no Init deste form -
626:     * ver cabecalho do arquivo). Protegido por PEMSTATUS/VARTYPE: em modo
627:     * teste (gb_4c_ModoTeste/gb_4c_ValidandoUI) o form pai pode ser .NULL.
628:     * ou um stub sem essa property, e a ausencia aqui NAO eh falha de
629:     * inicializacao (ValidarParametros ja fez o bypass acima).
630:     *==========================================================================
631:     PROTECTED PROCEDURE CarregarContextoFormPai
632:         IF VARTYPE(THIS.this_oFormPai) = "O"
633:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
634:                 THIS.this_oFormPai.Enabled = .F.
635:             ENDIF
636:         ENDIF
637:     ENDPROC
638: 
639:     *==========================================================================
640:     * ConfigurarDecoracao - Picture do form (new_background.jpg do legado)
641:     *==========================================================================
642:     PROTECTED PROCEDURE ConfigurarDecoracao
643:         LOCAL loc_cImagemFundo
644:         loc_cImagemFundo = ""
645: 
646:         IF TYPE("gc_4c_CaminhoIcones") = "C"
647:             loc_cImagemFundo = gc_4c_CaminhoIcones + "new_background.jpg"
648:         ENDIF
649: 
650:         IF !EMPTY(loc_cImagemFundo) AND FILE(loc_cImagemFundo)
651:             THIS.Picture = loc_cImagemFundo
652:         ENDIF
653:     ENDPROC
654: 
655:     *==========================================================================
656:     * ConfigurarPageFrame - cntSombra do legado -> cnt_4c_Cabecalho. Nome do
657:     * metodo mantido por paridade com os demais dialogos filhos desta
658:     * familia (FormSigOpTop.prg/FormSigOpSts.prg/FormSigOpSqn.prg/
659:     * FormSigOpSlc.prg/FormSigOpSpr.prg usam o mesmo nome), mesmo sem
660:     * PageFrame real - este form eh FLAT, igual ao legado (SIGOPTRF nao
661:     * tem PageFrame no SCX).
662:     *
663:     * Transcricao do dump (SigOpTrf_form_codigo_fonte.txt):
664:     *   cntSombra  Top=0  Left=0  Width=800  Height=80  BorderWidth=0
665:     *              BackColor=100,100,100
666:     *   lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
667:     *              Tahoma 18 bold, FontUnderline=.F., WordWrap=.T.,
668:     *              Alignment=0, BackStyle=0
669:     *   lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
670:     *              Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
671:     *
672:     * O Init legado sobrescreve os dois Caption com ThisForm.Caption
673:     * ("Operacoes Automaticas P/ <operacao>"), por isso .Caption =
674:     * THIS.Caption (dinamico) - o literal do dump ("Cadastro de Testes") eh
675:     * so o default do Form Designer, nunca chega a ser exibido.
676:     *
677:     * Width do container usa THIS.Width - padrao canonico da faixa, regra
678:     * #11 - em vez do literal 800: o SCX declara o CONTAINER mais largo que
679:     * o proprio form (530), artefato do Form Designer ja catalogado
680:     * (cabecalho_label_width_dump_maior_que_form) - copiar o literal 769
681:     * nos labels extrapolaria os 530px visiveis e cortaria o titulo. Os
682:     * labels usam THIS.Width - 20, mesma margem de 10px dos dois lados
683:     * aplicada pelo irmao FormSigOpTop.prg.
684:     *
685:     * AutoSize = .F. explicito nos dois labels: com WordWrap = .T. o
686:     * AutoSize DESCARTA a Height e colapsa o texto para uma linha (regra
687:     * #23), e os 40/46 do dump sao o tamanho ja calculado pelo Form
688:     * Designer.
689:     *==========================================================================
690:     PROTECTED PROCEDURE ConfigurarPageFrame
691:         *-- Container da faixa (cntSombra)
692:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
693:         WITH THIS.cnt_4c_Cabecalho
694:             .Top           = 0
695:             .Left          = 0
696:             .Width         = THIS.Width
697:             .Height        = 80
698:             .BorderWidth   = 0
699:             .BackStyle     = 1
700:             .BackColor     = RGB(100, 100, 100)
701:             .SpecialEffect = 0
702:             .Visible       = .T.
703:         ENDWITH
704: 
705:         *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
706:         *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
707:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
708:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
709:             .AutoSize      = .F.
710:             .FontBold      = .T.
711:             .FontName      = "Tahoma"
712:             .FontSize      = 18
713:             .FontUnderline = .F.
714:             .WordWrap      = .T.
715:             .Alignment     = 0
716:             .BackStyle     = 0
717:             .Caption       = THIS.Caption
718:             .Top           = 18
719:             .Left          = 10
720:             .Width         = THIS.Width - 20
721:             .Height        = 40
722:             .ForeColor     = RGB(0, 0, 0)
723:             .Rotation      = 0
724:             .Visible       = .T.
725:         ENDWITH
726: 
727:         *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
728:         *-- aqui porque o container eh OPACO e escuro (excecao prevista na
729:         *-- regra #12)
730:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")

*-- Linhas 775 a 818:
775:     * AplicarFormatoGrade, chamada ao final de ConfigurarGradeItens (apos
776:     * as DUAS grades existirem).
777:     *==========================================================================
778:     PROTECTED PROCEDURE ConfigurarGradeOperacoes
779:         THIS.AddObject("grd_4c_Operacoes", "Grid")
780:         WITH THIS.grd_4c_Operacoes
781:             .ColumnCount   = 1
782:             .FontName      = "Tahoma"
783:             .FontSize      = 8
784:             .Top           = 133
785:             .Left          = 5
786:             .Height        = 221
787:             .Width         = 180
788:             .ScrollBars    = 2
789:             .DeleteMark    = .F.
790:             .RecordMark    = .F.
791:             .GridLineColor = RGB(238, 238, 238)
792:             .Visible       = .T.
793:         ENDWITH
794:     ENDPROC
795: 
796:     *==========================================================================
797:     * ConfigurarBotoes - Shape1 + cmdSair/cmdInserir/cmdExcluir/Command2/
798:     * Command1 do legado.
799:     *
800:     * Shape1 PRIMEIRO (ordem do dump): BackStyle=0 + BorderStyle=0 (nao
801:     * desenha nada), mas a area dele (Top 12..122 / Left 432..522) invade
802:     * o canto do botao Encerrar (Top 3..78 / Left 455..530) - criado
803:     * depois, o retangulo invisivel ficaria por cima e bloquearia o
804:     * clique sem aparecer em screenshot (regra #30).
805:     *
806:     * Transcricao do dump:
807:     *   Shape1    Top=12 Left=432 Height=110 Width=90 BorderColor=136,189,188
808:     *   cmdSair   Top=3  Left=455 Picture=cadastro_sair_60.jpg Cancel=.T.
809:     *             Caption="Encerrar" TabIndex=8 (classe fwbtng)
810:     *   cmdInserir Top=91 Left=5   Picture=cadastro_inserir_26.jpg (fwbtnp)
811:     *   cmdExcluir Top=91 Left=45  Picture=cadastro_excluir_26.jpg (fwbtnp)
812:     *   Command2   Top=91 Left=190 Picture=cadastro_inserir_26.jpg (fwbtnp)
813:     *   Command1   Top=91 Left=230 Picture=cadastro_excluir_26.jpg (fwbtnp)
814:     *
815:     * Width/Height NAO constam do dump (propriedade da classe de
816:     * framework.vcx) - canonicos do projeto: fwbtng=75x75 (icone 60px),
817:     * fwbtnp=36x36 (icone 26px), mesma convencao de FormSigOpMpn.prg/
818:     * FormSigOpMpd.prg. 455+75=530=Form.Width (fecha exatamente na borda,

*-- Linhas 829 a 875:
829:     * atribuido se o arquivo existir - .Picture inexistente falha em
830:     * SILENCIO (regra #25).
831:     *
832:     * NENHUM BINDEVENT de Click aqui - fica para a Fase 7/8 (ver cabecalho
833:     * do arquivo).
834:     *==========================================================================
835:     PROTECTED PROCEDURE ConfigurarBotoes
836:         LOCAL loc_cIconeInserir, loc_cIconeExcluir, loc_cIconeSair
837:         loc_cIconeInserir = ""
838:         loc_cIconeExcluir = ""
839:         loc_cIconeSair    = ""
840: 
841:         IF TYPE("gc_4c_CaminhoIcones") = "C"
842:             loc_cIconeInserir = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
843:             loc_cIconeExcluir = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
844:             loc_cIconeSair    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
845:         ENDIF
846: 
847:         *-- Shape1 (decoracao invisivel) - PRIMEIRO, ver acima
848:         THIS.AddObject("shp_4c_Shape1", "Shape")
849:         WITH THIS.shp_4c_Shape1
850:             .Top         = 12
851:             .Left        = 432
852:             .Height      = 110
853:             .Width       = 90
854:             .BackStyle   = 0
855:             .BorderStyle = 0
856:             .BorderColor = RGB(136, 189, 188)
857:             .Visible     = .T.
858:         ENDWITH
859: 
860:         *-- cmdSair ("Encerrar") -> cmd_4c_CmdSair
861:         THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
862:         WITH THIS.cmd_4c_CmdSair
863:             .Top          = 3
864:             .Left         = 455
865:             .Width        = 75
866:             .Height       = 75
867:             .Caption      = "Encerrar"
868:             .Cancel       = .T.
869:             .TabIndex     = 8
870:             .FontName     = "Comic Sans MS"
871:             .FontSize     = 8
872:             .FontBold     = .T.
873:             .FontItalic   = .T.
874:             .WordWrap     = .T.
875:             .AutoSize     = .F.

*-- Linhas 1008 a 1051:
1008:     * grades - CarregarLista reaplica depois do RecordSource, que os zera
1009:     * (Problema 48).
1010:     *==========================================================================
1011:     PROTECTED PROCEDURE ConfigurarGradeItens
1012:         THIS.AddObject("grd_4c_Itens", "Grid")
1013:         WITH THIS.grd_4c_Itens
1014:             .ColumnCount = 2
1015:             .Top         = 133
1016:             .Left        = 190
1017:             .Height      = 220
1018:             .Width       = 335
1019:             .ScrollBars  = 2
1020:             .TabIndex    = 8
1021:             .DeleteMark  = .F.
1022:             .RecordMark  = .F.
1023:             .Visible     = .T.
1024:         ENDWITH
1025: 
1026:         THIS.AplicarFormatoGrade()
1027:     ENDPROC
1028: 
1029:     *==========================================================================
1030:     * AplicarFormatoGrade - FONTE UNICA da geometria das colunas das DUAS
1031:     * grades (regra do Problema 48 - RecordSource zera Column.Width e
1032:     * Header1.Caption, entao este metodo e chamado de novo em
1033:     * CarregarLista, depois do bind).
1034:     *
1035:     * Transcricao do dump:
1036:     *   GradeOpe.Column2 ("Operacoes")      - Width=150, Tahoma 8
1037:     *     Header1  Tahoma 8 Alignment=2 Caption="Operacoes"
1038:     *     Text1    BorderStyle=0 Margin=0 ForeColor=0,0,0 BackColor=255,255,255
1039:     *   GradePro.col_cpros ("Produto")      - Width=108, Courier New, Alignment=3
1040:     *     hdr_cpros Tahoma 8 Alignment=2 Caption="Produto"
1041:     *     txt_cpros Courier New BorderStyle=0 Format="!" Margin=0 MaxLength=10
1042:     *               ForeColor=0,0,0 BackColor=255,255,255
1043:     *   GradePro.col_dpros ("Descricao")    - Width=205, Courier New 9
1044:     *     hdr_dpros Tahoma 8 Alignment=2 Caption="Descricao"
1045:     *     txt_dpros Courier New 9 BorderStyle=0 Format="!" Margin=0 MaxLength=40
1046:     *               ForeColor=0,0,0 BackColor=255,255,255
1047:     *
1048:     * Column1 do dump (GradeOpe) chama-se "Column2"; Column1/Column2 de
1049:     * GradePro chamam-se "col_cpros"/"col_dpros" - renomes internos do
1050:     * Form Designer sem efeito na API (regra #34): sempre .Column1/
1051:     * .Column2, por POSICAO.

*-- Linhas 1060 a 1112:
1060:     *
1061:     * FASE 6: Column1 das DUAS grades recebe o TextBox customizado de
1062:     * lookup (classes\TextBoxGridLookup.prg) via AddObject + CurrentControl
1063:     * + Sparse = .F. (regra #18) - BINDEVENT em evento de celula de Grid
1064:     * nao eh confiavel (regra #46). Guard IF !PEMSTATUS(...) antes do
1065:     * AddObject: este metodo roda de novo em CarregarLista (Problema 48,
1066:     * RecordSource reseta Column.Width/Header1.Caption) e o 2o AddObject
1067:     * estouraria "Object ... is already defined".
1068:     *
1069:     * Metodo PUBLIC: chamado pela montagem (ConfigurarGradeItens) E pela
1070:     * recarga (CarregarLista), e o harness de teste o alcanca de fora.
1071:     *==========================================================================
1072:     PROCEDURE AplicarFormatoGrade
1073:         LOCAL loc_lAplicou
1074:         loc_lAplicou = .F.
1075: 
1076:         IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
1077:             WITH THIS.grd_4c_Operacoes
1078:                 .Column1.Width             = 150
1079:                 .Column1.Movable           = .F.
1080:                 .Column1.Resizable         = .F.
1081:                 .Column1.FontName          = "Tahoma"
1082:                 .Column1.FontSize          = 8
1083:                 .Column1.Header1.Caption   = "Opera" + CHR(231) + CHR(245) + "es"
1084:                 .Column1.Header1.FontName  = "Tahoma"
1085:                 .Column1.Header1.FontSize  = 8
1086:                 .Column1.Header1.Alignment = 2
1087:                 .Column1.Header1.ForeColor = RGB(90, 90, 90)
1088: 
1089:                 *-- Lookup de operacao de destino (legado:
1090:                 *-- GradeOpe.Column2.Text1.Valid/When, fwBuscaInt contra
1091:                 *-- TmpOpe + recusa duplicata em xOpe)
1092:                 IF !PEMSTATUS(.Column1, "txt_4c_CelOperacao", 5)
1093:                     .Column1.AddObject("txt_4c_CelOperacao", "TextBoxOperacaoTrf_4c")
1094:                 ENDIF
1095:                 .Column1.CurrentControl = "txt_4c_CelOperacao"
1096:                 .Column1.Sparse         = .F.
1097:                 .Column1.ReadOnly       = .F.
1098:             ENDWITH
1099: 
1100:             loc_lAplicou = .T.
1101:         ENDIF
1102: 
1103:         IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
1104:             WITH THIS.grd_4c_Itens
1105:                 *-- Column1 (col_cpros) - "Produto", EDITAVEL (Valid com
1106:                 *-- lookup contra SigCdPro)
1107:                 .Column1.Width             = 108
1108:                 .Column1.Movable           = .F.
1109:                 .Column1.Resizable         = .F.
1110:                 .Column1.FontName          = "Courier New"
1111:                 .Column1.Alignment         = 3
1112:                 .Column1.Header1.Caption   = "Produto"

*-- Linhas 1201 a 1244:
1201:     *
1202:     * RETURN unico, FORA do TRY/CATCH (regra #1).
1203:     *==========================================================================
1204:     PROCEDURE CarregarLista
1205:         LOCAL loc_lCarregou, loc_cAliasOperacoes, loc_cAliasItens, loc_oErro
1206:         loc_lCarregou = .F.
1207: 
1208:         IF !PEMSTATUS(THIS, "grd_4c_Operacoes", 5) OR !PEMSTATUS(THIS, "grd_4c_Itens", 5)
1209:             RETURN .F.
1210:         ENDIF
1211: 
1212:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1213:             RETURN .F.
1214:         ENDIF
1215: 
1216:         loc_cAliasOperacoes = THIS.this_oBusinessObject.this_cCursorOperacoes
1217:         loc_cAliasItens     = THIS.this_oBusinessObject.this_cCursorItens
1218: 
1219:         IF VARTYPE(loc_cAliasOperacoes) != "C" OR EMPTY(loc_cAliasOperacoes) OR ;
1220:            VARTYPE(loc_cAliasItens) != "C" OR EMPTY(loc_cAliasItens)
1221:             RETURN .F.
1222:         ENDIF
1223: 
1224:         TRY
1225:             *-- FASE 8: zera a ficha da LINHA no funil de carga, para a linha
1226:             *-- de uma sessao nunca vazar para a seguinte (e repoe a operacao
1227:             *-- de origem no BO, que eh de onde CarregarRegras a le)
1228:             THIS.LimparCampos()
1229: 
1230:             *-- Legado: AddCursor/CursorQuery + expansao (crSigOpTrf -> xTrf/xOpe)
1231:             IF THIS.this_oBusinessObject.CarregarRegras() AND ;
1232:                USED(loc_cAliasOperacoes) AND USED(loc_cAliasItens)
1233: 
1234:                 THIS.grd_4c_Operacoes.ColumnCount  = 1
1235:                 THIS.grd_4c_Operacoes.RecordSource = loc_cAliasOperacoes
1236: 
1237:                 WITH THIS.grd_4c_Operacoes
1238:                     .Column1.ControlSource = loc_cAliasOperacoes + ".Dopes"
1239:                 ENDWITH
1240: 
1241:                 THIS.grd_4c_Itens.ColumnCount  = 2
1242:                 THIS.grd_4c_Itens.RecordSource = loc_cAliasItens
1243: 
1244:                 WITH THIS.grd_4c_Itens

*-- Linhas 1280 a 1530:
1280:             THIS.this_cMensagemErro = loc_oErro.Message
1281:             MsgErro("Erro ao carregar as regras de transfer" + CHR(234) + "ncia: " + loc_oErro.Message + ;
1282:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1283:                     " | Procedure: " + loc_oErro.Procedure, THIS.Caption)
1284:             loc_lCarregou = .F.
1285:         ENDTRY
1286: 
1287:         RETURN loc_lCarregou
1288:     ENDPROC
1289: 
1290:     *==========================================================================
1291:     * FiltrarItensPorOperacaoCorrente - reproduz o filtro mestre-detalhe
1292:     * do FIM do Init legado:
1293:     *
1294:     *     Select xOpe   / Set Order to       / Go Top
1295:     *     Select xTrf   / Set Order to Dopes
1296:     *     SET KEY TO crSigCdOpe.Dopes+xOpe.Dopes
1297:     *     Go Top
1298:     *
1299:     * crSigCdOpe.Dopes e xOpe.Dopes no legado sao campos CHAR(20) (largura
1300:     * fixa) e a concatenacao direta ja produz os 40 chars da chave
1301:     * indexada ("Dopes + Dopeds Tag Dopes" criado em CarregarRegras) - a
1302:     * mesma chave POSICIONAL da regra #42. THIS.this_cDopes, aqui, e uma
1303:     * variavel ALLTRIM'd (nao um campo), por isso precisa de PADR(...,20)
1304:     * explicito; this_cCursorOperacoes.Dopes e lido SEM ALLTRIM (mantendo
1305:     * o padding do CHAR(20) de origem) para reproduzir a mesma largura.
1306:     *
1307:     * So filtra quando ha pelo menos 1 operacao de destino (xOpe nao
1308:     * vazio) - com xOpe vazio, xTrf tambem esta vazio (toda linha de xTrf
1309:     * nasce com um Dopeds correspondente em xOpe, em CarregarRegras), e
1310:     * "SET KEY TO" sem argumento (limpa o filtro) e o equivalente seguro.
1311:     *==========================================================================
1312:     PROTECTED PROCEDURE FiltrarItensPorOperacaoCorrente
1313:         LOCAL loc_cAliasOperacoes, loc_cAliasItens, loc_cDopedsAtual
1314: 
1315:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1316:             RETURN
1317:         ENDIF
1318: 
1319:         loc_cAliasOperacoes = THIS.this_oBusinessObject.this_cCursorOperacoes
1320:         loc_cAliasItens      = THIS.this_oBusinessObject.this_cCursorItens
1321: 
1322:         IF VARTYPE(loc_cAliasOperacoes) != "C" OR EMPTY(loc_cAliasOperacoes) OR !USED(loc_cAliasOperacoes) OR ;
1323:            VARTYPE(loc_cAliasItens) != "C" OR EMPTY(loc_cAliasItens) OR !USED(loc_cAliasItens)
1324:             RETURN
1325:         ENDIF
1326: 
1327:         SELECT (loc_cAliasOperacoes)
1328:         SET ORDER TO
1329:         GO TOP
1330: 
1331:         loc_cDopedsAtual = IIF(!EOF(loc_cAliasOperacoes), dopes, "")
1332: 
1333:         THIS.AplicarFiltroItensPorDestino(loc_cDopedsAtual)
1334:     ENDPROC
1335: 
1336:     *==========================================================================
1337:     * AplicarFiltroItensPorDestino - FONTE UNICA do "SET KEY TO
1338:     * crSigCdOpe.Dopes+xOpe.Dopes" do legado (fatorado de
1339:     * FiltrarItensPorOperacaoCorrente, FASE 6): quem muda a operacao de
1340:     * destino corrente (carga inicial - par_cDopesDestino vem do GO TOP de
1341:     * this_cCursorOperacoes - ou RecusarProdutoTrfDuplicado, que reaplica o
1342:     * filtro com o Dopes da linha ATIVA sem mover o cursor de operacoes)
1343:     * chama este metodo, em vez de duplicar o SET ORDER/SET KEY.
1344:     *
1345:     * PADR(...,20) - mesma chave POSICIONAL do metodo que o chama (regra
1346:     * #42): THIS.this_cDopes e variavel ALLTRIM'd, por isso precisa do
1347:     * padding explicito; par_cDopesDestino vem direto do campo CHAR(20) do
1348:     * cursor, ja com o padding original.
1349:     *==========================================================================
1350:     PROTECTED PROCEDURE AplicarFiltroItensPorDestino(par_cDopesDestino)
1351:         LOCAL loc_cAliasItens
1352: 
1353:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1354:             RETURN
1355:         ENDIF
1356: 
1357:         loc_cAliasItens = THIS.this_oBusinessObject.this_cCursorItens
1358: 
1359:         IF VARTYPE(loc_cAliasItens) != "C" OR EMPTY(loc_cAliasItens) OR !USED(loc_cAliasItens)
1360:             RETURN
1361:         ENDIF
1362: 
1363:         SELECT (loc_cAliasItens)
1364:         SET ORDER TO Dopes
1365: 
1366:         IF VARTYPE(par_cDopesDestino) = "C" AND !EMPTY(ALLTRIM(NVL(par_cDopesDestino, "")))
1367:             SET KEY TO PADR(ALLTRIM(THIS.this_cDopes), 20) + par_cDopesDestino
1368:         ELSE
1369:             SET KEY TO
1370:         ENDIF
1371: 
1372:         GO TOP
1373:     ENDPROC
1374: 
1375:     *==========================================================================
1376:     * GuardarOperacaoTrfAnterior - snapshot do valor da celula "Operacoes"
1377:     * ANTES da edicao (legado: GradeOpe.Column2.Text1.When -> Thisform.
1378:     * AntValue = This.Value). Usado por ValidarOperacaoTrfGridExec para
1379:     * saber se o usuario realmente mudou o codigo digitado.
1380:     *
1381:     * PUBLIC: chamado de fora da classe (THISFORM) pelo TextBox da coluna
1382:     * (TextBoxOperacaoTrf_4c.When, em classes\TextBoxGridLookup.prg).
1383:     *==========================================================================
1384:     PROCEDURE GuardarOperacaoTrfAnterior(par_oTxt)
1385:         IF VARTYPE(par_oTxt) = "O"
1386:             THIS.this_cValorAnteriorOperacao = par_oTxt.Value
1387:         ENDIF
1388:     ENDPROC
1389: 
1390:     *==========================================================================
1391:     * ValidarOperacaoTrfGridExec - Valid da celula "Operacoes" (Column1) de
1392:     * grd_4c_Operacoes. par_oTxt eh o TextBox da coluna (regra #46): dentro
1393:     * do Valid, o valor digitado esta em par_oTxt.Value e AINDA NAO chegou
1394:     * ao cursor.
1395:     *
1396:     * Equivalente ao legado (GradeOpe.Column2.Text1.Valid):
1397:     *   If IsEmpty(This.Value) / Return .f. (nao deixa a celula em branco -
1398:     *   cmdInserir insere a linha vazia e foca aqui, Fase 7/8)
1399:     *   If Not IsEmpty(This.Value) And Thisform.AntValue # This.Value
1400:     *       ThisForm.GravaDados = .t.
1401:     *       <lookup + recusa de duplicata, delegados abaixo>
1402:     *   EndIf
1403:     *
1404:     * PUBLIC: chamado de fora da classe pelo TextBox da coluna.
1405:     *==========================================================================
1406:     FUNCTION ValidarOperacaoTrfGridExec(par_oTxt)
1407:         IF VARTYPE(par_oTxt) != "O"
1408:             RETURN .T.
1409:         ENDIF
1410: 
1411:         *-- Legado: If IsEmpty(This.Value) / Return .f.
1412:         IF EMPTY(ALLTRIM(par_oTxt.Value))
1413:             RETURN .F.
1414:         ENDIF
1415: 
1416:         *-- Legado: If Not IsEmpty(This.Value) And Thisform.AntValue # This.Value
1417:         IF par_oTxt.Value == THIS.this_cValorAnteriorOperacao
1418:             RETURN .T.
1419:         ENDIF
1420: 
1421:         THIS.this_lDadosAlterados = .T.
1422:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1423:             THIS.this_oBusinessObject.this_lDadosAlterados = .T.
1424:         ENDIF
1425: 
1426:         *-- Legado: If Not Seek(This.Value, 'TmpOpe', 'Dopes') -> fwBuscaInt.
1427:         *-- Migrado: consulta direto SigCdOpe (regra #37) - o Init do
1428:         *-- FormBuscaAuxiliar ja tenta o match exato antes de abrir o
1429:         *-- picker, equivalente ao Seek local do legado
1430:         THIS.AbrirLookupOperacaoTrfGrade(par_oTxt)
1431: 
1432:         *-- Legado: recusa duplicata em xOpe (Seek+Skip+Delete+MessageBox) -
1433:         *-- TRANSCRITO literal (regra #17)
1434:         THIS.RecusarOperacaoTrfDuplicada(par_oTxt)
1435: 
1436:         RETURN .T.
1437:     ENDFUNC
1438: 
1439:     *==========================================================================
1440:     * AbrirLookupOperacaoTrfGrade - FUNIL do lookup da operacao de destino.
1441:     * Tres portas de entrada desaguam aqui: o Valid da celula
1442:     * (ValidarOperacaoTrfGridExec) e o F4/F5/duplo clique
1443:     * (TextBoxOperacaoTrf_4c.KeyPress/DblClick).
1444:     *
1445:     * Wrapper so para a guarda de reentrancia (regra #47): o picker eh
1446:     * MODAL, tira o foco da celula e redispara o Valid que o chamou. O
1447:     * corpo vive em AbrirLookupOperacaoTrfGradeExec.
1448:     *
1449:     * PUBLIC: chamado de fora da classe pelo TextBox da coluna.
1450:     *==========================================================================
1451:     PROCEDURE AbrirLookupOperacaoTrfGrade(par_oTxt)
1452:         IF THIS.this_lEmLookupOperacao
1453:             RETURN
1454:         ENDIF
1455: 
1456:         THIS.this_lEmLookupOperacao = .T.
1457:         THIS.AbrirLookupOperacaoTrfGradeExec(par_oTxt)
1458:         THIS.this_lEmLookupOperacao = .F.
1459:     ENDPROC
1460: 
1461:     *==========================================================================
1462:     * AbrirLookupOperacaoTrfGradeExec - corpo do lookup da operacao de
1463:     * destino. Equivalente ao legado:
1464:     *
1465:     *   loBrowse = CreateObject('fwBuscaInt','TmpOpe','Dopes',This.Value,
1466:     *       'Operacoes',.t.)
1467:     *   loBrowse.mAddColuna('Dopes', '', 'Operacao', .t.)
1468:     *   loBrowse.mAddColuna('nDopes', '9999', ' Cod ',.f.)
1469:     *   loBrowse.Show
1470:     *   This.Value = Iif( Lastkey() == 27, '', TmpOpe.Dopes )
1471:     *
1472:     * Migrado: FormBuscaAuxiliar direto contra SigCdOpe (regra #37), com o
1473:     * mesmo filtro de exclusao da operacao de ORIGEM que populou TmpOpe no
1474:     * legado ("Where Dopes <> crSigCdOpe.Dopes", ver SigOpTrfBO.
1475:     * CarregarRegras). Cancelar (ESC) ou nao selecionar nada limpa a
1476:     * celula, igual ao legado - diferente da regra #50 (que NUNCA apaga o
1477:     * digitado quando o universo esta vazio): aqui o legado EXPLICITAMENTE
1478:     * zera no cancelamento, entao o caso nao se aplica.
1479:     *==========================================================================
1480:     PROTECTED PROCEDURE AbrirLookupOperacaoTrfGradeExec(par_oTxt)
1481:         LOCAL loc_cValorDigitado, loc_oBusca, loc_oErro
1482: 
1483:         IF VARTYPE(par_oTxt) != "O"
1484:             RETURN
1485:         ENDIF
1486: 
1487:         loc_cValorDigitado = ALLTRIM(par_oTxt.Value)
1488: 
1489:         TRY
1490:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1491:                 "SigCdOpe", "cursor_4c_BuscaOperacaoTrf", "dopes", loc_cValorDigitado, ;
1492:                 "Opera" + CHR(231) + CHR(245) + "es", .F., .F., ;
1493:                 "dopes <> " + EscaparSQL(THIS.this_cDopes))
1494: 
1495:             IF VARTYPE(loc_oBusca) = "O"
1496:                 *-- Init ja tentou o match exato (regra #37) - so abre o
1497:                 *-- picker se nao achou
1498:                 IF !loc_oBusca.this_lAchouRegistro
1499:                     loc_oBusca.mAddColuna("dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
1500:                     loc_oBusca.mAddColuna("ndopes", "9999", " Cod ")
1501:                     loc_oBusca.Show()
1502:                 ENDIF
1503: 
1504:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOperacaoTrf") AND ;
1505:                    RECCOUNT("cursor_4c_BuscaOperacaoTrf") > 0
1506:                     SELECT cursor_4c_BuscaOperacaoTrf
1507:                     par_oTxt.Value = ALLTRIM(NVL(dopes, ""))
1508:                 ELSE
1509:                     *-- Legado: This.Value = Iif(Lastkey()==27,'',TmpOpe.Dopes)
1510:                     par_oTxt.Value = ""
1511:                 ENDIF
1512: 
1513:                 loc_oBusca.Release()
1514:             ENDIF
1515:         CATCH TO loc_oErro
1516:             MsgErro(loc_oErro.Message, "FormSigOpTrf.AbrirLookupOperacaoTrfGradeExec")
1517:         ENDTRY
1518: 
1519:         IF USED("cursor_4c_BuscaOperacaoTrf")
1520:             USE IN cursor_4c_BuscaOperacaoTrf
1521:         ENDIF
1522: 
1523:         par_oTxt.Refresh()
1524:     ENDPROC
1525: 
1526:     *==========================================================================
1527:     * RecusarOperacaoTrfDuplicada - equivalente literal (regra #17) ao
1528:     * trecho final do legado (GradeOpe.Column2.Text1.Valid):
1529:     *
1530:     *   lcdope = This.Value

*-- Linhas 1553 a 1635:
1553:     * (a achada pelo Seek e a seguinte, em ordem de indice) - mesma
1554:     * sequencia do legado, nao "corrigida" aqui (regra #17).
1555:     *==========================================================================
1556:     PROTECTED PROCEDURE RecusarOperacaoTrfDuplicada(par_oTxt)
1557:         LOCAL loc_cAliasOperacoes, loc_cDope, loc_nRecNo
1558: 
1559:         IF VARTYPE(par_oTxt) != "O" OR VARTYPE(THIS.this_oBusinessObject) != "O"
1560:             RETURN
1561:         ENDIF
1562: 
1563:         loc_cAliasOperacoes = THIS.this_oBusinessObject.this_cCursorOperacoes
1564: 
1565:         IF VARTYPE(loc_cAliasOperacoes) != "C" OR EMPTY(loc_cAliasOperacoes) OR !USED(loc_cAliasOperacoes)
1566:             RETURN
1567:         ENDIF
1568: 
1569:         loc_cDope = ALLTRIM(par_oTxt.Value)
1570:         IF EMPTY(loc_cDope)
1571:             RETURN
1572:         ENDIF
1573: 
1574:         *-- Legado: Select xOpe / lnRecNo = IIf(Not Eof() Or Bof(), RecNo(), 0)
1575:         SELECT (loc_cAliasOperacoes)
1576:         IF !EOF() OR BOF()
1577:             loc_nRecNo = RECNO()
1578:         ELSE
1579:             loc_nRecNo = 0
1580:         ENDIF
1581: 
1582:         *-- Legado: Set Order to Dopes / Seek (lcDope)
1583:         SET ORDER TO Dopes
1584:         SEEK loc_cDope
1585: 
1586:         *-- Legado: If Not Eof() / Skip / If xOpe.Dopes = lcDope -> ja
1587:         *-- existem DUAS linhas com este codigo
1588:         IF !EOF()
1589:             SKIP
1590:             IF !EOF() AND ALLTRIM(Dopes) == loc_cDope
1591:                 par_oTxt.Value = ""
1592:                 DELETE
1593:                 SKIP
1594:                 SKIP -1
1595:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o j" + CHR(225) + " Digitada ... ", THIS.Caption)
1596:             ENDIF
1597:         ENDIF
1598: 
1599:         *-- Legado: Select xOpe / Set Order to Dopes / Goto (lnRecNo) ou Bottom
1600:         SELECT (loc_cAliasOperacoes)
1601:         SET ORDER TO Dopes
1602:         IF loc_nRecNo != 0
1603:             GOTO (loc_nRecNo)
1604:         ELSE
1605:             GOTO BOTTOM
1606:         ENDIF
1607: 
1608:         IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
1609:             THIS.grd_4c_Operacoes.Refresh()
1610:         ENDIF
1611:     ENDPROC
1612: 
1613:     *==========================================================================
1614:     * ValidarProdutoTrfGridExec - Valid da celula "Produto" (Column1/
1615:     * col_cpros) de grd_4c_Itens. par_oTxt eh o TextBox da coluna (regra
1616:     * #46): dentro do Valid, o valor digitado esta em par_oTxt.Value e
1617:     * AINDA NAO chegou ao cursor.
1618:     *
1619:     * Equivalente ao legado (GradePro.col_cpros.txt_cpros.Valid):
1620:     *   If !IsEmpty(this.value)
1621:     *       ThisForm.GravaDados = .t.
1622:     *       <lookup + recusa de duplicata, delegados abaixo>
1623:     *   EndIf
1624:     *
1625:     * Produto pode ficar VAZIO - regra de negocio documentada no cabecalho
1626:     * de SigOpTrfBO.prg (operacao de destino sem produto especifico migra
1627:     * tudo) - por isso, igual ao legado, o Valid so age quando o valor
1628:     * NAO esta vazio.
1629:     *
1630:     * PUBLIC: chamado de fora da classe pelo TextBox da coluna.
1631:     *==========================================================================
1632:     FUNCTION ValidarProdutoTrfGridExec(par_oTxt)
1633:         IF VARTYPE(par_oTxt) != "O"
1634:             RETURN .T.
1635:         ENDIF

*-- Linhas 1659 a 1740:
1659:     *
1660:     * PUBLIC: chamado de fora da classe pelo TextBox da coluna.
1661:     *==========================================================================
1662:     PROCEDURE AbrirLookupProdutoTrfGrade(par_oTxt)
1663:         IF THIS.this_lEmLookupProduto
1664:             RETURN
1665:         ENDIF
1666: 
1667:         THIS.this_lEmLookupProduto = .T.
1668:         THIS.AbrirLookupProdutoTrfGradeExec(par_oTxt)
1669:         THIS.this_lEmLookupProduto = .F.
1670:     ENDPROC
1671: 
1672:     *==========================================================================
1673:     * AbrirLookupProdutoTrfGradeExec - corpo do lookup de produto.
1674:     * Equivalente ao legado:
1675:     *
1676:     *   xBrox = CreateObject('fwBuscaExt',<conn>,'SigCdPro','crSigCdPro',
1677:     *       'cPros',This.Value,'Cadastro de Produtos',.t.,'cPros')
1678:     *   xBrox.mAddColuna('CPros', '', 'Codigo', .t.)
1679:     *   xBrox.mAddColuna('DPros', '', 'Descricao', .t.)
1680:     *   xBrox.Show()
1681:     *   This.Value = Evaluate('crSigCdPro.CPROS')
1682:     *   This.Parent.Parent.col_dpros.txt_dpros.Value = crSigCdPro.Dpros
1683:     *
1684:     * Cancelar (ESC) ou nao selecionar nada NAO apaga o digitado (regra
1685:     * #50 - universo vazio/sem match nao e erro, apagar impediria o
1686:     * usuario de corrigir) - diferente da celula de Operacao acima, cujo
1687:     * legado zera explicitamente no cancelamento.
1688:     *==========================================================================
1689:     PROTECTED PROCEDURE AbrirLookupProdutoTrfGradeExec(par_oTxt)
1690:         LOCAL loc_cValorDigitado, loc_oBusca, loc_oErro, loc_cCodigoResolvido, ;
1691:               loc_cDescricaoResolvida
1692: 
1693:         IF VARTYPE(par_oTxt) != "O"
1694:             RETURN
1695:         ENDIF
1696: 
1697:         loc_cValorDigitado = ALLTRIM(par_oTxt.Value)
1698: 
1699:         TRY
1700:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1701:                 "SigCdPro", "cursor_4c_BuscaProdutoOpTrf", "cpros", loc_cValorDigitado, ;
1702:                 "Cadastro de Produtos")
1703: 
1704:             IF VARTYPE(loc_oBusca) = "O"
1705:                 IF !loc_oBusca.this_lAchouRegistro
1706:                     loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
1707:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1708:                     loc_oBusca.Show()
1709:                 ENDIF
1710: 
1711:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProdutoOpTrf") AND ;
1712:                    RECCOUNT("cursor_4c_BuscaProdutoOpTrf") > 0
1713:                     SELECT cursor_4c_BuscaProdutoOpTrf
1714:                     loc_cCodigoResolvido    = ALLTRIM(NVL(cpros, ""))
1715:                     loc_cDescricaoResolvida = ALLTRIM(NVL(dpros, ""))
1716: 
1717:                     *-- Legado: This.Value = Evaluate([crSigCdPro.CPROS]) +
1718:                     *-- This.Parent.Parent.col_dpros.txt_dpros.Value =
1719:                     *-- crSigCdPro.Dpros - a descricao vai para a MESMA
1720:                     *-- linha de this_cCursorItens (col_dpros eh so espelho,
1721:                     *-- ReadOnly).
1722:                     *--
1723:                     *-- FASE 8: o write-back passou a usar o par de hooks de
1724:                     *-- transporte em vez do REPLACE inline. FormParaBO leva a
1725:                     *-- identidade da LINHA (Dopes/Dopeds) mais o codigo
1726:                     *-- ESCOLHIDO no picker - que ainda nao chegou ao cursor
1727:                     *-- (regra #46) -, e BOParaForm devolve o CODIGO para a
1728:                     *-- celula e a DESCRICAO para a linha, que eh a divisao
1729:                     *-- do legado (ver o cabecalho de BOParaForm: escrever o
1730:                     *-- codigo na linha aqui mudaria o criterio do SEEK de
1731:                     *-- RecusarProdutoTrfDuplicado, logo abaixo)
1732:                     par_oTxt.Value = loc_cCodigoResolvido
1733: 
1734:                     IF THIS.FormParaBO(par_oTxt)
1735:                         THIS.this_oBusinessObject.this_cDpros = loc_cDescricaoResolvida
1736:                         THIS.BOParaForm(par_oTxt)
1737:                     ENDIF
1738: 
1739:                     *-- Legado: recusa duplicata do produto (Seek+Skip,
1740:                     *-- TRANSCRITO literal, regra #17)

*-- Linhas 1790 a 2062:
1790:     * FiltrarItensPorOperacaoCorrente (que usa GO TOP, so valido na carga
1791:     * inicial).
1792:     *==========================================================================
1793:     PROTECTED PROCEDURE RecusarProdutoTrfDuplicado(par_oTxt)
1794:         LOCAL loc_cAliasItens, loc_cAliasOperacoes, loc_cPro, loc_nRecNo, ;
1795:               loc_cDopedsAchado, loc_cDopesCorrente
1796: 
1797:         IF VARTYPE(par_oTxt) != "O" OR VARTYPE(THIS.this_oBusinessObject) != "O"
1798:             RETURN
1799:         ENDIF
1800: 
1801:         loc_cAliasItens     = THIS.this_oBusinessObject.this_cCursorItens
1802:         loc_cAliasOperacoes = THIS.this_oBusinessObject.this_cCursorOperacoes
1803: 
1804:         IF VARTYPE(loc_cAliasItens) != "C" OR EMPTY(loc_cAliasItens) OR !USED(loc_cAliasItens)
1805:             RETURN
1806:         ENDIF
1807: 
1808:         loc_cPro = ALLTRIM(par_oTxt.Value)
1809:         IF EMPTY(loc_cPro)
1810:             RETURN
1811:         ENDIF
1812: 
1813:         *-- Legado: Select xTrf / _Recno = Recno() / Set Order to Cpros
1814:         SELECT (loc_cAliasItens)
1815:         loc_nRecNo = RECNO()
1816:         SET ORDER TO Cpros
1817: 
1818:         *-- Legado: Seek cPro / If !Eof() / lcdope = xTrf.Dopeds / Skip /
1819:         *-- If Cpros = Cpro -> ja existem DUAS linhas com este produto
1820:         loc_cDopedsAchado = ""
1821:         SEEK loc_cPro
1822: 
1823:         IF !EOF()
1824:             loc_cDopedsAchado = ALLTRIM(Dopeds)
1825:             SKIP
1826:             IF !EOF() AND ALLTRIM(Cpros) == loc_cPro
1827:                 par_oTxt.Value = ""
1828:                 MsgAviso("Produto j" + CHR(225) + " Digitado na Opera" + CHR(231) + CHR(227) + "o " + ;
1829:                           loc_cDopedsAchado, THIS.Caption)
1830:             ENDIF
1831:         ENDIF
1832: 
1833:         *-- Legado: Set Order to Dopes / Set Key to crSigCdOpe.Dopes + xOpe.Dopes
1834:         loc_cDopesCorrente = ""
1835:         IF VARTYPE(loc_cAliasOperacoes) = "C" AND !EMPTY(loc_cAliasOperacoes) AND USED(loc_cAliasOperacoes)
1836:             SELECT (loc_cAliasOperacoes)
1837:             IF !EOF()
1838:                 loc_cDopesCorrente = Dopes
1839:             ENDIF
1840:         ENDIF
1841:         THIS.AplicarFiltroItensPorDestino(loc_cDopesCorrente)
1842: 
1843:         *-- Legado: If _Recno # 0 / go _Recno
1844:         IF loc_nRecNo != 0
1845:             SELECT (loc_cAliasItens)
1846:             GOTO (loc_nRecNo)
1847:         ENDIF
1848: 
1849:         IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
1850:             THIS.grd_4c_Itens.Refresh()
1851:         ENDIF
1852:     ENDPROC
1853: 
1854:     *==========================================================================
1855:     * ConfigurarBINDEVENTs - liga os eventos que a Fase 4 ainda nao ligava
1856:     * (os 5 botoes do legado) e o AfterRowColChange da grade superior.
1857:     *
1858:     * Chamado em InicializarForm DEPOIS dos AddObject das grades e dos
1859:     * botoes: BINDEVENT com objeto inexistente estoura no proprio bind.
1860:     *
1861:     * Todos os delegates sao PUBLIC (regra #3): metodo PROTECTED falha em
1862:     * SILENCIO no BINDEVENT.
1863:     *
1864:     * | controle (legado)          | delegate                        |
1865:     * |----------------------------|---------------------------------|
1866:     * | cmdInserir  (xOpe)         | CmdInserirClick                 |
1867:     * | cmdExcluir  (xOpe)         | CmdExcluirClick                 |
1868:     * | Command2    (xTrf)         | CmdInserirItemClick             |
1869:     * | Command1    (xTrf)         | CmdExcluirItemClick             |
1870:     * | cmdSair     ("Encerrar")   | BtnSairClick                    |
1871:     * | GradeOpe.AfterRowColChange | GradeOperacoesAfterRowColChange |
1872:     *
1873:     * Os Valid/When/KeyPress/DblClick das CELULAS nao entram aqui: sao
1874:     * servidos pelos TextBox customizados da Fase 6 (TextBoxOperacaoTrf_4c/
1875:     * TextBoxProdutoOpTrf_4c), porque BINDEVENT em evento de celula de Grid
1876:     * nao eh confiavel (regra #46).
1877:     *==========================================================================
1878:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
1879:         BINDEVENT(THIS.cmd_4c_CmdInserir, "Click", THIS, "CmdInserirClick")
1880:         BINDEVENT(THIS.cmd_4c_CmdExcluir, "Click", THIS, "CmdExcluirClick")
1881:         BINDEVENT(THIS.cmd_4c_Command2,   "Click", THIS, "CmdInserirItemClick")
1882:         BINDEVENT(THIS.cmd_4c_Command1,   "Click", THIS, "CmdExcluirItemClick")
1883:         BINDEVENT(THIS.cmd_4c_CmdSair,    "Click", THIS, "BtnSairClick")
1884: 
1885:         BINDEVENT(THIS.grd_4c_Operacoes, "AfterRowColChange", ;
1886:                   THIS, "GradeOperacoesAfterRowColChange")
1887:     ENDPROC
1888: 
1889:     *==========================================================================
1890:     * GradeOperacoesAfterRowColChange - GradeOpe.AfterRowColChange do
1891:     * legado, transcrito:
1892:     *
1893:     *     LPARAMETERS nColIndex
1894:     *     Select xTrf
1895:     *     Set Order to Dopes
1896:     *     SET KEY TO crSigCdOpe.Dopes+xOpe.Dopes
1897:     *     Go Top
1898:     *     ThisForm.GradePro.Refresh
1899:     *     Select xOpe
1900:     *
1901:     * Este eh o uso CORRETO de AfterRowColChange que a regra #46 descreve:
1902:     * refiltrar o DETALHE da linha corrente, SEM filtro por coluna - a regra
1903:     * proibe o outro uso (validar celula, que vai no Valid do TextBox da
1904:     * coluna e neste form ja esta na Fase 6). Por isso par_nColIndex eh
1905:     * RECEBIDO (obrigatorio pela regra #3 - handler ligado por BINDEVENT tem
1906:     * de declarar os parametros do evento) e nao eh testado: o que importa eh
1907:     * a troca de LINHA, nao a coluna de destino.
1908:     *
1909:     * O "Select xOpe" final do legado eh reproduzido: o SET KEY deixa xTrf
1910:     * selecionado e o resto da tela trabalha sobre a grade de operacoes.
1911:     *
1912:     * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
1913:     *==========================================================================
1914:     PROCEDURE GradeOperacoesAfterRowColChange(par_nColIndex)
1915:         LOCAL loc_cAliasOperacoes, loc_cDopesCorrente, loc_oErro
1916: 
1917:         TRY
1918:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1919:                 loc_cAliasOperacoes = THIS.this_oBusinessObject.this_cCursorOperacoes
1920: 
1921:                 IF VARTYPE(loc_cAliasOperacoes) = "C" AND !EMPTY(loc_cAliasOperacoes) AND ;
1922:                    USED(loc_cAliasOperacoes)
1923: 
1924:                     *-- Dopes da linha ATIVA, lido SEM ALLTRIM: a chave do
1925:                     *-- filtro eh POSICIONAL (regra #42) e o padding do
1926:                     *-- CHAR(20) faz parte dela
1927:                     SELECT (loc_cAliasOperacoes)
1928:                     loc_cDopesCorrente = IIF(!EOF(), Dopes, "")
1929: 
1930:                     *-- Legado: Select xTrf / Set Order to Dopes /
1931:                     *-- SET KEY TO crSigCdOpe.Dopes+xOpe.Dopes / Go Top
1932:                     THIS.AplicarFiltroItensPorDestino(loc_cDopesCorrente)
1933: 
1934:                     *-- Legado: ThisForm.GradePro.Refresh - filtrar cursor
1935:                     *-- NAO repinta a grade sozinho (regra #21a)
1936:                     IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
1937:                         THIS.grd_4c_Itens.Refresh()
1938:                     ENDIF
1939: 
1940:                     *-- Legado: Select xOpe
1941:                     SELECT (loc_cAliasOperacoes)
1942:                 ENDIF
1943:             ENDIF
1944:         CATCH TO loc_oErro
1945:             MsgErro(loc_oErro.Message + CHR(13) + ;
1946:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1947:                     "Procedure: " + loc_oErro.Procedure, ;
1948:                     "Erro em GradeOperacoesAfterRowColChange")
1949:         ENDTRY
1950:     ENDPROC
1951: 
1952:     *==========================================================================
1953:     * CmdInserirClick - cmdInserir.Click do legado (botao "+" da grade de
1954:     * OPERACOES DE DESTINO, Left = 5), transcrito:
1955:     *
1956:     *     Insert Into xOpe (Dopes) Values ( Space(20))
1957:     *     Select xOpe
1958:     *     ThisForm.GravaDados = .t.
1959:     *     Thisform.GradeOpe.Column2.SetFocus
1960:     *
1961:     * Insere a linha EM BRANCO e joga o foco na celula, para o usuario
1962:     * digitar o codigo da operacao de destino - quem valida, abre o picker e
1963:     * recusa duplicata eh o Valid da celula (Fase 6,
1964:     * ValidarOperacaoTrfGridExec).
1965:     *
1966:     * SEM GUARD de linha em branco repetida: o legado insere SEMPRE,
1967:     * diferente do irmao SIGMVCXS/FormSigOpSqn (que faz um LOCATE antes para
1968:     * reaproveitar a linha vazia ainda nao preenchida) - transcricao
1969:     * literal, nao se "melhora" aqui (regra #17).
1970:     *
1971:     * Grava SO no cursor LOCAL. A persistencia eh em LOTE, no Encerrar
1972:     * (PersistirRegras), igual ao legado - que trabalha sobre a view
1973:     * bufferizada e so chama UpDate+Commit no cmdSair.Click.
1974:     *
1975:     * Column1.SetFocus() eh o que o legado chama ("Column2" eh o NOME
1976:     * interno da unica coluna de GradeOpe - a API eh sempre por POSICAO,
1977:     * regra #34) e Column TEM esse metodo. NAO usar Grid.ActiveColumn = 1 no
1978:     * lugar: ActiveColumn eh READ-ONLY em runtime e derrubaria o handler.
1979:     *
1980:     * O "Select xOpe" do legado nao vira efeito colateral permanente: este
1981:     * form roda na DataSession do PAI (DataSession = 1), onde deixar outro
1982:     * alias selecionado atrapalharia quem chamou - por isso o alias anterior
1983:     * eh restaurado no fim.
1984:     *
1985:     * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
1986:     *==========================================================================
1987:     PROCEDURE CmdInserirClick
1988:         LOCAL loc_cAliasAnterior, loc_cAliasOperacoes, loc_oErro
1989: 
1990:         TRY
1991:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1992:                 loc_cAliasOperacoes = THIS.this_oBusinessObject.this_cCursorOperacoes
1993: 
1994:                 IF VARTYPE(loc_cAliasOperacoes) = "C" AND !EMPTY(loc_cAliasOperacoes) AND ;
1995:                    USED(loc_cAliasOperacoes)
1996: 
1997:                     loc_cAliasAnterior = ALIAS()
1998: 
1999:                     *-- Legado: Insert Into xOpe (Dopes) Values (Space(20))
2000:                     INSERT INTO (loc_cAliasOperacoes) (Dopes) VALUES (SPACE(20))
2001: 
2002:                     *-- Legado: Select xOpe
2003:                     SELECT (loc_cAliasOperacoes)
2004: 
2005:                     *-- Legado: ThisForm.GravaDados = .t.
2006:                     THIS.MarcarDadosAlterados()
2007: 
2008:                     *-- Legado: Thisform.GradeOpe.Column2.SetFocus
2009:                     IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
2010:                         THIS.grd_4c_Operacoes.Refresh()
2011:                         THIS.grd_4c_Operacoes.Column1.SetFocus()
2012:                     ENDIF
2013: 
2014:                     IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
2015:                         SELECT (loc_cAliasAnterior)
2016:                     ENDIF
2017:                 ENDIF
2018:             ENDIF
2019:         CATCH TO loc_oErro
2020:             MsgErro(loc_oErro.Message + CHR(13) + ;
2021:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2022:                     "Procedure: " + loc_oErro.Procedure, ;
2023:                     "Erro em CmdInserirClick")
2024:         ENDTRY
2025:     ENDPROC
2026: 
2027:     *==========================================================================
2028:     * CmdExcluirClick - cmdExcluir.Click do legado (botao "-" da grade de
2029:     * OPERACOES DE DESTINO, Left = 45), transcrito:
2030:     *
2031:     *     Select xOpe
2032:     *     If Not Eof()
2033:     *         SELECT xTrf
2034:     *         DELETE for Dopeds = xOpe.Dopes
2035:     *         SELECT xOpe
2036:     *         DELETE
2037:     *         SKIP
2038:     *         IF EOF()
2039:     *             GO Bott
2040:     *         Endif
2041:     *     ENDIF
2042:     *     Thisform.GradeOpe.SetFocus
2043:     *     ThisForm.GradePro.Refresh
2044:     *     SELECT xTrf
2045:     *     SET KEY TO crSigCdOpe.Dopes+xOpe.Dopes
2046:     *     ThisForm.GravaDados = .t.
2047:     *
2048:     * Excluir a operacao de DESTINO leva embora os PRODUTOS dela - eh o
2049:     * "DELETE for Dopeds = xOpe.Dopes" em xTrf, feito ANTES de apagar a
2050:     * linha de xOpe (enquanto o ponteiro de xOpe ainda esta nela).
2051:     *
2052:     * O par "SKIP / IF EOF() GO Bott" eh o que reposiciona o ponteiro numa
2053:     * linha VIVA depois da marcacao: com SET DELETED ON (config.prg) a linha
2054:     * marcada desaparece da grade de imediato. Note a assimetria com o irmao
2055:     * FormSigOpSqn ("Skip / Skip -1"): sao sequencias DIFERENTES nos dois
2056:     * legados e cada uma fica como esta (regra #17).
2057:     *
2058:     * UMA precaucao acrescentada, e o motivo: o "DELETE for" do legado roda
2059:     * com o SET KEY de xTrf ATIVO, logo so varre a faixa da operacao de
2060:     * destino corrente. No fluxo normal essa faixa eh exatamente a do
2061:     * destino sendo excluido (o AfterRowColChange a fixou quando o usuario
2062:     * selecionou a linha), mas se o ponteiro de xOpe tiver sido movido por

*-- Linhas 2075 a 2120:
2075:     * sim comparacao de UM campo, entao o ALLTRIM eh seguro e NAO cai na
2076:     * regra #42.
2077:     *
2078:     * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
2079:     *==========================================================================
2080:     PROCEDURE CmdExcluirClick
2081:         LOCAL loc_cAliasAnterior, loc_cAliasOperacoes, loc_cAliasItens, ;
2082:               loc_cDopedsExcluir, loc_cDopesCorrente, loc_oErro
2083: 
2084:         TRY
2085:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2086:                 loc_cAliasOperacoes = THIS.this_oBusinessObject.this_cCursorOperacoes
2087:                 loc_cAliasItens     = THIS.this_oBusinessObject.this_cCursorItens
2088: 
2089:                 IF VARTYPE(loc_cAliasOperacoes) = "C" AND !EMPTY(loc_cAliasOperacoes) AND ;
2090:                    USED(loc_cAliasOperacoes)
2091: 
2092:                     loc_cAliasAnterior = ALIAS()
2093: 
2094:                     *-- Legado: Select xOpe / If Not Eof()
2095:                     SELECT (loc_cAliasOperacoes)
2096: 
2097:                     IF !EOF()
2098:                         *-- Dopes da linha a excluir, CRU (CHAR(20) com o
2099:                         *-- padding): entra na chave POSICIONAL do filtro
2100:                         *-- (regra #42)
2101:                         loc_cDopedsExcluir = Dopes
2102: 
2103:                         IF VARTYPE(loc_cAliasItens) = "C" AND !EMPTY(loc_cAliasItens) AND ;
2104:                            USED(loc_cAliasItens)
2105: 
2106:                             *-- Reafirma a faixa que o legado pretende varrer
2107:                             *-- (ver cabecalho deste metodo)
2108:                             THIS.AplicarFiltroItensPorDestino(loc_cDopedsExcluir)
2109: 
2110:                             *-- Legado: SELECT xTrf /
2111:                             *-- DELETE for Dopeds = xOpe.Dopes
2112:                             SELECT (loc_cAliasItens)
2113:                             DELETE FOR ALLTRIM(NVL(Dopeds, "")) == ALLTRIM(loc_cDopedsExcluir)
2114:                         ENDIF
2115: 
2116:                         *-- Legado: SELECT xOpe / DELETE / SKIP /
2117:                         *-- IF EOF() GO Bott
2118:                         SELECT (loc_cAliasOperacoes)
2119:                         DELETE
2120:                         SKIP

*-- Linhas 2150 a 2226:
2150:         CATCH TO loc_oErro
2151:             MsgErro(loc_oErro.Message + CHR(13) + ;
2152:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2153:                     "Procedure: " + loc_oErro.Procedure, ;
2154:                     "Erro em CmdExcluirClick")
2155:         ENDTRY
2156:     ENDPROC
2157: 
2158:     *==========================================================================
2159:     * CmdInserirItemClick - Command2.Click do legado (botao "+" da grade de
2160:     * PRODUTOS, Left = 190), transcrito:
2161:     *
2162:     *     Insert Into xTrf (Dopes, Dopeds) Values ( crSigCdOpe.Dopes, xOpe.Dopes)
2163:     *     Select xTrf
2164:     *     ThisForm.GravaDados = .t.
2165:     *     ThisForm.GradePro.col_cpros.SetFocus
2166:     *
2167:     * A linha nova nasce com a operacao de ORIGEM e a de DESTINO ja
2168:     * preenchidas - eh o par que o SET KEY filtra, por isso ela aparece de
2169:     * imediato na grade - e com o PRODUTO em branco, para o usuario digitar.
2170:     * Quem valida, abre o picker e recusa duplicata eh o Valid da celula
2171:     * (Fase 6, ValidarProdutoTrfGridExec).
2172:     *
2173:     * SEM GUARD de "ha operacao de destino selecionada": o legado referencia
2174:     * xOpe.Dopes direto, que em cursor vazio/EOF devolve branco, e insere a
2175:     * linha com Dopeds vazio do mesmo jeito. Transcricao literal (regra #17)
2176:     * - e inofensivo no lote, porque PersistirRegras exige Dopes, Dopeds E
2177:     * Cpros preenchidos para gravar a linha (o mesmo criterio do legado).
2178:     *
2179:     * PADR(...,20) na origem: this_cDopes eh variavel ALLTRIM'd e a chave
2180:     * "Dopes + Dopeds" do cursor eh POSICIONAL (regra #42) - mesma forma
2181:     * usada em AplicarFiltroItensPorDestino. O Dopes de
2182:     * this_cCursorOperacoes vem CRU, do campo CHAR(20), ja com o padding.
2183:     *
2184:     * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
2185:     *==========================================================================
2186:     PROCEDURE CmdInserirItemClick
2187:         LOCAL loc_cAliasAnterior, loc_cAliasOperacoes, loc_cAliasItens, ;
2188:               loc_cDopesDestino, loc_oErro
2189: 
2190:         TRY
2191:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2192:                 loc_cAliasOperacoes = THIS.this_oBusinessObject.this_cCursorOperacoes
2193:                 loc_cAliasItens     = THIS.this_oBusinessObject.this_cCursorItens
2194: 
2195:                 IF VARTYPE(loc_cAliasItens) = "C" AND !EMPTY(loc_cAliasItens) AND ;
2196:                    USED(loc_cAliasItens)
2197: 
2198:                     loc_cAliasAnterior = ALIAS()
2199: 
2200:                     *-- Legado: xOpe.Dopes (linha corrente da grade de cima)
2201:                     loc_cDopesDestino = SPACE(20)
2202:                     IF VARTYPE(loc_cAliasOperacoes) = "C" AND !EMPTY(loc_cAliasOperacoes) AND ;
2203:                        USED(loc_cAliasOperacoes)
2204:                         SELECT (loc_cAliasOperacoes)
2205:                         IF !EOF()
2206:                             loc_cDopesDestino = Dopes
2207:                         ENDIF
2208:                     ENDIF
2209: 
2210:                     *-- Legado: Insert Into xTrf (Dopes, Dopeds) Values
2211:                     *-- (crSigCdOpe.Dopes, xOpe.Dopes)
2212:                     INSERT INTO (loc_cAliasItens) (Dopes, Dopeds) ;
2213:                         VALUES (PADR(ALLTRIM(THIS.this_cDopes), 20), loc_cDopesDestino)
2214: 
2215:                     *-- Legado: Select xTrf
2216:                     SELECT (loc_cAliasItens)
2217: 
2218:                     *-- Legado: ThisForm.GravaDados = .t.
2219:                     THIS.MarcarDadosAlterados()
2220: 
2221:                     *-- Legado: ThisForm.GradePro.col_cpros.SetFocus
2222:                     *-- ("col_cpros" eh o NOME interno da 1a coluna - a API
2223:                     *-- eh sempre por POSICAO, regra #34)
2224:                     IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
2225:                         THIS.grd_4c_Itens.Refresh()
2226:                         THIS.grd_4c_Itens.Column1.SetFocus()

*-- Linhas 2234 a 2420:
2234:         CATCH TO loc_oErro
2235:             MsgErro(loc_oErro.Message + CHR(13) + ;
2236:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2237:                     "Procedure: " + loc_oErro.Procedure, ;
2238:                     "Erro em CmdInserirItemClick")
2239:         ENDTRY
2240:     ENDPROC
2241: 
2242:     *==========================================================================
2243:     * CmdExcluirItemClick - Command1.Click do legado (botao "-" da grade de
2244:     * PRODUTOS, Left = 230), transcrito:
2245:     *
2246:     *     Select xTrf
2247:     *     If Not Eof()
2248:     *         Delete
2249:     *     Endif
2250:     *     ThisForm.GravaDados = .t.
2251:     *     Thisform.GradePro.Refresh
2252:     *
2253:     * SEM o "SKIP / GO Bott" que o cmdExcluir da grade de cima tem: sao
2254:     * sequencias diferentes nos dois handlers do legado e cada uma fica como
2255:     * esta (regra #17). Com SET DELETED ON (config.prg) a linha marcada
2256:     * desaparece da grade no Refresh.
2257:     *
2258:     * So MARCA a linha no cursor LOCAL - nenhum DELETE no SQL Server aqui. A
2259:     * remocao efetiva eh consequencia de a linha nao ser reinserida no lote
2260:     * do Encerrar (PersistirRegras apaga as regras da origem e regrava as
2261:     * linhas vivas), que eh exatamente o desenho do legado.
2262:     *
2263:     * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
2264:     *==========================================================================
2265:     PROCEDURE CmdExcluirItemClick
2266:         LOCAL loc_cAliasAnterior, loc_cAliasItens, loc_oErro
2267: 
2268:         TRY
2269:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2270:                 loc_cAliasItens = THIS.this_oBusinessObject.this_cCursorItens
2271: 
2272:                 IF VARTYPE(loc_cAliasItens) = "C" AND !EMPTY(loc_cAliasItens) AND ;
2273:                    USED(loc_cAliasItens)
2274: 
2275:                     loc_cAliasAnterior = ALIAS()
2276: 
2277:                     *-- Legado: Select xTrf / If Not Eof() / Delete
2278:                     SELECT (loc_cAliasItens)
2279:                     IF !EOF()
2280:                         DELETE
2281:                     ENDIF
2282: 
2283:                     *-- Legado: ThisForm.GravaDados = .t.
2284:                     THIS.MarcarDadosAlterados()
2285: 
2286:                     IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
2287:                         SELECT (loc_cAliasAnterior)
2288:                     ENDIF
2289:                 ENDIF
2290:             ENDIF
2291: 
2292:             *-- Legado: Thisform.GradePro.Refresh (fora do IF, como no dump)
2293:             IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
2294:                 THIS.grd_4c_Itens.Refresh()
2295:             ENDIF
2296:         CATCH TO loc_oErro
2297:             MsgErro(loc_oErro.Message + CHR(13) + ;
2298:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2299:                     "Procedure: " + loc_oErro.Procedure, ;
2300:                     "Erro em CmdExcluirItemClick")
2301:         ENDTRY
2302:     ENDPROC
2303: 
2304:     *==========================================================================
2305:     * MarcarDadosAlterados - FONTE UNICA do "ThisForm.GravaDados = .t." do
2306:     * legado, que aparece em SEIS handlers (os 4 botoes de grade e os 2 Valid
2307:     * de celula).
2308:     *
2309:     * Mantem a property do FORM - a que o Encerrar LE, ver a declaracao de
2310:     * this_lDadosAlterados - e espelha no BO. As DUAS, e nao so a do BO,
2311:     * porque BusinessBase.NovoRegistro()/Salvar() zeram a do BO a cada linha
2312:     * gravada no laco de PersistirRegras.
2313:     *
2314:     * PUBLIC: usado pelos handlers deste form e alcancavel pelo harness.
2315:     *==========================================================================
2316:     PROCEDURE MarcarDadosAlterados
2317:         THIS.this_lDadosAlterados = .T.
2318: 
2319:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2320:             THIS.this_oBusinessObject.this_lDadosAlterados = .T.
2321:         ENDIF
2322:     ENDPROC
2323: 
2324:     *==========================================================================
2325:     * BtnSairClick - cmdSair.Click do legado (botao "Encerrar", Cancel = .T.,
2326:     * logo tambem dispara no ESC). Transcrito:
2327:     *
2328:     *     If ThisForm.GravaDados
2329:     *         <apaga e regrava o lote - PersistirRegras>
2330:     *         If Not m.lnErro1>0
2331:     *             = MessageBox('Erro na Gravacao dos Dados do Cadastro de
2332:     *                 Operacoes.',48)
2333:     *         EndIf
2334:     *     EndIf
2335:     *     Thisform.ParentForm.Enabled = .T.
2336:     *     ThisForm.Release
2337:     *
2338:     * FLUXO DE SAIDA - transcrito, nao "melhorado": NADA aborta o
2339:     * fechamento. Diferente do irmao FormSigOpSqn (cujo cmdSair tem duas
2340:     * validacoes com "Return .f."), aqui o legado nao valida nada e, mesmo
2341:     * quando a gravacao FALHA, exibe a mensagem e FECHA - porque o RollBack
2342:     * ja desfez tudo. Manter o dialogo aberto convidaria a um segundo
2343:     * Encerrar, que tentaria reinserir linha ja gravada (cidchaves eh PK).
2344:     *
2345:     * Nada a gravar (GravaDados = .F., usuario so olhou a tela) fecha
2346:     * direto, sem SQL algum, igual ao legado.
2347:     *
2348:     * A mensagem generica do legado vai GUARDADA por this_lErroExibido
2349:     * (regra #20): BusinessBase.Salvar() e o Inserir()/ApagarRegrasDaOrigem()
2350:     * do BO ja exibem a falha com o texto do SQL Server, e repetir aqui daria
2351:     * dois dialogos para o mesmo erro. Se nenhum erro foi exibido, a mensagem
2352:     * do legado aparece - falha nunca pode ser muda.
2353:     *
2354:     * "Thisform.ParentForm.Enabled = .T." roda no Destroy() deste form, que o
2355:     * Release() dispara - e que tambem fecha os cursores de trabalho na
2356:     * DataSession compartilhada com o pai.
2357:     *
2358:     * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
2359:     *==========================================================================
2360:     PROCEDURE BtnSairClick
2361:         LOCAL loc_lGravou, loc_lErroExibido, loc_oErro
2362: 
2363:         loc_lGravou      = .T.
2364:         loc_lErroExibido = .F.
2365: 
2366:         TRY
2367:             *-- Legado: If ThisForm.GravaDados
2368:             IF THIS.this_lDadosAlterados
2369:                 loc_lGravou = THIS.PersistirRegras()
2370: 
2371:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
2372:                     loc_lErroExibido = THIS.this_oBusinessObject.this_lErroExibido
2373:                 ENDIF
2374:             ENDIF
2375:         CATCH TO loc_oErro
2376:             loc_lGravou      = .F.
2377:             loc_lErroExibido = .T.
2378:             MsgErro(loc_oErro.Message + CHR(13) + ;
2379:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2380:                     "Procedure: " + loc_oErro.Procedure, ;
2381:                     "Erro em BtnSairClick")
2382:         ENDTRY
2383: 
2384:         *-- Legado: MessageBox('Erro na Gravacao dos Dados do Cadastro de
2385:         *-- Operacoes.', 48) - so quando ninguem mais reportou (regra #20)
2386:         IF !loc_lGravou AND !loc_lErroExibido
2387:             MsgErro("Erro na Grava" + CHR(231) + CHR(227) + "o dos Dados do Cadastro de " + ;
2388:                     "Opera" + CHR(231) + CHR(245) + "es.", THIS.Caption)
2389:         ENDIF
2390: 
2391:         *-- Legado: ThisForm.Release (SEMPRE, inclusive apos falha)
2392:         THIS.Release()
2393:     ENDPROC
2394: 
2395:     *==========================================================================
2396:     * PersistirRegras - gravacao em LOTE do Encerrar. Corpo do cmdSair.Click
2397:     * do legado, transcrito:
2398:     *
2399:     *     SELECT crSigOpTrf
2400:     *     DELETE ALL
2401:     *     Select xTrf
2402:     *     SET KEY TO
2403:     *     Set Order To
2404:     *     Scan
2405:     *         If !IsEmpty(xTrf.Dopes) And !IsEmpty(xTrf.Dopeds) And !IsEmpty(xTrf.Cpros)
2406:     *             Scatter memvar
2407:     *             Insert Into crSigOpTrf From memvar
2408:     *             Replace crSigOpTrf.cIdChaves WITH fUniqueIds()
2409:     *         EndIf
2410:     *     EndScan
2411:     *     If (Reccount([crSigOpTrf]) = 0)
2412:     *         Select xOpe
2413:     *         Scan
2414:     *             Insert Into crSigOpTrf (Dopes, DopeDs, cIdChaves) ;
2415:     *                 Values (crSigCdOpe.Dopes, xOpe.Dopes, fUniqueIds())
2416:     *         EndScan
2417:     *     EndIf
2418:     *     <UpDate('crSigOpTrf') + Commit(), com RollBack e MessageBox>
2419:     *
2420:     * TRES pontos que se perdem quando nao sao transcritos com cuidado:

*-- Linhas 2561 a 2604:
2561:             THIS.this_cMensagemErro = loc_oErro.Message
2562:             MsgErro(loc_oErro.Message + CHR(13) + ;
2563:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2564:                     "Procedure: " + loc_oErro.Procedure, ;
2565:                     "Erro em PersistirRegras")
2566:         ENDTRY
2567: 
2568:         *-- Os lacos sobrescreveram this_cDopes do BO com o Dopes de cada
2569:         *-- linha (sempre a propria origem, por desenho desta tela - ver
2570:         *-- cabecalho de SigOpTrfBO.prg). Reposto por seguranca: eh o
2571:         *-- contexto de que CarregarRegras/ApagarRegrasDaOrigem dependem
2572:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2573:             THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes
2574:         ENDIF
2575: 
2576:         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
2577:             SELECT (loc_cAliasAnterior)
2578:         ENDIF
2579: 
2580:         RETURN loc_lSucesso
2581:     ENDFUNC
2582: 
2583:     *==========================================================================
2584:     * GravarUmaRegra - grava UMA linha do lote em SigOpTrf. Equivale ao par
2585:     * "Insert Into crSigOpTrf ... / Replace cIdChaves WITH fUniqueIds()" do
2586:     * cmdSair.Click legado, e eh usada pelos DOIS lacos de PersistirRegras.
2587:     *
2588:     * SEMPRE INSERT, nunca UPDATE: o legado apaga o lote inteiro e regrava
2589:     * cada linha com uma PK nova (ponto 1 do cabecalho de PersistirRegras).
2590:     * this_cCidChaves vai VAZIO de proposito - Inserir() do BO eh quem chama
2591:     * fUniqueIds(), que eh exatamente o "Replace cIdChaves WITH fUniqueIds()"
2592:     * do legado, e a chave NUNCA pode ficar em branco (regra #22: a 2a linha
2593:     * do lote colidiria no indice unico).
2594:     *
2595:     * NovoRegistro() ANTES das properties, nao depois: ele passa por
2596:     * LimparDados() e liga this_lNovoRegistro, que eh o que faz
2597:     * BusinessBase.Salvar() escolher Inserir() em vez de Atualizar().
2598:     *
2599:     * this_cDpros nao eh persistido (nao existe em SigOpTrf - eh a descricao
2600:     * que a grade exibe, resolvida em SigCdPro na carga), por isso vai limpo.
2601:     *
2602:     * PROTECTED: primitiva interna do lote do Encerrar.
2603:     *==========================================================================
2604:     PROTECTED FUNCTION GravarUmaRegra(par_cDopes, par_cDopeds, par_cCpros)

*-- Linhas 2655 a 2707:
2655:     * trocar o alias corrente sem necessidade atrapalha quem chamou.
2656:     *
2657:     * PROTECTED EXPLICITO, e nao por escolha de estilo: FormBase declara
2658:     * PROTECTED PROCEDURE FormParaBO (formbase.prg:285) e em VFP9 a subclasse
2659:     * NAO pode ALARGAR o escopo herdado - escrever o metodo sem o modificador
2660:     * nao o torna publico, so esconde o fato de quem le. Por isso eh chamado
2661:     * por THIS. de dentro da classe (regra #8), a partir de
2662:     * AbrirLookupProdutoTrfGradeExec.
2663:     *
2664:     * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1) - este metodo nao
2665:     * abre bloco algum.
2666:     *==========================================================================
2667:     PROTECTED PROCEDURE FormParaBO(par_oTxt)
2668:         LOCAL loc_cAliasItens, loc_cCpros
2669: 
2670:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2671:             RETURN .F.
2672:         ENDIF
2673: 
2674:         loc_cAliasItens = THIS.this_oBusinessObject.this_cCursorItens
2675: 
2676:         IF VARTYPE(loc_cAliasItens) != "C" OR EMPTY(loc_cAliasItens) OR ;
2677:            !USED(loc_cAliasItens)
2678:             RETURN .F.
2679:         ENDIF
2680: 
2681:         IF EOF(loc_cAliasItens)
2682:             RETURN .F.
2683:         ENDIF
2684: 
2685:         *-- Identidade e vinculo da linha: SEMPRE do cursor (a unica celula
2686:         *-- editavel desta grade eh a do produto)
2687:         THIS.this_oBusinessObject.this_cDopes  = ALLTRIM(NVL(EVALUATE(loc_cAliasItens + ".Dopes"), ""))
2688:         THIS.this_oBusinessObject.this_cDopeds = ALLTRIM(NVL(EVALUATE(loc_cAliasItens + ".Dopeds"), ""))
2689:         THIS.this_oBusinessObject.this_cDpros  = ALLTRIM(NVL(EVALUATE(loc_cAliasItens + ".Dpros"), ""))
2690: 
2691:         loc_cCpros = ALLTRIM(NVL(EVALUATE(loc_cAliasItens + ".Cpros"), ""))
2692: 
2693:         IF VARTYPE(par_oTxt) = "O"
2694:             IF PEMSTATUS(par_oTxt, "Value", 5)
2695:                 loc_cCpros = ALLTRIM(NVL(par_oTxt.Value, ""))
2696:             ENDIF
2697:         ENDIF
2698: 
2699:         THIS.this_oBusinessObject.this_cCpros = loc_cCpros
2700: 
2701:         *-- Toda linha deste lote nasce com PK nova (ponto 1 de PersistirRegras)
2702:         THIS.this_oBusinessObject.this_cCidChaves    = ""
2703:         THIS.this_oBusinessObject.this_lNovoRegistro = .T.
2704: 
2705:         RETURN .T.
2706:     ENDPROC
2707: 

*-- Linhas 2755 a 2802:
2755:     * o Valid trabalhando sobre xTrf (Set Order to Dopes / Set Key to ...).
2756:     *
2757:     * PROTECTED EXPLICITO pela MESMA razao do FormParaBO acima (FormBase
2758:     * declara PROTECTED PROCEDURE BOParaForm em formbase.prg:280).
2759:     *
2760:     * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
2761:     *==========================================================================
2762:     PROTECTED PROCEDURE BOParaForm(par_oTxt)
2763:         LOCAL loc_lSucesso, loc_cAliasItens, loc_cCpros, loc_cDpros
2764: 
2765:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2766:             RETURN .F.
2767:         ENDIF
2768: 
2769:         loc_cAliasItens = THIS.this_oBusinessObject.this_cCursorItens
2770: 
2771:         IF VARTYPE(loc_cAliasItens) != "C" OR EMPTY(loc_cAliasItens)
2772:             RETURN .F.
2773:         ENDIF
2774: 
2775:         loc_lSucesso = .F.
2776:         loc_cCpros   = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCpros, "")), 14)
2777:         loc_cDpros   = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDpros, "")), 60)
2778: 
2779:         IF USED(loc_cAliasItens)
2780:             *-- Legado: o Valid termina trabalhando sobre xTrf
2781:             SELECT (loc_cAliasItens)
2782: 
2783:             IF !EOF()
2784:                 *-- Legado: "txt_dpros.Value = crSigCdPro.Dpros" - o TextBox
2785:                 *-- da col_dpros tem ControlSource na coluna, entao a
2786:                 *-- descricao chega a linha no ato. O CODIGO nao entra aqui
2787:                 *-- (ver o cabecalho): quem o grava eh o bind da coluna,
2788:                 *-- depois do Valid
2789:                 REPLACE Dpros WITH loc_cDpros
2790:                 loc_lSucesso = .T.
2791:             ENDIF
2792:         ENDIF
2793: 
2794:         *-- Legado: This.Value = evaluate([crSigCdPro.CPROS]) / This.Refresh
2795:         IF VARTYPE(par_oTxt) = "O"
2796:             IF PEMSTATUS(par_oTxt, "Value", 5)
2797:                 par_oTxt.Value = loc_cCpros
2798:                 par_oTxt.Refresh()
2799:             ENDIF
2800:         ENDIF
2801: 
2802:         *-- Regra #21: gravar no cursor nao repinta a grade

*-- Linhas 2832 a 2923:
2832:     * zeradas aqui, uma a uma, com o valor-tipo de cada coluna.
2833:     *
2834:     * PROTECTED EXPLICITO pela MESMA razao do FormParaBO/BOParaForm (FormBase
2835:     * declara PROTECTED PROCEDURE LimparCampos em formbase.prg:276): eh
2836:     * chamado por THIS. de dentro da classe - aqui, por CarregarLista.
2837:     *==========================================================================
2838:     PROTECTED PROCEDURE LimparCampos
2839:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2840:             THIS.this_oBusinessObject.LimparDados()
2841: 
2842:             THIS.this_oBusinessObject.this_cCidChaves    = ""
2843:             THIS.this_oBusinessObject.this_cDopeds       = ""
2844:             THIS.this_oBusinessObject.this_cCpros        = ""
2845:             THIS.this_oBusinessObject.this_cDpros        = ""
2846:             THIS.this_oBusinessObject.this_lNovoRegistro = .F.
2847: 
2848:             *-- Contexto do dialogo - reposto, nunca zerado (ver cabecalho)
2849:             THIS.this_oBusinessObject.this_cDopes = ALLTRIM(THIS.this_cDopes)
2850:         ENDIF
2851:     ENDPROC
2852: 
2853:     *==========================================================================
2854:     * HabilitarCampos - abre ou fecha a edicao da tela
2855:     *
2856:     * O legado nao tem um metodo com este nome nem modo de so-leitura: as duas
2857:     * celulas editaveis (o codigo da operacao de destino e o do produto) e os
2858:     * quatro botoes de linha estao SEMPRE ativos no SCX - o Init nao esconde
2859:     * nem desabilita nada, e nao ha fChecaAcesso aqui (diferente do irmao
2860:     * SIGOPSTS). Por isso, sem argumento, este metodo deriva .T.: eh a
2861:     * reproducao fiel de "nao ha modo".
2862:     *
2863:     * Ele existe por um motivo concreto, nao por convencao: o rebind das
2864:     * grades em CarregarLista RESETA Column.ReadOnly junto com Width/Caption/
2865:     * CurrentControl (Problema 48 / regra #41), entao a cada recarga a
2866:     * editabilidade das celulas tem de ser REAPLICADA - e quem desabilita tem
2867:     * de reabilitar no FUNIL, nunca so no caminho de ida (regra #40). Este eh
2868:     * o ponto UNICO onde esse estado chega aos controles.
2869:     *
2870:     * Column.ReadOnly vai DEPOIS do ReadOnly do Grid (regra #46): o do grid
2871:     * propaga para as colunas e sobrescreveria o da coluna.
2872:     *
2873:     * Column2 de grd_4c_Itens nao aparece aqui: ela eh somente leitura em
2874:     * qualquer modo (legado: txt_dpros.When retorna .F.) e quem a trava eh
2875:     * AplicarFormatoGrade.
2876:     *
2877:     * cmd_4c_CmdSair fica SEMPRE habilitado: com TitleBar = 0 e
2878:     * ControlBox = .F. o Encerrar eh a saida da tela, e desabilita-lo
2879:     * prenderia o usuario - e perderia o lote, que so eh gravado por ele.
2880:     *
2881:     * Metodo PUBLIC (regra #3/#51): o harness de teste o alcanca de fora.
2882:     *==========================================================================
2883:     PROCEDURE HabilitarCampos(par_lHabilitar)
2884:         LOCAL loc_lHabilitar
2885: 
2886:         *-- PCOUNT() eh OBRIGATORIO aqui: em VFP9 parametro declarado e NAO
2887:         *-- passado chega como .F. LOGICO, entao VARTYPE(par_lHabilitar) = "L"
2888:         *-- eh verdade tanto para "nao passou" quanto para "passou .F." - o
2889:         *-- guard so por VARTYPE travaria as celulas ao chamar
2890:         *-- HabilitarCampos() sem argumento, em vez de derivar o modo
2891:         loc_lHabilitar = .T.
2892: 
2893:         IF PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L"
2894:             loc_lHabilitar = par_lHabilitar
2895:         ENDIF
2896: 
2897:         *-- Celula do codigo da operacao de destino (grade de cima). Column1
2898:         *-- so existe com a grade VINCULADA - grade sem alias fica com
2899:         *-- ColumnCount = 0, e tocar .Column1 ali estouraria "Unknown member
2900:         *-- COLUMN1"
2901:         IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
2902:             IF PEMSTATUS(THIS.grd_4c_Operacoes, "Column1", 5)
2903:                 THIS.grd_4c_Operacoes.Column1.ReadOnly = !loc_lHabilitar
2904:             ENDIF
2905:         ENDIF
2906: 
2907:         *-- Celula do codigo do produto (grade de baixo)
2908:         IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
2909:             IF PEMSTATUS(THIS.grd_4c_Itens, "Column1", 5)
2910:                 THIS.grd_4c_Itens.Column1.ReadOnly = !loc_lHabilitar
2911:             ENDIF
2912:         ENDIF
2913: 
2914:         *-- Os 4 botoes de linha do legado (cmdInserir/cmdExcluir da grade de
2915:         *-- operacoes e Command2/Command1 da de produtos)
2916:         IF PEMSTATUS(THIS, "cmd_4c_CmdInserir", 5)
2917:             THIS.cmd_4c_CmdInserir.Enabled = loc_lHabilitar
2918:         ENDIF
2919: 
2920:         IF PEMSTATUS(THIS, "cmd_4c_CmdExcluir", 5)
2921:             THIS.cmd_4c_CmdExcluir.Enabled = loc_lHabilitar
2922:         ENDIF
2923: 

*-- Linhas 2950 a 3034:
2950:     * PUBLIC pelo mesmo motivo (regra #3): PEMSTATUS devolve .T. para metodo
2951:     * PROTECTED e a chamada externa estouraria em runtime.
2952:     *==========================================================================
2953:     PROCEDURE AjustarBotoesPorModo
2954:         THIS.HabilitarCampos()
2955:     ENDPROC
2956: 
2957:     *==========================================================================
2958:     * TornarControlesVisiveis - AddObject cria controle com Visible = .F.
2959:     * por padrao; percorre recursivamente o container repondo Visible = .T.
2960:     * Este form nao tem container flutuante (Visible = .F. proposital) a
2961:     * filtrar - todos os controles devem ficar visiveis.
2962:     *==========================================================================
2963:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2964:         LOCAL loc_nI, loc_oControl
2965: 
2966:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2967:             loc_oControl = par_oContainer.Controls(loc_nI)
2968:             IF VARTYPE(loc_oControl) = "O"
2969:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
2970:                     loc_oControl.Visible = .T.
2971:                 ENDIF
2972:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
2973:                    loc_oControl.ControlCount > 0
2974:                     THIS.TornarControlesVisiveis(loc_oControl)
2975:                 ENDIF
2976:             ENDIF
2977:         ENDFOR
2978:     ENDPROC
2979: 
2980:     *==========================================================================
2981:     * Destroy - Reabilita o form pai ao fechar este dialogo (legado:
2982:     * cmdSair.Click faz .ParentForm.Enabled = .t. antes do ThisForm.Release;
2983:     * aqui tambem fica como rede de seguranca para qualquer caminho de
2984:     * fechamento que nao passe pelo botao Encerrar - ESC/Alt+F4/erro).
2985:     *
2986:     * Fecha tambem os 4 cursores de trabalho do BO (this_cCursorRegras/
2987:     * this_cCursorOperacoesDestino/this_cCursorOperacoes/this_cCursorItens -
2988:     * ver cabecalho de SigOpTrfBO.prg), se algum ja estiver aberto: nesta
2989:     * fase (estrutura base) nenhum deles existe ainda (a carga eh Fase 4),
2990:     * mas o guard USED() torna este laco seguro desde ja e evita ter que
2991:     * revisitar o Destroy quando a carga for acrescentada. Como o form roda
2992:     * na DataSession do pai (DataSession = 1), deixar algum alias aberto
2993:     * poluiria a sessao compartilhada.
2994:     *
2995:     * O TABLEREVERT vai GUARDADO por CURSORGETPROP("Buffering") > 1: sem
2996:     * buffering ele nao eh no-op, dispara o erro 1586 (regra #52).
2997:     *==========================================================================
2998:     PROCEDURE Destroy
2999:         LOCAL loc_nI, loc_aCursores(4), loc_cAlias
3000: 
3001:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3002:             loc_aCursores(1) = THIS.this_oBusinessObject.this_cCursorRegras
3003:             loc_aCursores(2) = THIS.this_oBusinessObject.this_cCursorOperacoesDestino
3004:             loc_aCursores(3) = THIS.this_oBusinessObject.this_cCursorOperacoes
3005:             loc_aCursores(4) = THIS.this_oBusinessObject.this_cCursorItens
3006: 
3007:             FOR loc_nI = 1 TO 4
3008:                 loc_cAlias = loc_aCursores(loc_nI)
3009:                 IF VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)
3010:                     IF CURSORGETPROP("Buffering", loc_cAlias) > 1
3011:                         TABLEREVERT(.T., loc_cAlias)
3012:                     ENDIF
3013:                     USE IN (loc_cAlias)
3014:                 ENDIF
3015:             ENDFOR
3016:         ENDIF
3017: 
3018:         IF VARTYPE(THIS.this_oFormPai) = "O"
3019:             *-- PEMSTATUS pela MESMA razao de CarregarContextoFormPai: em
3020:             *-- modo teste o "form pai" pode ser um objeto simples, sem a
3021:             *-- property Enabled. Sem a guarda, o teardown estoura
3022:             *-- "Property ENABLED is not found" depois de o dialogo ja ter
3023:             *-- fechado
3024:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
3025:                 THIS.this_oFormPai.Enabled = .T.
3026:             ENDIF
3027: 
3028:             THIS.this_oFormPai = .NULL.
3029:         ENDIF
3030: 
3031:         DODEFAULT()
3032:     ENDPROC
3033: 
3034: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpTrfBO.prg):
*==============================================================================
* SIGOPTRFBO.PRG
* Business Object do dialogo "Operacoes Automaticas" (SIGOPTRF - regras de
* TRANSFERENCIA de produtos entre operacoes), aberto pelo form pai de
* Cadastro de Operacoes (SigCdOpe) via
* "Do Form SigOpTrf With ThisForm, nDataSession", NAO acessivel direto
* pelo menu.
*
* Tabela persistida : SigOpTrf  (regras de transferencia gravadas)
* Chave Real (PK)    : cidchaves  CHAR(20)
* Colunas da tabela  : cpros CHAR(14), dopeds CHAR(20), dopes CHAR(20),
*                       cidchaves CHAR(20) - schema.sql conferido (regra #14
*                       do CLAUDE.md, leitura via Get-Content -Raw).
*
* NATUREZA DESTE DIALOGO (lido do legado, SigOpTrf_form_codigo_fonte.txt):
*   O Init recebe (poForm, pnDataSes): poForm e o form PAI (SigCdOpe) e
*   pnDataSes e a DataSession do pai - o dialogo faz "Set DataSession to
*   pnDataSes" para conseguir ler crSigCdOpe (cursor do pai, linha corrente
*   = operacao de ORIGEM) antes de abrir a propria DataSession = 2 privada.
*
*   O Caption e montado como:
*     'Operacoes Automaticas P/ ' + AllTrim(crSigCdOpe.Dopes)
*   e replicado em cntSombra.lblSombra.Caption e lblTitulo.Caption.
*
*   Duas grades, mestre-detalhe por codigo da OPERACAO DE DESTINO:
*     - GradeOpe (grade superior, 1 coluna) <- xOpe (Dopes C(20)) - lista
*       DISTINTA das operacoes de destino ja usadas nas regras desta
*       operacao de origem. Column2.Text1.Valid valida o codigo digitado
*       contra TmpOpe (Select Dopes,nDopes From SigCdOpe Where Dopes <>
*       <crSigCdOpe.Dopes>), abrindo fwBuscaInt quando nao encontra, e
*       recusa duplicata (MessageBox + Delete da linha repetida).
*     - GradePro (grade inferior, 2 colunas) <- xTrf (Dopes C(20),
*       Dopeds C(20), Cpros C(14), Dpros C(60)) - produtos que migram para
*       a operacao de destino selecionada na grade de cima. AfterRowColChange
*       da GradeOpe faz "Set Key To crSigCdOpe.Dopes+xOpe.Dopes" em xTrf
*       (indexado por Dopes+Dopeds) para filtrar so as linhas da operacao de
*       destino corrente. txt_cpros.Valid valida o produto contra SigCdPro
*       (fwBuscaExt quando nao encontra) e recusa duplicata na MESMA
*       operacao de destino.
*
*   Ao abrir (Init), as regras ja gravadas em SigOpTrf para a operacao de
*   origem (crSigOpTrf, AddCursor com Select * From SigOpTrf Where Dopes =
*   '<crSigCdOpe.Dopes>') sao expandidas para xTrf (com Dpros resolvido via
*   SqlExecute em SigCdPro) e xOpe (Dopeds distintos).
*
*   Ao Encerrar (cmdSair.Click), SE ThisForm.GravaDados: crSigOpTrf e
*   recriado do zero (Delete All + Scan em xTrf inserindo as linhas com
*   Dopes/Dopeds/Cpros todos preenchidos; se NENHUMA linha de xTrf for
*   valida, grava uma linha por xOpe.Dopes com Cpros vazio - "operacao de
*   destino sem produto especifico, migra tudo") e e persistido no SQL
*   Server via poDataMgr.UpDate('crSigOpTrf') + Commit() dentro de
*   ThisForm. cIdChaves de cada linha nova vem de fUniqueIds() (regra #22
*   do CLAUDE.md - NUNCA string vazia, senao a 2a linha colide no indice
*   unico). O botao reabilita o form pai e libera o dialogo:
*     Thisform.ParentForm.Enabled = .T.
*     ThisForm.Release
*
*   Por isso este BO sobrescreve Inserir() e Atualizar() operando sobre UMA
*   regra por vez (identificada por cidchaves) - primitivas que o fluxo de
*   gravacao em lote do Encerrar (fases seguintes) vai chamar em loop, uma
*   vez por linha de xTrf/xOpe, dentro do "apaga tudo e reinsere" do legado
*   (Delete All em crSigOpTrf + Scan inserindo cada linha nova). NAO
*   sobrescreve ExecutarExclusao(): nao ha exclusao unitaria no legado, a
*   remocao de uma regra e so o efeito colateral de ela nao ser reinserida
*   no lote seguinte.
*
* FASE 4 (acrescentada ao BO desta vez, alem do Form): CarregarRegras() -
*   a carga inicial completa (equivalente ao trecho do Init legado que
*   monta crSigOpTrf/TmpOpe via AddCursor e expande para xTrf/xOpe),
*   porque e consulta SQL - pertence ao BO, nao ao Form (arquitetura em
*   camadas). FecharCursoresTrabalho() da reentrancia a essa carga.
*==============================================================================

DEFINE CLASS SigOpTrfBO AS BusinessBase

    *--------------------------------------------------------------------------
    * CONTEXTO - SigCdOpe (crSigCdOpe no legado, cursor do form pai)
    * Operacao de ORIGEM cujas regras de transferencia estao sendo editadas.
    * this_cDopes e usado tanto como filtro das consultas quanto como o
    * valor da coluna "dopes" de cada linha de SigOpTrf (as duas coisas sao
    * sempre o mesmo codigo, por desenho deste dialogo).
    *--------------------------------------------------------------------------
    this_cDopes          = ""  && SigCdOpe.Dopes CHAR(20) - operacao de origem (contexto, vindo do form pai)
    this_cTituloDialogo  = ""  && Caption montado: "Operacoes Automaticas P/ " + this_cDopes

    *--------------------------------------------------------------------------
    * LINHA CORRENTE DA REGRA DE TRANSFERENCIA (SigOpTrf / crSigOpTrf)
    *--------------------------------------------------------------------------
    this_cCidChaves      = ""  && cidchaves CHAR(20) - PK, gerada com fUniqueIds() ao inserir
    this_cDopeds         = ""  && dopeds    CHAR(20) - codigo da operacao de DESTINO
    this_cCpros          = ""  && cpros     CHAR(14) - codigo do produto (pode ficar vazio - ver cabecalho)
    this_cDpros          = ""  && descricao do produto (SigCdPro.Dpros) - NAO persistida em SigOpTrf, so exibicao (equivale a xTrf.Dpros do legado)

    *--------------------------------------------------------------------------
    * CURSORES DE TRABALHO - nomes fixos, populados pelo Form/BO nas fases
    * seguintes. Nenhum deles e SQLEXEC direto no cursor ligado ao Grid
    * (regra do CLAUDE.md sobre SQLEXEC derrubar ColumnCount de Grid).
    *--------------------------------------------------------------------------
    this_cCursorRegras           = "cursor_4c_Regras"            && crSigOpTrf no legado - regras ja gravadas em SigOpTrf para this_cDopes
    this_cCursorOperacoesDestino = "cursor_4c_OperacoesDestino"  && TmpOpe no legado - Select Dopes,nDopes From SigCdOpe Where Dopes <> this_cDopes (lookup/picker da operacao de destino)
    this_cCursorOperacoes        = "cursor_4c_Operacoes"         && xOpe no legado - lista DISTINTA das operacoes de destino (grade superior)
    this_cCursorItens            = "cursor_4c_Itens"             && xTrf no legado - regras detalhadas Dopes+Dopeds+Cpros+Dpros (grade inferior, filtrada pela operacao de destino selecionada)

    *--------------------------------------------------------------------------
    * ESTADO DO DIALOGO
    *--------------------------------------------------------------------------
    this_lDadosAlterados = .F.  && ThisForm.GravaDados no legado - .T. quando algo foi incluido/excluido e precisa regravar ao Encerrar
    this_nTotalOperacoes = 0    && RECCOUNT de this_cCursorOperacoes apos a carga
    this_nTotalItens      = 0   && RECCOUNT de this_cCursorItens apos a carga (linhas visiveis na grade inferior, filtradas pela operacao de destino corrente)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * this_cTabela/this_cCampoChave apontam para a tabela REALMENTE gravada
    * por este dialogo (SigOpTrf) - diferente de SIGOPTOP/SIGOPTOR (so
    * leitura) e de SIGOPTOT (area de troca SigTempD).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigOpTrf"
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_cDopes         = ""
            THIS.this_cTituloDialogo = ""

            THIS.this_cCidChaves = ""
            THIS.this_cDopeds    = ""
            THIS.this_cCpros     = ""
            THIS.this_cDpros     = ""

            THIS.this_lDadosAlterados = .F.
            THIS.this_nTotalOperacoes = 0
            THIS.this_nTotalItens     = 0

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave real da linha de SigOpTrf (cidchaves).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCidChaves, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega cidchaves/dopes/dopeds/cpros da linha
    * corrente de um alias no formato real de SigOpTrf (this_cCursorRegras
    * por default - crSigOpTrf do legado). Se o alias tambem tiver a coluna
    * dpros (caso de this_cCursorItens, equivalente a xTrf, que resolve a
    * descricao do produto via SigCdPro so para exibicao), carrega tambem
    * this_cDpros; senao, limpa.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            par_cAliasCursor, THIS.this_cCursorRegras)

        IF !USED(loc_cAlias) OR EOF(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        THIS.this_cCidChaves = TratarNulo(cidchaves, "")
        THIS.this_cDopes     = TratarNulo(dopes, "")
        THIS.this_cDopeds    = TratarNulo(dopeds, "")
        THIS.this_cCpros     = TratarNulo(cpros, "")

        IF TYPE(loc_cAlias + ".dpros") != "U"
            THIS.this_cDpros = TratarNulo(dpros, "")
        ELSE
            THIS.this_cDpros = ""
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de uma regra de transferencia em SigOpTrf.
    * cidchaves (PK real, regra #22 do CLAUDE.md) e gerado com fUniqueIds()
    * quando ainda nao foi atribuido - NUNCA string vazia, senao a 2a linha
    * do lote colide no indice unico sigoptrf_cidchaves. cpros pode ficar
    * vazio (regra de negocio do legado: operacao de destino sem produto
    * especifico migra tudo), por isso NAO e validado como obrigatorio aqui.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
                THIS.this_cCidChaves = ALLTRIM(fUniqueIds())
            ENDIF

            loc_cSQL = "INSERT INTO SigOpTrf (cidchaves, dopes, dopeds, cpros)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cDopes) + "," + ;
                       EscaparSQL(THIS.this_cDopeds) + "," + ;
                       EscaparSQL(THIS.this_cCpros) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir regra de transfer" + CHR(234) + "ncia:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inserir regra de transfer" + CHR(234) + "ncia:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de uma regra de transferencia ja gravada,
    * localizada por cidchaves. Usado quando o lote do Encerrar preserva uma
    * linha existente (cidchaves ja atribuido) e so muda dopeds/cpros.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
                THIS.this_cMensagemErro = "Registro sem chave para altera" + CHR(231) + CHR(227) + "o"
            ELSE
                loc_cSQL = "UPDATE SigOpTrf SET" + ;
                           " dopes = "  + EscaparSQL(THIS.this_cDopes) + "," + ;
                           " dopeds = " + EscaparSQL(THIS.this_cDopeds) + "," + ;
                           " cpros = "  + EscaparSQL(THIS.this_cCpros) + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao atualizar regra de transfer" + CHR(234) + "ncia:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao atualizar regra de transfer" + CHR(234) + "ncia:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ApagarRegrasDaOrigem - apaga TODAS as regras de transferencia da
    * operacao de origem corrente (this_cDopes). Equivale ao "SELECT
    * crSigOpTrf / DELETE ALL" do cmdSair.Click legado: a view crSigOpTrf
    * nasce filtrada por "Where Dopes = '<crSigCdOpe.Dopes>'" (ver
    * CarregarRegras), logo o DELETE ALL dela apaga exatamente as regras
    * desta origem - nunca a tabela inteira.
    *
    * Primitiva do "apaga tudo e regrava" que o Encerrar faz em lote
    * (FormSigOpTrf.PersistirRegras, Fase 7). O legado NAO tem exclusao
    * unitaria de regra, e por isso este BO nao sobrescreve
    * ExecutarExclusao() - Excluir() por cidchaves nao serviria aqui: seriam
    * N comandos para o que o legado resolve em UM, e a base recusa a
    * operacao sem o hook (o stub herdado devolve .F.).
    *
    * Esta no BO, e nao no Form, porque eh SQL (PILAR 3 - arquitetura em
    * camadas): o Form orquestra o lote, o BO fala com o banco.
    *
    * A auditoria de um DELETE em LOTE nao tem uma PK unica para registrar,
    * entao a chave logada eh o codigo da operacao de ORIGEM - que eh o que
    * identifica o conjunto afetado. this_cCidChaves eh preservado e
    * reposto: ele pertence a linha corrente, nao a este comando.
    *
    * EscaparSQL(this_cDopes) com o valor ALLTRIM'd eh a mesma forma usada
    * em CarregarRegras: dopes eh CHAR(20) e o SQL Server compara CHAR com
    * blank-padding ANSI, entao o WHERE casa com o valor gravado (ALLTRIM na
    * chave INTEIRA eh inofensivo - regra #42 proibe ALLTRIM nas PARTES de
    * chave concatenada, que nao eh o caso).
    *
    * O RETURN de guarda fica FORA do TRY e o RETURN final eh unico
    * (regra #1).
    *
    * Metodo PUBLIC: chamado pelo Form (PersistirRegras) e pelo harness de
    * teste - metodo que o form chama de fora NUNCA pode ser PROTECTED
    * (regra #51).
    *--------------------------------------------------------------------------
    PROCEDURE ApagarRegrasDaOrigem()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChaveAnterior, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(THIS.this_cDopes, "")))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de origem n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigOpTrf" + ;
                       " WHERE dopes = " + EscaparSQL(THIS.this_cDopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                *-- Auditoria do lote pela operacao de origem (ver cabecalho)
                loc_cChaveAnterior   = THIS.this_cCidChaves
                THIS.this_cCidChaves = ALLTRIM(THIS.this_cDopes)
                THIS.RegistrarAuditoria("DELETE")
                THIS.this_cCidChaves = loc_cChaveAnterior

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao apagar as regras de transfer" + CHR(234) + "ncia:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao apagar as regras de transfer" + CHR(234) + "ncia:" + CHR(13) + loc_oErro.Message, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharCursoresTrabalho - fecha os 4 cursores de trabalho (regra #52 -
    * TABLEREVERT so quando ha buffering, senao dispara o erro 1586).
    * Chamado no INICIO de CarregarRegras (reentrancia - este dialogo pode
    * ser aberto mais de uma vez na mesma sessao do processo) e pelo
    * Destroy do Form (teardown final).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FecharCursoresTrabalho()
        LOCAL loc_nI, loc_aCursores(4), loc_cAlias

        loc_aCursores(1) = THIS.this_cCursorRegras
        loc_aCursores(2) = THIS.this_cCursorOperacoesDestino
        loc_aCursores(3) = THIS.this_cCursorOperacoes
        loc_aCursores(4) = THIS.this_cCursorItens

        FOR loc_nI = 1 TO 4
            loc_cAlias = loc_aCursores(loc_nI)
            IF VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                IF CURSORGETPROP("Buffering", loc_cAlias) > 1
                    TABLEREVERT(.T., loc_cAlias)
                ENDIF
                USE IN (loc_cAlias)
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarRegras - carga inicial do dialogo (trecho principal do Init
    * legado): monta os 4 cursores de trabalho e EXPANDE as regras ja
    * gravadas em SigOpTrf (this_cCursorRegras) para as duas grades
    * mestre-detalhe do Form (this_cCursorOperacoes/this_cCursorItens),
    * resolvendo a descricao do produto via SigCdPro (SqlExecute do
    * legado).
    *
    *   Legado (Init):
    *     .AddCursor('SigOpTrf',...,'crSigOpTrf','Dopes',.f.,
    *         [Select * From SigOpTrf Where Dopes = ']+crSigCdOpe.Dopes+['
    *         Order by Dopes])
    *     .AddCursor('SigCdOpe',...,'TmpOpe','Dopes',.f.,
    *         [Select Dopes,nDopes From SigCdOpe Where Dopes <> ']+
    *         crSigCdOpe.Dopes+[' order by Dopes])
    *     Select TmpOpe / Index on Dopes Tag Dopes
    *     Create Cursor xTrf (Dopes c(20), Dopeds c(20), Cpros c(14), Dpros c(60))
    *     Index on Cpros Tag Cpros / Index on Dopes + Dopeds Tag Dopes / Set Order to
    *     Create Cursor xOpe ( Dopes c(20) ) / Index on Dopes Tag Dopes / Set Order to
    *     Select crSigOpTrf
    *     Scan While Dopes = crSigCdOpe.Dopes
    *         ... SqlExecute(Select cPros,dPros From SigCdPro Where Cpros=?m.cPros)
    *         Insert Into xTrf (...) Value (...)
    *         Se Dopeds novo -> Insert Into xOpe (Dopes) Value (Dopeds)
    *     EndScan
    *
    * this_cCursorOperacoesDestino (TmpOpe) fica populado e INDEXADO para
    * o lookup da Fase 7/8 (Column2.Text1.Valid - Seek(valor,'TmpOpe',
    * 'Dopes')); nao e varrido aqui.
    *
    * FecharCursoresTrabalho() no INICIO garante reentrancia - os CREATE
    * CURSOR abaixo estourariam "Cursor ja existe" se os 2 cursores locais
    * (xTrf/xOpe) ja estivessem abertos de uma chamada anterior.
    *
    * Metodo PUBLIC: chamado pelo Form (CarregarLista, Fase 4) e pelo
    * harness de teste.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarRegras()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cAliasProTemp, ;
              loc_nResultadoTemp, loc_cDopesRegra, loc_cDopedsRegra, ;
              loc_cProsRegra, loc_cDpros, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(THIS.this_cDopes, "")))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de origem n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        TRY
            THIS.FecharCursoresTrabalho()

            *-- crSigOpTrf: regras ja gravadas para a operacao de origem
            loc_cSQL = "SELECT cidchaves, dopes, dopeds, cpros FROM SigOpTrf" + ;
                       " WHERE dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                       " ORDER BY dopes"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorRegras)

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao consultar regras de transfer" + CHR(234) + "ncia:" + CHR(13) + CapturarErroSQL()
                loc_lSucesso = .F.
            ELSE
                *-- TmpOpe: operacoes candidatas a destino (lookup da Fase 7/8)
                loc_cSQL = "SELECT dopes, ndopes FROM SigCdOpe" + ;
                           " WHERE dopes <> " + EscaparSQL(THIS.this_cDopes) + ;
                           " ORDER BY dopes"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOperacoesDestino)

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao consultar opera" + CHR(231) + CHR(245) + "es de destino:" + CHR(13) + CapturarErroSQL()
                    loc_lSucesso = .F.
                ELSE
                    IF USED(THIS.this_cCursorOperacoesDestino)
                        SELECT (THIS.this_cCursorOperacoesDestino)
                        INDEX ON dopes TAG Dopes
                        SET ORDER TO
                    ENDIF

                    *-- xTrf / xOpe: cursores LOCAIS editaveis (INSERT INTO
                    *-- direto, nunca SQLEXEC - regra do SQLEXEC derrubar
                    *-- Grid.ColumnCount nao se aplica, mas o padrao do
                    *-- projeto eh o mesmo: estes dois nunca sao alvo de SQLEXEC)
                    CREATE CURSOR (THIS.this_cCursorItens) (Dopes C(20), Dopeds C(20), Cpros C(14), Dpros C(60))
                    INDEX ON Cpros TAG Cpros
                    INDEX ON Dopes + Dopeds TAG Dopes
                    SET ORDER TO

                    CREATE CURSOR (THIS.this_cCursorOperacoes) (Dopes C(20))
                    INDEX ON Dopes TAG Dopes
                    SET ORDER TO

                    *-- Expansao: cada regra ja gravada entra em xTrf,
                    *-- resolvendo a descricao do produto via SigCdPro; e
                    *-- alimenta xOpe com os codigos de operacao-destino
                    *-- DISTINTOS
                    SELECT (THIS.this_cCursorRegras)
                    SCAN
                        loc_cDopesRegra  = dopes
                        loc_cDopedsRegra = dopeds
                        loc_cProsRegra   = cpros
                        loc_cDpros       = ""

                        IF !EMPTY(ALLTRIM(loc_cProsRegra))
                            loc_cAliasProTemp = "cursor_4c_RegraProTmp"
                            loc_cSQL = "SELECT dpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cProsRegra)
                            loc_nResultadoTemp = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasProTemp)

                            IF loc_nResultadoTemp >= 0 AND USED(loc_cAliasProTemp)
                                IF RECCOUNT(loc_cAliasProTemp) > 0
                                    SELECT (loc_cAliasProTemp)
                                    loc_cDpros = TratarNulo(dpros, "")
                                ENDIF
                                USE IN (loc_cAliasProTemp)
                            ENDIF
                        ENDIF

                        INSERT INTO (THIS.this_cCursorItens) (Dopes, Dopeds, Cpros, Dpros) ;
                            VALUES (loc_cDopesRegra, loc_cDopedsRegra, loc_cProsRegra, loc_cDpros)

                        IF !SEEK(loc_cDopedsRegra, THIS.this_cCursorOperacoes, "Dopes")
                            INSERT INTO (THIS.this_cCursorOperacoes) (Dopes) VALUES (loc_cDopedsRegra)
                        ENDIF

                        SELECT (THIS.this_cCursorRegras)
                    ENDSCAN

                    SELECT (THIS.this_cCursorOperacoes)
                    SET ORDER TO
                    GO TOP

                    SELECT (THIS.this_cCursorItens)
                    SET ORDER TO Dopes
                    GO TOP

                    THIS.this_nTotalOperacoes = RECCOUNT(THIS.this_cCursorOperacoes)
                    THIS.this_nTotalItens     = RECCOUNT(THIS.this_cCursorItens)

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar regras de transfer" + CHR(234) + "ncia:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


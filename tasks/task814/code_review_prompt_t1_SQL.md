# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CPROS, DOPEDS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  DeleteMark = .F.
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
		.AddCursor('SigOpTrf','cIdChaves','crSigOpTrf','Dopes',.f.,[Select * From SigOpTrf Where Dopes = '] + crSigCdOpe.Dopes + [' Order by Dopes])
		.AddCursor('SigCdOpe','Dopes','TmpOpe','Dopes',.f.,[Select Dopes,nDopes From SigCdOpe Where Dopes <> '] + crSigCdOpe.Dopes + [' order by Dopes])
		SELECT crSigOpTrf
SELECT TmpOpe 
	.Column2.ControlSource = 'xOpe.Dopes'
	ThisForm.GradePro.col_cpros.ControlSource = 'xTrf.Cpros'
	ThisForm.GradePro.col_dpros.Controlsource = 'xTrf.Dpros'
Select crSigOpTrf
	ThisForm.podatamgr.SqlExecute([Select cPros, dPros from SigCdPro Where Cpros = ?m.cPros],'CrSigCdPro')
	Insert Into xTrf ( Dopes, Dopeds, Cpros, Dpros ) ;
	Select xOpe
		Insert Into xOpe ( Dopes ) Value ( m.Dopeds )
Select xOpe
Select xTrf
Select xTrf
Select xOpe
	If Not Seek(This.Value, 'TmpOpe', 'Dopes')
		Select xOpe
		Seek (lcDope)
				Delete
		Select xOpe
	SELECT crSigOpTrf
	DELETE ALL
	Select xTrf
			Insert Into crSigOpTrf From memvar
		Select xOpe
			Insert Into crSigOpTrf (Dopes, DopeDs, cIdChaves) ;
			m.lnErro1 = Iif(.poDataMgr.UpDate('crSigOpTrf'),1,-1)
Insert Into xOpe (Dopes) Values ( Space(20))
Select xOpe
Select xOpe
	SELECT xTrf
	DELETE for Dopeds = xOpe.Dopes
	SELECT xOpe
	DELETE
SELECT xTrf
Insert Into xTrf (Dopes, Dopeds) Values ( crSigCdOpe.Dopes, xOpe.Dopes)
Select xTrf
Select xTrf
	Delete
	Select xTrf

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpTrf.prg) - TRECHOS RELEVANTES PARA PASS SQL (3034 linhas total):

*-- Linhas 9 a 59:
9: *           Movable=.F., ClipControls=.F., AutoCenter=.T., cabecalho cinza
10: *           no topo com o Caption "Operacoes Automaticas P/ <operacao>")
11: *   BD   -> SigOpTrf (ver cabecalho de SigOpTrfBO.prg para o detalhamento
12: *           completo da tabela/chave/queries); tela EDITAVEL (INSERT/UPDATE
13: *           em lote ao Encerrar, diferente dos irmaos somente-leitura
14: *           SigOpTop/SigOpTor/SigOpTot)
15: *   CODE -> arquitetura em camadas (FormBase / SigOpTrfBO)
16: *
17: * O QUE ESTA TELA EH
18: *   Dialogo FILHO que o form pai SigCdOpe (Cadastro de Operacoes do Caixa)
19: *   abre para o usuario DEFINIR regras de transferencia automatica de
20: *   produtos da operacao-pai (crSigCdOpe.Dopes no legado) para OUTRAS
21: *   operacoes de destino. O legado recebe "poForm" (o form pai) e
22: *   "pnDataSes" (DataSession do pai) no Init, troca para a DataSession do
23: *   pai (Set DataSession To pnDataSes) para ler crSigCdOpe.Dopes direto do
24: *   cursor do pai, monta o Caption e expande as regras ja gravadas em
25: *   SigOpTrf para duas grades mestre-detalhe:
26: *
27: *     - GradeOpe (grade superior, 1 coluna "Operacoes") <- xOpe (lista
28: *       DISTINTA das operacoes de DESTINO ja usadas nesta operacao de
29: *       origem). O Valid do Text1 da coluna valida o codigo digitado contra
30: *       TmpOpe (Select Dopes,nDopes From SigCdOpe Where Dopes <>
31: *       <crSigCdOpe.Dopes>), abre fwBuscaInt quando nao encontra, e recusa
32: *       duplicata apagando a linha repetida com aviso.
33: *     - GradePro (grade inferior, 2 colunas "Produto"/"Descricao") <- xTrf
34: *       (produtos que migram para a operacao de destino selecionada na
35: *       grade de cima). AfterRowColChange de GradeOpe filtra xTrf por
36: *       "Set Key To crSigCdOpe.Dopes+xOpe.Dopes" (mestre-detalhe). O Valid
37: *       de txt_cpros valida o produto contra SigCdPro (fwBuscaExt quando
38: *       nao encontra) e recusa duplicata na MESMA operacao de destino.
39: *
40: *   Botoes: cmdInserir/cmdExcluir operam a grade de OPERACOES (GradeOpe);
41: *   Command2/Command1 operam a grade de PRODUTOS (GradePro); cmdSair
42: *   ("Encerrar") grava o lote inteiro (Delete All + Scan + Insert em
43: *   crSigOpTrf, ou uma linha por operacao-destino sem produto especifico se
44: *   nenhuma linha de xTrf for valida), faz UpDate+Commit via poDataMgr,
45: *   reabilita o form pai e libera o dialogo.
46: *
47: *   No migrado, o form roda com DataSession = 1 (sessao CORRENTE,
48: *   compartilhada), reproduzindo o mesmo efeito do "Set DataSession To
49: *   pnDataSes" sem a troca manual de sessao - mesmo padrao adotado nos
50: *   dialogos irmaos desta familia (FormSigOpTop.prg/FormSigOpSts.prg/
51: *   FormSigOpSqn.prg/FormSigOpSlc.prg/FormSigOpSpr.prg). O codigo da
52: *   operacao (crSigCdOpe.Dopes) eh passado explicitamente pelo chamador,
53: *   em vez de lido direto de um cursor do pai (PILAR 3 - o BO consulta SQL
54: *   Server direto, nao reusa cursor do form pai).
55: *
56: *   "PROCEDURE Load" do legado ("=fConfigGeral()") fica de fora: no
57: *   Fortyus era inicializacao GLOBAL da aplicacao, ja coberta pelo startup
58: *   do sistema novo (config.prg) - mesma decisao documentada no cabecalho
59: *   de SigOpTopBO.prg/SigOpClpBO.prg (familia SigOp*).

*-- Linhas 157 a 176:
157: *   produz o mesmo efeito estrutural - nao e logica de negocio computada,
158: *   so travar o campo (diferente do caso que a regra #46 cobre).
159: *
160: *   CarregarLista() chama BO.CarregarRegras() (SQLEXEC de crSigOpTrf/TmpOpe
161: *   + CREATE CURSOR + SCAN de expansao - ver cabecalho de SigOpTrfBO.prg)
162: *   e faz so o que e do FORM: bind das duas grades, reaplicacao do formato
163: *   (RecordSource zera Column.Width/Header1.Caption - Problema 48) e o
164: *   filtro mestre-detalhe INICIAL (SET KEY TO do fim do Init legado). O
165: *   refiltro ao TROCAR de linha na grade superior (AfterRowColChange) fica
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

*-- Linhas 210 a 228:
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

*-- Linhas 243 a 292:
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
279: *   este BO nao sobrescreve ExecutarExclusao).
280: *
281: * FASE 8 (esta fase): o TRANSPORTE da linha da grade e a CONSOLIDACAO
282: *
283: *   Esta tela nao tem campo nenhum fora das duas grades, entao a FICHA dela
284: *   eh UMA LINHA de this_cCursorItens (xTrf: Dopes + Dopeds + Cpros + Dpros).
285: *   Os dois hooks de transferencia transportam essa linha, e nao um bloco de
286: *   TextBox de Page2 - que esta tela nao possui.
287: *
288: *   | metodo (FormSigOpTrf)   | o que faz / equivalente legado |
289: *   |-------------------------|---------------------------------|
290: *   | FormParaBO()            | LINHA corrente de xTrf -> properties do BO. Dentro do Valid da celula o valor digitado esta em par_oTxt.Value e o cursor so o recebe depois (regra #46), por isso a CELULA vence o cursor no campo Cpros |
291: *   | BOParaForm()            | properties do BO -> LINHA corrente + celula + Refresh. Eh a transcricao do "This.Value = evaluate('crSigCdPro.CPROS') / txt_dpros.Value = crSigCdPro.Dpros / Refresh" do Valid legado |
292: *   | LimparCampos()          | zera a ficha da linha no funil de carga, para a linha de uma sessao nunca vazar para a seguinte |

*-- Linhas 298 a 316:
298: *   o codigo escolhido, e BOParaForm devolve cada metade para onde o legado
299: *   manda - o CODIGO para a celula (no legado quem o grava no cursor eh o
300: *   bind da coluna, depois do Valid) e a DESCRICAO para a linha ("txt_dpros.
301: *   Value = crSigCdPro.Dpros", TextBox com ControlSource na coluna).
302: *   Escrever tambem o codigo na linha aqui pareceria mais seguro e MUDARIA a
303: *   regra: o SEEK de RecusarProdutoTrfDuplicado passaria a ver a propria
304: *   linha e recusaria com UMA duplicata pre-existente, no lugar das DUAS que
305: *   o legado exige (regra #17) - ver o cabecalho de BOParaForm.
306: *
307: *   FormParaBO/BOParaForm/LimparCampos sao PROTECTED EXPLICITOS: FormBase
308: *   declara os mesmos tres nomes como PROTECTED (formbase.prg:276/280/285) e
309: *   em VFP9 a subclasse NAO alarga escopo herdado - omitir o modificador nao
310: *   os tornaria publicos, so esconderia o fato. Sao chamados por THIS. de
311: *   dentro da classe (regra #8). HabilitarCampos/AjustarBotoesPorModo NAO
312: *   existem em FormBase, logo sao publicos de verdade e o harness os alcanca
313: *   de fora (regra #3/#51).
314: *
315: *   O lote do Encerrar (PersistirRegras + GravarUmaRegra) continua com os
316: *   parametros EXPLICITOS da Fase 7, e nao passa por FormParaBO: o 2o laco

*-- Linhas 754 a 804:
754:     * (grade superior, mestre: lista DISTINTA das operacoes de destino).
755:     *
756:     * Transcricao do dump (SIGOPTRF.GradeOpe):
757:     *   ColumnCount=1  FontName="Tahoma"  DeleteMark=.F.  Height=221
758:     *   Left=5  ScrollBars=2  Top=133  Width=180  GridLineColor=238,238,238
759:     *
760:     * RecordMark = .F. nao consta do dump (legado herda o default): posto
761:     * pela regra do projeto para grade de form OPERACIONAL criada por
762:     * AddObject.
763:     *
764:     * O Column1 do dump chama-se "Column2" (Column1.Name = "Column2" -
765:     * renome interno do Form Designer, SEM efeito na API): a Column eh
766:     * SEMPRE acessada por POSICAO (regra #34, Controls/Columns indexado
767:     * por numero) - NAO renomear nada aqui.
768:     *
769:     * Sem ReadOnly = .T.: esta grade EH editavel (cmdInserir insere linha
770:     * em branco, o usuario digita o codigo - diferente do irmao
771:     * FormSigOpTop, somente leitura).
772:     *
773:     * So o que NAO depende de dado (regra #41): ControlSource/RecordSource
774:     * moram em CarregarLista. Column.Width/Header1.Caption moram em
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

*-- Linhas 994 a 1036:
994:     * selecionada na grade de cima).
995:     *
996:     * Transcricao do dump (SIGOPTRF.GradePro):
997:     *   ColumnCount=2  DeleteMark=.F.  Height=220  Left=190  RecordMark=.F.
998:     *   ScrollBars=2  TabIndex=8  Top=133  Width=335
999:     *
1000:     * ZOrderSet = 8 do dump NAO e transcrito: e bookkeeping do Form
1001:     * Designer (indice de z-order), sem equivalente em runtime - o
1002:     * equivalente real e o METODO ZOrder(), que o legado nao chama aqui
1003:     * (regra #33).
1004:     *
1005:     * So o que NAO depende de dado (regra #41): ControlSource/RecordSource
1006:     * moram em CarregarLista. AplicarFormatoGrade (chamada ao final) e a
1007:     * FONTE UNICA de Column.Width/Header1.Caption/ReadOnly das DUAS
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

*-- Linhas 1160 a 1188:
1160:     *
1161:     *     With Thisform.GradeOpe
1162:     *         .RecordSource          = 'xOpe'
1163:     *         .Column2.ControlSource = 'xOpe.Dopes'
1164:     *         .Refresh
1165:     *     EndWith
1166:     *     With Thisform.GradePro
1167:     *         .RecordSource = 'xTrf'
1168:     *         .col_cpros.ControlSource = 'xTrf.Cpros'
1169:     *         .col_dpros.Controlsource = 'xTrf.Dpros'
1170:     *     ENDWITH
1171:     *     ... (expansao de crSigOpTrf para xTrf/xOpe - THIS.this_oBusinessObject.CarregarRegras()) ...
1172:     *     Select xOpe / Set Order to / Go Top
1173:     *     Select xTrf / Set Order to Dopes / Go Top
1174:     *     SET KEY TO crSigCdOpe.Dopes+xOpe.Dopes
1175:     *     Go Top
1176:     *     ThisForm.GradePro.Refresh
1177:     *
1178:     * A consulta e a expansao moram no BO (SigOpTrfBO.CarregarRegras,
1179:     * Fase 4), que popula this_cCursorOperacoes/this_cCursorItens. Aqui
1180:     * fica o que e do FORM: o binding, a reaplicacao de formato e a
1181:     * repintura.
1182:     *
1183:     * Tres cuidados do projeto, todos presentes no legado ou exigidos por
1184:     * regra:
1185:     *   1. ColumnCount e RecordSource FORA do WITH (GRID-WITH): acessar
1186:     *      .Column dentro do mesmo WITH que atribui RecordSource estoura
1187:     *      'Unknown member COLUMN1' - mesma cautela do irmao FormSigOpTop.
1188:     *   2. AplicarFormatoGrade roda DEPOIS do RecordSource das duas

*-- Linhas 1235 a 1278:
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
1245:                     .Column1.ControlSource = loc_cAliasItens + ".Cpros"
1246:                     .Column2.ControlSource = loc_cAliasItens + ".Dpros"
1247:                 ENDWITH
1248: 
1249:                 *-- Reaplica largura/cabecalho/readonly, que o RecordSource zerou
1250:                 THIS.AplicarFormatoGrade()
1251: 
1252:                 *-- FASE 8: o rebind acabou de resetar Column.ReadOnly junto
1253:                 *-- com Width/Caption/CurrentControl (Problema 48 / regra #41),
1254:                 *-- e quem desabilita tem de reabilitar no FUNIL (regra #40) -
1255:                 *-- este eh o funil
1256:                 THIS.HabilitarCampos()
1257: 
1258:                 *-- Legado: Set Key To crSigCdOpe.Dopes+xOpe.Dopes (carga INICIAL)
1259:                 THIS.FiltrarItensPorOperacaoCorrente()
1260: 
1261:                 *-- Legado: Select xOpe / Go Top / .Refresh (GradeOpe) e
1262:                 *-- ThisForm.GradePro.Refresh
1263:                 SELECT (loc_cAliasOperacoes)
1264:                 GO TOP
1265:                 THIS.grd_4c_Operacoes.Refresh()
1266:                 THIS.grd_4c_Itens.Refresh()
1267: 
1268:                 loc_lCarregou = .T.
1269:             ELSE
1270:                 *-- Sem dado nao ha binding (regra #41). Operacao sem
1271:                 *-- regra nenhuma gravada ainda e resultado valido (o
1272:                 *-- legado tambem nao avisa nada nesse caso - regra #50)
1273:                 IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
1274:                     THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
1275:                     MsgErro(THIS.this_cMensagemErro, THIS.Caption)
1276:                 ENDIF
1277:             ENDIF
1278: 

*-- Linhas 1291 a 1310:
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

*-- Linhas 1324 a 1342:
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

*-- Linhas 1360 a 1378:
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

*-- Linhas 1429 a 1447:
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

*-- Linhas 1490 a 1521:
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

*-- Linhas 1529 a 1561:
1529:     *
1530:     *   lcdope = This.Value
1531:     *   If !IsEmpty(lcDope)
1532:     *       Select xOpe
1533:     *       lnRecNo = IIf(Not Eof() Or Bof(), RecNo('xope'), 0)
1534:     *       Set Order to Dopes
1535:     *       Seek (lcDope)
1536:     *       If Not Eof()
1537:     *           Skip
1538:     *           If xOpe.Dopes = lcDope
1539:     *               This.Value = ''
1540:     *               Delete
1541:     *               Skip
1542:     *               Skip -1
1543:     *               MessageBox('Operacao ja Digitada ... ',48,'')
1544:     *           EndIf
1545:     *       Endif
1546:     *       Select xOpe / Set Order to Dopes
1547:     *       Goto (lnRecNo) ou Goto Bottom
1548:     *   EndIf
1549:     *
1550:     * SEEK em VFP9 ignora SET EXACT e faz busca por PREFIXO (documentado) -
1551:     * com lcDope ja resolvido pelo lookup, o SKIP so acusa duplicata
1552:     * quando ja existem DUAS linhas com o mesmo codigo ANTES desta edicao
1553:     * (a achada pelo Seek e a seguinte, em ordem de indice) - mesma
1554:     * sequencia do legado, nao "corrigida" aqui (regra #17).
1555:     *==========================================================================
1556:     PROTECTED PROCEDURE RecusarOperacaoTrfDuplicada(par_oTxt)
1557:         LOCAL loc_cAliasOperacoes, loc_cDope, loc_nRecNo
1558: 
1559:         IF VARTYPE(par_oTxt) != "O" OR VARTYPE(THIS.this_oBusinessObject) != "O"
1560:             RETURN
1561:         ENDIF

*-- Linhas 1571 a 1615:
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

*-- Linhas 1710 a 1728:
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

*-- Linhas 1761 a 1779:
1761:     * trecho final do legado (GradePro.col_cpros.txt_cpros.Valid):
1762:     *
1763:     *   cPro = This.Value
1764:     *   Select xTrf
1765:     *   _Recno = Recno()
1766:     *   Set Order to Cpros
1767:     *   Seek cPro
1768:     *   If !Eof()
1769:     *       lcdope = xTrf.Dopeds
1770:     *       Skip
1771:     *       If Cpros = Cpro
1772:     *           This.Value = ''
1773:     *           Messagebox('Produto ja Digitado na Operacao '+lcDope,48,'')
1774:     *       Endif
1775:     *   Endif
1776:     *   Set Order to Dopes
1777:     *   Set Key to crSigCdOpe.Dopes + xOpe.Dopes
1778:     *   If _Recno # 0 / go _Recno / Endif
1779:     *

*-- Linhas 1810 a 1860:
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

*-- Linhas 1891 a 2083:
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
2063:     * CODIGO - CmdInserirClick acabou de inserir uma linha, por exemplo - a
2064:     * chave fica DEFASADA e o DELETE nao alcanca linha alguma, EM SILENCIO:
2065:     * os produtos orfaos sobreviveriam e seriam REGRAVADOS no Encerrar
2066:     * (PersistirRegras varre xTrf sem filtro), fazendo a exclusao parecer
2067:     * nao ter funcionado. Por isso o filtro eh reafirmado com o Dopes da
2068:     * linha que esta sendo excluida ANTES do DELETE FOR: no caminho normal eh
2069:     * exatamente a mesma faixa do legado, e no caminho defasado eh a faixa
2070:     * que o legado PRETENDIA varrer.
2071:     *
2072:     * A comparacao usa ALLTRIM nos DOIS lados em vez do "=" do legado: com
2073:     * SET EXACT ON (config.prg) o "=" entre dois CHAR(20) depende de o
2074:     * padding de ambos coincidir. Aqui nao eh chave posicional concatenada e
2075:     * sim comparacao de UM campo, entao o ALLTRIM eh seguro e NAO cai na
2076:     * regra #42.
2077:     *
2078:     * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
2079:     *==========================================================================
2080:     PROCEDURE CmdExcluirClick
2081:         LOCAL loc_cAliasAnterior, loc_cAliasOperacoes, loc_cAliasItens, ;
2082:               loc_cDopedsExcluir, loc_cDopesCorrente, loc_oErro
2083: 

*-- Linhas 2091 a 2178:
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
2121:                         IF EOF()
2122:                             GO BOTTOM
2123:                         ENDIF
2124:                     ENDIF
2125: 
2126:                     *-- Legado: SELECT xTrf / SET KEY TO crSigCdOpe.Dopes +
2127:                     *-- xOpe.Dopes - agora com a linha CORRENTE (a que o
2128:                     *-- SKIP/GO BOTTOM deixou ativa), nao com a excluida
2129:                     SELECT (loc_cAliasOperacoes)
2130:                     loc_cDopesCorrente = IIF(!EOF() AND !BOF(), Dopes, "")
2131:                     THIS.AplicarFiltroItensPorDestino(loc_cDopesCorrente)
2132: 
2133:                     *-- Legado: ThisForm.GravaDados = .t.
2134:                     THIS.MarcarDadosAlterados()
2135: 
2136:                     *-- Legado: Thisform.GradeOpe.SetFocus /
2137:                     *-- ThisForm.GradePro.Refresh (fora do IF, como no dump)
2138:                     IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
2139:                         THIS.grd_4c_Operacoes.Refresh()
2140:                     ENDIF
2141:                     IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
2142:                         THIS.grd_4c_Itens.Refresh()
2143:                     ENDIF
2144: 
2145:                     IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
2146:                         SELECT (loc_cAliasAnterior)
2147:                     ENDIF
2148:                 ENDIF
2149:             ENDIF
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

*-- Linhas 2201 a 2302:
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
2227:                     ENDIF
2228: 
2229:                     IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
2230:                         SELECT (loc_cAliasAnterior)
2231:                     ENDIF
2232:                 ENDIF
2233:             ENDIF
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

*-- Linhas 2396 a 2459:
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
2421:     *
2422:     * 1. "APAGA TUDO E REGRAVA" eh o desenho da tela, nao uma otimizacao: o
2423:     *    legado nao faz UPDATE de linha alguma nem preserva cidchaves - toda
2424:     *    linha regravada ganha uma PK NOVA (fUniqueIds(), regra #22). Por
2425:     *    isso os lacos usam NovoRegistro()+Salvar() com this_cCidChaves
2426:     *    VAZIO (Inserir() do BO gera a chave quando ela chega vazia), e nunca
2427:     *    Atualizar().
2428:     *
2429:     * 2. O CRITERIO de cada laco eh regra de negocio (regra #17), inclusive a
2430:     *    ASSIMETRIA entre eles: o laco dos PRODUTOS exige Dopes, Dopeds E
2431:     *    Cpros preenchidos (linha de produto incompleta eh descartada), mas o
2432:     *    laco de FALLBACK insere TODA linha de xOpe, sem conferir se o codigo
2433:     *    da operacao de destino esta em branco. Nenhum dos dois eh
2434:     *    "corrigido" aqui.
2435:     *
2436:     * 3. O "Reccount([crSigOpTrf]) = 0" que dispara o fallback NAO significa
2437:     *    "nenhuma linha de produto valida": RECCOUNT conta tambem registro
2438:     *    MARCADO como excluido, e o DELETE ALL de duas linhas acima acabou de
2439:     *    marcar todas as regras que ja existiam. Ou seja, no legado o
2440:     *    fallback so dispara quando a view nasceu VAZIA - primeira gravacao
2441:     *    desta operacao de origem - E nenhuma linha de produto era valida. O
2442:     *    equivalente exato aqui eh (regras pre-existentes + linhas gravadas
2443:     *    agora) = 0, com as pre-existentes contadas em this_cCursorRegras,
2444:     *    que eh o mesmo "Select * From SigOpTrf Where Dopes = <origem>" do
2445:     *    crSigOpTrf legado e ninguem altera depois da carga.
2446:     *
2447:     * O filtro mestre-detalhe de this_cCursorItens eh DESFEITO aqui (SET KEY
2448:     * TO / SET ORDER TO do legado) e nao eh restaurado: a tela esta fechando
2449:     * (BtnSairClick chama Release() em seguida, inclusive quando a gravacao
2450:     * falha) e o Destroy fecha os cursores.
2451:     *
2452:     * PROTECTED: funil interno do Encerrar, nao se chama de fora deste form.
2453:     * O RETURN de guarda fica FORA de TRY/CATCH, e o RETURN final eh unico
2454:     * e tambem fora (regra #1).
2455:     *==========================================================================
2456:     PROTECTED FUNCTION PersistirRegras
2457:         LOCAL loc_lSucesso, loc_cAliasAnterior, loc_cAliasRegras, loc_cAliasItens, ;
2458:               loc_cAliasOperacoes, loc_nRegrasAnteriores, loc_nGravadas, ;
2459:               loc_cDopesLinha, loc_cDopedsLinha, loc_cProsLinha, loc_oErro

*-- Linhas 2471 a 2508:
2471:         loc_nGravadas       = 0
2472: 
2473:         TRY
2474:             *-- Legado: Reccount([crSigOpTrf]) APOS o Delete All, que conta as
2475:             *-- regras que JA existiam (ponto 3 do cabecalho)
2476:             loc_nRegrasAnteriores = 0
2477:             IF VARTYPE(loc_cAliasRegras) = "C" AND !EMPTY(loc_cAliasRegras) AND ;
2478:                USED(loc_cAliasRegras)
2479:                 loc_nRegrasAnteriores = RECCOUNT(loc_cAliasRegras)
2480:             ENDIF
2481: 
2482:             *-- Legado: SELECT crSigOpTrf / DELETE ALL. A view ja nasce
2483:             *-- filtrada por Dopes = <origem>, logo apaga so as regras desta
2484:             *-- operacao de origem - que eh o que ApagarRegrasDaOrigem faz
2485:             IF !THIS.this_oBusinessObject.ApagarRegrasDaOrigem()
2486:                 loc_lSucesso = .F.
2487:             ENDIF
2488: 
2489:             *-- Legado: Select xTrf / SET KEY TO / Set Order To / Scan
2490:             IF loc_lSucesso AND VARTYPE(loc_cAliasItens) = "C" AND ;
2491:                !EMPTY(loc_cAliasItens) AND USED(loc_cAliasItens)
2492: 
2493:                 SELECT (loc_cAliasItens)
2494: 
2495:                 *-- Legado: SET KEY TO / Set Order To - nesta ORDEM (limpa a
2496:                 *-- faixa com o indice ainda ativo e so depois solta o
2497:                 *-- indice). O guard por ORDER() nao eh zelo: medido no VFP9
2498:                 *-- (automation\ProbeF7SigOpTrfCursores.prg), "SET KEY TO"
2499:                 *-- sem indice ativo NAO eh no-op - dispara o erro 26,
2500:                 *-- "Table has no index order set.". No fluxo normal o
2501:                 *-- indice esta em Dopes (AplicarFiltroItensPorDestino o
2502:                 *-- fixa), igual ao legado, mas sem indice nao pode haver
2503:                 *-- faixa para limpar e pular eh exatamente equivalente
2504:                 IF !EMPTY(ORDER())
2505:                     SET KEY TO
2506:                 ENDIF
2507:                 SET ORDER TO
2508:                 GO TOP

*-- Linhas 2523 a 2603:
2523:                             loc_lSucesso = .F.
2524:                         ENDIF
2525: 
2526:                         *-- O BO grava por SQLEXEC sem cursor de destino,
2527:                         *-- entao a area de trabalho nao muda - reafirmada
2528:                         *-- aqui para o SCAN nunca depender disso
2529:                         SELECT (loc_cAliasItens)
2530:                     ENDIF
2531:                 ENDSCAN
2532:             ENDIF
2533: 
2534:             *-- Legado: If (Reccount([crSigOpTrf]) = 0) / Select xOpe / Scan /
2535:             *-- Insert ... ("operacao de destino sem produto especifico migra
2536:             *-- tudo"). Ver ponto 3 do cabecalho para o porque do criterio
2537:             IF loc_lSucesso AND (loc_nRegrasAnteriores + loc_nGravadas) = 0 AND ;
2538:                VARTYPE(loc_cAliasOperacoes) = "C" AND !EMPTY(loc_cAliasOperacoes) AND ;
2539:                USED(loc_cAliasOperacoes)
2540: 
2541:                 SELECT (loc_cAliasOperacoes)
2542:                 SET ORDER TO
2543:                 GO TOP
2544: 
2545:                 SCAN
2546:                     *-- Legado: Values (crSigCdOpe.Dopes, xOpe.Dopes,
2547:                     *-- fUniqueIds()) - Cpros fica VAZIO, e o legado NAO
2548:                     *-- confere se xOpe.Dopes esta em branco (ponto 2)
2549:                     loc_cDopedsLinha = ALLTRIM(NVL(Dopes, ""))
2550: 
2551:                     IF !THIS.GravarUmaRegra(ALLTRIM(THIS.this_cDopes), loc_cDopedsLinha, "")
2552:                         loc_lSucesso = .F.
2553:                     ENDIF
2554: 
2555:                     SELECT (loc_cAliasOperacoes)
2556:                 ENDSCAN
2557:             ENDIF
2558: 
2559:         CATCH TO loc_oErro
2560:             loc_lSucesso = .F.
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

*-- Linhas 2647 a 2669:
2647:     * NUNCA atualiza linha: o legado apaga o lote inteiro no Encerrar e regrava
2648:     * cada linha com uma PK nova (fUniqueIds() - ver o ponto 1 do cabecalho de
2649:     * PersistirRegras e a regra #22). A linha de xTrf nem tem o campo
2650:     * cidchaves (CREATE CURSOR em SigOpTrfBO.CarregarRegras), logo nao ha de
2651:     * onde ler uma chave existente.
2652:     *
2653:     * NAO muda a area de trabalho corrente: le tudo qualificado pelo alias,
2654:     * sem SELECT. Este form roda na DataSession do PAI (DataSession = 1), onde
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

*-- Linhas 2719 a 2759:
2719:     *   - o CODIGO (Cpros) vai para a CELULA. No legado quem o grava no cursor
2720:     *     eh o bind da coluna, DEPOIS que o Valid devolve .T.
2721:     *   - a DESCRICAO (Dpros) vai para o CURSOR. No legado ela eh escrita no
2722:     *     TextBox da col_dpros, que tem ControlSource na coluna - ou seja,
2723:     *     chega a linha no ato.
2724:     *
2725:     * POR QUE NAO GRAVAR Cpros NO CURSOR AQUI (medido, nao preferencia): logo
2726:     * depois deste metodo roda RecusarProdutoTrfDuplicado, que eh TRANSCRICAO
2727:     * LITERAL (regra #17) do "Set Order to Cpros / Seek cPro / Skip / If
2728:     * Cpros = Cpro" do legado. No legado esse SEEK varre o cursor SEM o codigo
2729:     * recem-escolhido - ele ainda esta so na celula -, e por isso o criterio
2730:     * de duplicata do legado exige DUAS linhas pre-existentes com o mesmo
2731:     * produto (quirk ja registrado no cabecalho deste arquivo desde a Fase 6).
2732:     * Escrever Cpros na linha corrente antes do SEEK faria a propria linha
2733:     * entrar na varredura e passaria a recusar com UMA linha pre-existente -
2734:     * mudanca silenciosa de regra de negocio, que eh exatamente o que a regra
2735:     * #17 proibe. Grava-se, entao, so o que o legado grava neste instante.
2736:     *
2737:     * Grava SO no cursor LOCAL - igual ao legado, que persiste em SigOpTrf
2738:     * apenas no Encerrar (BtnSairClick -> PersistirRegras).
2739:     *
2740:     * LEFT() pela largura da COLUNA, nunca pelo Width em pixels do controle
2741:     * (regra #19): Cpros = 14 (SigOpTrf.cpros char(14), a mesma largura do
2742:     * campo no cursor) e Dpros = 60 (largura do campo no CREATE CURSOR,
2743:     * transcrita do "Dpros c(60)" do legado). Assim o que a celula e a linha
2744:     * recebem eh exatamente o que cabe na coluna do SQL Server no INSERT do
2745:     * Encerrar.
2746:     *
2747:     * par_oTxt eh OPCIONAL: durante o lookup a celula precisa exibir o codigo
2748:     * escolhido (o "This.Value =" do legado); chamado sem ela, so o cursor e a
2749:     * grade sao atualizados.
2750:     *
2751:     * Repinta ao fim (regra #21): gravar no cursor NAO repinta a grade, e sem
2752:     * o Refresh a Column2 continuaria mostrando a descricao anterior.
2753:     *
2754:     * Deixa this_cCursorItens como alias corrente, igual ao legado, que termina
2755:     * o Valid trabalhando sobre xTrf (Set Order to Dopes / Set Key to ...).
2756:     *
2757:     * PROTECTED EXPLICITO pela MESMA razao do FormParaBO acima (FormBase
2758:     * declara PROTECTED PROCEDURE BOParaForm em formbase.prg:280).
2759:     *

*-- Linhas 2778 a 2800:
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


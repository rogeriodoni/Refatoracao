# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LINHAANTERIOR, CIDQUERYS, PARENTFORM, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LINHAANTERIOR, CIDQUERYS, PARENTFORM, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NUMES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LINHAANTERIOR, CIDQUERYS, PARENTFORM, EMPDOPNUMS

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
  ControlSource = ""
ThisForm.grd_itens.column1.ControlSource = 'dbItens.cpros'
ThisForm.grd_itens.column2.ControlSource = 'dbItens.dpros'
ThisForm.grd_itens.column3.ControlSource = 'dbItens.qtds'
ThisForm.grd_operacoes.column1.ControlSource = 'dbOperacao.Emps'
ThisForm.grd_operacoes.column2.ControlSource = 'dbOperacao.Dopes'
ThisForm.grd_operacoes.column3.ControlSource = 'dbOperacao.Numes'
ThisForm.grd_operacoes.column4.ControlSource = 'dbOperacao.Datas'
ThisForm.grd_operacoes.column5.ControlSource = 'dbOperacao.Valos'
Select TprMvCab
	Insert Into crSigTempC (EmpDopNums, cIdQuerys, cIdChaves) ;
If Not ThisForm.ParentForm.poDataTmp.Update('crSigTempC')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigTempC)')
lcQuery = [Select b.Emps, b.Dopes, b.Numes, b.Cpros, b.Dpros, b.Qtds ] + ;
		    [From SigTempC a, SigMvItn b ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crLclMvItn') < 1)
Select crLclMvItn
Select TprMvCab
	Insert Into dbOperacao From MemVar
Select dbOperacao
Select crLclMvItn
	Insert Into dbItens From MemVar
	Select crLclMvItn
		Insert Into dbItens From MemVar

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRPPP.prg) - TRECHOS RELEVANTES PARA PASS SQL (1310 linhas total):

*-- Linhas 127 a 145:
127:     * InicializarForm - Cria o Business Object, monta a moldura visual
128:     * (fundo + cabecalho + botao Encerrar + as duas grades) e faz a carga
129:     * inicial dos dados, na mesma ordem do Init legado: primeiro os
130:     * RecordSource/ControlSource das grades, depois a carga.
131:     *
132:     * Os campos de exibicao (Conta/Periodo/Grupo, somente leitura) entram
133:     * nas Fases 5-6; o Click do Encerrar e o AfterRowColChange da grade de
134:     * movimentacoes, nas Fases 7-8 (roteiro em ConfigurarPageFrame).
135:     *--------------------------------------------------------------------------
136:     PROTECTED PROCEDURE InicializarForm()
137:         LOCAL loc_lSucesso, loc_oErro
138:         loc_lSucesso = .F.
139: 
140:         TRY
141:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRPPPBO")
142: 
143:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
144:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + ;
145:                     "cio SIGPRPPPBO.", "Erro em InicializarForm")

*-- Linhas 259 a 277:
259:     *     pelos dois metodos que o legado de fato tem -
260:     *     CarregarFiltrosDoFormPai (os 5 campos de exibicao) e
261:     *     CarregarLista/GradeOperacoesAfterRowColChange (as duas grades,
262:     *     por RecordSource/ControlSource). O sentido inverso nao existe:
263:     *     os CINCO campos declaram "PROCEDURE When / Return .f." no SCX e
264:     *     sao reproduzidos com .ReadOnly = .T., e as duas grades tem
265:     *     Grid.ReadOnly = .T. mais ColumnN.ReadOnly = .T. no dump - nao ha
266:     *     um unico controle digitavel nesta tela para escrever de volta.
267:     *   Handler do Cancelar, metodo que habilita campos por modo, metodo
268:     *     que ajusta botoes por modo e metodo que limpa os campos: sao
269:     *     convencao do par Page1(Lista)/Page2(Dados) do frmcadastro. Este
270:     *     form eh PLANO (nao tem PageFrame) e nao tem modo INCLUIR/
271:     *     ALTERAR/VISUALIZAR/EXCLUIR: nao ha edicao para cancelar, campo
272:     *     para habilitar, modo para ajustar botao, nem reaproveitamento de
273:     *     instancia para limpar (o pai cria o form, Show() modal, e o
274:     *     Destroy o libera a cada consulta).
275:     *   Handler do botao de busca: a busca mora no form PAI (FormSigPrPpc
276:     *     valida Grupo/Conta/periodo e executa a consulta); esta tela so
277:     *     EXIBE o resultado que o pai deixou em TprMvCab.

*-- Linhas 725 a 776:
725:     * grade de itens eh o AfterRowColChange, na Fase 7-8).
726:     *
727:     * GarantirCursorOperacoes() roda ANTES do AddObject do Grid: o cursor
728:     * precisa existir no momento em que RecordSource/ControlSource sao
729:     * atribuidos, senao o Init inteiro derruba (regra #41). A carga
730:     * (CarregarOperacoes) entra na Fase 7-8 - aqui o cursor fica vazio,
731:     * so com a estrutura.
732:     *--------------------------------------------------------------------------
733:     PROTECTED PROCEDURE ConfigurarGridOperacoes()
734:         LOCAL loc_oGrid, loc_oErro
735: 
736:         TRY
737:             THIS.this_oBusinessObject.GarantirCursorOperacoes()
738: 
739:             THIS.AddObject("grd_4c_Operacoes", "Grid")
740:             loc_oGrid = THIS.grd_4c_Operacoes
741: 
742:             WITH loc_oGrid
743:                 .Top         = 234
744:                 .Left        = 140
745:                 .Width       = 469
746:                 .Height      = 94
747:                 .FontName    = "Arial"
748:                 .FontSize    = 8
749:                 .DeleteMark  = .F.
750:                 .RecordMark  = .F.
751:                 .ScrollBars  = 2
752:                 .ReadOnly    = .T.
753:                 .ColumnCount = 5
754:             ENDWITH
755: 
756:             loc_oGrid.RecordSource = THIS.this_oBusinessObject.this_cCursorOperacoes
757:             loc_oGrid.Column1.ControlSource = loc_oGrid.RecordSource + ".emps"
758:             loc_oGrid.Column2.ControlSource = loc_oGrid.RecordSource + ".dopes"
759:             loc_oGrid.Column3.ControlSource = loc_oGrid.RecordSource + ".numes"
760:             loc_oGrid.Column4.ControlSource = loc_oGrid.RecordSource + ".datas"
761:             loc_oGrid.Column5.ControlSource = loc_oGrid.RecordSource + ".valos"
762: 
763:             WITH loc_oGrid.Column1
764:                 .Width             = 31
765:                 .Movable           = .F.
766:                 .Resizable         = .F.
767:                 .ReadOnly          = .T.
768:                 .FontName          = "Courier New"
769:                 .Header1.FontName  = "Verdana"
770:                 .Header1.FontSize  = 8
771:                 .Header1.Alignment = 2
772:                 .Header1.ForeColor = RGB(90, 90, 90)
773:                 .Header1.Caption   = "Emp."
774:                 .Text1.FontName    = "Courier New"
775:                 .Text1.BorderStyle = 0
776:                 .Text1.Margin      = 0

*-- Linhas 889 a 917:
889:                 .Height      = 112
890:                 .FontName    = "Tahoma"
891:                 .FontSize    = 8
892:                 .DeleteMark  = .F.
893:                 .RecordMark  = .F.
894:                 .ScrollBars  = 2
895:                 .ReadOnly    = .T.
896:                 .ColumnCount = 3
897:             ENDWITH
898: 
899:             loc_oGrid.RecordSource = THIS.this_oBusinessObject.this_cCursorItens
900:             loc_oGrid.Column1.ControlSource = loc_oGrid.RecordSource + ".cpros"
901:             loc_oGrid.Column2.ControlSource = loc_oGrid.RecordSource + ".dpros"
902:             loc_oGrid.Column3.ControlSource = loc_oGrid.RecordSource + ".qtds"
903: 
904:             WITH loc_oGrid.Column1
905:                 .Width             = 108
906:                 .Movable           = .F.
907:                 .Resizable         = .F.
908:                 .ReadOnly          = .T.
909:                 .FontName          = "Tahoma"
910:                 .Header1.FontName  = "Tahoma"
911:                 .Header1.FontSize  = 8
912:                 .Header1.Alignment = 2
913:                 .Header1.ForeColor = RGB(90, 90, 90)
914:                 .Header1.Caption   = "Produto"
915:                 .Text1.FontName    = "Tahoma"
916:                 .Text1.BorderStyle = 0
917:                 .Text1.Margin      = 0

*-- Linhas 1045 a 1071:
1045: 
1046:     *--------------------------------------------------------------------------
1047:     * CarregarLista - Carga das duas grades. Equivale ao trecho final do Init
1048:     * legado, que depois de montar os RecordSource/ControlSource faz:
1049:     *
1050:     *     ThisForm.LockScreen   = .t.
1051:     *     ThisForm.MousePointer = 11
1052:     *     Zap In dbOperacao
1053:     *     Zap In dbItens
1054:     *     Select TprMvCab
1055:     *     Scan / Scatter MemVar / Insert Into dbOperacao From MemVar / EndScan
1056:     *     Select dbOperacao
1057:     *     Go Top
1058:     *     ... (carga de dbItens da PRIMEIRA linha)
1059:     *     ThisForm.MousePointer = 0
1060:     *     ThisForm.LockScreen   = .f.
1061:     *
1062:     * O ZAP/APPEND + GO TOP + carga dos itens da linha corrente moram no BO
1063:     * (SIGPRPPPBO.CarregarOperacoes, que encadeia
1064:     * CarregarItensDaOperacaoCorrente); aqui ficam o LockScreen/MousePointer
1065:     * transcritos do legado e o repintar das grades.
1066:     *
1067:     * NAO refaz a consulta em SigMvCab: o resultado vem do cursor que o form
1068:     * PAI deixou pronto (TprMvCab) - refazer o WHERE aqui faria esta grade
1069:     * mostrar um conjunto DIFERENTE do que o usuario pediu, sem erro na tela
1070:     * (ver comentario de CarregarOperacoes no BO).
1071:     *

*-- Linhas 1123 a 1152:
1123: 
1124:     *--------------------------------------------------------------------------
1125:     * RepintarGrades - Funil UNICO de repintura das duas grades (legado:
1126:     * "Select dbOperacao / Go Top" no Init e "ThisForm.grd_itens.Refresh" no
1127:     * fim do AfterRowColChange).
1128:     *
1129:     * Encher o cursor nao faz a grade exibir as linhas novas: sem Refresh a
1130:     * grade fica visualmente VAZIA com o cursor cheio, e o sintoma ("a tela
1131:     * nao traz dados") manda o diagnostico para SQL/cursor/permissao
1132:     * (regra #21). Por isso a repintura fica num metodo so, chamado por CADA
1133:     * caminho que popula os cursores.
1134:     *
1135:     * Este metodo NAO reposiciona os cursores - so repinta. O GO TOP que a
1136:     * regra #21 pede ja eh feito por quem CARREGA, no BO: CarregarOperacoes
1137:     * termina com SELECT + GO TOP no cursor da grade mestre, e
1138:     * CarregarItensPorChave faz o mesmo no cursor de itens. Repetir GO TOP
1139:     * aqui seria inofensivo na carga inicial, mas o AfterRowColChange da
1140:     * Fase 7-8 reusa este funil para repintar a grade de itens DEPOIS que o
1141:     * usuario escolheu uma linha da grade mestre - e ali o GO TOP puxaria a
1142:     * grade mestre de volta para a primeira linha, desfazendo a selecao
1143:     * (o legado, coerente com isso, so faz "grd_itens.Refresh" no fim do
1144:     * AfterRowColChange, sem tocar na posicao de dbOperacao).
1145:     *
1146:     * PUBLICO de proposito: mesmo motivo de CarregarLista - alem do harness,
1147:     * o AfterRowColChange da grade de movimentacoes (Fase 7-8) reusa este
1148:     * funil, e delegate de BINDEVENT precisa ser PUBLIC (regra #3).
1149:     *--------------------------------------------------------------------------
1150:     PROCEDURE RepintarGrades()
1151:         LOCAL loc_cAliasAnterior, loc_cCursorOps, loc_cCursorItens, loc_oErro
1152: 

*-- Linhas 1166 a 1208:
1166:             *-- A grade MESTRE manda na area de trabalho corrente: o
1167:             *-- AfterRowColChange (Fase 7-8) le a linha selecionada dela.
1168:             IF USED(loc_cCursorOps)
1169:                 SELECT (loc_cCursorOps)
1170:             ELSE
1171:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1172:                     SELECT (loc_cAliasAnterior)
1173:                 ENDIF
1174:             ENDIF
1175:         CATCH TO loc_oErro
1176:             MsgErro(loc_oErro.Message + CHR(13) + ;
1177:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1178:                 "Procedure: " + loc_oErro.Procedure, "Erro em RepintarGrades")
1179:         ENDTRY
1180:     ENDPROC
1181: 
1182:     *--------------------------------------------------------------------------
1183:     * GradeOperacoesAfterRowColChange - Delegate de BINDEVENT para o
1184:     * AfterRowColChange de grd_4c_Operacoes (ligado em
1185:     * ConfigurarGridOperacoes). Equivale ao PROCEDURE AfterRowColChange do
1186:     * dump legado:
1187:     *     Lparameters nColIndex
1188:     *     If (ThisForm.LinhaAnterior <> ThisForm.grd_operacoes.activerow)
1189:     *         ThisForm.LinhaAnterior = ThisForm.grd_operacoes.activerow
1190:     *         ThisForm.LockScreen   = .t.
1191:     *         ThisForm.MousePointer = 11
1192:     *         Zap In dbItens
1193:     *         Select crLclMvItn / Seek .../ Scan While ... / Insert Into dbItens
1194:     *         ThisForm.grd_itens.Refresh
1195:     *         ThisForm.MousePointer = 0
1196:     *         ThisForm.LockScreen   = .f.
1197:     *     EndIf
1198:     *
1199:     * O guard por LINHA (nao por nColIndex, regra #46 - delegate recebe o
1200:     * parametro do evento, mas AfterRowColChange e disparo por COLUNA
1201:     * dentro da MESMA linha nao justifica refazer a consulta de itens) eh
1202:     * exatamente o que o legado faz, comparando ActiveRow com a ultima
1203:     * linha carregada (THIS.this_nLinhaAnterior). O carrego da PRIMEIRA
1204:     * linha ja aconteceu no CarregarOperacoes do BO (chamado por
1205:     * THIS.CarregarLista em InicializarForm) - este handler so entra em
1206:     * acao quando o usuario muda de linha depois disso.
1207:     *
1208:     * SIGPRPPPBO.CarregarItensDaOperacaoCorrente encapsula o


### BO (C:\4c\projeto\app\classes\SIGPRPPPBO.prg):
*====================================================================
* SIGPRPPPBO.prg
*
* Business Object do SIGPRPPP - "Pesquisa de Produtos por Conta".
*
* Formulario OPERACIONAL de CONSULTA (drill-down), aberto como tela
* FILHA pelo FormSigPrPpc: o pai ja validou Grupo/Conta/Periodo,
* executou a consulta em SigMvCab e deixou o resultado no cursor
* TprMvCab (SigPrPpcBO.ConsultarMovimentacoes preserva esse nome
* EXATAMENTE para esta tela consumir). Aqui a grade de cima lista
* essas movimentacoes e a grade de baixo mostra os itens (SigMvItn)
* da movimentacao selecionada, com a descricao do produto lida AO
* VIVO do cadastro (SigCdPro).
*
* Sobre a ausencia de CRUD neste BO
* ---------------------------------
* O dump legado (tasks\task666\SIGPRPPP_form_codigo_fonte.txt) nao
* tem gravacao de dado de negocio. O unico acesso de escrita remota
* do legado eh ANDAIME de consulta: ele monta a lista de chaves
* Emps+Dopes+Numes na tabela de rascunho SigTempC (Insert Into
* crSigTempC + poDataTmp.Update + Commit), usa essa lista como lado
* esquerdo de um JOIN contra SigMvItn e, logo em seguida, APAGA as
* proprias linhas com fSqlApagarTmp. Era a forma de o Fortyus mandar
* uma lista de chaves ao servidor a partir de um cursor local.
*
* Na arquitetura nova a conexao eh direta ao SQL Server, entao o
* JOIN eh feito na propria consulta dos itens e a SigTempC deixa de
* ser necessaria - nao ha o que gravar. Por isso este BO NAO
* sobrescreve Inserir(), Atualizar() nem ExecutarExclusao(): o
* comportamento herdado de BusinessBase (recusar a operacao e
* reportar pelo ExibirFalha do Salvar) ja eh o correto, e escrever
* um INSERT/UPDATE aqui significaria inventar tabela e colunas, o
* que o PILAR 2 proibe. Pela mesma razao RegistrarAuditoria() nunca
* eh acionado nesta tela: auditoria registra gravacao, e gravacao
* nao existe aqui.
*
* Metodos publicos usados pelo formulario:
*   CarregarOperacoes()               - popula a grade de movimentacoes
*   CarregarDoCursor(par_cAlias)      - le a linha corrente p/ as props
*   CarregarItensDaOperacaoCorrente() - AfterRowColChange da grade
*   CarregarItensPorChave(E, D, N)    - itens de uma movimentacao
*   MontarChaveEmpDopNums(E, D, N)    - chave posicional char(29)
*====================================================================

DEFINE CLASS SIGPRPPPBO AS BusinessBase

	*-- Filtros recebidos do formulario chamador (equivalentes as
	*   PRIVATE pcGrupo/pcConta/pcContaDesc/pdInicial/pdFinal que o
	*   legado le no Init). Aqui servem so para exibicao nos campos
	*   somente-leitura do cabecalho - quem filtrou foi o pai.
	this_cGrupo = ""
	this_cConta = ""
	this_cContaDesc = ""
	this_dDataInicial = {}
	this_dDataFinal = {}

	*-- Cursor de ORIGEM das movimentacoes, populado pelo form pai
	*   (SigPrPpcBO.ConsultarMovimentacoes). Equivale ao TprMvCab que
	*   o legado recebia pronto na mesma DataSession.
	this_cCursorOrigem = "TprMvCab"

	*-- Cursores das duas grades (equivalem a dbOperacao e dbItens do
	*   DataEnvironment legado)
	this_cCursorOperacoes = "cursor_4c_Operacoes"
	this_cCursorItens = "cursor_4c_Itens"

	*-- Linha CORRENTE da grade de movimentacoes. Os nomes espelham as
	*   colunas de SigMvCab (emps, dopes, numes, datas, valos) para nao
	*   haver divergencia de nome entre BO e Form.
	this_cEmps = ""
	this_cDopes = ""
	this_nNumes = 0
	this_dDatas = {}
	this_nValos = 0

	*====================================================================
	* Init - Inicializa o Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- Tabela de leitura da tela. A chave de negocio eh COMPOSTA
		*   (Emps + Dopes + Numes) e existe materializada em SigMvCab e
		*   SigMvItn como empdopnums char(29) - ver MontarChaveEmpDopNums.
		THIS.this_cTabela = "SigMvCab"
		THIS.this_cCampoChave = "empdopnums"

		THIS.this_cGrupo = ""
		THIS.this_cConta = ""
		THIS.this_cContaDesc = ""
		THIS.this_dDataInicial = {}
		THIS.this_dDataFinal = {}

		THIS.this_cCursorOrigem = "TprMvCab"
		THIS.this_cCursorOperacoes = "cursor_4c_Operacoes"
		THIS.this_cCursorItens = "cursor_4c_Itens"

		THIS.this_cEmps = ""
		THIS.this_cDopes = ""
		THIS.this_nNumes = 0
		THIS.this_dDatas = {}
		THIS.this_nValos = 0

		RETURN .T.
	ENDPROC

	*====================================================================
	* GarantirCursorOperacoes - Cria o cursor da grade de movimentacoes
	* se ele ainda nao existir.
	*
	* A estrutura eh declarada em UM UNICO lugar (usado tanto na carga
	* quanto na limpeza) porque cursor de grade criado com ordem de
	* campos diferente em pontos diferentes quebra o APPEND FROM, que
	* casa os campos por NOME. Tipos copiados do schema:
	*   SigMvCab.emps  char(3)  / dopes char(20) / numes numeric(6,0)
	*   SigMvCab.datas datetime / valos numeric(11,2)
	*
	* PUBLICO de proposito: o Form chama este metodo de fora da classe em
	* ConfigurarGridOperacoes() (Fase 4), antes de CarregarOperacoes()
	* existir (Fase 7-8), para o cursor ja estar criado quando o Grid
	* recebe RecordSource/ControlSource - regra #41 (ControlSource de
	* cursor ainda inexistente derruba o Init).
	*====================================================================
	PROCEDURE GarantirCursorOperacoes()
		IF !USED(THIS.this_cCursorOperacoes)
			SET NULL ON
			CREATE CURSOR (THIS.this_cCursorOperacoes) ( ;
				emps C(3) NULL, ;
				dopes C(20) NULL, ;
				numes N(6,0) NULL, ;
				datas T NULL, ;
				valos N(11,2) NULL)
			SET NULL OFF
		ENDIF
	ENDPROC

	*====================================================================
	* GarantirCursorItens - Cria o cursor da grade de itens se ele ainda
	* nao existir. Tipos copiados do schema:
	*   SigMvItn.cpros char(14) / qtds numeric(9,3)
	*   SigCdPro.dpros char(65)
	*
	* PUBLICO de proposito: o Form chama este metodo de fora da classe em
	* ConfigurarGridItens() (Fase 4) - mesmo motivo de GarantirCursorOperacoes.
	*====================================================================
	PROCEDURE GarantirCursorItens()
		IF !USED(THIS.this_cCursorItens)
			SET NULL ON
			CREATE CURSOR (THIS.this_cCursorItens) ( ;
				cpros C(14) NULL, ;
				dpros C(65) NULL, ;
				qtds N(9,3) NULL)
			SET NULL OFF
		ENDIF
	ENDPROC

	*====================================================================
	* CarregarOperacoes - Popula a grade de movimentacoes a partir do
	* cursor que o form PAI deixou pronto (this_cCursorOrigem).
	*
	* Equivale a este trecho do Init legado:
	*     Zap In dbOperacao
	*     Select TprMvCab
	*     Scan
	*         Scatter MemVar
	*         Insert Into dbOperacao From MemVar
	*     EndScan
	*     Select dbOperacao
	*     Go Top
	* ... seguido da carga dos itens da PRIMEIRA linha (o legado popula
	* dbItens logo apos o Go Top; o AfterRowColChange so entra em acao
	* quando o usuario muda de linha).
	*
	* NAO re-executa a consulta em SigMvCab: o WHERE do legado vive no
	* form PAI (SigPrPpcBO.ConsultarMovimentacoes - periodo mais os
	* pares GrupoOs/GrupoDs e ContaOs/ContaDs com OR nos DOIS lados,
	* mais Dopes e Emps opcionais). Refazer a consulta aqui com um
	* filtro adivinhado faria esta grade mostrar um conjunto DIFERENTE
	* do que o usuario pediu, sem erro nenhum na tela.
	*
	* O cursor da grade nunca eh fechado nem recriado: ZAP + APPEND
	* FROM preserva estrutura, RecordSource e ControlSource das colunas.
	*====================================================================
	FUNCTION CarregarOperacoes()
		LOCAL loc_lSucesso, loc_cOrigem, loc_oErro

		THIS.this_cMensagemErro = ""
		THIS.this_lErroExibido = .F.
		loc_lSucesso = .F.
		loc_cOrigem = ALLTRIM(THIS.this_cCursorOrigem)

		TRY
			THIS.GarantirCursorOperacoes()
			THIS.GarantirCursorItens()

			IF !USED(loc_cOrigem)
				THIS.this_cMensagemErro = "O resultado da consulta (" + loc_cOrigem + ;
					") n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + ;
					"vel. Refa" + CHR(231) + "a a pesquisa na tela anterior."
			ELSE
				IF USED("cursor_4c_OperacoesTmp")
					USE IN cursor_4c_OperacoesTmp
				ENDIF

				*-- So as colunas que a grade exibe; o legado copiava o
				*   registro inteiro porque dbOperacao era um DBF com a
				*   mesma estrutura de SigMvCab.
				SELECT emps, dopes, numes, datas, valos ;
					FROM (loc_cOrigem) ;
					ORDER BY emps, dopes, numes ;
					INTO CURSOR cursor_4c_OperacoesTmp READWRITE

				SELECT (THIS.this_cCursorOperacoes)
				ZAP
				APPEND FROM DBF("cursor_4c_OperacoesTmp")

				IF USED("cursor_4c_OperacoesTmp")
					USE IN cursor_4c_OperacoesTmp
				ENDIF

				SELECT (THIS.this_cCursorOperacoes)
				GO TOP

				IF EOF()
					*-- Universo vazio nao eh erro: so deixa a grade de
					*   itens vazia e coerente com a de movimentacoes.
					SELECT (THIS.this_cCursorItens)
					ZAP

					THIS.this_cEmps = ""
					THIS.this_cDopes = ""
					THIS.this_nNumes = 0
					THIS.this_dDatas = {}
					THIS.this_nValos = 0

					loc_lSucesso = .T.
				ELSE
					*-- O resultado da carga dos itens EH o resultado desta
					*   carga: se a consulta dos itens falhar, a tela fica
					*   com a grade de baixo vazia sem motivo aparente, e
					*   devolver .T. aqui esconderia a falha do chamador
					*   (que leria this_cMensagemErro ja preenchido).
					loc_lSucesso = THIS.CarregarItensDaOperacaoCorrente()
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro em CarregarOperacoes")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Le a linha CORRENTE do cursor informado para as
	* propriedades da movimentacao selecionada.
	*
	* Padrao canonico: SELECT (par_cAliasCursor) ANTES de acessar os
	* campos, acesso aos campos SEM prefixo de alias, e cada campo
	* protegido por TYPE() porque o mesmo metodo atende tanto o cursor
	* da grade (5 colunas) quanto o cursor de origem TprMvCab, que eh um
	* SELECT * de SigMvCab com 158 colunas.
	*
	* PUBLICO de proposito: o Form chama este metodo de fora da classe, e
	* metodo PROTECTED chamado de fora estoura "Property ... is not
	* found" em runtime.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso, loc_cAlias, loc_oErro

		loc_lSucesso = .F.
		loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), ;
			ALLTRIM(THIS.this_cCursorOperacoes))

		TRY
			IF USED(loc_cAlias)
				SELECT (loc_cAlias)

				IF !EOF() AND !BOF()
					IF TYPE(loc_cAlias + ".emps") != "U"
						THIS.this_cEmps = TratarNulo(emps, "")
					ENDIF
					IF TYPE(loc_cAlias + ".dopes") != "U"
						THIS.this_cDopes = TratarNulo(dopes, "")
					ENDIF
					IF TYPE(loc_cAlias + ".numes") != "U"
						THIS.this_nNumes = TratarNulo(numes, 0)
					ENDIF
					IF TYPE(loc_cAlias + ".datas") != "U"
						THIS.this_dDatas = TratarNulo(datas, {})
					ENDIF
					IF TYPE(loc_cAlias + ".valos") != "U"
						THIS.this_nValos = TratarNulo(valos, 0)
					ENDIF

					loc_lSucesso = .T.
				ELSE
					THIS.this_cMensagemErro = "Nenhuma movimenta" + CHR(231) + CHR(227) + ;
						"o selecionada."
				ENDIF
			ELSE
				THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + ;
					"o est" + CHR(225) + " aberto."
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarItensDaOperacaoCorrente - Le a linha corrente da grade de
	* movimentacoes e recarrega a grade de itens com os produtos daquela
	* movimentacao.
	*
	* Equivale ao grd_operacoes.AfterRowColChange do legado (Zap In
	* dbItens, Seek na chave da linha corrente de dbOperacao e Scan
	* While a chave bater). Publico porque quem dispara eh o handler do
	* proprio Grid, no Form.
	*====================================================================
	FUNCTION CarregarItensDaOperacaoCorrente()
		LOCAL loc_lSucesso

		loc_lSucesso = .F.

		IF THIS.CarregarDoCursor(THIS.this_cCursorOperacoes)
			loc_lSucesso = THIS.CarregarItensPorChave(THIS.this_cEmps, ;
				THIS.this_cDopes, THIS.this_nNumes)
		ENDIF

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* CarregarItensPorChave - Popula a grade de itens com os produtos
	* (SigMvItn) da movimentacao Emps + Dopes + Numes informada.
	*
	* A descricao do produto vem SEMPRE do cadastro atual (SigCdPro),
	* nunca da descricao historica gravada no item. Eh exatamente o que
	* o legado faz:
	*     poDataMgr.CursorQuery("SigCdPro", "crSigCdPro", "CPros", ...)
	*     m.DPros = Iif(Eof("crSigCdPro"), "", crSigCdPro.DPros)
	* ou seja, produto que saiu do cadastro aparece com a descricao EM
	* BRANCO. O LEFT JOIN com ISNULL(b.dpros, "") reproduz os dois casos
	* (ISNULL aqui eh a funcao do SQL Server, dentro da string SQL).
	*
	* As tres colunas sao comparadas SEPARADAMENTE, e nao pela chave
	* concatenada empdopnums char(29) que o legado usava: char no SQL
	* Server compara com preenchimento de brancos, entao a igualdade por
	* coluna eh equivalente e dispensa reproduzir o alinhamento
	* posicional 3 + 20 + 6 - onde um ALLTRIM a mais devolveria zero
	* linha em silencio.
	*====================================================================
	FUNCTION CarregarItensPorChave(par_cEmps, par_cDopes, par_nNumes)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lProsseguir, loc_oErro

		THIS.this_cMensagemErro = ""
		loc_lSucesso = .F.
		loc_lProsseguir = .T.

		IF VARTYPE(par_cEmps) != "C" OR VARTYPE(par_cDopes) != "C" OR ;
		   VARTYPE(par_nNumes) != "N"
			THIS.this_cMensagemErro = "Chave da movimenta" + CHR(231) + CHR(227) + ;
				"o inv" + CHR(225) + "lida."
			loc_lProsseguir = .F.
		ENDIF

		IF loc_lProsseguir AND (TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0)
			THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel."
			loc_lProsseguir = .F.
		ENDIF

		IF loc_lProsseguir
			TRY
				THIS.GarantirCursorItens()

				loc_cSQL = "SELECT a.cpros, ISNULL(b.dpros, '') AS dpros, a.qtds" + ;
					" FROM SigMvItn a" + ;
					" LEFT JOIN SigCdPro b ON b.cpros = a.cpros" + ;
					" WHERE a.emps = " + EscaparSQL(ALLTRIM(par_cEmps)) + ;
					" AND a.dopes = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
					" AND a.numes = " + FormatarNumeroSQL(par_nNumes, 0) + ;
					" ORDER BY a.cpros"

				IF USED("cursor_4c_ItensTmp")
					USE IN cursor_4c_ItensTmp
				ENDIF

				*-- SQLEXEC sempre em cursor TEMPORARIO: executado sobre o
				*   alias da grade, ele fecharia e recriaria esse alias,
				*   zerando ColumnCount/RecordSource e deixando a grade
				*   como um retangulo branco pelo resto da vida do form.
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensTmp")

				IF loc_nResultado < 0
					THIS.this_cMensagemErro = "Erro ao buscar os itens da movimenta" + ;
						CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Erro SQL")
					THIS.this_lErroExibido = .T.
				ELSE
					SELECT (THIS.this_cCursorItens)
					ZAP
					APPEND FROM DBF("cursor_4c_ItensTmp")

					SELECT (THIS.this_cCursorItens)
					GO TOP

					loc_lSucesso = .T.
				ENDIF

				IF USED("cursor_4c_ItensTmp")
					USE IN cursor_4c_ItensTmp
				ENDIF
			CATCH TO loc_oErro
				THIS.this_cMensagemErro = loc_oErro.Message
				MsgErro(loc_oErro.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
					"Procedure: " + loc_oErro.Procedure, "Erro em CarregarItensPorChave")
				THIS.this_lErroExibido = .T.
				loc_lSucesso = .F.
			ENDTRY
		ENDIF

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* MontarChaveEmpDopNums - Chave POSICIONAL de 29 caracteres que o
	* sistema materializa na coluna empdopnums char(29) de SigMvCab e
	* SigMvItn, e que o legado monta como
	*     TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes, 6)
	*
	* O preenchimento FAZ PARTE da chave: emps char(3) + dopes char(20)
	* + Str(numes, 6) = 29. Usar ALLTRIM nas partes encurtaria a chave e
	* ela nunca casaria - a consulta rodaria sem erro e devolveria zero
	* linha. Por isso o PADR explicito, com as larguras do schema.
	*====================================================================
	FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
		LOCAL loc_cEmps, loc_cDopes, loc_nNumes

		loc_cEmps = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
		loc_cDopes = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
		loc_nNumes = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)

		RETURN PADR(loc_cEmps, 3) + PADR(loc_cDopes, 20) + STR(loc_nNumes, 6)
	ENDFUNC

	*====================================================================
	* ObterChavePrimaria - Chave da movimentacao selecionada, no mesmo
	* formato da coluna empdopnums char(29).
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.MontarChaveEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, ;
			THIS.this_nNumes)
	ENDPROC

	*====================================================================
	* LimparDados - Zera filtros, linha selecionada e as duas grades. As
	* grades sao esvaziadas com ZAP (nunca fechadas), para o Grid nao
	* perder RecordSource nem ControlSource.
	*====================================================================
	PROCEDURE LimparDados()
		DODEFAULT()

		THIS.this_cGrupo = ""
		THIS.this_cConta = ""
		THIS.this_cContaDesc = ""
		THIS.this_dDataInicial = {}
		THIS.this_dDataFinal = {}

		THIS.this_cEmps = ""
		THIS.this_cDopes = ""
		THIS.this_nNumes = 0
		THIS.this_dDatas = {}
		THIS.this_nValos = 0

		THIS.GarantirCursorOperacoes()
		SELECT (THIS.this_cCursorOperacoes)
		ZAP

		THIS.GarantirCursorItens()
		SELECT (THIS.this_cCursorItens)
		ZAP

		RETURN .T.
	ENDPROC

	*====================================================================
	* Destroy - Fecha os cursores criados por ESTE BO. O cursor de
	* origem (TprMvCab) pertence ao form pai e eh fechado por ele.
	*====================================================================
	PROCEDURE Destroy()
		IF USED("cursor_4c_OperacoesTmp")
			USE IN cursor_4c_OperacoesTmp
		ENDIF
		IF USED("cursor_4c_ItensTmp")
			USE IN cursor_4c_ItensTmp
		ENDIF
		IF USED(THIS.this_cCursorItens)
			USE IN (THIS.this_cCursorItens)
		ENDIF
		IF USED(THIS.this_cCursorOperacoes)
			USE IN (THIS.this_cCursorOperacoes)
		ENDIF

		DODEFAULT()
	ENDPROC

ENDDEFINE


# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LNPAG' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOME, GERBALS, LNLINHAS, GRUPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MESTRE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOME, GERBALS, LNLINHAS, GRUPOS

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
  ControlSource = "crSigPrDmo.nome"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  ControlSource = "crSigPrDmo.Grupos"
  ControlSource = "crSigPrDmo.Contas"
lcQuery = [Delete From SigCdDpr Where nome=']+ThisForm.pagina.dados.getnome.Value+[']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crDelSigCdDpr') < 1)
Select crSigCdDpr
Select crSigPrDmo
lcQryDmPro = [Select * From SigPrDmo ]
lcQryDmPri = [Select * From SigCdDpr Where nome=?sNome Order By Ordems]
		Select crSigPrDmo
		lcQuery = [Select * ] + ;
		    [ From SigOpOpt]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigOpOpt') < 1)
		Select crSigOpOpt
		lcQuery = [Select codigos,Descrs ] + ;
		    [ From SigCdGcr] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdGcr') < 1)
		Select crSigCdGcr
		lcQuery = [Select Grupos, IClis, RClis ] + ;
				    [From SigCdCli ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCli') < 1)
		Select crSigCdCli
		ThisForm.pagina.dados.grade.column1.ControlSource=''
		ThisForm.pagina.dados.grade.column2.ControlSource=''
		ThisForm.pagina.dados.grade.column3.ControlSource=''
		ThisForm.pagina.dados.grade.column4.ControlSource=''
		ThisForm.pagina.dados.grade.column5.ControlSource=''
ThisForm.pagina.dados.grade.column1.ControlSource='crSigCdDpr.Ordems'
ThisForm.pagina.dados.grade.column2.ControlSource='crSigCdDpr.grupos'
ThisForm.pagina.dados.grade.column3.ControlSource='crSigCdDpr.contas'
ThisForm.pagina.dados.grade.column4.ControlSource='crSigCdDpr.tpops'
ThisForm.pagina.dados.grade.column5.ControlSource='crSigCdDpr.operas'
ThisForm.pagina.dados.grade.column1.ControlSource=''
ThisForm.pagina.dados.grade.column2.ControlSource=''
ThisForm.pagina.dados.grade.column3.ControlSource=''
ThisForm.pagina.dados.grade.column4.ControlSource=''
ThisForm.pagina.dados.grade.column5.ControlSource=''
If Not ThisForm.poDataMgr.Update('crSigCdDpr')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdDpr)')
		Select crSigCdDpr
Select crSigCdDpr
	If not Seek(Padr(This.Value,10),'crSigCdGcr','BalCodigo')
Select crSigPrDmo
	If !Seek( This.Value, 'crSigCdCli', 'BalCodigo' )
Select crSigOpOpt
If !Seek( This.Value ) Or ( crSigCdDpr.Grupos # crSigOpOpt.Grupos And !IsEmpty( crSigOpOpt.Grupos ) )
	Select Cods, Descs, pFalhas From crSigOpOpt ;
	Select crSigCdDpr
	Delete
	If !Seek(This.Value,'crSigCdCli','BalNome')
	If !Seek(This.Value,'crSigCdGcr','BalDescrs')
	If !Seek( This.Value, 'crSigCdGcr', 'BalCodigo')
	If !Seek(This.Value,'crSigCdCli','BalCodigo')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigOpDmp.prg) - TRECHOS RELEVANTES PARA PASS SQL (4218 linhas total):

*-- Linhas 46 a 64:
46: *                     (sNome = Space(20) nao casa nenhuma linha) e so e'
47: *                     recarregado pelo Grupo_op.Click - Fases 7-8. Aqui ele e'
48: *                     criado como placeholder com a estrutura EXATA de
49: *                     SigCdDpr, porque ligar Column.ControlSource a um cursor
50: *                     inexistente derruba o Init e a tela nao abre (regra #41).
51: *
52: * Notas de fidelidade (PILAR 1):
53: *   - O SCX legado tem Caption = (prompt()), resolvido em tempo de execucao a
54: *     partir do prompt da barra de menu. O dump nao traz o texto literal, logo
55: *     o Caption fixo abaixo acompanha o cabecalho do SigOpDmpBO (Fases 1-2) e
56: *     sera o mesmo texto do DEFINE BAR no menu.prg.
57: *   - Pagina.Dados.Picture = imagens\new_background.jpg vem do SCX. A pagina
58: *     Lista nao e sobrescrita no SCX: usa a textura canonica do form de
59: *     1000px de largura (fundo_cad_1003.jpg).
60: *   - Grupo_op (Left=338) e Grupo_Saida (Left=718) do SCX estao no espaco de
61: *     coordenadas do frmcadastro de 800px. O form novo tem 1000px e usa os
62: *     valores canonicos 542 e 917 (CLAUDE.md regra #10).
63: *   - Pagina.Top = -29 no legado: todo controle das Pages compensa +29 no Top.
64: *==============================================================================

*-- Linhas 91 a 109:
91:     *-- LostFocus (Grupo/DGrupo/Conta/DConta). LostFocus dispara SEMPRE que o
92:     *-- foco sai do campo, mesmo sem digitacao - diferente do Valid do
93:     *-- legado; sem esta guarda, so tabular pelos campos repete o
94:     *-- SQLEXEC/CreateObject("FormBuscaAuxiliar") a cada passagem, mesmo com
95:     *-- o valor inalterado. Declarado com "" aqui (DEFINE CLASS so aceita
96:     *-- literal, nunca CHR() - a sentinela CHR(1) e atribuida em
97:     *-- InicializarForm, onde chamada de funcao e permitida).
98:     this_cUltimoValidarGrupoLostFocusValidado  = ""
99:     this_cUltimoValidarDGrupoLostFocusValidado = ""
100:     this_cUltimoValidarContaLostFocusValidado  = ""
101:     this_cUltimoValidarDContaLostFocusValidado = ""
102: 
103:     *===========================================================================
104:     * Init - Inicializa o formulario
105:     * REGRA CRITICA: apenas RETURN DODEFAULT().
106:     * FormBase.Init() ja chama InicializarForm() - NUNCA duplicar a chamada.
107:     *===========================================================================
108:     PROCEDURE Init()
109:         RETURN DODEFAULT()

*-- Linhas 209 a 227:
209:     * containers de botao ficam em Top=29, DENTRO da area da faixa, e so
210:     * aparecem se criados DEPOIS dela.
211:     * A grade espelha o pColuna do Init legado: UMA coluna (Nome). O bind do
212:     * RecordSource/ControlSource fica em CarregarLista, porque a Page1 e
213:     * montada ANTES de o cursor existir (regra #41).
214:     *===========================================================================
215:     PROTECTED PROCEDURE ConfigurarPaginaLista()
216:         LOCAL loc_oPagina
217:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
218: 
219:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
220:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
221: 
222:         *-- Faixa do cabecalho (legado: Pagina.Lista.cntSombra Top=2, Height=80,
223:         *-- BackColor=100,100,100; com a compensacao +29 do PageFrame -> Top=29)
224:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
225:         WITH loc_oPagina.cnt_4c_Cabecalho
226:             .Top         = 29
227:             .Left        = 0

*-- Linhas 461 a 479:
461:             .HighlightBackColor = RGB(255, 255, 255)
462:             .HighlightForeColor = RGB(15, 41, 104)
463:             .HighlightStyle     = 2
464:             .DeleteMark         = .F.
465:             .RecordMark         = .F.
466:             .ScrollBars         = 2
467:             .GridLines          = 3
468:             .ReadOnly           = .T.
469:             .Visible            = .T.
470:         ENDWITH
471: 
472:         *-- Atalhos da grade (Fase 7). O Enter sobre a grade da Lista e
473:         *-- CONSULTAR no frmcadastro (KeyPress: nKeyCode=13 + ActiveControl
474:         *-- GRID -> Grupo_Op.Click(2)); o duplo clique nao existe no legado e
475:         *-- cai no MESMO funil. O handler de KeyPress declara os DOIS
476:         *-- parametros do evento, senao o VFP estoura "No PARAMETER statement
477:         *-- is found" a cada tecla (regra #3).
478:         BINDEVENT(loc_oPagina.grd_4c_Lista, "KeyPress", THIS, "GradeListaKeyPress")
479:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GradeListaDblClick")

*-- Linhas 631 a 651:
631:         *-- dos demais, ou seja este campo NAO forca maiuscula (regra #49).
632:         *-- MaxLength = 20 e' a largura de SigPrDmo.nome char(20), NUNCA o
633:         *-- Width em pixels (regra #19).
634:         *-- O legado usa ControlSource = "crSigPrDmo.nome"; na arquitetura
635:         *-- nova o valor trafega por FormParaBO/BOParaForm, entao o campo
636:         *-- nasce com .Value = "" e sem ControlSource.
637:         loc_oPagina.AddObject("txt_4c_Nome", "TextBox")
638:         WITH loc_oPagina.txt_4c_Nome
639:             .Value             = ""
640:             .Top               = 175
641:             .Left              = 214
642:             .Width             = 150
643:             .Height            = 23
644:             .MaxLength         = 20
645:             .FontName          = "Tahoma"
646:             .FontSize          = 8
647:             .Format            = "K"
648:             .DisabledBackColor = RGB(192, 192, 192)
649:             .DisabledForeColor = RGB(0, 0, 0)
650:             .Themes            = .F.
651:             .Visible           = .T.

*-- Linhas 679 a 697:
679:         *-- Format = "K!" seleciona ao entrar E forca MAIUSCULA; os dois
680:         *-- efeitos sao do legado e mudam o DADO digitado (regra #49).
681:         *-- MaxLength = 10 = SigPrDmo.grupos char(10) (regra #19).
682:         *-- O legado usa ControlSource = "crSigPrDmo.Grupos".
683:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
684:         WITH loc_oPagina.txt_4c_Grupo
685:             .Value             = ""
686:             .Top               = 198
687:             .Left              = 214
688:             .Width             = 80
689:             .Height            = 25
690:             .MaxLength         = 10
691:             .FontName          = "Courier New"
692:             .FontSize          = 9
693:             .FontBold          = .F.
694:             .FontItalic        = .F.
695:             .FontUnderline     = .F.
696:             .Alignment         = 0
697:             .BackStyle         = 1

*-- Linhas 706 a 724:
706:         ENDWITH
707: 
708:         *-- Get_DGrupo -> txt_4c_DGrupo (descricao do grupo).
709:         *-- Campo SEM ControlSource no legado: ele e' preenchido pelo Valid de
710:         *-- Get_Grupo (crSigCdGcr.Descrs) e pelo IniciaDesc do form, e aceita
711:         *-- digitacao para buscar o grupo PELA descricao - por isso tem Valid
712:         *-- proprio e MaxLength = 20, embora SigCdGcr.descrs seja char(40).
713:         *-- Os dois numeros sao do dump e ficam como estao (PILAR 1).
714:         loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
715:         WITH loc_oPagina.txt_4c_DGrupo
716:             .Value             = ""
717:             .Top               = 198
718:             .Left              = 294
719:             .Width             = 271
720:             .Height            = 25
721:             .MaxLength         = 20
722:             .FontName          = "Courier New"
723:             .FontSize          = 9
724:             .FontBold          = .F.

*-- Linhas 773 a 791:
773:         *-- efeitos sao do legado e mudam o DADO digitado (regra #49).
774:         *-- MaxLength = 10 = SigPrDmo.contas char(10), NUNCA o Width em
775:         *-- pixels (regra #19).
776:         *-- O legado usa ControlSource = "crSigPrDmo.Contas"; na arquitetura
777:         *-- nova o valor trafega por FormParaBO/BOParaForm.
778:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
779:         WITH loc_oPagina.txt_4c_Conta
780:             .Value             = ""
781:             .Top               = 223
782:             .Left              = 214
783:             .Width             = 80
784:             .Height            = 25
785:             .MaxLength         = 10
786:             .FontName          = "Courier New"
787:             .FontSize          = 9
788:             .FontBold          = .F.
789:             .FontItalic        = .F.
790:             .FontUnderline     = .F.
791:             .Alignment         = 0

*-- Linhas 801 a 819:
801:         ENDWITH
802: 
803:         *-- Get_DConta -> txt_4c_DConta (descricao/nome da conta).
804:         *-- Campo SEM ControlSource no legado: e' preenchido pelo Valid de
805:         *-- Get_Conta (crSigCdCli.RClis) e pelo IniciaDesc do form, e aceita
806:         *-- digitacao para buscar a conta PELO NOME - por isso tem Valid
807:         *-- proprio e NAO pode nascer ReadOnly fixo, que apagaria a segunda
808:         *-- porta de entrada. Quem o habilita e' o AtualizarEstadoCampos,
809:         *-- que reproduz o "When" do legado.
810:         *-- MaxLength = 40 e' o do dump (SigCdCli.rclis e' char(50)): o
811:         *-- numero do SCX fica como esta (PILAR 1).
812:         loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
813:         WITH loc_oPagina.txt_4c_DConta
814:             .Value             = ""
815:             .Top               = 223
816:             .Left              = 294
817:             .Width             = 271
818:             .Height            = 25
819:             .MaxLength         = 40

*-- Linhas 932 a 950:
932:         THIS.TornarControlesVisiveis(loc_oPagina)
933: 
934:         *-- Cursor de detalhe + vinculo da grade DEPOIS do TornarControlesVisiveis:
935:         *-- Column.ControlSource exige o cursor ABERTO, senao o Init estoura
936:         *-- "Alias not found" e a tela nao abre (regra #41).
937:         THIS.CriarCursorFases()
938:         THIS.VincularGradeFases()
939: 
940:         *-- Estado inicial dos campos conforme os "When" do legado.
941:         THIS.AtualizarEstadoCampos()
942:     ENDPROC
943: 
944:     *===========================================================================
945:     * ConfigurarLabelsCabecalho - Cria lbl_4c_Sombra/lbl_4c_Titulo na faixa
946:     * Fonte unica para as duas paginas (regra #11: os labels NUNCA ficam
947:     * pelados, e o Caption vem do Caption do form). O ForeColor branco e
948:     * legitimo aqui porque o container e OPACO e escuro (excecao da regra #12).
949:     *===========================================================================
950:     PROTECTED PROCEDURE ConfigurarLabelsCabecalho(par_oCabecalho)

*-- Linhas 1096 a 1147:
1096:     *===========================================================================
1097:     * CarregarLista - Alimenta a grade da pagina Lista
1098:     * Legado (Init): AddCursor('SigPrDmo', 'cIdChaves', 'crSigPrDmo', '',
1099:     *   ThisForm.Pagina.Lista.Grade, [Select * From SigPrDmo ]) seguido de
1100:     *   pfSqlTabela(1).pColuna('Nome','','','Nome do Demonstrativo',150,.t.)
1101:     * Ou seja: UMA coluna na grade da Lista (regra #35 - a grade espelha o
1102:     * pColuna do Init, nao os headers desenhados no SCX) e consulta SEM filtro.
1103:     * PUBLIC: chamado de fora por AlternarPagina e pelo harness de teste.
1104:     *===========================================================================
1105:     PROCEDURE CarregarLista()
1106:         LOCAL loc_lResultado, loc_oGrid
1107:         loc_lResultado = .F.
1108: 
1109:         TRY
1110:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1111: 
1112:             IF !THIS.this_oBusinessObject.Buscar("")
1113:                 loc_lResultado = .F.
1114:             ELSE
1115:                 *-- Ordem obrigatoria (regra #41 / Problemas 32 e 48):
1116:                 *-- ColumnCount -> RecordSource -> ControlSource ->
1117:                 *-- Header1.Caption -> FormatarGridLista -> Width.
1118:                 *-- RecordSource faz auto-bind e RESETA largura e caption.
1119:                 loc_oGrid.ColumnCount  = 1
1120:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1121: 
1122:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.nome"
1123:                 loc_oGrid.Column1.Header1.Caption = "Nome do Demonstrativo"
1124: 
1125:                 *-- Column.ReadOnly DEPOIS do Grid.ReadOnly (regra #18): o do
1126:                 *-- grid propaga para as colunas e sobrescreveria este.
1127:                 loc_oGrid.Column1.ReadOnly = .T.
1128: 
1129:                 THIS.FormatarGridLista(loc_oGrid)
1130: 
1131:                 *-- Column.Width por ULTIMO (regra #35): mexer em RecordSource,
1132:                 *-- em ControlSource ou na FONTE do grid faz o VFP recalcular a
1133:                 *-- largura das colunas. Medido nesta tela: com o Width antes do
1134:                 *-- FormatarGridLista a coluna abria com 45 em vez de 150.
1135:                 loc_oGrid.Column1.Width = 150
1136: 
1137:                 *-- Popular o cursor NAO repinta a grade (regra #21).
1138:                 *-- Legado: "Go Top In <cursor>" + "<grid>.Refresh".
1139:                 IF USED("cursor_4c_Dados")
1140:                     GO TOP IN cursor_4c_Dados
1141:                 ENDIF
1142:                 loc_oGrid.Refresh()
1143: 
1144:                 loc_lResultado = .T.
1145:             ENDIF
1146: 
1147:         CATCH TO loException

*-- Linhas 1269 a 1289:
1269:     * ORDEM DAS COLUNAS: o dump declara ColumnOrder em todas as cinco e os
1270:     * objetos foram RENOMEADOS pelo Form Designer, logo a posicao no array
1271:     * NAO e a posicao visual. Resolvendo pelos nomes (que e como o
1272:     * Grupo_op.Click do legado liga os ControlSource) a ordem visual e:
1273:     *
1274:     *   ColumnOrder | nome legado | ControlSource        | Header         | W
1275:     *   ------------+-------------+----------------------+----------------+----
1276:     *        1      | Column1     | crSigCdDpr.Ordems    | Ordem          |  40
1277:     *        2      | Column2     | crSigCdDpr.grupos    | Fase           |  75
1278:     *        3      | Column3     | crSigCdDpr.contas    | Funcionario    |  75
1279:     *        4      | Column4     | crSigCdDpr.tpops     | Tipo Operacao  | 100
1280:     *        5      | Column5     | crSigCdDpr.operas    | E/S            |  30
1281:     *
1282:     * As colunas sao criadas JA na ordem visual (Column1 = primeira coluna) e
1283:     * ColumnOrder NAO e atribuido: reatribuir RecordSource faz o VFP refazer o
1284:     * auto-bind pela ORDEM dos campos do cursor, ignorando ColumnOrder, e os
1285:     * dados saem desalinhados dos cabecalhos.
1286:     *
1287:     * ZOrderSet = 15 do dump NAO e transcrito: e propriedade so do Form
1288:     * Designer e atribui-la em runtime derruba o Init (regra #33).
1289:     *===========================================================================

*-- Linhas 1308 a 1336:
1308:             .RowHeight         = 20
1309:             .ScrollBars        = 2
1310:             .Panel             = 1
1311:             .DeleteMark        = .F.
1312:             .AllowHeaderSizing = .F.
1313:             .AllowRowSizing    = .F.
1314:             .GridLineColor     = RGB(238, 238, 238)
1315:             .ReadOnly          = .F.
1316:             .Visible           = .T.
1317:         ENDWITH
1318: 
1319:         *-- Propriedades que NAO dependem do cursor. O ControlSource, os
1320:         *-- Header1.Caption e a Width ficam no VincularGradeFases: ligar
1321:         *-- Column.ControlSource a um cursor que ainda nao existe estoura
1322:         *-- "Alias not found" DENTRO do Init e a tela nao abre (regra #41).
1323:         *-- Column.ReadOnly vem DEPOIS de Grid.ReadOnly, que propaga para as
1324:         *-- colunas e sobrescreveria este (regra #18).
1325:         loc_oGrid.Column1.Movable   = .F.
1326:         loc_oGrid.Column1.Resizable = .F.
1327:         loc_oGrid.Column1.ReadOnly  = .F.
1328:         loc_oGrid.Column1.FontName  = "Tahoma"
1329:         loc_oGrid.Column1.FontSize  = 8
1330:         loc_oGrid.Column1.InputMask = "999"
1331: 
1332:         loc_oGrid.Column2.Movable   = .F.
1333:         loc_oGrid.Column2.Resizable = .F.
1334:         loc_oGrid.Column2.ReadOnly  = .F.
1335:         loc_oGrid.Column2.FontName  = "Tahoma"
1336:         loc_oGrid.Column2.FontSize  = 8

*-- Linhas 1435 a 1453:
1435:             IF loc_nI = 1
1436:                 *-- Coluna Ordem: numerica, alinhada a direita e com o
1437:                 *-- InputMask "999" do dump. O .Value inicial SO na criacao -
1438:                 *-- depois do ControlSource ligado, atribuir .Value GRAVARIA
1439:                 *-- no cursor, zerando a Ordem da linha corrente.
1440:                 loc_oCel.InputMask = "999"
1441:                 loc_oCel.Alignment = 1
1442:                 IF loc_lNova
1443:                     loc_oCel.Value = 0
1444:                 ENDIF
1445:             ELSE
1446:                 *-- Format = "K!" das quatro colunas character (dump).
1447:                 loc_oCel.Format = "K!"
1448:             ENDIF
1449: 
1450:             *-- Column3.Text1 e o UNICO dos cinco que o dump declara com
1451:             *-- BackStyle = 0 (transparente). Vai na INSTANCIA, nao no
1452:             *-- default da classe, exatamente como o legado.
1453:             IF loc_nI = 3

*-- Linhas 1465 a 1531:
1465:     * CriarCursorFases - Cria o cursor de detalhe (SigCdDpr) da pagina Dados
1466:     *
1467:     * Equivale ao .AddCursor('SigCdDpr','cIdChaves','crSigCdDpr','', ,
1468:     *   [Select * From SigCdDpr Where nome=?sNome Order By Ordems])
1469:     * do Init legado com sNome = Space(20): nenhuma linha casa, o cursor nasce
1470:     * VAZIO e so e recarregado pelo Grupo_op.Click (Fases 7-8).
1471:     *
1472:     * A estrutura e a EXATA de SigCdDpr (docs\schema.sql, lido com
1473:     * Get-Content -Raw por ser UTF-16 - regra #14), inclusive dopes, que nao
1474:     * aparece em lugar nenhum do codigo legado mas e NOT NULL na tabela: o
1475:     * legado a recebia de graca do "Select *" + "Append Blank", e omiti-la
1476:     * aqui faria o INSERT da Fase 7 ser recusado inteiro (regra #22).
1477:     *
1478:     * SET NULL ON durante o CREATE CURSOR: CarregarFasesDoBanco alimenta este
1479:     * cursor com APPEND FROM a partir do resultado de um SQLEXEC direto no
1480:     * SQL Server (cursor_4c_FasesTmp); se qualquer linha trouxer NULL numa
1481:     * coluna, um cursor criado com SET NULL OFF recusa o APPEND FROM inteiro
1482:     * com "Field XXX does not accept null values". InserirLinhaFase continua
1483:     * seguro: o APPEND BLANK ali e seguido de REPLACE nas OITO colunas, sem
1484:     * nenhuma sobrar com .NULL.
1485:     *===========================================================================
1486:     PROTECTED PROCEDURE CriarCursorFases()
1487:         IF USED("cursor_4c_Fases")
1488:             *-- USE IN fecha o alias mesmo com buffer sujo; TABLEREVERT sem
1489:             *-- antes conferir o Buffering dispara o erro 1586 (regra #52).
1490:             IF CURSORGETPROP("Buffering", "cursor_4c_Fases") > 1
1491:                 TABLEREVERT(.T., "cursor_4c_Fases")
1492:             ENDIF
1493:             USE IN cursor_4c_Fases
1494:         ENDIF
1495: 
1496:         SET NULL ON
1497:         CREATE CURSOR cursor_4c_Fases ( ;
1498:             contas    C(10), ;
1499:             grupos    C(10), ;
1500:             nome      C(20), ;
1501:             operas    C(1),  ;
1502:             ordems    N(4),  ;
1503:             tpops     C(15), ;
1504:             cidchaves C(20), ;
1505:             dopes     C(20))
1506:         SET NULL OFF
1507:     ENDPROC
1508: 
1509:     *===========================================================================
1510:     * VincularGradeFases - Liga a grade de fases ao cursor_4c_Fases
1511:     *
1512:     * Ordem OBRIGATORIA (regra #41 / Problemas 32, 36 e 48):
1513:     *   ColumnCount -> RecordSource -> ControlSource -> Header1.Caption ->
1514:     *   celulas (CurrentControl) -> Width (por ULTIMO).
1515:     * RecordSource faz auto-bind pela ordem dos campos do cursor e RESETA
1516:     * ControlSource, Header1.Caption e a largura das colunas para o default 90.
1517:     *
1518:     * ColumnCount so e tocado se divergir de 5: reatribui-lo DESTROI os
1519:     * objetos postos por Column.AddObject (as celulas).
1520:     *
1521:     * PUBLIC: chamado de fora pelos handlers de recarga da grade (Fases 7-8) e
1522:     * pelo harness de teste.
1523:     *===========================================================================
1524:     PROCEDURE VincularGradeFases()
1525:         LOCAL loc_lResultado, loc_oGrid
1526:         loc_lResultado = .F.
1527: 
1528:         TRY
1529:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Fases
1530: 
1531:             IF !USED("cursor_4c_Fases")

*-- Linhas 1538 a 1560:
1538: 
1539:                 loc_oGrid.RecordSource = "cursor_4c_Fases"
1540: 
1541:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Fases.ordems"
1542:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Fases.grupos"
1543:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Fases.contas"
1544:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Fases.tpops"
1545:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Fases.operas"
1546: 
1547:                 loc_oGrid.Column1.Header1.Caption = "Ordem"
1548:                 loc_oGrid.Column2.Header1.Caption = "Fase"
1549:                 loc_oGrid.Column3.Header1.Caption = "Funcion" + CHR(225) + "rio"
1550:                 loc_oGrid.Column4.Header1.Caption = "Tipo Opera" + CHR(231) + ;
1551:                     CHR(227) + "o"
1552:                 loc_oGrid.Column5.Header1.Caption = "E/S"
1553: 
1554:                 *-- Grid.ReadOnly ANTES de Column.ReadOnly: o do grid propaga
1555:                 *-- para as colunas (regra #18). O legado faz exatamente isto
1556:                 *-- no Grupo_op.Click (columnN.ReadOnly = .F.); quem bloqueia a
1557:                 *-- edicao fora dos modos INSERIR/ALTERAR e o "When" da celula.
1558:                 loc_oGrid.ReadOnly         = .F.
1559:                 loc_oGrid.Column1.ReadOnly = .F.
1560:                 loc_oGrid.Column2.ReadOnly = .F.

*-- Linhas 1613 a 1652:
1613:     *===========================================================================
1614:     * ContarLinhasFases - COUNT de linhas vivas do cursor de fases
1615:     *
1616:     * Legado: "Select crSigCdDpr / Count to lnLinhas" - COUNT respeita
1617:     * SET DELETED ON (as linhas excluidas pelo botao Excluir NAO entram),
1618:     * diferente de RECCOUNT(). O preco e que COUNT percorre o cursor e MOVE o
1619:     * ponteiro: o RECNO e o alias correntes sao salvos e repostos, senao a
1620:     * linha selecionada na grade salta sozinha.
1621:     *===========================================================================
1622:     PROTECTED PROCEDURE ContarLinhasFases()
1623:         LOCAL loc_nLinhas, loc_nAliasAnt, loc_nRegAnt
1624: 
1625:         loc_nLinhas = 0
1626: 
1627:         IF USED("cursor_4c_Fases")
1628:             loc_nAliasAnt = SELECT(0)
1629:             SELECT cursor_4c_Fases
1630:             loc_nRegAnt = RECNO("cursor_4c_Fases")
1631: 
1632:             COUNT TO loc_nLinhas
1633: 
1634:             IF loc_nRegAnt > 0 AND loc_nRegAnt <= RECCOUNT("cursor_4c_Fases")
1635:                 GO loc_nRegAnt IN cursor_4c_Fases
1636:             ENDIF
1637:             SELECT (loc_nAliasAnt)
1638:         ENDIF
1639: 
1640:         RETURN loc_nLinhas
1641:     ENDPROC
1642: 
1643:     *===========================================================================
1644:     * NomeEditavel - Reproduz o "When" de GetNome do legado
1645:     *
1646:     *   Case pcEscolha = 'PROCURAR'  -> .T.
1647:     *   Case pcEscolha <> 'INSERIR'  -> .F.
1648:     *   Case pcEscolha = 'INSERIR'   -> .T. so se a grade de fases estiver
1649:     *        vazia, ou tiver UMA unica linha com Grupos E Contas vazios
1650:     *        (ou seja, a linha em branco que o proprio form acabou de inserir)
1651:     *   Other                        -> .F.
1652:     *

*-- Linhas 1671 a 1700:
1671:                 loc_lPrimeiraVazia = .F.
1672: 
1673:                 IF loc_nLinhas = 1 AND USED("cursor_4c_Fases")
1674:                     loc_nAliasAnt = SELECT(0)
1675:                     SELECT cursor_4c_Fases
1676:                     loc_nRegAnt = RECNO("cursor_4c_Fases")
1677: 
1678:                     GO TOP IN cursor_4c_Fases
1679:                     loc_lPrimeiraVazia = EMPTY(cursor_4c_Fases.grupos) AND ;
1680:                         EMPTY(cursor_4c_Fases.contas)
1681: 
1682:                     IF loc_nRegAnt > 0 AND loc_nRegAnt <= RECCOUNT("cursor_4c_Fases")
1683:                         GO loc_nRegAnt IN cursor_4c_Fases
1684:                     ENDIF
1685:                     SELECT (loc_nAliasAnt)
1686:                 ENDIF
1687: 
1688:                 loc_lEditavel = (loc_nLinhas = 0) OR loc_lPrimeiraVazia
1689:         ENDCASE
1690: 
1691:         RETURN loc_lEditavel
1692:     ENDPROC
1693: 
1694:     *===========================================================================
1695:     * AtualizarEstadoCampos - Reavalia os "When" dos campos da pagina Dados
1696:     *
1697:     * FONTE UNICA das regras de habilitacao do legado:
1698:     *   GetNome.When    -> ver NomeEditavel
1699:     *   Get_Grupo.When  -> Inlist(pcEscolha,'INSERIR','ALTERAR')
1700:     *   Get_DGrupo.When -> IsEmpty(Get_Grupo.Value) And Inlist(...)

*-- Linhas 1764 a 1782:
1764:     *       Messagebox('O Nome deve ser informado...',32,'')
1765:     *       Return 0
1766:     *   Endif
1767:     *   Select crSigCdDpr / Go Top / If Eof() -> InsiraRegGrade() / Go Top
1768:     *
1769:     * DIVERGENCIA DOCUMENTADA: "Return 0" num Valid retem o foco no campo;
1770:     * LostFocus nao tem como fazer isso e devolver o foco daqui provocaria
1771:     * reentrancia. O aviso continua aparecendo no mesmo momento, e o bloqueio
1772:     * efetivo da gravacao fica no Confirmar (Fase 7), que e onde o legado
1773:     * tambem recusa gravar sem nome.
1774:     *
1775:     * A guarda this_lEmLookup tambem vale aqui: o MsgAviso e MODAL, tira o
1776:     * foco e redisparia este proprio LostFocus.
1777:     *
1778:     * PUBLIC: BINDEVENT exige metodo publico (regra #3). LostFocus nao passa
1779:     * parametro nenhum.
1780:     *===========================================================================
1781:     PROCEDURE ValidarNomeLostFocus()
1782:         LOCAL loc_oPg2, loc_cNome, loc_lEmLookupAnt

*-- Linhas 1821 a 1877:
1821:     *===========================================================================
1822:     * InserirLinhaFase - PROCEDURE insirareggrade do legado
1823:     *
1824:     *   Select crSigCdDpr / Append Blank
1825:     *   Replace contas With Space(10), grupos With Space(10),
1826:     *           nome With getNome.Value, operas With Space(1),
1827:     *           ordems With 0, tpops With Space(15),
1828:     *           cIdChaves With fUniqueIds()
1829:     *
1830:     * cidchaves vem de fUniqueIds() e NUNCA de string vazia: com cidchaves em
1831:     * branco a segunda linha colidiria no indice unico de SigCdDpr (regra #22).
1832:     * dopes nao e citada em lugar nenhum do legado, mas e NOT NULL na tabela -
1833:     * o legado a ganhava em branco do "Select *" + "Append Blank" e aqui ela e
1834:     * preenchida explicitamente pelo mesmo motivo.
1835:     *
1836:     * PUBLIC: chamado pelo handler do botao, pelo ValidarNomeLostFocus e pelas
1837:     * Fases 7-8.
1838:     *===========================================================================
1839:     PROCEDURE InserirLinhaFase()
1840:         LOCAL loc_lResultado, loc_nAliasAnt, loc_cNome
1841:         loc_lResultado = .F.
1842: 
1843:         TRY
1844:             IF !USED("cursor_4c_Fases")
1845:                 MsgAviso("Cursor de fases indispon" + CHR(237) + "vel.", ;
1846:                     "FormSigOpDmp")
1847:             ELSE
1848:                 loc_cNome = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Nome.Value)
1849: 
1850:                 loc_nAliasAnt = SELECT(0)
1851:                 SELECT cursor_4c_Fases
1852:                 APPEND BLANK
1853:                 REPLACE contas    WITH SPACE(10), ;
1854:                         grupos    WITH SPACE(10), ;
1855:                         nome      WITH loc_cNome, ;
1856:                         operas    WITH SPACE(1),  ;
1857:                         ordems    WITH 0,         ;
1858:                         tpops     WITH SPACE(15), ;
1859:                         cidchaves WITH fUniqueIds(), ;
1860:                         dopes     WITH SPACE(20) ;
1861:                         IN cursor_4c_Fases
1862:                 SELECT (loc_nAliasAnt)
1863: 
1864:                 loc_lResultado = .T.
1865:             ENDIF
1866: 
1867:         CATCH TO loException
1868:             MostrarErro("Erro ao inserir a linha de fase:" + CHR(13) + ;
1869:                 loException.Message, "FormSigOpDmp.InserirLinhaFase")
1870:             loc_lResultado = .F.
1871:         ENDTRY
1872: 
1873:         RETURN loc_lResultado
1874:     ENDPROC
1875: 
1876:     *===========================================================================
1877:     * BtnInserirFaseClick - Pagina.Dados.Inserir.Click do legado

*-- Linhas 1919 a 1937:
1919:     * BtnExcluirFaseClick - Pagina.Dados.Excluir.Click do legado
1920:     *
1921:     *   If Inlist( pcEscolha, 'INSERIR', 'ALTERAR' )
1922:     *       Select crSigCdDpr / Delete / Skip
1923:     *       If Eof() -> Go Bottom
1924:     *       If Eof() -> InsiraRegGrade()
1925:     *       Grade.Column1.Text1.SetFocus / Grade.Refresh
1926:     *   Endif
1927:     *
1928:     * O segundo "If Eof()" nao e repetido por descuido: com o cursor vazio o
1929:     * GO BOTTOM nao sai do EOF, e e dai que o legado conclui que a grade ficou
1930:     * sem nenhuma linha e repoe a linha em branco.
1931:     *
1932:     * NAO confundir com BtnExcluirClick (CRUD do registro mestre, pagina
1933:     * Lista): este exclui a LINHA da grade de fases.
1934:     *
1935:     * PUBLIC: BINDEVENT exige metodo publico (regra #3).
1936:     *===========================================================================
1937:     PROCEDURE BtnExcluirFaseClick()

*-- Linhas 1945 a 1993:
1945:             IF !USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
1946:                 MsgAviso("Nenhuma fase selecionada.", "FormSigOpDmp")
1947:             ELSE
1948:                 loc_nAliasAnt = SELECT(0)
1949:                 SELECT cursor_4c_Fases
1950:                 DELETE
1951:                 SKIP
1952: 
1953:                 IF EOF("cursor_4c_Fases")
1954:                     GO BOTTOM IN cursor_4c_Fases
1955:                 ENDIF
1956:                 SELECT (loc_nAliasAnt)
1957: 
1958:                 *-- Grade sem nenhuma linha viva: repor a linha em branco.
1959:                 IF THIS.ContarLinhasFases() = 0
1960:                     THIS.InserirLinhaFase()
1961:                 ENDIF
1962: 
1963:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Fases
1964:                 loc_oGrid.Refresh()
1965:                 THIS.AtualizarEstadoCampos()
1966:                 loc_oGrid.SetFocus()
1967:             ENDIF
1968: 
1969:         CATCH TO loException
1970:             MostrarErro("Erro ao excluir fase:" + CHR(13) + ;
1971:                 loException.Message, "FormSigOpDmp.BtnExcluirFaseClick")
1972:         ENDTRY
1973:     ENDPROC
1974: 
1975:     *===========================================================================
1976:     * ConexaoAtiva - Ha conexao SQL utilizavel?
1977:     *
1978:     * Os sete lookups consultam o banco. Com gnConnHandle invalido o SQLEXEC
1979:     * do FormBuscaAuxiliar dispara EXCECAO (nao devolve -1), e sem esta guarda
1980:     * o ValidarUIFidelity e o harness headless - que rodam com
1981:     * gnConnHandle = -1 - encheriam a tela de dialogos de erro.
1982:     *===========================================================================
1983:     PROTECTED PROCEDURE ConexaoAtiva()
1984:         RETURN (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
1985:     ENDPROC
1986: 
1987:     *===========================================================================
1988:     * UsuarioCorrente - Usuario logado para os checks de acesso
1989:     *===========================================================================
1990:     PROTECTED PROCEDURE UsuarioCorrente()
1991:         LOCAL loc_cUsuario
1992:         loc_cUsuario = ""
1993: 

*-- Linhas 2031 a 2052:
2031:             RETURN
2032:         ENDIF
2033: 
2034:         loc_nAliasAnt = SELECT(0)
2035:         SELECT cursor_4c_Fases
2036:         REPLACE (par_cCampo) WITH par_uValor IN cursor_4c_Fases
2037:         SELECT (loc_nAliasAnt)
2038:     ENDPROC
2039: 
2040:     *===========================================================================
2041:     * GrupoDaLinhaFase - Grupo da linha corrente da grade de fases
2042:     * Legado: crSigCdDpr.Grupos, usado como filtro do lookup de Tipo de
2043:     * Operacao e como 2o argumento do fAcessoContas.
2044:     *===========================================================================
2045:     PROTECTED PROCEDURE GrupoDaLinhaFase()
2046:         LOCAL loc_cGrupo
2047:         loc_cGrupo = ""
2048: 
2049:         IF USED("cursor_4c_Fases") AND !EOF("cursor_4c_Fases")
2050:             loc_cGrupo = ALLTRIM(cursor_4c_Fases.grupos)
2051:         ENDIF
2052: 

*-- Linhas 2070 a 2088:
2070:     *   EndIf
2071:     *
2072:     * crSigCdGcr e criado no Init legado com
2073:     *   Select codigos,Descrs From SigCdGcr Where gerbals=1
2074:     * logo o universo do lookup e' SO os grupos com gerbals = 1 - o filtro faz
2075:     * parte da regra e vai para o 9o argumento do FormBuscaAuxiliar, que o
2076:     * aplica na busca exata, na parcial e no fallback show-all.
2077:     *===========================================================================
2078:     PROCEDURE ValidarGrupoLostFocus()
2079:         LOCAL loc_oPg2, loc_cGrupo
2080: 
2081:         *-- Guarda de reentrancia: o picker e MODAL, tira o foco do campo e
2082:         *-- redispara este proprio LostFocus (regra #37). A flag e ligada
2083:         *-- dentro de AbrirLookupGrupo, funil das TRES portas (LostFocus,
2084:         *-- F4/F5 e DblClick).
2085:         IF THIS.this_lEmLookup
2086:             RETURN
2087:         ENDIF
2088: 

*-- Linhas 2165 a 2183:
2165:                 ENDIF
2166: 
2167:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2168:                     SELECT cursor_4c_BuscaGcr
2169:                     loc_oPg2.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcr.codigos)
2170:                     loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
2171:                 ELSE
2172:                     *-- ESC/Cancelar com o picker ABERTO: o legado limpa os
2173:                     *-- dois (Iif(LastKey()==27,'',...)). Sem o picker na tela
2174:                     *-- nada e limpado - apagar o que o usuario digitou o
2175:                     *-- deixaria sem como preencher o campo (regra #50).
2176:                     IF loc_lMostrou
2177:                         loc_oPg2.txt_4c_Grupo.Value  = ""
2178:                         loc_oPg2.txt_4c_DGrupo.Value = ""
2179:                     ENDIF
2180:                 ENDIF
2181: 
2182:                 loc_oBusca.Release()
2183:             ENDIF

*-- Linhas 2278 a 2296:
2278:                 ENDIF
2279: 
2280:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcrD")
2281:                     SELECT cursor_4c_BuscaGcrD
2282:                     loc_oPg2.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcrD.codigos)
2283:                     loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcrD.descrs)
2284:                 ELSE
2285:                     IF loc_lMostrou
2286:                         loc_oPg2.txt_4c_Grupo.Value  = ""
2287:                         loc_oPg2.txt_4c_DGrupo.Value = ""
2288:                     ENDIF
2289:                 ENDIF
2290: 
2291:                 loc_oBusca.Release()
2292:             ENDIF
2293: 
2294:         CATCH TO loException
2295:             MsgErro("Erro em FormSigOpDmp.AbrirLookupDGrupo: " + ;
2296:                 loException.Message, "Erro")

*-- Linhas 2308 a 2326:
2308:     * Get_DConta, limpando os dois no ESC.
2309:     *
2310:     * crSigCdCli e criado no Init legado com
2311:     *   Select Grupos, IClis, RClis From SigCdCli Where GerBals = 1
2312:     * logo o universo e' SO as contas com gerbals = 1.
2313:     *===========================================================================
2314:     PROCEDURE ValidarContaLostFocus()
2315:         LOCAL loc_oPg2, loc_cConta
2316: 
2317:         IF THIS.this_lEmLookup
2318:             RETURN
2319:         ENDIF
2320: 
2321:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
2322:         loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
2323: 
2324:         *-- LostFocus dispara mesmo sem o valor mudar; pular quando igual ao
2325:         *-- ultimo valor ja validado.
2326:         IF loc_cConta == THIS.this_cUltimoValidarContaLostFocusValidado

*-- Linhas 2385 a 2403:
2385:                 ENDIF
2386: 
2387:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2388:                     SELECT cursor_4c_BuscaCli
2389:                     loc_oPg2.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCli.iclis)
2390:                     loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
2391:                 ELSE
2392:                     IF loc_lMostrou
2393:                         loc_oPg2.txt_4c_Conta.Value  = ""
2394:                         loc_oPg2.txt_4c_DConta.Value = ""
2395:                     ENDIF
2396:                 ENDIF
2397: 
2398:                 loc_oBusca.Release()
2399:             ENDIF
2400: 
2401:         CATCH TO loException
2402:             MsgErro("Erro em FormSigOpDmp.AbrirLookupConta: " + ;
2403:                 loException.Message, "Erro")

*-- Linhas 2488 a 2506:
2488:                 ENDIF
2489: 
2490:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCliD")
2491:                     SELECT cursor_4c_BuscaCliD
2492:                     loc_oPg2.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCliD.iclis)
2493:                     loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCliD.rclis)
2494:                 ELSE
2495:                     IF loc_lMostrou
2496:                         loc_oPg2.txt_4c_Conta.Value  = ""
2497:                         loc_oPg2.txt_4c_DConta.Value = ""
2498:                     ENDIF
2499:                 ENDIF
2500: 
2501:                 loc_oBusca.Release()
2502:             ENDIF
2503: 
2504:         CATCH TO loException
2505:             MsgErro("Erro em FormSigOpDmp.AbrirLookupDConta: " + ;
2506:                 loException.Message, "Erro")

*-- Linhas 2624 a 2642:
2624:                 ENDIF
2625: 
2626:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFase")
2627:                     SELECT cursor_4c_BuscaFase
2628:                     *-- O codigo escolhido vai para os DOIS lugares: .Value e
2629:                     *-- cursor. Sem a .Value o texto digitado sobrescreveria o
2630:                     *-- cursor na saida da celula (regra #46).
2631:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaFase.codigos)
2632:                     THIS.GravarCelulaFase("grupos", ;
2633:                         PADR(ALLTRIM(cursor_4c_BuscaFase.codigos), 10))
2634:                 ENDIF
2635: 
2636:                 loc_oBusca.Release()
2637:             ENDIF
2638: 
2639:         CATCH TO loException
2640:             MsgErro("Erro em FormSigOpDmp.AbrirLookupFaseGrade: " + ;
2641:                 loException.Message, "Erro")
2642:         ENDTRY

*-- Linhas 2735 a 2753:
2735:                 ENDIF
2736: 
2737:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFunc")
2738:                     SELECT cursor_4c_BuscaFunc
2739:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaFunc.iclis)
2740:                     THIS.GravarCelulaFase("contas", ;
2741:                         PADR(ALLTRIM(cursor_4c_BuscaFunc.iclis), 10))
2742:                 ELSE
2743:                     IF loc_lMostrou
2744:                         par_oTxt.Value = ""
2745:                         THIS.GravarCelulaFase("contas", SPACE(10))
2746:                     ENDIF
2747:                 ENDIF
2748: 
2749:                 loc_oBusca.Release()
2750:             ENDIF
2751: 
2752:         CATCH TO loException
2753:             MsgErro("Erro em FormSigOpDmp.AbrirLookupFuncionarioGrade: " + ;

*-- Linhas 2762 a 2784:
2762:     * GradeFasesTpOpValid - Column4.Text1.Valid (coluna Tipo Operacao)
2763:     *
2764:     *   If IsEmpty( This.Value ) -> Return .t.
2765:     *   Select crSigOpOpt / Set Order to Cods / Set Near On
2766:     *   If !Seek( This.Value ) Or ( crSigCdDpr.Grupos # crSigOpOpt.Grupos
2767:     *                               And !IsEmpty( crSigOpOpt.Grupos ) )
2768:     *       lcGrupo = crSigCdDpr.Grupos
2769:     *       Select Cods, Descs, pFalhas From crSigOpOpt
2770:     *           where Grupos = lcGrupo Or IsEmpty( Grupos ) Into cursor TmpOpt
2771:     *       loBrowse = fwBuscaSel( 'TmpOpt', 'Cods', ... )
2772:     *       This.Value = Iif( Lastkey() == 27, '', TmpOpt.Cods )
2773:     *   Endif
2774:     *
2775:     * A condicao do WHERE e regra de negocio e vai inteira: um tipo de
2776:     * operacao serve se for do grupo da LINHA ou se for generico (Grupos
2777:     * vazio). Esse filtro tambem e o que invalida um codigo que existe mas
2778:     * pertence a outro grupo - e por isso ele vai no 9o argumento do
2779:     * FormBuscaAuxiliar, que o aplica TAMBEM na busca exata.
2780:     *===========================================================================
2781:     PROCEDURE GradeFasesTpOpValid(par_oTxt)
2782:         IF VARTYPE(par_oTxt) != "O"
2783:             RETURN .T.
2784:         ENDIF

*-- Linhas 2809 a 2828:
2809:         loc_cGrupoLinha = THIS.GrupoDaLinhaFase()
2810: 
2811:         *-- "Where Grupos = lcGrupo Or IsEmpty( Grupos )" do legado.
2812:         *-- EscaparSQL JA devolve o valor COM as aspas (regra #5).
2813:         loc_cFiltro = "(RTRIM(grupos) = " + EscaparSQL(loc_cGrupoLinha) + ;
2814:             " OR RTRIM(grupos) = '')"
2815: 
2816:         loc_lEmLookupAnt    = THIS.this_lEmLookup
2817:         THIS.this_lEmLookup = .T.
2818:         TRY
2819:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2820:                 "SigOpOpt", "cursor_4c_BuscaTpOp", "cods", loc_cTpOp, ;
2821:                 "Cadastro de Tipos de Opera" + CHR(231) + CHR(227) + "o", ;
2822:                 .F., .T., loc_cFiltro)
2823: 
2824:             IF VARTYPE(loc_oBusca) = "O"
2825:                 loc_lMostrou = .F.
2826: 
2827:                 IF !loc_oBusca.this_lAchouRegistro
2828:                     loc_oBusca.mAddColuna("cods",    "", "C" + CHR(243) + "digo")

*-- Linhas 2834 a 2852:
2834:                 ENDIF
2835: 
2836:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpOp")
2837:                     SELECT cursor_4c_BuscaTpOp
2838:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaTpOp.cods)
2839:                     THIS.GravarCelulaFase("tpops", ;
2840:                         PADR(ALLTRIM(cursor_4c_BuscaTpOp.cods), 15))
2841:                 ELSE
2842:                     IF loc_lMostrou
2843:                         par_oTxt.Value = ""
2844:                         THIS.GravarCelulaFase("tpops", SPACE(15))
2845:                     ENDIF
2846:                 ENDIF
2847: 
2848:                 loc_oBusca.Release()
2849:             ENDIF
2850: 
2851:         CATCH TO loException
2852:             MsgErro("Erro em FormSigOpDmp.AbrirLookupTpOpGrade: " + ;

*-- Linhas 2946 a 2974:
2946:     *
2947:     * A EXCLUSAO NAO ACONTECE AQUI: no legado o Excluir apenas abre a ficha em
2948:     * modo EXCLUIR com os campos travados, e quem pergunta "Deseja Realmente
2949:     * Excluir Esses Dados?" e executa o DELETE e o Salva.Click (frmcadastro:
2950:     * Case pcEscolha=[EXCLUIR] -> MessageBox + mSv_Excluir, mais o ExcluiItens
2951:     * desta tela, que apaga as linhas de SigCdDpr). Esse caminho e o Confirmar,
2952:     * da Fase 8.
2953:     *===========================================================================
2954: 
2955:     *===========================================================================
2956:     * LimparCampos - Deixa a ficha em branco (legado: poDataMgr.NewReg, que
2957:     * cria um registro VAZIO no cursor mestre, e os controles ligados a ele
2958:     * passam a exibir branco).
2959:     * Os campos desta tela nao tem ControlSource: quem os esvazia e este
2960:     * metodo. Os PEMSTATUS existem porque ele pode ser chamado antes de a
2961:     * pagina Dados estar inteiramente montada.
2962:     * PROTECTED OBRIGATORIO: FormBase declara LimparCampos / BOParaForm /
2963:     * FormParaBO como PROTECTED (sao os hooks que FormBase chama por THIS.) e
2964:     * o VFP9 NAO deixa a subclasse ALARGAR o escopo - escrever PROCEDURE sem
2965:     * o modificador nao torna o metodo publico, so esconde do leitor que ele
2966:     * continua protegido. Chamar sempre por THIS. de dentro da classe; de
2967:     * fora, nem o harness alcanca (PEMSTATUS(...,5) responde "existe?", nao
2968:     * "da para chamar daqui?").
2969:     *===========================================================================
2970:     PROTECTED PROCEDURE LimparCampos()
2971:         LOCAL loc_oPg2
2972: 
2973:         TRY
2974:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2

*-- Linhas 3093 a 3114:
3093:             ELSE
3094:                 THIS.FecharCursorBusca("cursor_4c_DescGcr")
3095: 
3096:                 loc_cSQL = "SELECT descrs FROM SigCdGcr" + ;
3097:                     " WHERE RTRIM(codigos) = " + EscaparSQL(loc_cGrupo)
3098: 
3099:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescGcr")
3100: 
3101:                 IF loc_nResultado < 0
3102:                     MsgErro("Erro ao ler a descri" + CHR(231) + CHR(227) + ;
3103:                         "o do grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
3104:                     loc_oPg2.txt_4c_DGrupo.Value = ""
3105:                 ELSE
3106:                     IF USED("cursor_4c_DescGcr") AND RECCOUNT("cursor_4c_DescGcr") > 0
3107:                         GO TOP IN cursor_4c_DescGcr
3108:                         loc_oPg2.txt_4c_DGrupo.Value = ;
3109:                             ALLTRIM(TratarNulo(cursor_4c_DescGcr.descrs, ""))
3110:                     ELSE
3111:                         loc_oPg2.txt_4c_DGrupo.Value = ""
3112:                     ENDIF
3113:                 ENDIF
3114: 

*-- Linhas 3121 a 3142:
3121:             ELSE
3122:                 THIS.FecharCursorBusca("cursor_4c_DescCli")
3123: 
3124:                 loc_cSQL = "SELECT rclis FROM SigCdCli" + ;
3125:                     " WHERE RTRIM(iclis) = " + EscaparSQL(loc_cConta)
3126: 
3127:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCli")
3128: 
3129:                 IF loc_nResultado < 0
3130:                     MsgErro("Erro ao ler a descri" + CHR(231) + CHR(227) + ;
3131:                         "o da conta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
3132:                     loc_oPg2.txt_4c_DConta.Value = ""
3133:                 ELSE
3134:                     IF USED("cursor_4c_DescCli") AND RECCOUNT("cursor_4c_DescCli") > 0
3135:                         GO TOP IN cursor_4c_DescCli
3136:                         loc_oPg2.txt_4c_DConta.Value = ;
3137:                             ALLTRIM(TratarNulo(cursor_4c_DescCli.rclis, ""))
3138:                     ELSE
3139:                         loc_oPg2.txt_4c_DConta.Value = ""
3140:                     ENDIF
3141:                 ENDIF
3142: 

*-- Linhas 3161 a 3180:
3161:     *===========================================================================
3162:     * LimparFases - o "Zap in ('crSigCdDpr')" do ramo INSERIR/PROCURAR
3163:     *
3164:     * ZAP (e nao USE IN + CREATE CURSOR) de proposito: fechar e recriar o alias
3165:     * derruba Grid.RecordSource e as Column.ControlSource ligadas na montagem
3166:     * da pagina, e a grade fica permanentemente vazia com o cursor cheio. O
3167:     * legado Fortyus faz "Zap In <cursor>" exatamente por isso.
3168:     *
3169:     * O par SET SAFETY e obrigatorio: com SAFETY ON o ZAP abre o dialogo modal
3170:     * de confirmacao e CONGELA a tela. SET SAFETY e escopado por data session,
3171:     * logo o SET SAFETY OFF do main.prg nao alcanca form com DataSession = 2 -
3172:     * e o estado anterior e reposto para nao mexer no ambiente do chamador.
3173:     *===========================================================================
3174:     PROTECTED PROCEDURE LimparFases()
3175:         LOCAL loc_cSafety
3176: 
3177:         IF USED("cursor_4c_Fases")
3178:             loc_cSafety = SET("SAFETY")
3179:             SET SAFETY OFF
3180: 

*-- Linhas 3191 a 3216:
3191:     *
3192:     * Query do AddCursor do Init legado, com o nome da ficha no lugar do
3193:     * parametro ?sNome que o Grupo_op.Click atribuia antes do Requery:
3194:     *   Select * From SigCdDpr Where nome=?sNome Order By Ordems
3195:     *
3196:     * O SELECT vai para um cursor TEMPORARIO e as linhas entram no
3197:     * cursor_4c_Fases por ZAP + APPEND FROM: SQLEXEC direto sobre o alias da
3198:     * grade DESTROI o cursor e com ele todas as Column (Problema 34) - a linha
3199:     * seguinte estouraria "Unknown member COLUMN1". A lista de colunas segue a
3200:     * ordem EXATA de SigCdDpr, que e a ordem do CREATE CURSOR de
3201:     * CriarCursorFases, porque APPEND FROM casa os campos por POSICAO.
3202:     *
3203:     * PUBLIC: chamado pelos handlers de Alterar/Visualizar/Excluir e pela
3204:     * Fase 8 (o Confirmar recarrega a ficha gravada).
3205:     *===========================================================================
3206:     PROCEDURE CarregarFasesDoBanco()
3207:         LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cNome, loc_nAliasAnt
3208:         loc_lResultado = .F.
3209: 
3210:         TRY
3211:             loc_cNome = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Nome.Value)
3212: 
3213:             IF !USED("cursor_4c_Fases")
3214:                 *-- O placeholder e criado na montagem da pagina Dados; se
3215:                 *-- algum caminho de erro o fechou, recria-lo aqui e o que
3216:                 *-- permite a grade voltar a funcionar. Quem religa a grade e o

*-- Linhas 3226 a 3262:
3226:             ELSE
3227:                 THIS.FecharCursorBusca("cursor_4c_FasesTmp")
3228: 
3229:                 loc_cSQL = "SELECT contas, grupos, nome, operas, ordems," + ;
3230:                     " tpops, cidchaves, dopes FROM SigCdDpr" + ;
3231:                     " WHERE RTRIM(nome) = " + EscaparSQL(loc_cNome) + ;
3232:                     " ORDER BY ordems"
3233: 
3234:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FasesTmp")
3235: 
3236:                 IF loc_nResultado < 0
3237:                     MsgErro("Erro ao carregar as fases do demonstrativo:" + ;
3238:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
3239:                 ELSE
3240:                     THIS.LimparFases()
3241: 
3242:                     IF USED("cursor_4c_FasesTmp") AND ;
3243:                        RECCOUNT("cursor_4c_FasesTmp") > 0
3244:                         loc_nAliasAnt = SELECT(0)
3245:                         SELECT cursor_4c_Fases
3246:                         APPEND FROM DBF("cursor_4c_FasesTmp")
3247:                         SELECT (loc_nAliasAnt)
3248:                     ENDIF
3249: 
3250:                     loc_lResultado = .T.
3251:                 ENDIF
3252: 
3253:                 THIS.FecharCursorBusca("cursor_4c_FasesTmp")
3254:             ENDIF
3255: 
3256:         CATCH TO loException
3257:             MsgErro("Erro em FormSigOpDmp.CarregarFasesDoBanco: " + ;
3258:                 loException.Message, "Erro")
3259:             loc_lResultado = .F.
3260:         ENDTRY
3261: 
3262:         RETURN loc_lResultado

*-- Linhas 3415 a 3433:
3415:             ELSE
3416:                 *-- NovoRegistro limpa as properties do BO e liga
3417:                 *-- this_lNovoRegistro, que e o que faz o Salvar escolher
3418:                 *-- INSERT em vez de UPDATE. Sem ele o Confirmar da Fase 8
3419:                 *-- tentaria atualizar um registro que ainda nao existe.
3420:                 THIS.this_oBusinessObject.NovoRegistro()
3421: 
3422:                 THIS.LimparCampos()
3423:                 THIS.LimparFases()
3424: 
3425:                 THIS.this_cModoAtual = "INCLUIR"
3426:                 THIS.AlternarPagina(2)
3427: 
3428:                 THIS.VincularGradeFases()
3429:                 THIS.RepintarGradeFases()
3430: 
3431:                 THIS.FocarAposAbrirFicha()
3432: 
3433:                 loc_lResultado = .T.

*-- Linhas 3476 a 3494:
3476:     *
3477:     * NAO exclui nada: abre a ficha travada em modo EXCLUIR, com o Confirmar
3478:     * habilitado, exatamente como o legado. A pergunta "Deseja Realmente
3479:     * Excluir Esses Dados?" e o DELETE (mSv_Excluir + ExcluiItens, que apaga as
3480:     * linhas de SigCdDpr do mesmo nome) vivem no Confirmar, da Fase 8.
3481:     *
3482:     * PUBLIC: BINDEVENT exige metodo publico (regra #3).
3483:     *===========================================================================
3484:     PROCEDURE BtnExcluirClick()
3485:         RETURN THIS.AbrirFichaDoRegistro("EXCLUIR")
3486:     ENDPROC
3487: 
3488:     *===========================================================================
3489:     * GradeListaKeyPress / GradeListaDblClick - atalhos da grade da Lista
3490:     *
3491:     * O frmcadastro trata o Enter na grade da Lista como CONSULTAR:
3492:     *   Case (nKeyCode = 13) And lnPag = 1 And ...ActiveControl.BaseClass=[GRID]
3493:     *       NoDefault / loGrp.Click(2)
3494:     * O duplo clique nao existe no legado e vai para o MESMO funil: e o gesto

*-- Linhas 3567 a 3611:
3567:     * FASE 8 - CONFIRMAR, BUSCAR POR EXEMPLO E PERSISTENCIA
3568:     *
3569:     * Legado (Pagina.Dados.Grupo_Salva.Salva.Click do SCX):
3570:     *   <limpa RecordSource/ControlSource da grade de fases>
3571:     *   If pcescolha = 'INSERIR' -> Replace cIdChaves With fUniqueIds()
3572:     *   If Not poDataMgr.Update('crSigCdDpr') -> erro
3573:     *   If Inlist( pcEscolha, 'EXCLUIR' ) -> ExcluiItens()
3574:     *   =DoDefault()          && frmcadastro.Salva.Click: o Do Case por verbo
3575:     *   ThisForm.mAtivapagina1
3576:     *
3577:     * e o Do Case do frmcadastro, que e o despachante de verdade:
3578:     *   INSERIR   -> mSv_Inserir   (poDataMgr.Update(1) + Commit)
3579:     *   CONSULTAR -> mSv_Consultar
3580:     *   ALTERAR   -> mSv_Alterar   (poDataMgr.Update(1) + Commit)
3581:     *   EXCLUIR   -> MessageBox('Deseja Realmente Excluir Esses Dados?')
3582:     *                e, se 6, mSv_Excluir (poDataMgr.Delete(1) + Commit)
3583:     *   PROCURAR  -> apaga o registro em branco do cursor mestre e chama
3584:     *                mSv_Procurar, que nesta tela e o Seek por nome
3585:     *===========================================================================
3586: 
3587:     *===========================================================================
3588:     * FormParaBO - Transfere os campos da ficha para as propriedades do BO
3589:     *
3590:     * No SCX os TRES campos do cabecalho tem ControlSource no cursor mestre:
3591:     *   GetNome   -> crSigPrDmo.nome
3592:     *   Get_Grupo -> crSigPrDmo.Grupos
3593:     *   Get_Conta -> crSigPrDmo.Contas
3594:     * ou seja, o que o usuario digita vai DIRETO para o registro que o
3595:     * TableUpdate do Salva.Click grava. Os campos desta tela nao tem
3596:     * ControlSource (o valor vive na .Value) e este metodo e o equivalente.
3597:     *
3598:     * Os campos de DESCRICAO (txt_4c_DGrupo/txt_4c_DConta) NAO entram: eles
3599:     * sao a segunda porta de entrada do lookup e vem de outras tabelas
3600:     * (SigCdGcr.descrs e SigCdCli.rclis); quem os resolve e o
3601:     * CarregarDescricoesMestre. SigPrDmo nao tem coluna de descricao.
3602:     *
3603:     * cidchaves tambem nao vem da tela: e a PK Fortyus de SigPrDmo. No
3604:     * INCLUIR o Inserir do BO a gera com fUniqueIds (legado: "If pcescolha
3605:     * ='INSERIR' Replace cIdChaves With fUniqueIds() in crSigPrDmo"); no
3606:     * ALTERAR ela ja veio do CarregarPorCodigo e nao se toca.
3607:     *
3608:     * PROTECTED OBRIGATORIO: FormBase declara LimparCampos / BOParaForm /
3609:     * FormParaBO como PROTECTED (sao os hooks que FormBase chama por THIS.) e
3610:     * o VFP9 NAO deixa a subclasse ALARGAR o escopo - escrever PROCEDURE sem
3611:     * o modificador nao torna o metodo publico, so esconde do leitor que ele

*-- Linhas 3627 a 3645:
3627: 
3628:                 *-- Os LEFT() respeitam a largura das colunas de SigPrDmo
3629:                 *-- (nome char(20), grupos char(10), contas char(10)): sem
3630:                 *-- eles o SQL Server recusa o INSERT inteiro com "String or
3631:                 *-- binary data would be truncated" (regra #19).
3632:                 loc_oBO.this_cNome   = LEFT(ALLTRIM(loc_oPg2.txt_4c_Nome.Value), 20)
3633:                 loc_oBO.this_cGrupos = LEFT(ALLTRIM(loc_oPg2.txt_4c_Grupo.Value), 10)
3634:                 loc_oBO.this_cContas = LEFT(ALLTRIM(loc_oPg2.txt_4c_Conta.Value), 10)
3635: 
3636:                 loc_lResultado = .T.
3637:             ENDIF
3638: 
3639:         CATCH TO loException
3640:             MsgErro("Erro em FormSigOpDmp.FormParaBO: " + ;
3641:                 loException.Message, "Erro")
3642:             loc_lResultado = .F.
3643:         ENDTRY
3644: 
3645:         RETURN loc_lResultado

*-- Linhas 3894 a 3918:
3894:     * GravarFicha - ramos INSERIR e ALTERAR do Confirmar
3895:     *
3896:     * ORDEM: fases (SigCdDpr) ANTES do mestre (SigPrDmo), como no legado - o
3897:     * Salva.Click do SCX faz "poDataMgr.Update('crSigCdDpr')" e so depois
3898:     * chama o DoDefault() que dispara mSv_Inserir/mSv_Alterar. As duas tabelas
3899:     * nao tem FK entre si, logo a ordem nao muda o resultado no banco; o que
3900:     * ela muda e o estado do BO quando algo falha. Com o mestre primeiro, uma
3901:     * falha nas fases deixaria o BO com this_lNovoRegistro = .F. (o Salvar
3902:     * limpa os flags no sucesso) e a retentativa viraria um UPDATE de um
3903:     * registro que o rollback apagou - UPDATE que afeta 0 linhas devolve
3904:     * sucesso e perderia o cadastro EM SILENCIO. Na ordem do legado o BO so
3905:     * muda de estado depois que tudo deu certo.
3906:     *
3907:     * A validacao do Nome fica FORA do TRY. Ela e a mesma do GetNome.Valid
3908:     * legado ("O Nome deve ser informado..."), que la retem o foco com
3909:     * "Return 0" e por isso impede o usuario de chegar ao Confirmar sem nome;
3910:     * aqui o LostFocus nao pode reter o foco (ver ValidarNomeLostFocus) e este
3911:     * e o ponto onde a gravacao e efetivamente recusada.
3912:     *===========================================================================
3913:     PROTECTED PROCEDURE GravarFicha()
3914:         LOCAL loc_lResultado, loc_lProsseguir, loc_oPg2, loc_cNome, loc_oBO
3915:         loc_lResultado  = .F.
3916:         loc_lProsseguir = .T.
3917: 
3918:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2

*-- Linhas 3936 a 3968:
3936:                 loc_lProsseguir = .F.
3937:             ENDIF
3938: 
3939:             *-- Fases primeiro (poDataMgr.Update('crSigCdDpr') do legado).
3940:             IF loc_lProsseguir
3941:                 IF !loc_oBO.GravarFases("cursor_4c_Fases", loc_cNome)
3942:                     IF !loc_oBO.this_lErroExibido
3943:                         MsgErro(IIF(EMPTY(ALLTRIM(loc_oBO.ObterMensagemErro())), ;
3944:                             "Favor Reinicializar o Processo!!!", ;
3945:                             ALLTRIM(loc_oBO.ObterMensagemErro())), ;
3946:                             "Falha ao gravar as fases")
3947:                     ENDIF
3948:                     loc_lProsseguir = .F.
3949:                 ENDIF
3950:             ENDIF
3951: 
3952:             *-- Mestre depois (mSv_Inserir / mSv_Alterar do frmcadastro).
3953:             *-- O BusinessBase.Salvar() escolhe INSERT ou UPDATE pelo
3954:             *-- this_lNovoRegistro e JA reporta toda falha (regra #20): o
3955:             *-- ELSE abaixo so cobre o caso de ele recusar sem exibir.
3956:             IF loc_lProsseguir
3957:                 IF !loc_oBO.Salvar()
3958:                     IF !loc_oBO.this_lErroExibido
3959:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
3960:                             "vel gravar o demonstrativo.", "Confirmar")
3961:                     ENDIF
3962:                     loc_lProsseguir = .F.
3963:                 ENDIF
3964:             ENDIF
3965: 
3966:             IF loc_lProsseguir
3967:                 IF THIS.ConfirmarTransacao()
3968:                     loc_lResultado = .T.

*-- Linhas 4005 a 4032:
4005:     *       Else
4006:     *           .plCancelar = .t.
4007:     *       EndIf
4008:     * e o ExcluiItens (DELETE das fases) no Salva.Click do SCX.
4009:     *
4010:     * DIVERGENCIA DELIBERADA NA ORDEM - a pergunta vem PRIMEIRO.
4011:     * No legado o Salva.Click do SCX executa o ExcluiItens (que tem
4012:     * SqlExecute + Commit PROPRIOS) ANTES de chamar o DoDefault() que
4013:     * pergunta: responder "Nao" ja chegava com as fases apagadas e
4014:     * COMMITADAS, e o RollBack do mAtivapagina1 nao as trazia de volta. E
4015:     * perda de dados silenciosa no caminho de CANCELAMENTO - reproduzi-la
4016:     * seria migrar um defeito destrutivo. Aqui nada e tocado antes do "Sim",
4017:     * e o DELETE das fases e o do mestre ficam sob o MESMO commit.
4018:     *
4019:     * MsgConfirma devolve LOGICO (.T./.F.), nunca 6 (regra #7).
4020:     *===========================================================================
4021:     PROTECTED PROCEDURE ExcluirFicha()
4022:         LOCAL loc_lResultado, loc_lProsseguir, loc_cNome, loc_oBO
4023:         loc_lResultado  = .F.
4024:         loc_lProsseguir = .T.
4025: 
4026:         loc_cNome = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Nome.Value)
4027: 
4028:         IF EMPTY(loc_cNome)
4029:             MsgAviso("A ficha n" + CHR(227) + "o tem nome de demonstrativo " + ;
4030:                 "para excluir.", "FormSigOpDmp")
4031:             RETURN .F.
4032:         ENDIF

*-- Linhas 4053 a 4071:
4053:                 loc_lProsseguir = .F.
4054:             ENDIF
4055: 
4056:             *-- mSv_Excluir: DELETE do mestre. O Excluir() do BusinessBase e
4057:             *-- PUBLIC e chama o ExecutarExclusao do BO (regra #51); ele ja
4058:             *-- reporta toda falha (regra #20).
4059:             IF loc_lProsseguir
4060:                 IF !loc_oBO.Excluir()
4061:                     IF !loc_oBO.this_lErroExibido
4062:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
4063:                             "vel excluir o demonstrativo.", "Confirmar")
4064:                     ENDIF
4065:                     loc_lProsseguir = .F.
4066:                 ENDIF
4067:             ENDIF
4068: 
4069:             IF loc_lProsseguir
4070:                 IF THIS.ConfirmarTransacao()
4071:                     loc_lResultado = .T.

*-- Linhas 4096 a 4128:
4096:     * ExecutarBuscaPorNome - PROCEDURE msv_procurar do legado
4097:     *
4098:     *   Set Near On
4099:     *   Select crSigPrDmo
4100:     *   Index On nome tag ix_Nome
4101:     *   Set Order To ix_nome
4102:     *   Seek ThisForm.pagina.dados.getNome.Value
4103:     *   Set Near Off
4104:     *
4105:     * SET NEAR ON e o que faz desta uma busca APROXIMADA: sem casamento
4106:     * exato o ponteiro para no registro mais proximo em vez de ir para EOF.
4107:     * Repor o SET anterior em vez de forcar OFF (o legado forca) porque
4108:     * SET NEAR e de sessao e esta tela nao tem data session privada - deixar
4109:     * o ambiente como estava e o que nao quebra quem chamou.
4110:     *
4111:     * ORDEM INVERTIDA EM RELACAO AO LEGADO, por necessidade: a volta para a
4112:     * pagina Lista vem ANTES do Seek. AlternarPagina(1) chama CarregarLista,
4113:     * que refaz o SELECT e RECRIA o cursor_4c_Dados - posicionar antes seria
4114:     * jogado fora na troca de pagina. No legado o mAtivapagina1 tambem faz
4115:     * ReQuery depois do msv_procurar, com o mesmo efeito de descartar a
4116:     * posicao; a ordem daqui e a unica em que o Procurar realmente posiciona
4117:     * a grade, que e o que o usuario pediu ao clicar no botao.
4118:     *===========================================================================
4119:     PROTECTED PROCEDURE ExecutarBuscaPorNome()
4120:         LOCAL loc_lResultado, loc_cNome, loc_oGrid, loc_nAliasAnt, loc_cNearAnt
4121:         loc_lResultado = .F.
4122: 
4123:         TRY
4124:             loc_cNome = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Nome.Value)
4125: 
4126:             THIS.AlternarPagina(1)
4127: 
4128:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

*-- Linhas 4134 a 4153:
4134:                 loc_lResultado = .T.
4135:             ELSE
4136:                 IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
4137:                     loc_nAliasAnt = SELECT(0)
4138:                     SELECT cursor_4c_Dados
4139: 
4140:                     *-- O Buscar do BO ja devolve ORDER BY nome, logo a ordem
4141:                     *-- visual da grade nao muda com este indice - ele existe
4142:                     *-- so para o SEEK, que exige tag ativa.
4143:                     INDEX ON nome TAG ix_nome
4144:                     SET ORDER TO ix_nome IN cursor_4c_Dados
4145: 
4146:                     loc_cNearAnt = SET("NEAR")
4147:                     SET NEAR ON
4148: 
4149:                     SEEK loc_cNome IN cursor_4c_Dados
4150: 
4151:                     IF loc_cNearAnt == "ON"
4152:                         SET NEAR ON
4153:                     ELSE

*-- Linhas 4162 a 4180:
4162:                         GO BOTTOM IN cursor_4c_Dados
4163:                     ENDIF
4164: 
4165:                     SELECT (loc_nAliasAnt)
4166: 
4167:                     *-- Mover o ponteiro NAO repinta a grade (regra #21).
4168:                     loc_oGrid.Refresh()
4169: 
4170:                     IF loc_oGrid.Enabled AND loc_oGrid.Visible
4171:                         loc_oGrid.SetFocus()
4172:                     ENDIF
4173: 
4174:                     loc_lResultado = .T.
4175:                 ELSE
4176:                     MsgAviso("Nenhum demonstrativo cadastrado.", "FormSigOpDmp")
4177:                 ENDIF
4178:             ENDIF
4179: 
4180:         CATCH TO loException


### BO (C:\4c\projeto\app\classes\SigOpDmpBO.prg):
*====================================================================
* SigOpDmpBO.prg
*
* Business Object para Cadastro de Demonstrativos de Balanco (SigOpDmp)
* Tabela: SigPrDmo (cabecalho) - detalhe em SigCdDpr (fases 2+)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpDmpBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrDmo)
    this_cNome      = ""    && nome char(20) - chave (nome do demonstrativo)
    this_cContas    = ""    && contas char(10)
    this_cGrupos    = ""    && grupos char(10)
    this_cCidChaves = ""    && cidchaves char(20) - PK Fortyus (gerada em fUniqueIds())

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrDmo"
            THIS.this_cCampoChave = "nome"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpDmpBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave (nome) do demonstrativo para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cNome)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                *-- O 2o argumento do TratarNulo e o valor PADRAO, nao o tipo:
                *-- TratarNulo(x, "C") devolveria a letra "C" se a coluna
                *-- viesse NULL. Nenhuma coluna de SigPrDmo aceita nulo
                *-- no schema, logo o caminho era inerte - mas o
                *-- padrao certo de coluna char e a string vazia.
                THIS.this_cNome      = TratarNulo(nome,      "")
                THIS.this_cContas    = TratarNulo(contas,    "")
                THIS.this_cGrupos    = TratarNulo(grupos,    "")
                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigOpDmpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrDmo
    * cidchaves = PK Fortyus (fUniqueIds) - NUNCA string vazia (regra #22)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrDmo (contas, grupos, nome, cidchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cContas)>>,
                    <<EscaparSQL(THIS.this_cGrupos)>>,
                    <<EscaparSQL(THIS.this_cNome)>>,
                    <<EscaparSQL(THIS.this_cCidChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir demonstrativo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigOpDmpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrDmo
    * nome eh a chave de negocio (nao editavel em modo ALTERAR) - WHERE por nome
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrDmo
                SET contas = <<EscaparSQL(THIS.this_cContas)>>,
                    grupos = <<EscaparSQL(THIS.this_cGrupos)>>
                WHERE nome = <<EscaparSQL(THIS.this_cNome)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar demonstrativo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigOpDmpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *====================================================================
    * Buscar - Alimenta cursor_4c_Dados, o cursor da grade da pagina Lista
    *
    * Legado (Init do SCX):
    *   lcQryDmPro = [Select * From SigPrDmo ]
    *   .AddCursor('SigPrDmo','cIdChaves','crSigPrDmo','',
    *              ThisForm.Pagina.Lista.Grade, lcQryDmPro)
    *   Select crSigPrDmo / Index On nome tag ix_nome
    * Ou seja: consulta SEM filtro (tabela inteira) e ordenada por nome
    * (regra #35 - a pagina Lista segue o Init do legado).
    *
    * O BusinessBase.Buscar herdado NAO serve aqui: ele delega para
    * this_oDataAccess (nunca instanciado, porque o Init chama DODEFAULT()
    * sem o nome da tabela) e grava no cursor "cur" + tabela, nao no
    * cursor_4c_Dados a que a grade se liga.
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                *-- Sem conexao (ValidarUIFidelity / teste headless): cria um
                *-- cursor vazio com a MESMA estrutura de SigPrDmo, para a
                *-- grade ter a que se ligar sem consultar o banco.
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (contas C(10), grupos C(10), nome C(20), cidchaves C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT contas, grupos, nome, cidchaves FROM SigPrDmo"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY nome"

                *-- USE IN fecha o alias mesmo com buffer sujo; NUNCA
                *-- TABLEREVERT sem antes conferir o Buffering (regra #52).
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar demonstrativos:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, ;
                "SigOpDmpBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Le do BANCO o demonstrativo de um nome
    *
    * Equivale ao ReQuery(1, pcChavePrimaria, <cursor>.<chave>) que o
    * Grupo_op.Click do frmcadastro dispara nos verbos CONSULTAR, ALTERAR e
    * EXCLUIR: o registro vem da tabela, nao do cursor que esta na grade da
    * Lista - que pode estar na tela desde antes de outro usuario altera-lo.
    *
    * A chave de NEGOCIO e o nome (this_cCampoChave = "nome"), e nao a
    * cidchaves: o nome e o que a grade da Lista exibe e o que amarra as
    * linhas de SigCdDpr ao demonstrativo (Where nome=?sNome do AddCursor
    * legado).
    *
    * this_lNovoRegistro volta a .F. aqui: sem isso, um Incluir seguido de
    * Alterar faria o Salvar escolher INSERT e violar a chave primaria.
    *
    * PUBLIC: o form chama este metodo de fora (regra #51).
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cNome)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cMensagemErro = ""

            DO CASE
                CASE VARTYPE(par_cNome) != "C" OR EMPTY(ALLTRIM(par_cNome))
                    THIS.this_cMensagemErro = "Nome do demonstrativo n" + ;
                        CHR(227) + "o informado."

                CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Sem conex" + CHR(227) + ;
                        "o com o banco de dados."

                OTHERWISE
                    IF USED("cursor_4c_Carrega")
                        USE IN cursor_4c_Carrega
                    ENDIF

                    loc_cSQL = "SELECT contas, grupos, nome, cidchaves" + ;
                        " FROM SigPrDmo" + ;
                        " WHERE RTRIM(nome) = " + EscaparSQL(ALLTRIM(par_cNome))

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao carregar o demonstrativo:" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                        THIS.this_lErroExibido = .T.
                    ELSE
                        IF USED("cursor_4c_Carrega") AND ;
                           RECCOUNT("cursor_4c_Carrega") > 0
                            GO TOP IN cursor_4c_Carrega
                            loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                            THIS.this_lNovoRegistro = .F.
                        ELSE
                            THIS.this_cMensagemErro = "Demonstrativo n" + ;
                                CHR(227) + "o encontrado: " + ALLTRIM(par_cNome)
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_Carrega")
                        USE IN cursor_4c_Carrega
                    ENDIF
            ENDCASE

        CATCH TO loException
            MostrarErro("Erro ao carregar por c" + CHR(243) + "digo:" + CHR(13) + ;
                loException.Message, "SigOpDmpBO.CarregarPorCodigo")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparDados - Zera as properties da entidade
    *
    * O LimparDados do BusinessBase limpa so a mensagem de erro: as
    * properties de CADA entidade sao responsabilidade da subclasse. Sem este
    * override, NovoRegistro() (chamado pelo Incluir) deixaria nome, grupos,
    * contas e - o mais grave - a cidchaves do registro ANTERIOR nas
    * properties, e o INSERT seguinte reaproveitaria aquela PK: colisao na
    * chave primaria de SigPrDmo (regra #22).
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cNome      = ""
        THIS.this_cContas    = ""
        THIS.this_cGrupos    = ""
        THIS.this_cCidChaves = ""

        RETURN .T.
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE do registro mestre em SigPrDmo
    *
    * Legado: frmcadastro.mSv_Excluir -> poDataMgr.Delete(1) + Commit(). O
    * AddCursor do Init legado passa 'cIdChaves' como chave do cursor
    * mestre, logo o Delete(1) do Fortyus apaga PELA cidchaves - que e a
    * PRIMARY KEY de SigPrDmo (docs\schema.sql, lido com Get-Content -Raw
    * por ser UTF-16 - regra #14). O nome e a chave de NEGOCIO e NAO tem
    * indice unico: apagar por nome mataria tambem um homonimo gravado por
    * outro caminho. Por isso o WHERE prefere a cidchaves e so cai no nome
    * quando ela nao veio.
    *
    * O COMMIT NAO ACONTECE AQUI. No legado ele e um passo com caminho de
    * falha PROPRIO logo depois do Delete/Update ("If (poDataMgr.Commit()
    * < 1) -> Favor Reinicializar o Processo!!!"), e nesta tela UMA
    * gravacao mexe em DUAS tabelas (SigPrDmo e SigCdDpr): commitar aqui
    * efetivaria o mestre antes de saber se as fases foram gravadas. O
    * commit unico vive no Confirmar do form.
    *
    * PROTECTED: quem chama e o Excluir() do BusinessBase, que ja faz o
    * AntesDeExcluir e o ExibirFalha (regra #51). O form chama Excluir().
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                loc_cSQL = "DELETE FROM SigPrDmo WHERE RTRIM(nome) = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cNome))
            ELSE
                loc_cSQL = "DELETE FROM SigPrDmo WHERE RTRIM(cidchaves) = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir demonstrativo:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, ;
                "SigOpDmpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExcluirFases - PROCEDURE excluiitens do legado
    *
    *   lcQuery = [Delete From SigCdDpr Where nome=] + getnome.Value
    *   If (poDataMgr.SqlExecute(lcQuery, 'crDelSigCdDpr') < 1)
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
    *   If (poDataMgr.Commit() < 1)
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
    *
    * Apaga TODAS as fases de um demonstrativo. Serve a dois caminhos do
    * Confirmar: a exclusao do demonstrativo inteiro (o ExcluiItens do
    * legado) e o "apaga e regrava" do GravarFases.
    *
    * O Commit fica de fora pelo mesmo motivo do ExecutarExclusao: e UM so,
    * no form, cobrindo mestre e fases.
    *
    * PUBLIC: o form chama este metodo de fora (regra #51).
    *====================================================================
    PROCEDURE ExcluirFases(par_cNome)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DO CASE
                CASE VARTYPE(par_cNome) != "C" OR EMPTY(ALLTRIM(par_cNome))
                    THIS.this_cMensagemErro = "Nome do demonstrativo n" + ;
                        CHR(227) + "o informado."

                CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Sem conex" + CHR(227) + ;
                        "o com o banco de dados."

                OTHERWISE
                    loc_cSQL = "DELETE FROM SigCdDpr WHERE RTRIM(nome) = " + ;
                        EscaparSQL(ALLTRIM(par_cNome))

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir as fases do " + ;
                            "demonstrativo:" + CHR(13) + CapturarErroSQL(), ;
                            "Erro SQL")
                        THIS.this_lErroExibido = .T.
                    ENDIF
            ENDCASE

        CATCH TO loException
            MostrarErro("Erro ao excluir as fases:" + CHR(13) + ;
                loException.Message, "SigOpDmpBO.ExcluirFases")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * GravarFases - o poDataMgr.Update('crSigCdDpr') do Salva.Click legado
    *
    * No legado o cursor de detalhe e um cursor REMOTO BUFFERIZADO: o
    * Update do fSqlConector e um TABLEUPDATE, que manda ao SQL Server o
    * INSERT das linhas novas, o UPDATE das alteradas e o DELETE das
    * marcadas. Aqui o cursor_4c_Fases e um cursor LOCAL sem buffering
    * (TABLEUPDATE/TABLEREVERT em cursor com Buffering = 1 dispara o erro
    * 1586 - regra #52), logo nao existe lista de alteracoes em aberto a
    * mandar: a gravacao e "apaga as fases deste nome e regrava as linhas
    * vivas da grade".
    *
    * O efeito no banco e o MESMO do TABLEUPDATE: o conjunto de linhas de
    * SigCdDpr daquele nome passa a ser exatamente o conjunto exibido na
    * grade, cada uma com a sua cidchaves PRESERVADA (a PK de SigCdDpr).
    *
    * SCAN FOR !DELETED(): o botao Excluir de LINHA do form faz DELETE no
    * cursor (delecao LOGICA, como o legado), e linha apagada nao pode ser
    * regravada. O FOR explicito e necessario porque SET DELETED e escopado
    * por data session - confiar no SET DELETED ON do config.prg deixaria a
    * exclusao de linha sem efeito em form de sessao privada.
    *
    * O nome gravado em cada linha e o da FICHA, nao o que estava na linha:
    * ele e a chave que amarra a fase ao demonstrativo (o Where nome=?sNome
    * do AddCursor legado). O legado o estampa no momento do Append Blank
    * (InsiraRegGrade) e a ficha nunca deixa trocar o Nome depois que as
    * fases estao preenchidas (o "When" de GetNome), logo em todo caminho
    * normal e o MESMO valor - mas gravar o da ficha fecha a janela em que
    * o usuario troca o Nome com a grade ainda em branco e as linhas ficam
    * ORFAS, invisiveis para o CarregarFasesDoBanco.
    *
    * PUBLIC: o form chama este metodo de fora (regra #51).
    *====================================================================
    PROCEDURE GravarFases(par_cCursor, par_cNome)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cNome, loc_cSQL
        LOCAL loc_nResultado, loc_nAliasAnt, loc_nRegAnt, loc_cCidChaves

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        TRY
            DO CASE
                CASE VARTYPE(par_cCursor) != "C" OR !USED(par_cCursor)
                    THIS.this_cMensagemErro = "Cursor de fases indispon" + ;
                        CHR(237) + "vel."
                    loc_lProsseguir = .F.

                CASE VARTYPE(par_cNome) != "C" OR EMPTY(ALLTRIM(par_cNome))
                    THIS.this_cMensagemErro = "Nome do demonstrativo n" + ;
                        CHR(227) + "o informado."
                    loc_lProsseguir = .F.

                CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Sem conex" + CHR(227) + ;
                        "o com o banco de dados."
                    loc_lProsseguir = .F.
            ENDCASE

            IF loc_lProsseguir
                loc_cNome = ALLTRIM(par_cNome)

                *-- Apaga as fases atuais do nome. A falha ja foi exibida
                *-- pelo proprio ExcluirFases.
                IF !THIS.ExcluirFases(loc_cNome)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_nAliasAnt = SELECT(0)
                SELECT (par_cCursor)
                loc_nRegAnt = RECNO(par_cCursor)

                loc_lSucesso = .T.

                SCAN FOR !DELETED()
                    *-- cidchaves NUNCA em branco: com ela vazia a segunda
                    *-- linha colidiria na PK de SigCdDpr (regra #22).
                    loc_cCidChaves = ALLTRIM(TratarNulo(cidchaves, ""))
                    IF EMPTY(loc_cCidChaves)
                        loc_cCidChaves = fUniqueIds()
                    ENDIF

                    *-- As OITO colunas de SigCdDpr sao NOT NULL e todas
                    *-- entram no INSERT - inclusive dopes, que nao aparece
                    *-- em lugar nenhum do codigo legado (ele a ganhava de
                    *-- graca do "Select *" + "Append Blank") e cuja
                    *-- ausencia faria o SQL Server recusar o INSERT
                    *-- inteiro (regra #22).
                    loc_cSQL = "INSERT INTO SigCdDpr" + ;
                        " (contas, grupos, nome, operas, ordems," + ;
                        " tpops, cidchaves, dopes) VALUES (" + ;
                        EscaparSQL(ALLTRIM(TratarNulo(contas, ""))) + "," + ;
                        EscaparSQL(ALLTRIM(TratarNulo(grupos, ""))) + "," + ;
                        EscaparSQL(loc_cNome) + "," + ;
                        EscaparSQL(TratarNulo(operas, " ")) + "," + ;
                        FormatarNumeroSQL(TratarNulo(ordems, 0), 0) + "," + ;
                        EscaparSQL(ALLTRIM(TratarNulo(tpops, ""))) + "," + ;
                        EscaparSQL(loc_cCidChaves) + "," + ;
                        EscaparSQL(ALLTRIM(TratarNulo(dopes, ""))) + ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao gravar a fase de ordem " + ;
                            TRANSFORM(TratarNulo(ordems, 0)) + ":" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                        THIS.this_lErroExibido = .T.
                        loc_lSucesso = .F.
                        EXIT
                    ENDIF
                ENDSCAN

                IF loc_nRegAnt > 0 AND loc_nRegAnt <= RECCOUNT(par_cCursor)
                    GO loc_nRegAnt IN (par_cCursor)
                ENDIF
                SELECT (loc_nAliasAnt)
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao gravar as fases:" + CHR(13) + ;
                loException.Message, "SigOpDmpBO.GravarFases")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC
ENDDEFINE


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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigOpDmp.prg) - TRECHOS RELEVANTES PARA PASS SQL (4124 linhas total):

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

*-- Linhas 186 a 204:
186:     * containers de botao ficam em Top=29, DENTRO da area da faixa, e so
187:     * aparecem se criados DEPOIS dela.
188:     * A grade espelha o pColuna do Init legado: UMA coluna (Nome). O bind do
189:     * RecordSource/ControlSource fica em CarregarLista, porque a Page1 e
190:     * montada ANTES de o cursor existir (regra #41).
191:     *===========================================================================
192:     PROTECTED PROCEDURE ConfigurarPaginaLista()
193:         LOCAL loc_oPagina
194:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
195: 
196:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
197:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
198: 
199:         *-- Faixa do cabecalho (legado: Pagina.Lista.cntSombra Top=2, Height=80,
200:         *-- BackColor=100,100,100; com a compensacao +29 do PageFrame -> Top=29)
201:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
202:         WITH loc_oPagina.cnt_4c_Cabecalho
203:             .Top         = 29
204:             .Left        = 0

*-- Linhas 438 a 456:
438:             .HighlightBackColor = RGB(255, 255, 255)
439:             .HighlightForeColor = RGB(15, 41, 104)
440:             .HighlightStyle     = 2
441:             .DeleteMark         = .F.
442:             .RecordMark         = .F.
443:             .ScrollBars         = 2
444:             .GridLines          = 3
445:             .ReadOnly           = .T.
446:             .Visible            = .T.
447:         ENDWITH
448: 
449:         *-- Atalhos da grade (Fase 7). O Enter sobre a grade da Lista e
450:         *-- CONSULTAR no frmcadastro (KeyPress: nKeyCode=13 + ActiveControl
451:         *-- GRID -> Grupo_Op.Click(2)); o duplo clique nao existe no legado e
452:         *-- cai no MESMO funil. O handler de KeyPress declara os DOIS
453:         *-- parametros do evento, senao o VFP estoura "No PARAMETER statement
454:         *-- is found" a cada tecla (regra #3).
455:         BINDEVENT(loc_oPagina.grd_4c_Lista, "KeyPress", THIS, "GradeListaKeyPress")
456:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GradeListaDblClick")

*-- Linhas 608 a 628:
608:         *-- dos demais, ou seja este campo NAO forca maiuscula (regra #49).
609:         *-- MaxLength = 20 e' a largura de SigPrDmo.nome char(20), NUNCA o
610:         *-- Width em pixels (regra #19).
611:         *-- O legado usa ControlSource = "crSigPrDmo.nome"; na arquitetura
612:         *-- nova o valor trafega por FormParaBO/BOParaForm, entao o campo
613:         *-- nasce com .Value = "" e sem ControlSource.
614:         loc_oPagina.AddObject("txt_4c_Nome", "TextBox")
615:         WITH loc_oPagina.txt_4c_Nome
616:             .Value             = ""
617:             .Top               = 175
618:             .Left              = 214
619:             .Width             = 150
620:             .Height            = 23
621:             .MaxLength         = 20
622:             .FontName          = "Tahoma"
623:             .FontSize          = 8
624:             .Format            = "K"
625:             .DisabledBackColor = RGB(192, 192, 192)
626:             .DisabledForeColor = RGB(0, 0, 0)
627:             .Themes            = .F.
628:             .Visible           = .T.

*-- Linhas 656 a 674:
656:         *-- Format = "K!" seleciona ao entrar E forca MAIUSCULA; os dois
657:         *-- efeitos sao do legado e mudam o DADO digitado (regra #49).
658:         *-- MaxLength = 10 = SigPrDmo.grupos char(10) (regra #19).
659:         *-- O legado usa ControlSource = "crSigPrDmo.Grupos".
660:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
661:         WITH loc_oPagina.txt_4c_Grupo
662:             .Value             = ""
663:             .Top               = 198
664:             .Left              = 214
665:             .Width             = 80
666:             .Height            = 25
667:             .MaxLength         = 10
668:             .FontName          = "Courier New"
669:             .FontSize          = 9
670:             .FontBold          = .F.
671:             .FontItalic        = .F.
672:             .FontUnderline     = .F.
673:             .Alignment         = 0
674:             .BackStyle         = 1

*-- Linhas 683 a 701:
683:         ENDWITH
684: 
685:         *-- Get_DGrupo -> txt_4c_DGrupo (descricao do grupo).
686:         *-- Campo SEM ControlSource no legado: ele e' preenchido pelo Valid de
687:         *-- Get_Grupo (crSigCdGcr.Descrs) e pelo IniciaDesc do form, e aceita
688:         *-- digitacao para buscar o grupo PELA descricao - por isso tem Valid
689:         *-- proprio e MaxLength = 20, embora SigCdGcr.descrs seja char(40).
690:         *-- Os dois numeros sao do dump e ficam como estao (PILAR 1).
691:         loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
692:         WITH loc_oPagina.txt_4c_DGrupo
693:             .Value             = ""
694:             .Top               = 198
695:             .Left              = 294
696:             .Width             = 271
697:             .Height            = 25
698:             .MaxLength         = 20
699:             .FontName          = "Courier New"
700:             .FontSize          = 9
701:             .FontBold          = .F.

*-- Linhas 750 a 768:
750:         *-- efeitos sao do legado e mudam o DADO digitado (regra #49).
751:         *-- MaxLength = 10 = SigPrDmo.contas char(10), NUNCA o Width em
752:         *-- pixels (regra #19).
753:         *-- O legado usa ControlSource = "crSigPrDmo.Contas"; na arquitetura
754:         *-- nova o valor trafega por FormParaBO/BOParaForm.
755:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
756:         WITH loc_oPagina.txt_4c_Conta
757:             .Value             = ""
758:             .Top               = 223
759:             .Left              = 214
760:             .Width             = 80
761:             .Height            = 25
762:             .MaxLength         = 10
763:             .FontName          = "Courier New"
764:             .FontSize          = 9
765:             .FontBold          = .F.
766:             .FontItalic        = .F.
767:             .FontUnderline     = .F.
768:             .Alignment         = 0

*-- Linhas 778 a 796:
778:         ENDWITH
779: 
780:         *-- Get_DConta -> txt_4c_DConta (descricao/nome da conta).
781:         *-- Campo SEM ControlSource no legado: e' preenchido pelo Valid de
782:         *-- Get_Conta (crSigCdCli.RClis) e pelo IniciaDesc do form, e aceita
783:         *-- digitacao para buscar a conta PELO NOME - por isso tem Valid
784:         *-- proprio e NAO pode nascer ReadOnly fixo, que apagaria a segunda
785:         *-- porta de entrada. Quem o habilita e' o AtualizarEstadoCampos,
786:         *-- que reproduz o "When" do legado.
787:         *-- MaxLength = 40 e' o do dump (SigCdCli.rclis e' char(50)): o
788:         *-- numero do SCX fica como esta (PILAR 1).
789:         loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
790:         WITH loc_oPagina.txt_4c_DConta
791:             .Value             = ""
792:             .Top               = 223
793:             .Left              = 294
794:             .Width             = 271
795:             .Height            = 25
796:             .MaxLength         = 40

*-- Linhas 909 a 927:
909:         THIS.TornarControlesVisiveis(loc_oPagina)
910: 
911:         *-- Cursor de detalhe + vinculo da grade DEPOIS do TornarControlesVisiveis:
912:         *-- Column.ControlSource exige o cursor ABERTO, senao o Init estoura
913:         *-- "Alias not found" e a tela nao abre (regra #41).
914:         THIS.CriarCursorFases()
915:         THIS.VincularGradeFases()
916: 
917:         *-- Estado inicial dos campos conforme os "When" do legado.
918:         THIS.AtualizarEstadoCampos()
919:     ENDPROC
920: 
921:     *===========================================================================
922:     * ConfigurarLabelsCabecalho - Cria lbl_4c_Sombra/lbl_4c_Titulo na faixa
923:     * Fonte unica para as duas paginas (regra #11: os labels NUNCA ficam
924:     * pelados, e o Caption vem do Caption do form). O ForeColor branco e
925:     * legitimo aqui porque o container e OPACO e escuro (excecao da regra #12).
926:     *===========================================================================
927:     PROTECTED PROCEDURE ConfigurarLabelsCabecalho(par_oCabecalho)

*-- Linhas 1073 a 1124:
1073:     *===========================================================================
1074:     * CarregarLista - Alimenta a grade da pagina Lista
1075:     * Legado (Init): AddCursor('SigPrDmo', 'cIdChaves', 'crSigPrDmo', '',
1076:     *   ThisForm.Pagina.Lista.Grade, [Select * From SigPrDmo ]) seguido de
1077:     *   pfSqlTabela(1).pColuna('Nome','','','Nome do Demonstrativo',150,.t.)
1078:     * Ou seja: UMA coluna na grade da Lista (regra #35 - a grade espelha o
1079:     * pColuna do Init, nao os headers desenhados no SCX) e consulta SEM filtro.
1080:     * PUBLIC: chamado de fora por AlternarPagina e pelo harness de teste.
1081:     *===========================================================================
1082:     PROCEDURE CarregarLista()
1083:         LOCAL loc_lResultado, loc_oGrid
1084:         loc_lResultado = .F.
1085: 
1086:         TRY
1087:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1088: 
1089:             IF !THIS.this_oBusinessObject.Buscar("")
1090:                 loc_lResultado = .F.
1091:             ELSE
1092:                 *-- Ordem obrigatoria (regra #41 / Problemas 32 e 48):
1093:                 *-- ColumnCount -> RecordSource -> ControlSource ->
1094:                 *-- Header1.Caption -> FormatarGridLista -> Width.
1095:                 *-- RecordSource faz auto-bind e RESETA largura e caption.
1096:                 loc_oGrid.ColumnCount  = 1
1097:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1098: 
1099:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.nome"
1100:                 loc_oGrid.Column1.Header1.Caption = "Nome do Demonstrativo"
1101: 
1102:                 *-- Column.ReadOnly DEPOIS do Grid.ReadOnly (regra #18): o do
1103:                 *-- grid propaga para as colunas e sobrescreveria este.
1104:                 loc_oGrid.Column1.ReadOnly = .T.
1105: 
1106:                 THIS.FormatarGridLista(loc_oGrid)
1107: 
1108:                 *-- Column.Width por ULTIMO (regra #35): mexer em RecordSource,
1109:                 *-- em ControlSource ou na FONTE do grid faz o VFP recalcular a
1110:                 *-- largura das colunas. Medido nesta tela: com o Width antes do
1111:                 *-- FormatarGridLista a coluna abria com 45 em vez de 150.
1112:                 loc_oGrid.Column1.Width = 150
1113: 
1114:                 *-- Popular o cursor NAO repinta a grade (regra #21).
1115:                 *-- Legado: "Go Top In <cursor>" + "<grid>.Refresh".
1116:                 IF USED("cursor_4c_Dados")
1117:                     GO TOP IN cursor_4c_Dados
1118:                 ENDIF
1119:                 loc_oGrid.Refresh()
1120: 
1121:                 loc_lResultado = .T.
1122:             ENDIF
1123: 
1124:         CATCH TO loException

*-- Linhas 1246 a 1266:
1246:     * ORDEM DAS COLUNAS: o dump declara ColumnOrder em todas as cinco e os
1247:     * objetos foram RENOMEADOS pelo Form Designer, logo a posicao no array
1248:     * NAO e a posicao visual. Resolvendo pelos nomes (que e como o
1249:     * Grupo_op.Click do legado liga os ControlSource) a ordem visual e:
1250:     *
1251:     *   ColumnOrder | nome legado | ControlSource        | Header         | W
1252:     *   ------------+-------------+----------------------+----------------+----
1253:     *        1      | Column1     | crSigCdDpr.Ordems    | Ordem          |  40
1254:     *        2      | Column2     | crSigCdDpr.grupos    | Fase           |  75
1255:     *        3      | Column3     | crSigCdDpr.contas    | Funcionario    |  75
1256:     *        4      | Column4     | crSigCdDpr.tpops     | Tipo Operacao  | 100
1257:     *        5      | Column5     | crSigCdDpr.operas    | E/S            |  30
1258:     *
1259:     * As colunas sao criadas JA na ordem visual (Column1 = primeira coluna) e
1260:     * ColumnOrder NAO e atribuido: reatribuir RecordSource faz o VFP refazer o
1261:     * auto-bind pela ORDEM dos campos do cursor, ignorando ColumnOrder, e os
1262:     * dados saem desalinhados dos cabecalhos.
1263:     *
1264:     * ZOrderSet = 15 do dump NAO e transcrito: e propriedade so do Form
1265:     * Designer e atribui-la em runtime derruba o Init (regra #33).
1266:     *===========================================================================

*-- Linhas 1285 a 1313:
1285:             .RowHeight         = 20
1286:             .ScrollBars        = 2
1287:             .Panel             = 1
1288:             .DeleteMark        = .F.
1289:             .AllowHeaderSizing = .F.
1290:             .AllowRowSizing    = .F.
1291:             .GridLineColor     = RGB(238, 238, 238)
1292:             .ReadOnly          = .F.
1293:             .Visible           = .T.
1294:         ENDWITH
1295: 
1296:         *-- Propriedades que NAO dependem do cursor. O ControlSource, os
1297:         *-- Header1.Caption e a Width ficam no VincularGradeFases: ligar
1298:         *-- Column.ControlSource a um cursor que ainda nao existe estoura
1299:         *-- "Alias not found" DENTRO do Init e a tela nao abre (regra #41).
1300:         *-- Column.ReadOnly vem DEPOIS de Grid.ReadOnly, que propaga para as
1301:         *-- colunas e sobrescreveria este (regra #18).
1302:         loc_oGrid.Column1.Movable   = .F.
1303:         loc_oGrid.Column1.Resizable = .F.
1304:         loc_oGrid.Column1.ReadOnly  = .F.
1305:         loc_oGrid.Column1.FontName  = "Tahoma"
1306:         loc_oGrid.Column1.FontSize  = 8
1307:         loc_oGrid.Column1.InputMask = "999"
1308: 
1309:         loc_oGrid.Column2.Movable   = .F.
1310:         loc_oGrid.Column2.Resizable = .F.
1311:         loc_oGrid.Column2.ReadOnly  = .F.
1312:         loc_oGrid.Column2.FontName  = "Tahoma"
1313:         loc_oGrid.Column2.FontSize  = 8

*-- Linhas 1412 a 1430:
1412:             IF loc_nI = 1
1413:                 *-- Coluna Ordem: numerica, alinhada a direita e com o
1414:                 *-- InputMask "999" do dump. O .Value inicial SO na criacao -
1415:                 *-- depois do ControlSource ligado, atribuir .Value GRAVARIA
1416:                 *-- no cursor, zerando a Ordem da linha corrente.
1417:                 loc_oCel.InputMask = "999"
1418:                 loc_oCel.Alignment = 1
1419:                 IF loc_lNova
1420:                     loc_oCel.Value = 0
1421:                 ENDIF
1422:             ELSE
1423:                 *-- Format = "K!" das quatro colunas character (dump).
1424:                 loc_oCel.Format = "K!"
1425:             ENDIF
1426: 
1427:             *-- Column3.Text1 e o UNICO dos cinco que o dump declara com
1428:             *-- BackStyle = 0 (transparente). Vai na INSTANCIA, nao no
1429:             *-- default da classe, exatamente como o legado.
1430:             IF loc_nI = 3

*-- Linhas 1442 a 1503:
1442:     * CriarCursorFases - Cria o cursor de detalhe (SigCdDpr) da pagina Dados
1443:     *
1444:     * Equivale ao .AddCursor('SigCdDpr','cIdChaves','crSigCdDpr','', ,
1445:     *   [Select * From SigCdDpr Where nome=?sNome Order By Ordems])
1446:     * do Init legado com sNome = Space(20): nenhuma linha casa, o cursor nasce
1447:     * VAZIO e so e recarregado pelo Grupo_op.Click (Fases 7-8).
1448:     *
1449:     * A estrutura e a EXATA de SigCdDpr (docs\schema.sql, lido com
1450:     * Get-Content -Raw por ser UTF-16 - regra #14), inclusive dopes, que nao
1451:     * aparece em lugar nenhum do codigo legado mas e NOT NULL na tabela: o
1452:     * legado a recebia de graca do "Select *" + "Append Blank", e omiti-la
1453:     * aqui faria o INSERT da Fase 7 ser recusado inteiro (regra #22).
1454:     *
1455:     * SET NULL fica OFF de proposito: todas as colunas de SigCdDpr sao
1456:     * NOT NULL, logo nenhum NULL volta do SQL Server, e num cursor
1457:     * null-capable o APPEND BLANK do InserirLinhaFase gravaria .NULL. nas
1458:     * colunas que o legado nao sobrescreve.
1459:     *===========================================================================
1460:     PROTECTED PROCEDURE CriarCursorFases()
1461:         IF USED("cursor_4c_Fases")
1462:             *-- USE IN fecha o alias mesmo com buffer sujo; TABLEREVERT sem
1463:             *-- antes conferir o Buffering dispara o erro 1586 (regra #52).
1464:             IF CURSORGETPROP("Buffering", "cursor_4c_Fases") > 1
1465:                 TABLEREVERT(.T., "cursor_4c_Fases")
1466:             ENDIF
1467:             USE IN cursor_4c_Fases
1468:         ENDIF
1469: 
1470:         CREATE CURSOR cursor_4c_Fases ( ;
1471:             contas    C(10), ;
1472:             grupos    C(10), ;
1473:             nome      C(20), ;
1474:             operas    C(1),  ;
1475:             ordems    N(4),  ;
1476:             tpops     C(15), ;
1477:             cidchaves C(20), ;
1478:             dopes     C(20))
1479:     ENDPROC
1480: 
1481:     *===========================================================================
1482:     * VincularGradeFases - Liga a grade de fases ao cursor_4c_Fases
1483:     *
1484:     * Ordem OBRIGATORIA (regra #41 / Problemas 32, 36 e 48):
1485:     *   ColumnCount -> RecordSource -> ControlSource -> Header1.Caption ->
1486:     *   celulas (CurrentControl) -> Width (por ULTIMO).
1487:     * RecordSource faz auto-bind pela ordem dos campos do cursor e RESETA
1488:     * ControlSource, Header1.Caption e a largura das colunas para o default 90.
1489:     *
1490:     * ColumnCount so e tocado se divergir de 5: reatribui-lo DESTROI os
1491:     * objetos postos por Column.AddObject (as celulas).
1492:     *
1493:     * PUBLIC: chamado de fora pelos handlers de recarga da grade (Fases 7-8) e
1494:     * pelo harness de teste.
1495:     *===========================================================================
1496:     PROCEDURE VincularGradeFases()
1497:         LOCAL loc_lResultado, loc_oGrid
1498:         loc_lResultado = .F.
1499: 
1500:         TRY
1501:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Fases
1502: 
1503:             IF !USED("cursor_4c_Fases")

*-- Linhas 1510 a 1532:
1510: 
1511:                 loc_oGrid.RecordSource = "cursor_4c_Fases"
1512: 
1513:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Fases.ordems"
1514:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Fases.grupos"
1515:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Fases.contas"
1516:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Fases.tpops"
1517:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Fases.operas"
1518: 
1519:                 loc_oGrid.Column1.Header1.Caption = "Ordem"
1520:                 loc_oGrid.Column2.Header1.Caption = "Fase"
1521:                 loc_oGrid.Column3.Header1.Caption = "Funcion" + CHR(225) + "rio"
1522:                 loc_oGrid.Column4.Header1.Caption = "Tipo Opera" + CHR(231) + ;
1523:                     CHR(227) + "o"
1524:                 loc_oGrid.Column5.Header1.Caption = "E/S"
1525: 
1526:                 *-- Grid.ReadOnly ANTES de Column.ReadOnly: o do grid propaga
1527:                 *-- para as colunas (regra #18). O legado faz exatamente isto
1528:                 *-- no Grupo_op.Click (columnN.ReadOnly = .F.); quem bloqueia a
1529:                 *-- edicao fora dos modos INSERIR/ALTERAR e o "When" da celula.
1530:                 loc_oGrid.ReadOnly         = .F.
1531:                 loc_oGrid.Column1.ReadOnly = .F.
1532:                 loc_oGrid.Column2.ReadOnly = .F.

*-- Linhas 1585 a 1624:
1585:     *===========================================================================
1586:     * ContarLinhasFases - COUNT de linhas vivas do cursor de fases
1587:     *
1588:     * Legado: "Select crSigCdDpr / Count to lnLinhas" - COUNT respeita
1589:     * SET DELETED ON (as linhas excluidas pelo botao Excluir NAO entram),
1590:     * diferente de RECCOUNT(). O preco e que COUNT percorre o cursor e MOVE o
1591:     * ponteiro: o RECNO e o alias correntes sao salvos e repostos, senao a
1592:     * linha selecionada na grade salta sozinha.
1593:     *===========================================================================
1594:     PROTECTED PROCEDURE ContarLinhasFases()
1595:         LOCAL loc_nLinhas, loc_nAliasAnt, loc_nRegAnt
1596: 
1597:         loc_nLinhas = 0
1598: 
1599:         IF USED("cursor_4c_Fases")
1600:             loc_nAliasAnt = SELECT(0)
1601:             SELECT cursor_4c_Fases
1602:             loc_nRegAnt = RECNO("cursor_4c_Fases")
1603: 
1604:             COUNT TO loc_nLinhas
1605: 
1606:             IF loc_nRegAnt > 0 AND loc_nRegAnt <= RECCOUNT("cursor_4c_Fases")
1607:                 GO loc_nRegAnt IN cursor_4c_Fases
1608:             ENDIF
1609:             SELECT (loc_nAliasAnt)
1610:         ENDIF
1611: 
1612:         RETURN loc_nLinhas
1613:     ENDPROC
1614: 
1615:     *===========================================================================
1616:     * NomeEditavel - Reproduz o "When" de GetNome do legado
1617:     *
1618:     *   Case pcEscolha = 'PROCURAR'  -> .T.
1619:     *   Case pcEscolha <> 'INSERIR'  -> .F.
1620:     *   Case pcEscolha = 'INSERIR'   -> .T. so se a grade de fases estiver
1621:     *        vazia, ou tiver UMA unica linha com Grupos E Contas vazios
1622:     *        (ou seja, a linha em branco que o proprio form acabou de inserir)
1623:     *   Other                        -> .F.
1624:     *

*-- Linhas 1643 a 1672:
1643:                 loc_lPrimeiraVazia = .F.
1644: 
1645:                 IF loc_nLinhas = 1 AND USED("cursor_4c_Fases")
1646:                     loc_nAliasAnt = SELECT(0)
1647:                     SELECT cursor_4c_Fases
1648:                     loc_nRegAnt = RECNO("cursor_4c_Fases")
1649: 
1650:                     GO TOP IN cursor_4c_Fases
1651:                     loc_lPrimeiraVazia = EMPTY(cursor_4c_Fases.grupos) AND ;
1652:                         EMPTY(cursor_4c_Fases.contas)
1653: 
1654:                     IF loc_nRegAnt > 0 AND loc_nRegAnt <= RECCOUNT("cursor_4c_Fases")
1655:                         GO loc_nRegAnt IN cursor_4c_Fases
1656:                     ENDIF
1657:                     SELECT (loc_nAliasAnt)
1658:                 ENDIF
1659: 
1660:                 loc_lEditavel = (loc_nLinhas = 0) OR loc_lPrimeiraVazia
1661:         ENDCASE
1662: 
1663:         RETURN loc_lEditavel
1664:     ENDPROC
1665: 
1666:     *===========================================================================
1667:     * AtualizarEstadoCampos - Reavalia os "When" dos campos da pagina Dados
1668:     *
1669:     * FONTE UNICA das regras de habilitacao do legado:
1670:     *   GetNome.When    -> ver NomeEditavel
1671:     *   Get_Grupo.When  -> Inlist(pcEscolha,'INSERIR','ALTERAR')
1672:     *   Get_DGrupo.When -> IsEmpty(Get_Grupo.Value) And Inlist(...)

*-- Linhas 1736 a 1754:
1736:     *       Messagebox('O Nome deve ser informado...',32,'')
1737:     *       Return 0
1738:     *   Endif
1739:     *   Select crSigCdDpr / Go Top / If Eof() -> InsiraRegGrade() / Go Top
1740:     *
1741:     * DIVERGENCIA DOCUMENTADA: "Return 0" num Valid retem o foco no campo;
1742:     * LostFocus nao tem como fazer isso e devolver o foco daqui provocaria
1743:     * reentrancia. O aviso continua aparecendo no mesmo momento, e o bloqueio
1744:     * efetivo da gravacao fica no Confirmar (Fase 7), que e onde o legado
1745:     * tambem recusa gravar sem nome.
1746:     *
1747:     * A guarda this_lEmLookup tambem vale aqui: o MsgAviso e MODAL, tira o
1748:     * foco e redisparia este proprio LostFocus.
1749:     *
1750:     * PUBLIC: BINDEVENT exige metodo publico (regra #3). LostFocus nao passa
1751:     * parametro nenhum.
1752:     *===========================================================================
1753:     PROCEDURE ValidarNomeLostFocus()
1754:         LOCAL loc_oPg2, loc_cNome, loc_lEmLookupAnt

*-- Linhas 1793 a 1849:
1793:     *===========================================================================
1794:     * InserirLinhaFase - PROCEDURE insirareggrade do legado
1795:     *
1796:     *   Select crSigCdDpr / Append Blank
1797:     *   Replace contas With Space(10), grupos With Space(10),
1798:     *           nome With getNome.Value, operas With Space(1),
1799:     *           ordems With 0, tpops With Space(15),
1800:     *           cIdChaves With fUniqueIds()
1801:     *
1802:     * cidchaves vem de fUniqueIds() e NUNCA de string vazia: com cidchaves em
1803:     * branco a segunda linha colidiria no indice unico de SigCdDpr (regra #22).
1804:     * dopes nao e citada em lugar nenhum do legado, mas e NOT NULL na tabela -
1805:     * o legado a ganhava em branco do "Select *" + "Append Blank" e aqui ela e
1806:     * preenchida explicitamente pelo mesmo motivo.
1807:     *
1808:     * PUBLIC: chamado pelo handler do botao, pelo ValidarNomeLostFocus e pelas
1809:     * Fases 7-8.
1810:     *===========================================================================
1811:     PROCEDURE InserirLinhaFase()
1812:         LOCAL loc_lResultado, loc_nAliasAnt, loc_cNome
1813:         loc_lResultado = .F.
1814: 
1815:         TRY
1816:             IF !USED("cursor_4c_Fases")
1817:                 MsgAviso("Cursor de fases indispon" + CHR(237) + "vel.", ;
1818:                     "FormSigOpDmp")
1819:             ELSE
1820:                 loc_cNome = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Nome.Value)
1821: 
1822:                 loc_nAliasAnt = SELECT(0)
1823:                 SELECT cursor_4c_Fases
1824:                 APPEND BLANK
1825:                 REPLACE contas    WITH SPACE(10), ;
1826:                         grupos    WITH SPACE(10), ;
1827:                         nome      WITH loc_cNome, ;
1828:                         operas    WITH SPACE(1),  ;
1829:                         ordems    WITH 0,         ;
1830:                         tpops     WITH SPACE(15), ;
1831:                         cidchaves WITH fUniqueIds(), ;
1832:                         dopes     WITH SPACE(20) ;
1833:                         IN cursor_4c_Fases
1834:                 SELECT (loc_nAliasAnt)
1835: 
1836:                 loc_lResultado = .T.
1837:             ENDIF
1838: 
1839:         CATCH TO loException
1840:             MostrarErro("Erro ao inserir a linha de fase:" + CHR(13) + ;
1841:                 loException.Message, "FormSigOpDmp.InserirLinhaFase")
1842:             loc_lResultado = .F.
1843:         ENDTRY
1844: 
1845:         RETURN loc_lResultado
1846:     ENDPROC
1847: 
1848:     *===========================================================================
1849:     * BtnInserirFaseClick - Pagina.Dados.Inserir.Click do legado

*-- Linhas 1891 a 1909:
1891:     * BtnExcluirFaseClick - Pagina.Dados.Excluir.Click do legado
1892:     *
1893:     *   If Inlist( pcEscolha, 'INSERIR', 'ALTERAR' )
1894:     *       Select crSigCdDpr / Delete / Skip
1895:     *       If Eof() -> Go Bottom
1896:     *       If Eof() -> InsiraRegGrade()
1897:     *       Grade.Column1.Text1.SetFocus / Grade.Refresh
1898:     *   Endif
1899:     *
1900:     * O segundo "If Eof()" nao e repetido por descuido: com o cursor vazio o
1901:     * GO BOTTOM nao sai do EOF, e e dai que o legado conclui que a grade ficou
1902:     * sem nenhuma linha e repoe a linha em branco.
1903:     *
1904:     * NAO confundir com BtnExcluirClick (CRUD do registro mestre, pagina
1905:     * Lista): este exclui a LINHA da grade de fases.
1906:     *
1907:     * PUBLIC: BINDEVENT exige metodo publico (regra #3).
1908:     *===========================================================================
1909:     PROCEDURE BtnExcluirFaseClick()

*-- Linhas 1917 a 1965:
1917:             IF !USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
1918:                 MsgAviso("Nenhuma fase selecionada.", "FormSigOpDmp")
1919:             ELSE
1920:                 loc_nAliasAnt = SELECT(0)
1921:                 SELECT cursor_4c_Fases
1922:                 DELETE
1923:                 SKIP
1924: 
1925:                 IF EOF("cursor_4c_Fases")
1926:                     GO BOTTOM IN cursor_4c_Fases
1927:                 ENDIF
1928:                 SELECT (loc_nAliasAnt)
1929: 
1930:                 *-- Grade sem nenhuma linha viva: repor a linha em branco.
1931:                 IF THIS.ContarLinhasFases() = 0
1932:                     THIS.InserirLinhaFase()
1933:                 ENDIF
1934: 
1935:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Fases
1936:                 loc_oGrid.Refresh()
1937:                 THIS.AtualizarEstadoCampos()
1938:                 loc_oGrid.SetFocus()
1939:             ENDIF
1940: 
1941:         CATCH TO loException
1942:             MostrarErro("Erro ao excluir fase:" + CHR(13) + ;
1943:                 loException.Message, "FormSigOpDmp.BtnExcluirFaseClick")
1944:         ENDTRY
1945:     ENDPROC
1946: 
1947:     *===========================================================================
1948:     * ConexaoAtiva - Ha conexao SQL utilizavel?
1949:     *
1950:     * Os sete lookups consultam o banco. Com gnConnHandle invalido o SQLEXEC
1951:     * do FormBuscaAuxiliar dispara EXCECAO (nao devolve -1), e sem esta guarda
1952:     * o ValidarUIFidelity e o harness headless - que rodam com
1953:     * gnConnHandle = -1 - encheriam a tela de dialogos de erro.
1954:     *===========================================================================
1955:     PROTECTED PROCEDURE ConexaoAtiva()
1956:         RETURN (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
1957:     ENDPROC
1958: 
1959:     *===========================================================================
1960:     * UsuarioCorrente - Usuario logado para os checks de acesso
1961:     *===========================================================================
1962:     PROTECTED PROCEDURE UsuarioCorrente()
1963:         LOCAL loc_cUsuario
1964:         loc_cUsuario = ""
1965: 

*-- Linhas 2003 a 2024:
2003:             RETURN
2004:         ENDIF
2005: 
2006:         loc_nAliasAnt = SELECT(0)
2007:         SELECT cursor_4c_Fases
2008:         REPLACE (par_cCampo) WITH par_uValor IN cursor_4c_Fases
2009:         SELECT (loc_nAliasAnt)
2010:     ENDPROC
2011: 
2012:     *===========================================================================
2013:     * GrupoDaLinhaFase - Grupo da linha corrente da grade de fases
2014:     * Legado: crSigCdDpr.Grupos, usado como filtro do lookup de Tipo de
2015:     * Operacao e como 2o argumento do fAcessoContas.
2016:     *===========================================================================
2017:     PROTECTED PROCEDURE GrupoDaLinhaFase()
2018:         LOCAL loc_cGrupo
2019:         loc_cGrupo = ""
2020: 
2021:         IF USED("cursor_4c_Fases") AND !EOF("cursor_4c_Fases")
2022:             loc_cGrupo = ALLTRIM(cursor_4c_Fases.grupos)
2023:         ENDIF
2024: 

*-- Linhas 2042 a 2060:
2042:     *   EndIf
2043:     *
2044:     * crSigCdGcr e criado no Init legado com
2045:     *   Select codigos,Descrs From SigCdGcr Where gerbals=1
2046:     * logo o universo do lookup e' SO os grupos com gerbals = 1 - o filtro faz
2047:     * parte da regra e vai para o 9o argumento do FormBuscaAuxiliar, que o
2048:     * aplica na busca exata, na parcial e no fallback show-all.
2049:     *===========================================================================
2050:     PROCEDURE ValidarGrupoLostFocus()
2051:         LOCAL loc_oPg2, loc_cGrupo
2052: 
2053:         *-- Guarda de reentrancia: o picker e MODAL, tira o foco do campo e
2054:         *-- redispara este proprio LostFocus (regra #37). A flag e ligada
2055:         *-- dentro de AbrirLookupGrupo, funil das TRES portas (LostFocus,
2056:         *-- F4/F5 e DblClick).
2057:         IF THIS.this_lEmLookup
2058:             RETURN
2059:         ENDIF
2060: 

*-- Linhas 2125 a 2143:
2125:                 ENDIF
2126: 
2127:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2128:                     SELECT cursor_4c_BuscaGcr
2129:                     loc_oPg2.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcr.codigos)
2130:                     loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
2131:                 ELSE
2132:                     *-- ESC/Cancelar com o picker ABERTO: o legado limpa os
2133:                     *-- dois (Iif(LastKey()==27,'',...)). Sem o picker na tela
2134:                     *-- nada e limpado - apagar o que o usuario digitou o
2135:                     *-- deixaria sem como preencher o campo (regra #50).
2136:                     IF loc_lMostrou
2137:                         loc_oPg2.txt_4c_Grupo.Value  = ""
2138:                         loc_oPg2.txt_4c_DGrupo.Value = ""
2139:                     ENDIF
2140:                 ENDIF
2141: 
2142:                 loc_oBusca.Release()
2143:             ENDIF

*-- Linhas 2229 a 2247:
2229:                 ENDIF
2230: 
2231:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcrD")
2232:                     SELECT cursor_4c_BuscaGcrD
2233:                     loc_oPg2.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcrD.codigos)
2234:                     loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcrD.descrs)
2235:                 ELSE
2236:                     IF loc_lMostrou
2237:                         loc_oPg2.txt_4c_Grupo.Value  = ""
2238:                         loc_oPg2.txt_4c_DGrupo.Value = ""
2239:                     ENDIF
2240:                 ENDIF
2241: 
2242:                 loc_oBusca.Release()
2243:             ENDIF
2244: 
2245:         CATCH TO loException
2246:             MsgErro("Erro em FormSigOpDmp.AbrirLookupDGrupo: " + ;
2247:                 loException.Message, "Erro")

*-- Linhas 2259 a 2277:
2259:     * Get_DConta, limpando os dois no ESC.
2260:     *
2261:     * crSigCdCli e criado no Init legado com
2262:     *   Select Grupos, IClis, RClis From SigCdCli Where GerBals = 1
2263:     * logo o universo e' SO as contas com gerbals = 1.
2264:     *===========================================================================
2265:     PROCEDURE ValidarContaLostFocus()
2266:         LOCAL loc_oPg2, loc_cConta
2267: 
2268:         IF THIS.this_lEmLookup
2269:             RETURN
2270:         ENDIF
2271: 
2272:         TRY
2273:             loc_oPg2   = THIS.pgf_4c_Paginas.Page2
2274:             loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
2275: 
2276:             IF EMPTY(loc_cConta)
2277:                 loc_oPg2.txt_4c_DConta.Value = ""

*-- Linhas 2327 a 2345:
2327:                 ENDIF
2328: 
2329:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2330:                     SELECT cursor_4c_BuscaCli
2331:                     loc_oPg2.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCli.iclis)
2332:                     loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
2333:                 ELSE
2334:                     IF loc_lMostrou
2335:                         loc_oPg2.txt_4c_Conta.Value  = ""
2336:                         loc_oPg2.txt_4c_DConta.Value = ""
2337:                     ENDIF
2338:                 ENDIF
2339: 
2340:                 loc_oBusca.Release()
2341:             ENDIF
2342: 
2343:         CATCH TO loException
2344:             MsgErro("Erro em FormSigOpDmp.AbrirLookupConta: " + ;
2345:                 loException.Message, "Erro")

*-- Linhas 2421 a 2439:
2421:                 ENDIF
2422: 
2423:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCliD")
2424:                     SELECT cursor_4c_BuscaCliD
2425:                     loc_oPg2.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCliD.iclis)
2426:                     loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCliD.rclis)
2427:                 ELSE
2428:                     IF loc_lMostrou
2429:                         loc_oPg2.txt_4c_Conta.Value  = ""
2430:                         loc_oPg2.txt_4c_DConta.Value = ""
2431:                     ENDIF
2432:                 ENDIF
2433: 
2434:                 loc_oBusca.Release()
2435:             ENDIF
2436: 
2437:         CATCH TO loException
2438:             MsgErro("Erro em FormSigOpDmp.AbrirLookupDConta: " + ;
2439:                 loException.Message, "Erro")

*-- Linhas 2557 a 2575:
2557:                 ENDIF
2558: 
2559:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFase")
2560:                     SELECT cursor_4c_BuscaFase
2561:                     *-- O codigo escolhido vai para os DOIS lugares: .Value e
2562:                     *-- cursor. Sem a .Value o texto digitado sobrescreveria o
2563:                     *-- cursor na saida da celula (regra #46).
2564:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaFase.codigos)
2565:                     THIS.GravarCelulaFase("grupos", ;
2566:                         PADR(ALLTRIM(cursor_4c_BuscaFase.codigos), 10))
2567:                 ENDIF
2568: 
2569:                 loc_oBusca.Release()
2570:             ENDIF
2571: 
2572:         CATCH TO loException
2573:             MsgErro("Erro em FormSigOpDmp.AbrirLookupFaseGrade: " + ;
2574:                 loException.Message, "Erro")
2575:         ENDTRY

*-- Linhas 2668 a 2686:
2668:                 ENDIF
2669: 
2670:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFunc")
2671:                     SELECT cursor_4c_BuscaFunc
2672:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaFunc.iclis)
2673:                     THIS.GravarCelulaFase("contas", ;
2674:                         PADR(ALLTRIM(cursor_4c_BuscaFunc.iclis), 10))
2675:                 ELSE
2676:                     IF loc_lMostrou
2677:                         par_oTxt.Value = ""
2678:                         THIS.GravarCelulaFase("contas", SPACE(10))
2679:                     ENDIF
2680:                 ENDIF
2681: 
2682:                 loc_oBusca.Release()
2683:             ENDIF
2684: 
2685:         CATCH TO loException
2686:             MsgErro("Erro em FormSigOpDmp.AbrirLookupFuncionarioGrade: " + ;

*-- Linhas 2695 a 2717:
2695:     * GradeFasesTpOpValid - Column4.Text1.Valid (coluna Tipo Operacao)
2696:     *
2697:     *   If IsEmpty( This.Value ) -> Return .t.
2698:     *   Select crSigOpOpt / Set Order to Cods / Set Near On
2699:     *   If !Seek( This.Value ) Or ( crSigCdDpr.Grupos # crSigOpOpt.Grupos
2700:     *                               And !IsEmpty( crSigOpOpt.Grupos ) )
2701:     *       lcGrupo = crSigCdDpr.Grupos
2702:     *       Select Cods, Descs, pFalhas From crSigOpOpt
2703:     *           where Grupos = lcGrupo Or IsEmpty( Grupos ) Into cursor TmpOpt
2704:     *       loBrowse = fwBuscaSel( 'TmpOpt', 'Cods', ... )
2705:     *       This.Value = Iif( Lastkey() == 27, '', TmpOpt.Cods )
2706:     *   Endif
2707:     *
2708:     * A condicao do WHERE e regra de negocio e vai inteira: um tipo de
2709:     * operacao serve se for do grupo da LINHA ou se for generico (Grupos
2710:     * vazio). Esse filtro tambem e o que invalida um codigo que existe mas
2711:     * pertence a outro grupo - e por isso ele vai no 9o argumento do
2712:     * FormBuscaAuxiliar, que o aplica TAMBEM na busca exata.
2713:     *===========================================================================
2714:     PROCEDURE GradeFasesTpOpValid(par_oTxt)
2715:         IF VARTYPE(par_oTxt) != "O"
2716:             RETURN .T.
2717:         ENDIF

*-- Linhas 2742 a 2761:
2742:         loc_cGrupoLinha = THIS.GrupoDaLinhaFase()
2743: 
2744:         *-- "Where Grupos = lcGrupo Or IsEmpty( Grupos )" do legado.
2745:         *-- EscaparSQL JA devolve o valor COM as aspas (regra #5).
2746:         loc_cFiltro = "(RTRIM(grupos) = " + EscaparSQL(loc_cGrupoLinha) + ;
2747:             " OR RTRIM(grupos) = '')"
2748: 
2749:         loc_lEmLookupAnt    = THIS.this_lEmLookup
2750:         THIS.this_lEmLookup = .T.
2751:         TRY
2752:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2753:                 "SigOpOpt", "cursor_4c_BuscaTpOp", "cods", loc_cTpOp, ;
2754:                 "Cadastro de Tipos de Opera" + CHR(231) + CHR(227) + "o", ;
2755:                 .F., .T., loc_cFiltro)
2756: 
2757:             IF VARTYPE(loc_oBusca) = "O"
2758:                 loc_lMostrou = .F.
2759: 
2760:                 IF !loc_oBusca.this_lAchouRegistro
2761:                     loc_oBusca.mAddColuna("cods",    "", "C" + CHR(243) + "digo")

*-- Linhas 2767 a 2785:
2767:                 ENDIF
2768: 
2769:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpOp")
2770:                     SELECT cursor_4c_BuscaTpOp
2771:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaTpOp.cods)
2772:                     THIS.GravarCelulaFase("tpops", ;
2773:                         PADR(ALLTRIM(cursor_4c_BuscaTpOp.cods), 15))
2774:                 ELSE
2775:                     IF loc_lMostrou
2776:                         par_oTxt.Value = ""
2777:                         THIS.GravarCelulaFase("tpops", SPACE(15))
2778:                     ENDIF
2779:                 ENDIF
2780: 
2781:                 loc_oBusca.Release()
2782:             ENDIF
2783: 
2784:         CATCH TO loException
2785:             MsgErro("Erro em FormSigOpDmp.AbrirLookupTpOpGrade: " + ;

*-- Linhas 2879 a 2907:
2879:     *
2880:     * A EXCLUSAO NAO ACONTECE AQUI: no legado o Excluir apenas abre a ficha em
2881:     * modo EXCLUIR com os campos travados, e quem pergunta "Deseja Realmente
2882:     * Excluir Esses Dados?" e executa o DELETE e o Salva.Click (frmcadastro:
2883:     * Case pcEscolha=[EXCLUIR] -> MessageBox + mSv_Excluir, mais o ExcluiItens
2884:     * desta tela, que apaga as linhas de SigCdDpr). Esse caminho e o Confirmar,
2885:     * da Fase 8.
2886:     *===========================================================================
2887: 
2888:     *===========================================================================
2889:     * LimparCampos - Deixa a ficha em branco (legado: poDataMgr.NewReg, que
2890:     * cria um registro VAZIO no cursor mestre, e os controles ligados a ele
2891:     * passam a exibir branco).
2892:     * Os campos desta tela nao tem ControlSource: quem os esvazia e este
2893:     * metodo. Os PEMSTATUS existem porque ele pode ser chamado antes de a
2894:     * pagina Dados estar inteiramente montada.
2895:     * PROTECTED OBRIGATORIO: FormBase declara LimparCampos / BOParaForm /
2896:     * FormParaBO como PROTECTED (sao os hooks que FormBase chama por THIS.) e
2897:     * o VFP9 NAO deixa a subclasse ALARGAR o escopo - escrever PROCEDURE sem
2898:     * o modificador nao torna o metodo publico, so esconde do leitor que ele
2899:     * continua protegido. Chamar sempre por THIS. de dentro da classe; de
2900:     * fora, nem o harness alcanca (PEMSTATUS(...,5) responde "existe?", nao
2901:     * "da para chamar daqui?").
2902:     *===========================================================================
2903:     PROTECTED PROCEDURE LimparCampos()
2904:         LOCAL loc_oPg2
2905: 
2906:         TRY
2907:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2

*-- Linhas 3008 a 3029:
3008:             ELSE
3009:                 THIS.FecharCursorBusca("cursor_4c_DescGcr")
3010: 
3011:                 loc_cSQL = "SELECT descrs FROM SigCdGcr" + ;
3012:                     " WHERE RTRIM(codigos) = " + EscaparSQL(loc_cGrupo)
3013: 
3014:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescGcr")
3015: 
3016:                 IF loc_nResultado < 0
3017:                     MsgErro("Erro ao ler a descri" + CHR(231) + CHR(227) + ;
3018:                         "o do grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
3019:                     loc_oPg2.txt_4c_DGrupo.Value = ""
3020:                 ELSE
3021:                     IF USED("cursor_4c_DescGcr") AND RECCOUNT("cursor_4c_DescGcr") > 0
3022:                         GO TOP IN cursor_4c_DescGcr
3023:                         loc_oPg2.txt_4c_DGrupo.Value = ;
3024:                             ALLTRIM(TratarNulo(cursor_4c_DescGcr.descrs, ""))
3025:                     ELSE
3026:                         loc_oPg2.txt_4c_DGrupo.Value = ""
3027:                     ENDIF
3028:                 ENDIF
3029: 

*-- Linhas 3036 a 3057:
3036:             ELSE
3037:                 THIS.FecharCursorBusca("cursor_4c_DescCli")
3038: 
3039:                 loc_cSQL = "SELECT rclis FROM SigCdCli" + ;
3040:                     " WHERE RTRIM(iclis) = " + EscaparSQL(loc_cConta)
3041: 
3042:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCli")
3043: 
3044:                 IF loc_nResultado < 0
3045:                     MsgErro("Erro ao ler a descri" + CHR(231) + CHR(227) + ;
3046:                         "o da conta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
3047:                     loc_oPg2.txt_4c_DConta.Value = ""
3048:                 ELSE
3049:                     IF USED("cursor_4c_DescCli") AND RECCOUNT("cursor_4c_DescCli") > 0
3050:                         GO TOP IN cursor_4c_DescCli
3051:                         loc_oPg2.txt_4c_DConta.Value = ;
3052:                             ALLTRIM(TratarNulo(cursor_4c_DescCli.rclis, ""))
3053:                     ELSE
3054:                         loc_oPg2.txt_4c_DConta.Value = ""
3055:                     ENDIF
3056:                 ENDIF
3057: 

*-- Linhas 3067 a 3086:
3067:     *===========================================================================
3068:     * LimparFases - o "Zap in ('crSigCdDpr')" do ramo INSERIR/PROCURAR
3069:     *
3070:     * ZAP (e nao USE IN + CREATE CURSOR) de proposito: fechar e recriar o alias
3071:     * derruba Grid.RecordSource e as Column.ControlSource ligadas na montagem
3072:     * da pagina, e a grade fica permanentemente vazia com o cursor cheio. O
3073:     * legado Fortyus faz "Zap In <cursor>" exatamente por isso.
3074:     *
3075:     * O par SET SAFETY e obrigatorio: com SAFETY ON o ZAP abre o dialogo modal
3076:     * de confirmacao e CONGELA a tela. SET SAFETY e escopado por data session,
3077:     * logo o SET SAFETY OFF do main.prg nao alcanca form com DataSession = 2 -
3078:     * e o estado anterior e reposto para nao mexer no ambiente do chamador.
3079:     *===========================================================================
3080:     PROTECTED PROCEDURE LimparFases()
3081:         LOCAL loc_cSafety
3082: 
3083:         IF USED("cursor_4c_Fases")
3084:             loc_cSafety = SET("SAFETY")
3085:             SET SAFETY OFF
3086: 

*-- Linhas 3097 a 3122:
3097:     *
3098:     * Query do AddCursor do Init legado, com o nome da ficha no lugar do
3099:     * parametro ?sNome que o Grupo_op.Click atribuia antes do Requery:
3100:     *   Select * From SigCdDpr Where nome=?sNome Order By Ordems
3101:     *
3102:     * O SELECT vai para um cursor TEMPORARIO e as linhas entram no
3103:     * cursor_4c_Fases por ZAP + APPEND FROM: SQLEXEC direto sobre o alias da
3104:     * grade DESTROI o cursor e com ele todas as Column (Problema 34) - a linha
3105:     * seguinte estouraria "Unknown member COLUMN1". A lista de colunas segue a
3106:     * ordem EXATA de SigCdDpr, que e a ordem do CREATE CURSOR de
3107:     * CriarCursorFases, porque APPEND FROM casa os campos por POSICAO.
3108:     *
3109:     * PUBLIC: chamado pelos handlers de Alterar/Visualizar/Excluir e pela
3110:     * Fase 8 (o Confirmar recarrega a ficha gravada).
3111:     *===========================================================================
3112:     PROCEDURE CarregarFasesDoBanco()
3113:         LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cNome, loc_nAliasAnt
3114:         loc_lResultado = .F.
3115: 
3116:         TRY
3117:             loc_cNome = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Nome.Value)
3118: 
3119:             IF !USED("cursor_4c_Fases")
3120:                 *-- O placeholder e criado na montagem da pagina Dados; se
3121:                 *-- algum caminho de erro o fechou, recria-lo aqui e o que
3122:                 *-- permite a grade voltar a funcionar. Quem religa a grade e o

*-- Linhas 3132 a 3168:
3132:             ELSE
3133:                 THIS.FecharCursorBusca("cursor_4c_FasesTmp")
3134: 
3135:                 loc_cSQL = "SELECT contas, grupos, nome, operas, ordems," + ;
3136:                     " tpops, cidchaves, dopes FROM SigCdDpr" + ;
3137:                     " WHERE RTRIM(nome) = " + EscaparSQL(loc_cNome) + ;
3138:                     " ORDER BY ordems"
3139: 
3140:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FasesTmp")
3141: 
3142:                 IF loc_nResultado < 0
3143:                     MsgErro("Erro ao carregar as fases do demonstrativo:" + ;
3144:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
3145:                 ELSE
3146:                     THIS.LimparFases()
3147: 
3148:                     IF USED("cursor_4c_FasesTmp") AND ;
3149:                        RECCOUNT("cursor_4c_FasesTmp") > 0
3150:                         loc_nAliasAnt = SELECT(0)
3151:                         SELECT cursor_4c_Fases
3152:                         APPEND FROM DBF("cursor_4c_FasesTmp")
3153:                         SELECT (loc_nAliasAnt)
3154:                     ENDIF
3155: 
3156:                     loc_lResultado = .T.
3157:                 ENDIF
3158: 
3159:                 THIS.FecharCursorBusca("cursor_4c_FasesTmp")
3160:             ENDIF
3161: 
3162:         CATCH TO loException
3163:             MsgErro("Erro em FormSigOpDmp.CarregarFasesDoBanco: " + ;
3164:                 loException.Message, "Erro")
3165:             loc_lResultado = .F.
3166:         ENDTRY
3167: 
3168:         RETURN loc_lResultado

*-- Linhas 3321 a 3339:
3321:             ELSE
3322:                 *-- NovoRegistro limpa as properties do BO e liga
3323:                 *-- this_lNovoRegistro, que e o que faz o Salvar escolher
3324:                 *-- INSERT em vez de UPDATE. Sem ele o Confirmar da Fase 8
3325:                 *-- tentaria atualizar um registro que ainda nao existe.
3326:                 THIS.this_oBusinessObject.NovoRegistro()
3327: 
3328:                 THIS.LimparCampos()
3329:                 THIS.LimparFases()
3330: 
3331:                 THIS.this_cModoAtual = "INCLUIR"
3332:                 THIS.AlternarPagina(2)
3333: 
3334:                 THIS.VincularGradeFases()
3335:                 THIS.RepintarGradeFases()
3336: 
3337:                 THIS.FocarAposAbrirFicha()
3338: 
3339:                 loc_lResultado = .T.

*-- Linhas 3382 a 3400:
3382:     *
3383:     * NAO exclui nada: abre a ficha travada em modo EXCLUIR, com o Confirmar
3384:     * habilitado, exatamente como o legado. A pergunta "Deseja Realmente
3385:     * Excluir Esses Dados?" e o DELETE (mSv_Excluir + ExcluiItens, que apaga as
3386:     * linhas de SigCdDpr do mesmo nome) vivem no Confirmar, da Fase 8.
3387:     *
3388:     * PUBLIC: BINDEVENT exige metodo publico (regra #3).
3389:     *===========================================================================
3390:     PROCEDURE BtnExcluirClick()
3391:         RETURN THIS.AbrirFichaDoRegistro("EXCLUIR")
3392:     ENDPROC
3393: 
3394:     *===========================================================================
3395:     * GradeListaKeyPress / GradeListaDblClick - atalhos da grade da Lista
3396:     *
3397:     * O frmcadastro trata o Enter na grade da Lista como CONSULTAR:
3398:     *   Case (nKeyCode = 13) And lnPag = 1 And ...ActiveControl.BaseClass=[GRID]
3399:     *       NoDefault / loGrp.Click(2)
3400:     * O duplo clique nao existe no legado e vai para o MESMO funil: e o gesto

*-- Linhas 3473 a 3517:
3473:     * FASE 8 - CONFIRMAR, BUSCAR POR EXEMPLO E PERSISTENCIA
3474:     *
3475:     * Legado (Pagina.Dados.Grupo_Salva.Salva.Click do SCX):
3476:     *   <limpa RecordSource/ControlSource da grade de fases>
3477:     *   If pcescolha = 'INSERIR' -> Replace cIdChaves With fUniqueIds()
3478:     *   If Not poDataMgr.Update('crSigCdDpr') -> erro
3479:     *   If Inlist( pcEscolha, 'EXCLUIR' ) -> ExcluiItens()
3480:     *   =DoDefault()          && frmcadastro.Salva.Click: o Do Case por verbo
3481:     *   ThisForm.mAtivapagina1
3482:     *
3483:     * e o Do Case do frmcadastro, que e o despachante de verdade:
3484:     *   INSERIR   -> mSv_Inserir   (poDataMgr.Update(1) + Commit)
3485:     *   CONSULTAR -> mSv_Consultar
3486:     *   ALTERAR   -> mSv_Alterar   (poDataMgr.Update(1) + Commit)
3487:     *   EXCLUIR   -> MessageBox('Deseja Realmente Excluir Esses Dados?')
3488:     *                e, se 6, mSv_Excluir (poDataMgr.Delete(1) + Commit)
3489:     *   PROCURAR  -> apaga o registro em branco do cursor mestre e chama
3490:     *                mSv_Procurar, que nesta tela e o Seek por nome
3491:     *===========================================================================
3492: 
3493:     *===========================================================================
3494:     * FormParaBO - Transfere os campos da ficha para as propriedades do BO
3495:     *
3496:     * No SCX os TRES campos do cabecalho tem ControlSource no cursor mestre:
3497:     *   GetNome   -> crSigPrDmo.nome
3498:     *   Get_Grupo -> crSigPrDmo.Grupos
3499:     *   Get_Conta -> crSigPrDmo.Contas
3500:     * ou seja, o que o usuario digita vai DIRETO para o registro que o
3501:     * TableUpdate do Salva.Click grava. Os campos desta tela nao tem
3502:     * ControlSource (o valor vive na .Value) e este metodo e o equivalente.
3503:     *
3504:     * Os campos de DESCRICAO (txt_4c_DGrupo/txt_4c_DConta) NAO entram: eles
3505:     * sao a segunda porta de entrada do lookup e vem de outras tabelas
3506:     * (SigCdGcr.descrs e SigCdCli.rclis); quem os resolve e o
3507:     * CarregarDescricoesMestre. SigPrDmo nao tem coluna de descricao.
3508:     *
3509:     * cidchaves tambem nao vem da tela: e a PK Fortyus de SigPrDmo. No
3510:     * INCLUIR o Inserir do BO a gera com fUniqueIds (legado: "If pcescolha
3511:     * ='INSERIR' Replace cIdChaves With fUniqueIds() in crSigPrDmo"); no
3512:     * ALTERAR ela ja veio do CarregarPorCodigo e nao se toca.
3513:     *
3514:     * PROTECTED OBRIGATORIO: FormBase declara LimparCampos / BOParaForm /
3515:     * FormParaBO como PROTECTED (sao os hooks que FormBase chama por THIS.) e
3516:     * o VFP9 NAO deixa a subclasse ALARGAR o escopo - escrever PROCEDURE sem
3517:     * o modificador nao torna o metodo publico, so esconde do leitor que ele

*-- Linhas 3533 a 3551:
3533: 
3534:                 *-- Os LEFT() respeitam a largura das colunas de SigPrDmo
3535:                 *-- (nome char(20), grupos char(10), contas char(10)): sem
3536:                 *-- eles o SQL Server recusa o INSERT inteiro com "String or
3537:                 *-- binary data would be truncated" (regra #19).
3538:                 loc_oBO.this_cNome   = LEFT(ALLTRIM(loc_oPg2.txt_4c_Nome.Value), 20)
3539:                 loc_oBO.this_cGrupos = LEFT(ALLTRIM(loc_oPg2.txt_4c_Grupo.Value), 10)
3540:                 loc_oBO.this_cContas = LEFT(ALLTRIM(loc_oPg2.txt_4c_Conta.Value), 10)
3541: 
3542:                 loc_lResultado = .T.
3543:             ENDIF
3544: 
3545:         CATCH TO loException
3546:             MsgErro("Erro em FormSigOpDmp.FormParaBO: " + ;
3547:                 loException.Message, "Erro")
3548:             loc_lResultado = .F.
3549:         ENDTRY
3550: 
3551:         RETURN loc_lResultado

*-- Linhas 3800 a 3824:
3800:     * GravarFicha - ramos INSERIR e ALTERAR do Confirmar
3801:     *
3802:     * ORDEM: fases (SigCdDpr) ANTES do mestre (SigPrDmo), como no legado - o
3803:     * Salva.Click do SCX faz "poDataMgr.Update('crSigCdDpr')" e so depois
3804:     * chama o DoDefault() que dispara mSv_Inserir/mSv_Alterar. As duas tabelas
3805:     * nao tem FK entre si, logo a ordem nao muda o resultado no banco; o que
3806:     * ela muda e o estado do BO quando algo falha. Com o mestre primeiro, uma
3807:     * falha nas fases deixaria o BO com this_lNovoRegistro = .F. (o Salvar
3808:     * limpa os flags no sucesso) e a retentativa viraria um UPDATE de um
3809:     * registro que o rollback apagou - UPDATE que afeta 0 linhas devolve
3810:     * sucesso e perderia o cadastro EM SILENCIO. Na ordem do legado o BO so
3811:     * muda de estado depois que tudo deu certo.
3812:     *
3813:     * A validacao do Nome fica FORA do TRY. Ela e a mesma do GetNome.Valid
3814:     * legado ("O Nome deve ser informado..."), que la retem o foco com
3815:     * "Return 0" e por isso impede o usuario de chegar ao Confirmar sem nome;
3816:     * aqui o LostFocus nao pode reter o foco (ver ValidarNomeLostFocus) e este
3817:     * e o ponto onde a gravacao e efetivamente recusada.
3818:     *===========================================================================
3819:     PROTECTED PROCEDURE GravarFicha()
3820:         LOCAL loc_lResultado, loc_lProsseguir, loc_oPg2, loc_cNome, loc_oBO
3821:         loc_lResultado  = .F.
3822:         loc_lProsseguir = .T.
3823: 
3824:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2

*-- Linhas 3842 a 3874:
3842:                 loc_lProsseguir = .F.
3843:             ENDIF
3844: 
3845:             *-- Fases primeiro (poDataMgr.Update('crSigCdDpr') do legado).
3846:             IF loc_lProsseguir
3847:                 IF !loc_oBO.GravarFases("cursor_4c_Fases", loc_cNome)
3848:                     IF !loc_oBO.this_lErroExibido
3849:                         MsgErro(IIF(EMPTY(ALLTRIM(loc_oBO.ObterMensagemErro())), ;
3850:                             "Favor Reinicializar o Processo!!!", ;
3851:                             ALLTRIM(loc_oBO.ObterMensagemErro())), ;
3852:                             "Falha ao gravar as fases")
3853:                     ENDIF
3854:                     loc_lProsseguir = .F.
3855:                 ENDIF
3856:             ENDIF
3857: 
3858:             *-- Mestre depois (mSv_Inserir / mSv_Alterar do frmcadastro).
3859:             *-- O BusinessBase.Salvar() escolhe INSERT ou UPDATE pelo
3860:             *-- this_lNovoRegistro e JA reporta toda falha (regra #20): o
3861:             *-- ELSE abaixo so cobre o caso de ele recusar sem exibir.
3862:             IF loc_lProsseguir
3863:                 IF !loc_oBO.Salvar()
3864:                     IF !loc_oBO.this_lErroExibido
3865:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
3866:                             "vel gravar o demonstrativo.", "Confirmar")
3867:                     ENDIF
3868:                     loc_lProsseguir = .F.
3869:                 ENDIF
3870:             ENDIF
3871: 
3872:             IF loc_lProsseguir
3873:                 IF THIS.ConfirmarTransacao()
3874:                     loc_lResultado = .T.

*-- Linhas 3911 a 3938:
3911:     *       Else
3912:     *           .plCancelar = .t.
3913:     *       EndIf
3914:     * e o ExcluiItens (DELETE das fases) no Salva.Click do SCX.
3915:     *
3916:     * DIVERGENCIA DELIBERADA NA ORDEM - a pergunta vem PRIMEIRO.
3917:     * No legado o Salva.Click do SCX executa o ExcluiItens (que tem
3918:     * SqlExecute + Commit PROPRIOS) ANTES de chamar o DoDefault() que
3919:     * pergunta: responder "Nao" ja chegava com as fases apagadas e
3920:     * COMMITADAS, e o RollBack do mAtivapagina1 nao as trazia de volta. E
3921:     * perda de dados silenciosa no caminho de CANCELAMENTO - reproduzi-la
3922:     * seria migrar um defeito destrutivo. Aqui nada e tocado antes do "Sim",
3923:     * e o DELETE das fases e o do mestre ficam sob o MESMO commit.
3924:     *
3925:     * MsgConfirma devolve LOGICO (.T./.F.), nunca 6 (regra #7).
3926:     *===========================================================================
3927:     PROTECTED PROCEDURE ExcluirFicha()
3928:         LOCAL loc_lResultado, loc_lProsseguir, loc_cNome, loc_oBO
3929:         loc_lResultado  = .F.
3930:         loc_lProsseguir = .T.
3931: 
3932:         loc_cNome = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Nome.Value)
3933: 
3934:         IF EMPTY(loc_cNome)
3935:             MsgAviso("A ficha n" + CHR(227) + "o tem nome de demonstrativo " + ;
3936:                 "para excluir.", "FormSigOpDmp")
3937:             RETURN .F.
3938:         ENDIF

*-- Linhas 3959 a 3977:
3959:                 loc_lProsseguir = .F.
3960:             ENDIF
3961: 
3962:             *-- mSv_Excluir: DELETE do mestre. O Excluir() do BusinessBase e
3963:             *-- PUBLIC e chama o ExecutarExclusao do BO (regra #51); ele ja
3964:             *-- reporta toda falha (regra #20).
3965:             IF loc_lProsseguir
3966:                 IF !loc_oBO.Excluir()
3967:                     IF !loc_oBO.this_lErroExibido
3968:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
3969:                             "vel excluir o demonstrativo.", "Confirmar")
3970:                     ENDIF
3971:                     loc_lProsseguir = .F.
3972:                 ENDIF
3973:             ENDIF
3974: 
3975:             IF loc_lProsseguir
3976:                 IF THIS.ConfirmarTransacao()
3977:                     loc_lResultado = .T.

*-- Linhas 4002 a 4034:
4002:     * ExecutarBuscaPorNome - PROCEDURE msv_procurar do legado
4003:     *
4004:     *   Set Near On
4005:     *   Select crSigPrDmo
4006:     *   Index On nome tag ix_Nome
4007:     *   Set Order To ix_nome
4008:     *   Seek ThisForm.pagina.dados.getNome.Value
4009:     *   Set Near Off
4010:     *
4011:     * SET NEAR ON e o que faz desta uma busca APROXIMADA: sem casamento
4012:     * exato o ponteiro para no registro mais proximo em vez de ir para EOF.
4013:     * Repor o SET anterior em vez de forcar OFF (o legado forca) porque
4014:     * SET NEAR e de sessao e esta tela nao tem data session privada - deixar
4015:     * o ambiente como estava e o que nao quebra quem chamou.
4016:     *
4017:     * ORDEM INVERTIDA EM RELACAO AO LEGADO, por necessidade: a volta para a
4018:     * pagina Lista vem ANTES do Seek. AlternarPagina(1) chama CarregarLista,
4019:     * que refaz o SELECT e RECRIA o cursor_4c_Dados - posicionar antes seria
4020:     * jogado fora na troca de pagina. No legado o mAtivapagina1 tambem faz
4021:     * ReQuery depois do msv_procurar, com o mesmo efeito de descartar a
4022:     * posicao; a ordem daqui e a unica em que o Procurar realmente posiciona
4023:     * a grade, que e o que o usuario pediu ao clicar no botao.
4024:     *===========================================================================
4025:     PROTECTED PROCEDURE ExecutarBuscaPorNome()
4026:         LOCAL loc_lResultado, loc_cNome, loc_oGrid, loc_nAliasAnt, loc_cNearAnt
4027:         loc_lResultado = .F.
4028: 
4029:         TRY
4030:             loc_cNome = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Nome.Value)
4031: 
4032:             THIS.AlternarPagina(1)
4033: 
4034:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

*-- Linhas 4040 a 4059:
4040:                 loc_lResultado = .T.
4041:             ELSE
4042:                 IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
4043:                     loc_nAliasAnt = SELECT(0)
4044:                     SELECT cursor_4c_Dados
4045: 
4046:                     *-- O Buscar do BO ja devolve ORDER BY nome, logo a ordem
4047:                     *-- visual da grade nao muda com este indice - ele existe
4048:                     *-- so para o SEEK, que exige tag ativa.
4049:                     INDEX ON nome TAG ix_nome
4050:                     SET ORDER TO ix_nome IN cursor_4c_Dados
4051: 
4052:                     loc_cNearAnt = SET("NEAR")
4053:                     SET NEAR ON
4054: 
4055:                     SEEK loc_cNome IN cursor_4c_Dados
4056: 
4057:                     IF loc_cNearAnt == "ON"
4058:                         SET NEAR ON
4059:                     ELSE

*-- Linhas 4068 a 4086:
4068:                         GO BOTTOM IN cursor_4c_Dados
4069:                     ENDIF
4070: 
4071:                     SELECT (loc_nAliasAnt)
4072: 
4073:                     *-- Mover o ponteiro NAO repinta a grade (regra #21).
4074:                     loc_oGrid.Refresh()
4075: 
4076:                     IF loc_oGrid.Enabled AND loc_oGrid.Visible
4077:                         loc_oGrid.SetFocus()
4078:                     ENDIF
4079: 
4080:                     loc_lResultado = .T.
4081:                 ELSE
4082:                     MsgAviso("Nenhum demonstrativo cadastrado.", "FormSigOpDmp")
4083:                 ENDIF
4084:             ENDIF
4085: 
4086:         CATCH TO loException


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


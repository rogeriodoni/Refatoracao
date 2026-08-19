# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (15)
- [GRID-SQL] Campo 'cpros' usado em ControlSource de cursor_4c_Itens mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'dpros' usado em ControlSource de cursor_4c_Itens mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'reffs' usado em ControlSource de cursor_4c_Itens mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'ean13' usado em ControlSource de cursor_4c_Itens mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'pcuss' usado em ControlSource de cursor_4c_Itens mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'moevs' usado em ControlSource de cursor_4c_Itens mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'pvens' usado em ControlSource de cursor_4c_Itens mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'vencfs' usado em ControlSource de cursor_4c_Itens mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'cgrus' usado em ControlSource de cursor_4c_Itens mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'precode' usado em ControlSource de cursor_4c_Itens mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CMOES, IFORS, CSTOTA, LPRECOS, TIPOS, VENCFS, I, EMPS, OPT_TIPO, LNCNT, COLECOES, LCDTF
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'FPAGS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CMOES, IFORS, CSTOTA, LPRECOS, TIPOS, VENCFS, I, EMPS, OPT_TIPO, LNCNT, COLECOES, LCDTF
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VENCIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CMOES, IFORS, CSTOTA, LPRECOS, TIPOS, VENCFS, I, EMPS, OPT_TIPO, LNCNT, COLECOES, LCDTF
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CMOES, IFORS, CSTOTA, LPRECOS, TIPOS, VENCFS, I, EMPS, OPT_TIPO, LNCNT, COLECOES, LCDTF
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CMOES, IFORS, CSTOTA, LPRECOS, TIPOS, VENCFS, I, EMPS, OPT_TIPO, LNCNT, COLECOES, LCDTF

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
Objeto: DELETE
  ControlSource = "crSigCdLpc.lprecos"
  ControlSource = "crSigCdLpc.fpags"
  ControlSource = "crSigCdLpc.nComiss"
  ControlSource = "crSigCdLpc.AplicTabDs"
  ControlSource = "crSigCdLpc.nVencs"
  ControlSource = "crSigCdLpc.Formulas"
  ControlSource = "crSigCdLpc.tabds"
  ControlSource = "crSigCdLpc.descos"
  ControlSource = "crSigCdLpc.Emps"
  ControlSource = "crSigCdLpc.Codigos"
  Name = "DELETE"
  ControlSource = "crSigCdLpc.contas"
  ControlSource = "crSigCdLpc.vencis"
  ControlSource = "crSigCdLpc.vencis"
lcQuery = [Select CustoFs, MoeCusFs, PVens, MoeVs ] + ;
		    [From SigCdPro ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalPro') < 1)
lcQuery = [Select CMoes, MoeQs, QtdEqs ] + ;
		    [From SigCdMoe ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMoe') < 1)
Select LocalMoe
If Seek(LocalPro.MoeCusFs, [LocalMoe], [CMoes]) And Not Empty(LocalMoe.MoeQs)
If Seek(LocalPro.MoeVs, [LocalMoe], [CMoes]) And Not Empty(LocalMoe.MoeQs)
lcUpdate = [Update SigCdPro Set MarkupA = ] + Str(lnMkp,12,3) + [ Where Cpros = '] + pPro + [']
If ThisForm.PodataMgr.SqlExecute(lcUpdate,'') < 1
lStrQuery = [Select flagctabs,cpros,dpros,pvens,precode,moevs,situas,cgrus,colecoes,linhas,Pcuss,Moecs,Reffs,Ean13 ]+;
			[From SigCdPro ]+;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
SELECT CrSigCdLpi
Select TmpPro
    Insert Into CrSigCdLpi From MemVar
	lcQuery = [Select a.Colecoes, b.AltProds ] + ;
				[From SigCdPro a, SigCdCol b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crBusCol]) < 1)
	Select crBusCol
	Select crOriginal
		Select crSigCdLpi
	Select crSigCdLpi
		Select crOriginal
	Select CrSigCdLpc
Select Count(1) As nTotal, lprecos From CrSigCdLpi Group By lprecos Into Cursor CsTotais
Select CrSigCdLpc
	.Column1.ControlSource = 'CrSigCdLpc.lprecos'
	.Column2.ControlSource = 'CsTotais.nTotal'
Insert Into CrSigCdLpi (lprecos, ordems) Values (CrSigCdLpc.lprecos,Chr(255))
Select CrSigCdLpi
lcQuery = [Select * From SigCdLpi Where lPrecos = ']+lcLprecos+[' Order by Cpros ]
If ThisForm.PodataMgr.SqlExecute(lcQuery,'TmplPrei') < 1
Select TmpLprei
Select tmplprei
	loBarraPrei.Update(.T.)
		lStrQuery = [Select a.Cpros,a.linhas,a.cgrus,a.situas,a.pesoms,b.tpvendas,c.dgrus,d.dcompos,a.figJpgs From SigCdPro a ]+;
					[Left Join SigCdLin b On b.linhas = a.linhas ]+;
					[Left Join SigCdGrp c On c.cgrus  = a.cgrus ]+;
					[Left Join SigPrCpo d On d.cpros = a.cpros ]+;
		lStrQuery = [Select cpros,cgrus,situas,figJpgs From SigCdPro ]+;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
	Select TmpPro
		Insert Into CsRelatorio From MemVar
	Select tmplprei
lcQryLPre  = [Select Distinct a.* From SigCdLpc a ]+;
             [Inner Join SigCdLpi b On a.lPrecos = b.Lprecos ]+;
			 [(Select Distinct c.lPrecos From SigCdLpc c Inner Join SigCdLpi d ]+;
lcQryLPrei = [Select * From SigCdLpi Where lprecos = ?lcLPrecos Order by cpros ]
If ThisForm.poDataMgr.SqlExecute([Select * From SigCdEmb ],'CrSigCdEmb') < 1
Select CrSigCdEmb
If ThisForm.poDataMgr.SqlExecute([Select tpinstalas, ncasas, GrPadFors From SigCdPam ],'CrSigCdPam') < 1
Select CrSigCdPam
Select CrSigCdLpc
	Select CrSigCdLpc
	Select crSigCdLpc
If Not ThisForm.poDataMgr.Update('CrSigCdLpi')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - CrSigCdLpi)')
	ThisForm.Updateok = .f.
If Not ThisForm.poDataMgr.Update('CrSigCdLpi')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - CrSigCdLpi)')
	ThisForm.Updateok = .f.
If Not ThisForm.poDataMgr.Update('CrSigCdLpi')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - CrSigCdLpi)')
	ThisForm.Updateok = .f.
Select crSigCdLpc
Select CrSigCdLpi
Update CrSigCdLpi Set vencis = Nvl(vencis,{}),;
	.Column1.ControlSource = 'CrSigCdLpi.cpros'
	.Column2.ControlSource = 'CrSigCdLpi.dpros'
	.Column3.ControlSource = 'CrSigCdLpi.pvens'
	.Column4.ControlSource = 'CrSigCdLpi.moevs'
	.Column5.ControlSource = 'CrSigCdLpi.comiss'
	.Column6.ControlSource = 'CrSigCdLpi.vencis'
	.Column7.ControlSource = 'CrSigCdLpi.vencfs'
	.Column8.ControlSource = 'CrSigCdLpi.ccontroles'
	.Column9.ControlSource = 'CrSigCdLpi.precode'
	.Column1.ControlSource = 'CrSigCdLpi.cpros'
	.Column2.ControlSource = 'CrSigCdLpi.dpros'
	.Column3.ControlSource = 'CrSigCdLpi.Reffs'
	.Column4.ControlSource = 'CrSigCdLpi.Ean13'
	.Column5.ControlSource = 'CrSigCdLpi.Pvens'
	.Column6.ControlSource = 'CrSigCdLpi.Moevs'
	.Column7.ControlSource = 'CrSigCdLpi.Pcuss'
			Select CrSigCdLpc
			Select CrSigCdLpi
			Select CrSigCdLpi
	.Delete.Visible    = llVisual And ThisForm.CompVenda # [C]
		Select * ;
		  From crSigCdLpi ;
		lcQuery = [Select lPrecos ] + ;
				    [From SigCdLpc ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)
		Select CrSigCdLpi
			Delete From CrSigCdLpi
		Select CrSigCdLpi
				Delete
		Count for ! Deleted() to lnQtdes 
		Select crSigCdLpc
	Select CPros ;
	  From crSigCdLpi ;
ThisForm.Updateok = .t.
If Not Thisform.Updateok 
Select CrSigCdLpc
Select CrSigCdLpi
	Select CsRelatorio
	Select CrSigCdEmb
			Select CrSigCdEmb
	Select CsRelatorio
	Select CsRelatorio
	Select CrSigCdEmb
			Select CrSigCdEmb
	Select CsRelatorio
lcquery = [Select * From SigCdLpi Where Lprecos = ']+CrSigCdLpc.Lprecos+[']
If ThisForm.PodataMgr.SqlExecute(lcQuery,'TmpLprei') < 1
Select VencFs ;
  From TmpLprei ;
Select TmpLpreI
	Select TmpLprei
			Select LocalPro
			Insert Into crSigCdPrc From MemVar
			Select LocalCompo
				Insert Into crSigPrCp2 From MemVar
		Select TmpLprei
			lcUpdate = [Update SigCdPro Set Pcuss = ] + Str(m.PCuss,15,3) + [, CustoFs = ]+STR(m.Pcuss,15,3)+[ Where Cpros = ']+m.Cpros+[']
			lcUpdate = [Update SigCdPro Set PVens = ] + Str(m.PVens,15,3) + [, PrecoDe = ] + Str(m.PrecoDe,15,3) + [ Where Cpros = '] + m.Cpros + [']
		If ThisForm.PodataMgr.SqlExecute(lcUpdate,'') < 1
		lcDelete = [Delete From SigPrPrt Where Cpros = '] + m.Cpros + [']
		If ThisForm.PodataMgr.SqlExecute(lcDelete,'') < 1
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão - Delete - SigPrPrt')
	lcUpdate = [Update SigCdLpc Set Flags = ?lcFlag Where Lprecos = ']+CrSigCdLpc.Lprecos+[']
	If ThisForm.PodataMgr.SqlExecute(lcUpdate,'') < 1
	If Not ThisForm.poDataMgr.Update('crSigCdPrc')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdPrc)')
	If Not ThisForm.poDataMgr.Update('crSigPrCp2')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPrCp2)')
	Select CrSigCdLpi
	Select CrSigCdLpi
	If Seek(This.Value,'CrSigCdLpi','dpros')
	Select CrSigCdLpi
		Select CrSigCdLpi
	Select CPros ;
	  From crSigCdLpi ;
	If Seek(This.Value,'CrSigCdLpi','dpros')
	If !Seek(lcGCPros,'CrSigCdLpi','CPros')
		Select CrSigCdLpc
Select crSigCdLpi
Update crSigCdLpi Set Vencfs = ldDat
		Select CrSigCdLpc
		Select CrSigCdLpi
			Select crSigCdLpi
			Delete
Select CrSigCdLpi
If !Seek(Space(14),'CrSigCdLpi','cpros')
	Insert Into CrSigCdLpi(lprecos,ordems,vencis,vencfs) ;
		Select CrSigCdLpc
updateok

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormLpr.prg) - TRECHOS RELEVANTES PARA PASS SQL (3398 linhas total):

*-- Linhas 38 a 56:
38:     this_cAntLPreco         = ""     && anti-bounce: ultimo lpreco validado
39:     this_nOldCasas          = 0      && backup de SET DECIMALS antes do form
40:     this_lPlCancelar        = .F.    && flag: usuario cancelou operacao
41:     this_lUpdateok          = .T.    && flag: ultima operacao Update foi bem-sucedida
42:     this_cNomeFrm           = ""     && identidade do form para DO FORM ... WITH
43:     this_cLprecosAtual      = ""     && lpreco selecionado na lista (para detalhe)
44: 
45:     *==========================================================================
46:     * Init - Inicializa o formulario
47:     * par_lCompra: .T. = modo compra, .F. ou omitido = modo venda
48:     * par_cNomeFrm: nome alternativo do form (usado em DO FORM ... WITH ThisForm)
49:     *==========================================================================
50:     PROCEDURE Init(par_lCompra, par_cNomeFrm)
51:         LOCAL loc_lResultado
52:         loc_lResultado = .F.
53: 
54:         TRY
55:             *-- Definir modo compra vs venda ANTES do DODEFAULT()
56:             IF VARTYPE(par_lCompra) = "L" AND par_lCompra

*-- Linhas 744 a 762:
744:             loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
745:             loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
746:             loc_oGrid.HighlightStyle    = 2
747:             loc_oGrid.DeleteMark        = .F.
748:             loc_oGrid.RecordMark        = .F.
749:             loc_oGrid.RowHeight         = 18
750:             loc_oGrid.ScrollBars        = 2
751:             loc_oGrid.ReadOnly          = .T.
752:             loc_oGrid.GridLines         = 3
753:             loc_oGrid.Visible           = .T.
754:             *-- ColumnCount FORA do WITH para criar colunas imediatamente
755:             loc_oGrid.ColumnCount       = 4
756:             WITH loc_oGrid
757:                 .Column1.Header1.Caption  = "Lista de Pre" + CHR(231) + "os"
758:                 .Column1.Width            = 250
759:                 .Column1.ReadOnly         = .T.
760:                 .Column2.Header1.Caption  = "Cond. Pagamento"
761:                 .Column2.Width            = 130
762:                 .Column2.ReadOnly         = .T.

*-- Linhas 1088 a 1117:
1088:             *----------------------------------------------------------------------
1089:             * grd_4c_GradeC - Grade modo COMPRA (7 colunas)
1090:             * top=184+29=213, left=8, width=982, height=293
1091:             * ControlSources sao vinculados em VincularGrade() quando cursor existe
1092:             *----------------------------------------------------------------------
1093:             loc_oPagina.AddObject("grd_4c_GradeC", "Grid")
1094:             WITH loc_oPagina.grd_4c_GradeC
1095:                 .Top          = 213
1096:                 .Left         = 8
1097:                 .Width        = 982
1098:                 .Height       = 293
1099:                 .ColumnCount  = 7
1100:                 .ReadOnly     = .F.
1101:                 .GridLines    = 1
1102:                 .DeleteMark   = .F.
1103:                 .RecordSource = ""
1104:                 .Visible      = .T.
1105:                 .FontName     = "Tahoma"
1106:                 .FontSize     = 8
1107:                 WITH .Column1
1108:                     .Width = 100
1109:                     .RecordMark   = .F.
1110:                 ENDWITH
1111:                 WITH .Column2
1112:                     .Width = 250
1113:                 ENDWITH
1114:                 WITH .Column3
1115:                     .Width = 130
1116:                 ENDWITH
1117:                 WITH .Column4

*-- Linhas 1141 a 1159:
1141:                 .ColumnCount  = 9
1142:                 .ReadOnly     = .F.
1143:                 .GridLines    = 1
1144:                 .DeleteMark   = .F.
1145:                 .RecordSource = ""
1146:                 .Visible      = .T.
1147:                 .FontName     = "Tahoma"
1148:                 .FontSize     = 8
1149:                 WITH .Column1
1150:                     .Width = 100
1151:                     .RecordMark   = .F.
1152:                 ENDWITH
1153:                 WITH .Column2
1154:                     .Width = 250
1155:                 ENDWITH
1156:                 WITH .Column3
1157:                     .Width = 90
1158:                 ENDWITH
1159:                 WITH .Column4

*-- Linhas 1178 a 1196:
1178: 
1179:             *----------------------------------------------------------------------
1180:             * Botoes de acao na grade (linha inferior: top=499+29=528)
1181:             * INSERE=left28, DELETE=left103, COPIA=left178, Seleciona=left253
1182:             * CmdVencimento=left328 - todos width=75, height=75
1183:             *----------------------------------------------------------------------
1184:             loc_oPagina.AddObject("cmd_4c_INSERE", "CommandButton")
1185:             WITH loc_oPagina.cmd_4c_INSERE
1186:                 .Caption         = "Inserir"
1187:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
1188:                 .PicturePosition = 13
1189:                 .Top             = 528
1190:                 .Left            = 28
1191:                 .Width           = 75
1192:                 .Height          = 75
1193:                 .FontName        = "Comic Sans MS"
1194:                 .FontSize        = 8
1195:                 .FontBold        = .T.
1196:                 .FontItalic      = .T.

*-- Linhas 1203 a 1222:
1203:                 .Visible         = .T.
1204:             ENDWITH
1205: 
1206:             loc_oPagina.AddObject("cmd_4c_DELETE", "CommandButton")
1207:             WITH loc_oPagina.cmd_4c_DELETE
1208:                 .Caption         = "Excluir"
1209:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1210:                 .PicturePosition = 13
1211:                 .Top             = 528
1212:                 .Left            = 103
1213:                 .Width           = 75
1214:                 .Height          = 75
1215:                 .FontName        = "Comic Sans MS"
1216:                 .FontSize        = 8
1217:                 .FontBold        = .T.
1218:                 .FontItalic      = .T.
1219:                 .ForeColor       = RGB(90, 90, 90)
1220:                 .Themes          = .F.
1221:                 .SpecialEffect   = 0
1222:                 .MousePointer    = 15

*-- Linhas 1630 a 1648:
1630:             * BINDEVENTs para controles adicionados na Fase 6
1631:             *----------------------------------------------------------------------
1632:             BINDEVENT(loc_oPagina.cmd_4c_INSERE,        "Click",            THIS, "BtnINSEREClick")
1633:             BINDEVENT(loc_oPagina.cmd_4c_DELETE,        "Click",            THIS, "BtnDELETEClick")
1634:             BINDEVENT(loc_oPagina.cmd_4c_COPIA,         "Click",            THIS, "BtnCOPIAClick")
1635:             BINDEVENT(loc_oPagina.cmd_4c_Seleciona,     "Click",            THIS, "BtnSelecionaClick")
1636:             BINDEVENT(loc_oPagina.cmd_4c_CmdVencimento, "Click",            THIS, "BtnCmdVencimentoClick")
1637:             BINDEVENT(loc_oPagina.cnt_4c_Vencimentos.cmd_4c_SalvaVenc, "Click", THIS, "BtnSalvaVencimentoClick")
1638:             BINDEVENT(loc_oPagina.cnt_4c_Vencimentos.cmd_4c_FechaVenc, "Click", THIS, "BtnFechaVencimentoClick")
1639:             BINDEVENT(loc_oPagina.cmd_4c_SelecionaC,   "Click",            THIS, "BtnSelecionaCClick")
1640:             BINDEVENT(loc_oPagina.grd_4c_Grade,  "AfterRowColChange", THIS, "GradeAfterRowColChange")
1641:             BINDEVENT(loc_oPagina.grd_4c_GradeC, "AfterRowColChange", THIS, "GradeAfterRowColChange")
1642:             BINDEVENT(loc_oPagina.txt_4c_Tabd, "KeyPress", THIS, "ValidarTabd")
1643:             BINDEVENT(loc_oPagina.txt_4c_Tabd, "KeyPress",  THIS, "TeclaTabd")
1644:             BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetConta,  "KeyPress", THIS, "ValidarGetConta")
1645:             BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetConta,  "KeyPress",  THIS, "TeclaGetConta")
1646:             BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetDconta, "KeyPress", THIS, "ValidarGetDconta")
1647:             BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetDconta, "KeyPress",  THIS, "TeclaGetDconta")
1648: 

*-- Linhas 1685 a 1705:
1685:         TRY
1686:             THIS.FormParaBO()
1687:             IF THIS.this_oBusinessObject.Salvar()
1688:                 LOCAL loc_cLprecoSalvo
1689:                 loc_cLprecoSalvo = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
1690:                 IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0
1691:                     IF THIS.this_oBusinessObject.SalvarItens(loc_cLprecoSalvo)
1692:                         MsgInfo("Lista salva com sucesso!", "")
1693:                         THIS.AlternarPagina(1)
1694:                     ELSE
1695:                         MsgErro("Cabe" + CHR(231) + "alho salvo mas houve erro ao salvar itens.", "Aviso")
1696:                     ENDIF
1697:                 ELSE
1698:                     MsgInfo("Lista salva com sucesso!", "")
1699:                     THIS.AlternarPagina(1)
1700:                 ENDIF
1701:             ENDIF
1702:         CATCH TO loException
1703:             MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, "FormLpr.BtnSalvarClick")
1704:         ENDTRY
1705:     ENDPROC

*-- Linhas 1733 a 1753:
1733:             ELSE
1734:                 *-- Verificar se empresa existe em SigCdEmp
1735:                 LOCAL loc_cSQL
1736:                 loc_cSQL = "SELECT TOP 1 CEmps FROM SigCdEmp WHERE CEmps = " + ;
1737:                            EscaparSQL(loc_cEmps)
1738:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldEmps")
1739:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldEmps") = 0
1740:                     MsgErro("Empresa [" + loc_cEmps + "] n" + CHR(227) + "o encontrada!", "Aviso")
1741:                     loc_oPg2.txt_4c_Emps.Value = ALLTRIM(go_4c_Sistema.cCodEmpresa)
1742:                 ENDIF
1743:                 IF USED("cursor_4c_VldEmps")
1744:                     USE IN cursor_4c_VldEmps
1745:                 ENDIF
1746:             ENDIF
1747: 
1748:         CATCH TO loException
1749:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarEmpresa")
1750:         ENDTRY
1751:     ENDPROC
1752: 
1753:     *==========================================================================

*-- Linhas 1769 a 1789:
1769:             IF THIS.this_cPcEscolha = "INSERIR"
1770:                 *-- Verificar duplicata
1771:                 LOCAL loc_cSQL2
1772:                 loc_cSQL2 = "SELECT TOP 1 lprecos FROM SigCdLpc WHERE lprecos = " + ;
1773:                             EscaparSQL(loc_cLpreco)
1774:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL2, "cursor_4c_VldLpr")
1775:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldLpr") > 0
1776:                     MsgErro("Lista de Pre" + CHR(231) + "o [" + loc_cLpreco + ;
1777:                         "] j" + CHR(225) + " cadastrada!", "Aviso")
1778:                     loc_oPg2.txt_4c_Lpreco.Value = THIS.this_cAntLPreco
1779:                 ENDIF
1780:                 IF USED("cursor_4c_VldLpr")
1781:                     USE IN cursor_4c_VldLpr
1782:                 ENDIF
1783:             ELSE
1784:                 IF THIS.this_cPcEscolha = "PROCURAR"
1785:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLpreco)
1786:                     THIS.BOParaForm()
1787:                 ELSE
1788:                     MsgAviso("Lista [" + loc_cLpreco + "] n" + CHR(227) + ;
1789:                         "o encontrada!", "Aviso")

*-- Linhas 1814 a 1834:
1814:         TRY
1815:             LOCAL loc_oBusca, loc_cSQL3
1816:             *-- Verificar se fpag existe
1817:             loc_cSQL3 = "SELECT TOP 1 fpags FROM SigOpFp WHERE fpags = " + EscaparSQL(loc_cFpg)
1818:             LOCAL loc_nRes
1819:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL3, "cursor_4c_BuscaFpg")
1820:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_BuscaFpg") = 0
1821:                 *-- Nao encontrou exato - abrir lookup
1822:                 IF USED("cursor_4c_BuscaFpg")
1823:                     USE IN cursor_4c_BuscaFpg
1824:                 ENDIF
1825:                 THIS.AbrirBuscaFpg(loc_cFpg)
1826:             ELSE
1827:                 IF USED("cursor_4c_BuscaFpg")
1828:                     USE IN cursor_4c_BuscaFpg
1829:                 ENDIF
1830:             ENDIF
1831: 
1832:         CATCH TO loException
1833:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarFpg")
1834:         ENDTRY

*-- Linhas 1854 a 1872:
1854:                 ENDIF
1855: 
1856:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
1857:                     SELECT cursor_4c_BuscaFpg
1858:                     loc_oPg2.txt_4c_Fpg.Value = ALLTRIM(cursor_4c_BuscaFpg.fpags)
1859:                 ELSE
1860:                     IF !loc_oBusca.this_lAchouRegistro
1861:                         loc_oPg2.txt_4c_Fpg.Value = ""
1862:                     ENDIF
1863:                 ENDIF
1864:                 loc_oBusca.Release()
1865:             ENDIF
1866: 
1867:             IF USED("cursor_4c_BuscaFpg")
1868:                 USE IN cursor_4c_BuscaFpg
1869:             ENDIF
1870: 
1871:         CATCH TO loException
1872:             MsgErro("Erro: " + loException.Message, "FormLpr.AbrirBuscaFpg")

*-- Linhas 1900 a 1918:
1900:                 ENDIF
1901: 
1902:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1903:                     SELECT cursor_4c_BuscaProd
1904:                     loc_oPg2.txt_4c_Txtcpros.Value = ALLTRIM(cursor_4c_BuscaProd.cpros)
1905:                     loc_oPg2.txt_4c_Txtdpros.Value = ALLTRIM(cursor_4c_BuscaProd.dpros)
1906:                     THIS.this_cAntCPro = ALLTRIM(cursor_4c_BuscaProd.cpros)
1907:                     THIS.this_cAntDPro = ALLTRIM(cursor_4c_BuscaProd.dpros)
1908:                 ELSE
1909:                     IF !loc_oBusca.this_lAchouRegistro
1910:                         loc_oPg2.txt_4c_Txtcpros.Value = ""
1911:                         loc_oPg2.txt_4c_Txtdpros.Value = ""
1912:                         THIS.this_cAntCPro = ""
1913:                         THIS.this_cAntDPro = ""
1914:                     ENDIF
1915:                 ENDIF
1916:                 loc_oBusca.Release()
1917:             ENDIF
1918: 

*-- Linhas 1956 a 2009:
1956:                 ENDIF
1957: 
1958:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1959:                     SELECT cursor_4c_BuscaProd
1960:                     loc_oPg2.txt_4c_Txtdpros.Value = ALLTRIM(cursor_4c_BuscaProd.dpros)
1961:                     loc_oPg2.txt_4c_Txtcpros.Value = ALLTRIM(cursor_4c_BuscaProd.cpros)
1962:                     THIS.this_cAntDPro = ALLTRIM(cursor_4c_BuscaProd.dpros)
1963:                     THIS.this_cAntCPro = ALLTRIM(cursor_4c_BuscaProd.cpros)
1964:                 ELSE
1965:                     IF !loc_oBusca.this_lAchouRegistro
1966:                         loc_oPg2.txt_4c_Txtdpros.Value = ""
1967:                         THIS.this_cAntDPro = ""
1968:                     ENDIF
1969:                 ENDIF
1970:                 loc_oBusca.Release()
1971:             ENDIF
1972: 
1973:             IF USED("cursor_4c_BuscaProd")
1974:                 USE IN cursor_4c_BuscaProd
1975:             ENDIF
1976: 
1977:         CATCH TO loException
1978:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarDpros")
1979:         ENDTRY
1980:     ENDPROC
1981: 
1982:     *==========================================================================
1983:     * BtnBuscaGradeClick - Click do botao Busca na area de pesquisa da grade
1984:     * Busca no cursor de itens (cursor_4c_Itens) pelo cpros digitado e
1985:     * posiciona o foco na grade (grade sera vinculada na Fase 6)
1986:     *==========================================================================
1987:     PROCEDURE BtnBuscaGradeClick()
1988:         LOCAL loc_oPg2, loc_cCpros
1989:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1990:         loc_cCpros = ALLTRIM(loc_oPg2.txt_4c_Txtcpros.Value)
1991: 
1992:         TRY
1993:             IF USED("cursor_4c_Itens")
1994:                 SELECT cursor_4c_Itens
1995:                 SET NEAR ON
1996:                 IF !EMPTY(loc_cCpros)
1997:                     SEEK PADR(loc_cCpros, 14) ORDER "cpros"
1998:                 ENDIF
1999:                 SET NEAR OFF
2000: 
2001:                 *-- Tentar focar na grade de itens (adicionada na Fase 6)
2002:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5)
2003:                     loc_oPg2.grd_4c_Grade.Column1.SetFocus()
2004:                 ELSE
2005:                     IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5)
2006:                     loc_oPg2.grd_4c_GradeC.Column1.SetFocus()
2007:                     ENDIF
2008:                 ENDIF
2009:             ENDIF

*-- Linhas 2102 a 2230:
2102:             *-- Verificar se a lista ja foi publicada (flags=1)
2103:             IF THIS.this_cPcEscolha = "ALTERAR" AND ;
2104:                USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2105:                 SELECT cursor_4c_Dados
2106:                 loc_lFlags = (TratarNulo(cursor_4c_Dados.flags, "N") = 1)
2107:             ENDIF
2108: 
2109:             *-- Emps: editavel apenas em INSERIR e quando nao flags
2110:             loc_oPg2.txt_4c_Emps.ReadOnly   = !(par_lHabilitar AND !loc_lFlags)
2111:             *-- Lpreco: editavel apenas em INSERIR (nao pode mudar PK em ALTERAR)
2112:             loc_oPg2.txt_4c_Lpreco.ReadOnly = !(par_lHabilitar AND THIS.this_cPcEscolha = "INSERIR")
2113:             *-- Fpg: editavel em INSERIR e ALTERAR (quando nao flags)
2114:             loc_oPg2.txt_4c_Fpg.ReadOnly    = !(par_lHabilitar AND !loc_lFlags)
2115:             *-- Campos de busca na grade: sempre editaveis quando ha lista selecionada
2116:             loc_oPg2.txt_4c_Txtcpros.ReadOnly = !par_lHabilitar
2117:             loc_oPg2.txt_4c_Txtdpros.ReadOnly = !par_lHabilitar
2118:             *-- Botoes acao
2119:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
2120:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2121: 
2122:         CATCH TO loException
2123:             MsgErro("Erro: " + loException.Message, "FormLpr.HabilitarCampos")
2124:         ENDTRY
2125:     ENDPROC
2126: 
2127:     *==========================================================================
2128:     * CarregarItens - Carrega SigCdLpi no cursor_4c_Itens e vincula grids
2129:     * par_cLprecos: codigo da lista; vazio = nova lista (cursor nao carregado)
2130:     *==========================================================================
2131:     PROTECTED PROCEDURE CarregarItens(par_cLprecos)
2132:         LOCAL loc_lSucesso
2133:         loc_lSucesso = .F.
2134: 
2135:         TRY
2136:             IF USED("cursor_4c_Itens")
2137:                 USE IN cursor_4c_Itens
2138:             ENDIF
2139: 
2140:             IF !EMPTY(ALLTRIM(par_cLprecos))
2141:                 loc_lSucesso = THIS.this_oBusinessObject.CarregarItens(par_cLprecos, THIS.this_cCompVenda)
2142:             ENDIF
2143: 
2144:             IF loc_lSucesso AND USED("cursor_4c_Itens")
2145:                 *-- Criar indice para SEEK em BtnBuscaGradeClick
2146:                 SELECT cursor_4c_Itens
2147:                 INDEX ON PADR(cpros, 14) TAG cpros ADDITIVE
2148:                 GO TOP
2149:             ENDIF
2150: 
2151:             THIS.VincularGrade()
2152: 
2153:         CATCH TO loException
2154:             MsgErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "FormLpr.CarregarItens")
2155:         ENDTRY
2156:     ENDPROC
2157: 
2158:     *==========================================================================
2159:     * VincularGrade - Define RecordSource, ControlSources e Headers dos grids
2160:     * Exibe grd_4c_GradeC em modo compra; grd_4c_Grade em modo venda
2161:     *==========================================================================
2162:     PROTECTED PROCEDURE VincularGrade()
2163:         LOCAL loc_oPg2, loc_lModoCompra, loc_oGrid
2164:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
2165:         loc_lModoCompra = (THIS.this_cCompVenda = "C")
2166: 
2167:         TRY
2168:             IF loc_lModoCompra
2169:                 *-- Modo compra: grd_4c_GradeC visivel, grd_4c_Grade oculta
2170:                 IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5)
2171:                     loc_oGrid = loc_oPg2.grd_4c_GradeC
2172:                     IF USED("cursor_4c_Itens")
2173:                         loc_oGrid.ColumnCount = 7
2174:                         loc_oGrid.RecordSource         = "cursor_4c_Itens"
2175:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Itens.cpros"
2176:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Itens.dpros"
2177:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Itens.reffs"
2178:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Itens.ean13"
2179:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Itens.pcuss"
2180:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Itens.moevs"
2181:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Itens.pvens"
2182:                     ELSE
2183:                         loc_oGrid.RecordSource = ""
2184:                     ENDIF
2185:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
2186:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
2187:                     loc_oGrid.Column3.Header1.Caption = "Ref.Fornecedor"
2188:                     loc_oGrid.Column4.Header1.Caption = "EAN"
2189:                     loc_oGrid.Column5.Header1.Caption = "Custo Atual"
2190:                     loc_oGrid.Column6.Header1.Caption = "Moe"
2191:                     loc_oGrid.Column7.Header1.Caption = "Custo Novo"
2192:                     loc_oGrid.FontName = "Verdana"
2193:                     loc_oGrid.FontSize = 8
2194:                     loc_oGrid.Visible = .T.
2195:                     loc_oGrid.Refresh()
2196:                 ENDIF
2197:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5)
2198:                     loc_oPg2.grd_4c_Grade.Visible = .F.
2199:                 ENDIF
2200:             ELSE
2201:                 *-- Modo venda: grd_4c_Grade visivel, grd_4c_GradeC oculta
2202:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5)
2203:                     loc_oGrid = loc_oPg2.grd_4c_Grade
2204:                     IF USED("cursor_4c_Itens")
2205:                         loc_oGrid.ColumnCount = 9
2206:                         loc_oGrid.RecordSource         = "cursor_4c_Itens"
2207:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Itens.cpros"
2208:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Itens.dpros"
2209:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Itens.pvens"
2210:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Itens.moevs"
2211:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Itens.comiss"
2212:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Itens.vencis"
2213:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Itens.vencfs"
2214:                         loc_oGrid.Column8.ControlSource = "cursor_4c_Itens.cgrus"
2215:                         loc_oGrid.Column9.ControlSource = "cursor_4c_Itens.precode"
2216:                     ELSE
2217:                         loc_oGrid.RecordSource = ""
2218:                     ENDIF
2219:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
2220:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
2221:                     loc_oGrid.Column3.Header1.Caption = "Pr. Venda"
2222:                     loc_oGrid.Column4.Header1.Caption = "Moe"
2223:                     loc_oGrid.Column5.Header1.Caption = "Comiss."
2224:                     loc_oGrid.Column6.Header1.Caption = "Venc. Inicial"
2225:                     loc_oGrid.Column7.Header1.Caption = "Venc. Final"
2226:                     loc_oGrid.Column8.Header1.Caption = "C"
2227:                     loc_oGrid.Column9.Header1.Caption = "Pr. De"
2228:                     loc_oGrid.FontName = "Verdana"
2229:                     loc_oGrid.FontSize = 8
2230:                     loc_oGrid.Visible = .T.

*-- Linhas 2252 a 2376:
2252:             MsgAviso("Salve o cabe" + CHR(231) + "alho da lista antes de inserir itens.", "Aviso")
2253:             RETURN
2254:         ENDIF
2255: 
2256:         TRY
2257:             IF !USED("cursor_4c_Itens")
2258:                 CREATE CURSOR cursor_4c_Itens (cidchaves c(20), lprecos c(30), ;
2259:                     cpros c(14), dpros c(40), reffs c(20), ean13 n(13,0), ;
2260:                     pcuss n(16,6), moevs c(3), pvens n(16,6), vencis d, ;
2261:                     vencfs d, comiss n(7,4), cgrus c(3), flagutabs n(1,0), ;
2262:                     ordems c(11), ccontroles c(30), precode n(16,6))
2263:             ENDIF
2264: 
2265:             SELECT cursor_4c_Itens
2266:             SET FILTER TO
2267:             INSERT INTO cursor_4c_Itens (lprecos, ordems) VALUES (loc_cLpreco, CHR(255))
2268:             SET FILTER TO !DELETED("cursor_4c_Itens")
2269: 
2270:             THIS.VincularGrade()
2271: 
2272:             SELECT cursor_4c_Itens
2273:             GO BOTTOM
2274: 
2275:             IF THIS.this_cCompVenda = "C" AND PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5) ;
2276:                     AND loc_oPg2.grd_4c_GradeC.Visible
2277:                 loc_oPg2.grd_4c_GradeC.Column1.SetFocus()
2278:             ELSE
2279:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5) AND loc_oPg2.grd_4c_Grade.Visible
2280:                 loc_oPg2.grd_4c_Grade.Column1.SetFocus()
2281:                 ENDIF
2282:             ENDIF
2283: 
2284:         CATCH TO loException
2285:             MsgErro("Erro ao inserir item:" + CHR(13) + loException.Message, "FormLpr.BtnINSEREClick")
2286:         ENDTRY
2287:     ENDPROC
2288: 
2289:     *==========================================================================
2290:     * BtnDELETEClick - Marca item atual como excluido no cursor de itens
2291:     *==========================================================================
2292:     PROCEDURE BtnDELETEClick()
2293:         LOCAL loc_oPg2
2294:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2295: 
2296:         TRY
2297:             IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0 AND ;
2298:                !EOF("cursor_4c_Itens") AND !BOF("cursor_4c_Itens")
2299:                 IF MsgConfirma("Confirma exclus" + CHR(227) + "o do item?", "Confirmar")
2300:                     SELECT cursor_4c_Itens
2301:                     IF !DELETED()
2302:                         DELETE
2303:                         SET FILTER TO !DELETED("cursor_4c_Itens")
2304:                         GO TOP
2305:                     ENDIF
2306:                     IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5) AND loc_oPg2.grd_4c_Grade.Visible
2307:                         loc_oPg2.grd_4c_Grade.Refresh()
2308:                     ENDIF
2309:                     IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5) AND loc_oPg2.grd_4c_GradeC.Visible
2310:                         loc_oPg2.grd_4c_GradeC.Refresh()
2311:                     ENDIF
2312:                 ENDIF
2313:             ELSE
2314:                 MsgAviso("Nenhum item selecionado para excluir.", "Aviso")
2315:             ENDIF
2316:         CATCH TO loException
2317:             MsgErro("Erro ao excluir item:" + CHR(13) + loException.Message, "FormLpr.BtnDELETEClick")
2318:         ENDTRY
2319:     ENDPROC
2320: 
2321:     *==========================================================================
2322:     * BtnCOPIAClick - Duplica o item atual no cursor de itens
2323:     *==========================================================================
2324:     PROCEDURE BtnCOPIAClick()
2325:         LOCAL loc_oPg2, loc_cLpreco
2326:         LOCAL loc_cCpros, loc_cDpros, loc_cMoevs, loc_cCgrus, loc_cReffs
2327:         LOCAL loc_nPvens, loc_nComiss, loc_nEan13, loc_nPcuss, loc_nPrecode
2328:         LOCAL loc_dVencis, loc_dVencfs
2329:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2330:         loc_cLpreco = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
2331: 
2332:         TRY
2333:             IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0 AND ;
2334:                !EOF("cursor_4c_Itens") AND !BOF("cursor_4c_Itens")
2335:                 SELECT cursor_4c_Itens
2336:                 loc_cCpros   = ALLTRIM(TratarNulo(cpros,   "C"))
2337:                 loc_cDpros   = ALLTRIM(TratarNulo(dpros,   "C"))
2338:                 loc_cMoevs   = ALLTRIM(TratarNulo(moevs,   "C"))
2339:                 loc_cCgrus   = ALLTRIM(TratarNulo(cgrus,   "C"))
2340:                 loc_cReffs   = ALLTRIM(TratarNulo(reffs,   "C"))
2341:                 loc_nPvens   = TratarNulo(pvens,   "N")
2342:                 loc_nComiss  = TratarNulo(comiss,  "N")
2343:                 loc_nEan13   = TratarNulo(ean13,   "N")
2344:                 loc_nPcuss   = TratarNulo(pcuss,   "N")
2345:                 loc_nPrecode = TratarNulo(precode, "N")
2346:                 loc_dVencis  = TratarNulo(vencis,  "D")
2347:                 loc_dVencfs  = TratarNulo(vencfs,  "D")
2348: 
2349:                 SET FILTER TO
2350:                 INSERT INTO cursor_4c_Itens ;
2351:                     (lprecos, cpros, dpros, moevs, cgrus, reffs, pvens, comiss, ;
2352:                      ean13, pcuss, precode, vencis, vencfs, ordems) ;
2353:                     VALUES (loc_cLpreco, loc_cCpros, loc_cDpros, loc_cMoevs, ;
2354:                             loc_cCgrus, loc_cReffs, loc_nPvens, loc_nComiss, ;
2355:                             loc_nEan13, loc_nPcuss, loc_nPrecode, loc_dVencis, ;
2356:                             loc_dVencfs, CHR(255))
2357:                 SET FILTER TO !DELETED("cursor_4c_Itens")
2358: 
2359:                 THIS.VincularGrade()
2360: 
2361:                 SELECT cursor_4c_Itens
2362:                 GO BOTTOM
2363:             ELSE
2364:                 MsgAviso("Nenhum item selecionado para duplicar.", "Aviso")
2365:             ENDIF
2366:         CATCH TO loException
2367:             MsgErro("Erro ao duplicar item:" + CHR(13) + loException.Message, "FormLpr.BtnCOPIAClick")
2368:         ENDTRY
2369:     ENDPROC
2370: 
2371:     *==========================================================================
2372:     * BtnSelecionaClick - Abre browser de produtos para adicionar item a lista
2373:     *==========================================================================
2374:     PROCEDURE BtnSelecionaClick()
2375:         LOCAL loc_oPg2, loc_oBusca, loc_nResult, loc_cSQL, loc_cLpreco
2376:         LOCAL loc_cCpros, loc_cDpros, loc_nPvens, loc_nPcuss, loc_cMoevs

*-- Linhas 2384 a 2441:
2384:         ENDIF
2385: 
2386:         TRY
2387:             loc_cSQL = "SELECT TOP 500 cpros, dpros, pvens, pcuss, moevs, cgrus, reffs, ean13" + ;
2388:                        " FROM SigCdPro ORDER BY cpros"
2389:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProd")
2390: 
2391:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaProd") > 0
2392:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2393:                 IF VARTYPE(loc_oBusca) = "O"
2394:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaProd", "cpros", "dpros", ;
2395:                         "Selecionar Produto")
2396:                     loc_oBusca.Mostrar()
2397: 
2398:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
2399:                         SELECT cursor_4c_BuscaProd
2400:                         loc_cCpros  = ALLTRIM(cursor_4c_BuscaProd.cpros)
2401:                         loc_cDpros  = ALLTRIM(cursor_4c_BuscaProd.dpros)
2402:                         loc_nPvens  = TratarNulo(cursor_4c_BuscaProd.pvens,  "N")
2403:                         loc_nPcuss  = TratarNulo(cursor_4c_BuscaProd.pcuss,  "N")
2404:                         loc_cMoevs  = ALLTRIM(TratarNulo(cursor_4c_BuscaProd.moevs, "C"))
2405:                         loc_cCgrus  = ALLTRIM(TratarNulo(cursor_4c_BuscaProd.cgrus, "C"))
2406:                         loc_cReffs  = ALLTRIM(TratarNulo(cursor_4c_BuscaProd.reffs, "C"))
2407:                         loc_nEan13  = TratarNulo(cursor_4c_BuscaProd.ean13,  "N")
2408: 
2409:                         IF !USED("cursor_4c_Itens")
2410:                             CREATE CURSOR cursor_4c_Itens (cidchaves c(20), lprecos c(30), ;
2411:                                 cpros c(14), dpros c(40), reffs c(20), ean13 n(13,0), ;
2412:                                 pcuss n(16,6), moevs c(3), pvens n(16,6), vencis d, ;
2413:                                 vencfs d, comiss n(7,4), cgrus c(3), flagutabs n(1,0), ;
2414:                                 ordems c(11), ccontroles c(30), precode n(16,6))
2415:                         ENDIF
2416: 
2417:                         SELECT cursor_4c_Itens
2418:                         SET FILTER TO
2419:                         INSERT INTO cursor_4c_Itens ;
2420:                             (lprecos, cpros, dpros, moevs, cgrus, reffs, ean13, ordems, ;
2421:                              pvens, pcuss) ;
2422:                             VALUES (loc_cLpreco, loc_cCpros, loc_cDpros, loc_cMoevs, ;
2423:                                     loc_cCgrus, loc_cReffs, loc_nEan13, CHR(255), ;
2424:                                     IIF(THIS.this_cCompVenda = "C", loc_nPcuss, loc_nPvens), ;
2425:                                     loc_nPcuss)
2426:                         SET FILTER TO !DELETED("cursor_4c_Itens")
2427:                         GO BOTTOM
2428: 
2429:                         THIS.VincularGrade()
2430:                     ENDIF
2431:                     loc_oBusca.Release()
2432:                 ENDIF
2433:             ELSE
2434:                 MsgAviso("Nenhum produto encontrado.", "Aviso")
2435:             ENDIF
2436: 
2437:             IF USED("cursor_4c_BuscaProd")
2438:                 USE IN cursor_4c_BuscaProd
2439:             ENDIF
2440: 
2441:         CATCH TO loException

*-- Linhas 2477 a 2506:
2477:                 loc_dVenc = loc_oPg2.cnt_4c_Vencimentos.txt_4c_GetVencs.Value
2478:             ELSE
2479:                 loc_dVenc = DATE()
2480:             ENDIF
2481: 
2482:             IF USED("cursor_4c_Itens") AND VARTYPE(loc_dVenc) = "D" AND !EMPTY(loc_dVenc)
2483:                 SELECT cursor_4c_Itens
2484:                 SET FILTER TO
2485:                 GO TOP
2486:                 SCAN
2487:                     IF !DELETED()
2488:                         REPLACE vencis WITH loc_dVenc
2489:                     ENDIF
2490:                 ENDSCAN
2491:                 SET FILTER TO !DELETED("cursor_4c_Itens")
2492:                 GO TOP
2493:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5) AND loc_oPg2.grd_4c_Grade.Visible
2494:                     loc_oPg2.grd_4c_Grade.Refresh()
2495:                 ENDIF
2496:                 IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5) AND loc_oPg2.grd_4c_GradeC.Visible
2497:                     loc_oPg2.grd_4c_GradeC.Refresh()
2498:                 ENDIF
2499:             ENDIF
2500: 
2501:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Vencimentos", 5)
2502:                 loc_oPg2.cnt_4c_Vencimentos.Visible = .F.
2503:             ENDIF
2504: 
2505:         CATCH TO loException
2506:             MsgErro("Erro ao aplicar vencimento:" + CHR(13) + loException.Message, "FormLpr.BtnSalvaVencimentoClick")

*-- Linhas 2537 a 2579:
2537:         LOCAL loc_cCpros, loc_nResult, loc_cSQL, loc_lContinuar
2538:         loc_cCpros     = ""
2539:         loc_lContinuar = .T.
2540: 
2541:         TRY
2542:             IF par_nColIndex = 1 AND USED("cursor_4c_Itens") AND ;
2543:                !EOF("cursor_4c_Itens") AND !BOF("cursor_4c_Itens")
2544:                 SELECT cursor_4c_Itens
2545:                 loc_cCpros = ALLTRIM(TratarNulo(cpros, "C"))
2546: 
2547:                 IF !EMPTY(loc_cCpros)
2548:                     *-- Verificar grupo em modo venda (bloqueado para certos grupos)
2549:                     IF THIS.this_cCompVenda <> "C"
2550:                         IF !THIS.this_oBusinessObject.ChecaGrpVenda(loc_cCpros)
2551:                             SELECT cursor_4c_Itens
2552:                             REPLACE cpros WITH "", dpros WITH ""
2553:                             loc_lContinuar = .F.
2554:                         ENDIF
2555:                     ENDIF
2556: 
2557:                     IF loc_lContinuar
2558:                         *-- Buscar produto no catalogo e pre-preencher campos da linha
2559:                         loc_cSQL = "SELECT cpros, dpros, pvens, pcuss, moevs, cgrus, reffs, ean13" + ;
2560:                                    " FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
2561:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldPro")
2562: 
2563:                         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldPro") > 0
2564:                             SELECT cursor_4c_Itens
2565:                             REPLACE dpros WITH ALLTRIM(cursor_4c_VldPro.dpros)
2566:                             IF EMPTY(ALLTRIM(TratarNulo(moevs, "C")))
2567:                                 REPLACE moevs WITH ALLTRIM(cursor_4c_VldPro.moevs)
2568:                             ENDIF
2569:                             IF EMPTY(ALLTRIM(TratarNulo(cgrus, "C")))
2570:                                 REPLACE cgrus WITH ALLTRIM(cursor_4c_VldPro.cgrus)
2571:                             ENDIF
2572:                             IF THIS.this_cCompVenda = "C"
2573:                                 *-- Modo compra: custo atual + reffs + ean
2574:                                 IF TratarNulo(pcuss, "N") = 0
2575:                                     REPLACE pcuss WITH TratarNulo(cursor_4c_VldPro.pcuss, "N")
2576:                                 ENDIF
2577:                                 IF EMPTY(ALLTRIM(TratarNulo(reffs, "C")))
2578:                                     REPLACE reffs WITH ALLTRIM(cursor_4c_VldPro.reffs)
2579:                                 ENDIF

*-- Linhas 2585 a 2605:
2585:                                 IF TratarNulo(pvens, "N") = 0
2586:                                     REPLACE pvens WITH TratarNulo(cursor_4c_VldPro.pvens, "N")
2587:                                 ENDIF
2588:                             ENDIF
2589:                         ELSE
2590:                             SELECT cursor_4c_Itens
2591:                             REPLACE dpros WITH ""
2592:                         ENDIF
2593: 
2594:                         IF USED("cursor_4c_VldPro")
2595:                             USE IN cursor_4c_VldPro
2596:                         ENDIF
2597:                     ENDIF
2598:                 ENDIF
2599:             ENDIF
2600: 
2601:         CATCH TO loException
2602:             MsgErro("Erro na grade (col " + TRANSFORM(par_nColIndex) + "):" + ;
2603:                     CHR(13) + loException.Message, "FormLpr.GradeAfterRowColChange")
2604:         ENDTRY
2605:     ENDPROC

*-- Linhas 2625 a 2665:
2625:                     ENDIF
2626: 
2627:                     IF USED("cursor_4c_Dados")
2628:                         SELECT cursor_4c_Dados
2629:                         DO CASE
2630:                             CASE loc_nFiltroVenc = 2
2631:                                 SET FILTER TO vencis >= DATE()
2632:                             CASE loc_nFiltroVenc = 3
2633:                                 SET FILTER TO !EMPTY(vencis) AND vencis < DATE()
2634:                             OTHERWISE
2635:                                 SET FILTER TO
2636:                         ENDCASE
2637:                         GO TOP
2638:                     ENDIF
2639: 
2640:                     *-- Vincular grid: RecordSource -> ControlSources -> Headers
2641:                     *   VFP9 sobrescreve ControlSources e Headers ao trocar RecordSource
2642:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
2643:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2644:                         IF USED("cursor_4c_Dados")
2645:                             loc_oGrid.ColumnCount = 4
2646:                             loc_oGrid.RecordSource = "cursor_4c_Dados"
2647:                             loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.lprecos"
2648:                             loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.fpags"
2649:                             loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.vencis"
2650:                             loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.flags"
2651:                             loc_oGrid.Column1.Header1.Caption = "Lista de Pre" + CHR(231) + "os"
2652:                             loc_oGrid.Column2.Header1.Caption = "Cond. Pagamento"
2653:                             loc_oGrid.Column3.Header1.Caption = "Vencimento"
2654:                             loc_oGrid.Column4.Header1.Caption = "Atualizada"
2655:                             THIS.FormatarGridLista(loc_oGrid)
2656:                             loc_oGrid.Refresh()
2657:                         ENDIF
2658:                     ENDIF
2659: 
2660:                     loc_lResultado = .T.
2661:                 ELSE
2662:                     loc_lResultado = .F.
2663:                 ENDIF
2664:             ENDIF
2665: 

*-- Linhas 2777 a 2795:
2777:         TRY
2778:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
2779:                !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
2780:                 SELECT cursor_4c_Dados
2781:                 loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
2782:                 loc_lOk = .T.
2783:             ENDIF
2784: 
2785:             IF loc_lOk AND !EMPTY(loc_cLprecos)
2786:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLprecos)
2787:                     THIS.this_cPcEscolha    = "PROCURAR"
2788:                     THIS.this_cLprecosAtual = loc_cLprecos
2789:                     THIS.AlternarPagina(2)
2790:                 ENDIF
2791:             ELSE
2792:                 MsgAviso("Selecione uma lista de pre" + CHR(231) + "os!", "Aviso")
2793:             ENDIF
2794:         CATCH TO loException
2795:             MsgErro("Erro ao visualizar:" + CHR(13) + loException.Message, "FormLpr.BtnVisualizarClick")

*-- Linhas 2810 a 2828:
2810:         TRY
2811:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
2812:                !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
2813:                 SELECT cursor_4c_Dados
2814:                 loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
2815:                 loc_nFlags   = TratarNulo(cursor_4c_Dados.flags, "N")
2816:                 loc_lOk = .T.
2817:             ENDIF
2818: 
2819:             IF loc_lOk AND !EMPTY(loc_cLprecos)
2820:                 IF loc_nFlags = 1
2821:                     loc_lProsseguir = MsgConfirma("Esta lista j" + CHR(225) + ;
2822:                         " foi atualizada no sistema." + CHR(13) + ;
2823:                         "Deseja alterar mesmo assim?", "Aten" + CHR(231) + CHR(227) + "o")
2824:                 ENDIF
2825: 
2826:                 IF loc_lProsseguir
2827:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLprecos)
2828:                         THIS.this_cPcEscolha    = "ALTERAR"

*-- Linhas 2851 a 2869:
2851:         TRY
2852:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
2853:                !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
2854:                 SELECT cursor_4c_Dados
2855:                 loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
2856:                 loc_nFlags   = TratarNulo(cursor_4c_Dados.flags, "N")
2857:                 loc_lOk = .T.
2858:             ENDIF
2859: 
2860:             IF loc_lOk AND !EMPTY(loc_cLprecos)
2861:                 IF loc_nFlags = 1
2862:                     MsgErro("Lista j" + CHR(225) + " atualizada no sistema." + CHR(13) + ;
2863:                             "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
2864:                             "vel excluir!", "Aviso")
2865:                 ELSE
2866:                     IF MsgConfirma("Confirma exclus" + CHR(227) + "o da lista [" + ;
2867:                                    loc_cLprecos + "]?", "Confirmar")
2868:                         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLprecos)
2869:                             IF THIS.this_oBusinessObject.Excluir()

*-- Linhas 2917 a 2935:
2917:         TRY
2918:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
2919:                !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
2920:                 SELECT cursor_4c_Dados
2921:                 loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
2922:                 loc_nFlags   = TratarNulo(cursor_4c_Dados.flags, "N")
2923:                 loc_lOk = .T.
2924:             ENDIF
2925: 
2926:             IF loc_lOk AND !EMPTY(loc_cLprecos)
2927:                 IF loc_nFlags = 1
2928:                     loc_lProsseguir = MsgConfirma("Lista j" + CHR(225) + ;
2929:                         " atualizada no sistema." + CHR(13) + ;
2930:                         "Deseja atualizar novamente?", "Confirmar")
2931:                 ENDIF
2932: 
2933:                 IF loc_lProsseguir
2934:                     IF THIS.this_oBusinessObject.AtualizarFlags(loc_cLprecos)
2935:                         MsgInfo("Lista [" + loc_cLprecos + "] atualizada com sucesso!", "")

*-- Linhas 2993 a 3022:
2993:                     loc_cFiltroTipo = ""
2994:             ENDCASE
2995: 
2996:             loc_cSQL = "SELECT b.lprecos, b.fpags, b.vencis AS vencis_lista," + ;
2997:                        " b.flags, b.tipos," + ;
2998:                        " a.cpros, a.dpros, a.pvens, a.pcuss, a.moevs," + ;
2999:                        " a.comiss, a.vencis AS vencis_item, a.vencfs," + ;
3000:                        " a.cgrus, a.ean13, a.reffs, a.ordems, a.precode" + ;
3001:                        " FROM SigCdLpi a" + ;
3002:                        " INNER JOIN SigCdLpc b ON a.lprecos = b.lprecos" + ;
3003:                        " WHERE b.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
3004:                        loc_cFiltroTipo + ;
3005:                        " ORDER BY b.lprecos, a.ordems, a.cpros"
3006: 
3007:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Relatorio")
3008:             IF loc_nResult >= 0
3009:                 GO TOP IN cursor_4c_Relatorio
3010:                 loc_lSucesso = .T.
3011:             ELSE
3012:                 MsgErro("Erro ao montar relat" + CHR(243) + "rio:" + CHR(13) + ;
3013:                         CapturarErroSQL(), "Erro SQL")
3014:             ENDIF
3015:         CATCH TO loException
3016:             MsgErro("Erro ao montar relat" + CHR(243) + "rio:" + CHR(13) + ;
3017:                     loException.Message, "FormLpr.MontarRelatorio")
3018:         ENDTRY
3019: 
3020:         RETURN loc_lSucesso
3021:     ENDFUNC
3022: 

*-- Linhas 3070 a 3088:
3070: 
3071:             IF THIS.MontarRelatorio(loc_nTipo)
3072:                 IF USED("cursor_4c_Relatorio")
3073:                     SELECT cursor_4c_Relatorio
3074:                     COPY TO (loc_cArquivo) TYPE XL5
3075:                     MsgInfo("Arquivo exportado:" + CHR(13) + loc_cArquivo, "")
3076:                 ENDIF
3077:             ENDIF
3078:         CATCH TO loException
3079:             MsgErro("Erro ao exportar Excel:" + CHR(13) + loException.Message, "FormLpr.BtnImpExcelClick")
3080:         ENDTRY
3081:     ENDPROC
3082: 
3083:     *==========================================================================
3084:     * BtnImpFecharClick - Oculta o painel de impressao cnt_4c_ImpLista
3085:     *==========================================================================
3086:     PROCEDURE BtnImpFecharClick()
3087:         TRY
3088:             THIS.pgf_4c_Paginas.Page1.cnt_4c_ImpLista.Visible = .F.

*-- Linhas 3106 a 3125:
3106: 
3107:         TRY
3108:             LOCAL loc_cSQL
3109:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigOpTdz WHERE codigos = " + EscaparSQL(loc_cTabd)
3110:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaTabd")
3111:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaTabd") = 0
3112:                 IF USED("cursor_4c_BuscaTabd")
3113:                     USE IN cursor_4c_BuscaTabd
3114:                 ENDIF
3115:                 THIS.AbrirBuscaTabd()
3116:             ELSE
3117:                 IF USED("cursor_4c_BuscaTabd")
3118:                     USE IN cursor_4c_BuscaTabd
3119:                 ENDIF
3120:             ENDIF
3121:         CATCH TO loException
3122:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarTabd")
3123:         ENDTRY
3124:     ENDPROC
3125: 

*-- Linhas 3144 a 3162:
3144:                 ENDIF
3145: 
3146:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTabd")
3147:                     SELECT cursor_4c_BuscaTabd
3148:                     loc_oPg2.txt_4c_Tabd.Value = ALLTRIM(cursor_4c_BuscaTabd.codigos)
3149:                 ELSE
3150:                     IF !loc_oBusca.this_lAchouRegistro
3151:                         loc_oPg2.txt_4c_Tabd.Value = ""
3152:                     ENDIF
3153:                 ENDIF
3154:                 loc_oBusca.Release()
3155:             ENDIF
3156: 
3157:             IF USED("cursor_4c_BuscaTabd")
3158:                 USE IN cursor_4c_BuscaTabd
3159:             ENDIF
3160: 
3161:         CATCH TO loException
3162:             MsgErro("Erro: " + loException.Message, "FormLpr.AbrirBuscaTabd")

*-- Linhas 3194 a 3215:
3194: 
3195:         TRY
3196:             LOCAL loc_cSQL
3197:             loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta)
3198:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaForns")
3199:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaForns") > 0
3200:                 SELECT cursor_4c_BuscaForns
3201:                 loc_oCnt.txt_4c_GetDconta.Value = ALLTRIM(cursor_4c_BuscaForns.rclis)
3202:             ELSE
3203:                 IF USED("cursor_4c_BuscaForns")
3204:                     USE IN cursor_4c_BuscaForns
3205:                 ENDIF
3206:                 THIS.AbrirBuscaGetConta()
3207:             ENDIF
3208:             IF USED("cursor_4c_BuscaForns")
3209:                 USE IN cursor_4c_BuscaForns
3210:             ENDIF
3211:         CATCH TO loException
3212:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarGetConta")
3213:         ENDTRY
3214:     ENDPROC
3215: 

*-- Linhas 3236 a 3254:
3236:                 ENDIF
3237: 
3238:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaForns")
3239:                     SELECT cursor_4c_BuscaForns
3240:                     loc_oCnt.txt_4c_GetConta.Value  = ALLTRIM(cursor_4c_BuscaForns.iclis)
3241:                     loc_oCnt.txt_4c_GetDconta.Value = ALLTRIM(cursor_4c_BuscaForns.rclis)
3242:                 ELSE
3243:                     IF !loc_oBusca.this_lAchouRegistro
3244:                         loc_oCnt.txt_4c_GetConta.Value  = ""
3245:                         loc_oCnt.txt_4c_GetDconta.Value = ""
3246:                     ENDIF
3247:                 ENDIF
3248:                 loc_oBusca.Release()
3249:             ENDIF
3250: 
3251:             IF USED("cursor_4c_BuscaForns")
3252:                 USE IN cursor_4c_BuscaForns
3253:             ENDIF
3254: 

*-- Linhas 3317 a 3335:
3317:                 ENDIF
3318: 
3319:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaForns")
3320:                     SELECT cursor_4c_BuscaForns
3321:                     loc_oCnt.txt_4c_GetConta.Value  = ALLTRIM(cursor_4c_BuscaForns.iclis)
3322:                     loc_oCnt.txt_4c_GetDconta.Value = ALLTRIM(cursor_4c_BuscaForns.rclis)
3323:                 ELSE
3324:                     IF !loc_oBusca.this_lAchouRegistro
3325:                         loc_oCnt.txt_4c_GetDconta.Value = ""
3326:                     ENDIF
3327:                 ENDIF
3328:                 loc_oBusca.Release()
3329:             ENDIF
3330: 
3331:             IF USED("cursor_4c_BuscaForns")
3332:                 USE IN cursor_4c_BuscaForns
3333:             ENDIF
3334: 
3335:         CATCH TO loException

*-- Linhas 3364 a 3388:
3364: 
3365:             *-- Fechar cursores de trabalho
3366:             IF USED("cursor_4c_Dados")
3367:                 USE IN cursor_4c_Dados
3368:             ENDIF
3369:             IF USED("cursor_4c_Itens")
3370:                 USE IN cursor_4c_Itens
3371:             ENDIF
3372:             IF USED("cursor_4c_ItensCopia")
3373:                 USE IN cursor_4c_ItensCopia
3374:             ENDIF
3375:             IF USED("cursor_4c_BuscaProd")
3376:                 USE IN cursor_4c_BuscaProd
3377:             ENDIF
3378:             IF USED("cursor_4c_BuscaMoe")
3379:                 USE IN cursor_4c_BuscaMoe
3380:             ENDIF
3381:             IF USED("cursor_4c_BuscaFpg")
3382:                 USE IN cursor_4c_BuscaFpg
3383:             ENDIF
3384:             IF USED("cursor_4c_BuscaTabd")
3385:                 USE IN cursor_4c_BuscaTabd
3386:             ENDIF
3387:             IF USED("cursor_4c_Relatorio")
3388:                 USE IN cursor_4c_Relatorio


### BO (C:\4c\projeto\app\classes\LprBO.prg):
*------------------------------------------------------------------------------
* LprBO.prg - Business Object para Listas de Precificacao
* Tabela principal: SigCdLpc (cabecalho da lista)
* Tabela detalhe  : SigCdLpi (itens da lista)
* Herda de        : BusinessBase
*------------------------------------------------------------------------------

DEFINE CLASS LprBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades SigCdLpc - campo a campo conforme schema.sql
    *--------------------------------------------------------------------------
    this_cLprecos    = ""    && c(30) PK  - codigo da lista de precos
    this_cFpags      = ""    && c(12)     - condicao de pagamento (FK SigOpFp)
    this_nFormulas   = 0     && n(1,0)    - tipo formula de calculo
    this_nComiss     = 0     && n(1,0)    - tipo calculo comissao
    this_nNvencs     = 0     && n(1,0)    - tipo vencimento
    this_cContas     = ""    && c(10)     - conta (modo compra: fornecedor)
    this_lFlags      = .F.   && bit       - ja atualizada no sistema
    this_cTipos      = ""    && c(1)      - tipo: "C"=compra, " "=venda
    this_dVencis     = {}    && datetime  - data vencimento inicial
    this_nAplictabds = 0     && n(1,0)    - aplica tabela de desconto
    this_cCidchaves  = ""    && c(20)     - chave unica
    this_nDescos     = 0     && n(5,2)    - percentual de desconto
    this_cTabds      = ""    && c(10)     - codigo tabela desconto (FK SigOpTdz)
    this_nCodigos    = 0     && n(6,0)    - codigo sequencial (gerado por fGerUniqueKey)
    this_cEmps       = ""    && c(3)      - empresa (FK SigCdEmp)
    this_nNqtdes     = 0     && n(5,0)    - quantidade minima

    *--------------------------------------------------------------------------
    * Propriedades auxiliares - descricoes (nao persistidas no banco)
    *--------------------------------------------------------------------------
    this_cDfpags     = ""    && descricao da condicao de pagamento
    this_cDtabds     = ""    && descricao da tabela de desconto
    this_cDemps      = ""    && razao social da empresa
    this_cDcontas    = ""    && descricao da conta (modo compra)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdLpc"
        THIS.this_cCampoChave = "lprecos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cLprecos
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista cabecalhos SigCdLpc filtrados por empresa e tipo
    * par_cFiltro: "C"=compra, " "=venda (vazio = venda)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cTipos
        loc_lSucesso = .F.

        TRY
            loc_cTipos = IIF(VARTYPE(par_cFiltro) = "C" AND ALLTRIM(par_cFiltro) = "C", "C", " ")

            loc_cSQL = "SELECT DISTINCT a.lprecos, a.fpags, a.formulas, a.ncomiss," + ;
                       " a.nvencs, a.contas, a.flags, a.tipos, a.vencis," + ;
                       " a.aplictabds, a.cidchaves, a.descos, a.tabds," + ;
                       " a.codigos, a.emps, a.nqtdes" + ;
                       " FROM SigCdLpc a" + ;
                       " INNER JOIN SigCdLpi b ON a.lprecos = b.lprecos" + ;
                       " WHERE a.Tipos = " + EscaparSQL(loc_cTipos) + ;
                       " AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " ORDER BY a.lprecos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar listas de precifica" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar listas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um SigCdLpc pela PK lprecos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cLprecos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.lprecos, a.fpags, a.formulas, a.ncomiss," + ;
                       " a.nvencs, a.contas, a.flags, a.tipos, a.vencis," + ;
                       " a.aplictabds, a.cidchaves, a.descos, a.tabds," + ;
                       " a.codigos, a.emps, a.nqtdes" + ;
                       " FROM SigCdLpc a" + ;
                       " WHERE a.lprecos = " + EscaparSQL(par_cLprecos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cLprecos     = TratarNulo(lprecos,     "C")
            THIS.this_cFpags       = TratarNulo(fpags,       "C")
            THIS.this_nFormulas    = TratarNulo(formulas,    "N")
            THIS.this_nComiss      = TratarNulo(ncomiss,     "N")
            THIS.this_nNvencs      = TratarNulo(nvencs,      "N")
            THIS.this_cContas      = TratarNulo(contas,      "C")
            THIS.this_lFlags       = (TratarNulo(flags, "N") = 1)
            THIS.this_cTipos       = TratarNulo(tipos,       "C")
            THIS.this_dVencis      = TratarNulo(vencis,      "D")
            THIS.this_nAplictabds  = TratarNulo(aplictabds,  "N")
            THIS.this_cCidchaves   = TratarNulo(cidchaves,   "C")
            THIS.this_nDescos      = TratarNulo(descos,      "N")
            THIS.this_cTabds       = TratarNulo(tabds,       "C")
            THIS.this_nCodigos     = TratarNulo(codigos,     "N")
            THIS.this_cEmps        = TratarNulo(emps,        "C")
            THIS.this_nNqtdes      = TratarNulo(nqtdes,      "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdLpc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdLpc" + ;
                       " (lprecos, fpags, formulas, ncomiss, nvencs, contas," + ;
                       " flags, tipos, vencis, aplictabds, cidchaves, descos," + ;
                       " tabds, codigos, emps, nqtdes)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cLprecos) + "," + ;
                       EscaparSQL(THIS.this_cFpags) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFormulas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nComiss) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNvencs) + "," + ;
                       EscaparSQL(THIS.this_cContas) + "," + ;
                       IIF(THIS.this_lFlags, "1", "0") + "," + ;
                       EscaparSQL(THIS.this_cTipos) + "," + ;
                       FormatarDataSQL(THIS.this_dVencis) + "," + ;
                       FormatarNumeroSQL(THIS.this_nAplictabds) + "," + ;
                       EscaparSQL(THIS.this_cCidchaves) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDescos) + "," + ;
                       EscaparSQL(THIS.this_cTabds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
                       EscaparSQL(THIS.this_cEmps) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNqtdes) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir lista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdLpc (lprecos eh PK, nao alterar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdLpc SET" + ;
                       " fpags = " + EscaparSQL(THIS.this_cFpags) + "," + ;
                       " formulas = " + FormatarNumeroSQL(THIS.this_nFormulas) + "," + ;
                       " ncomiss = " + FormatarNumeroSQL(THIS.this_nComiss) + "," + ;
                       " nvencs = " + FormatarNumeroSQL(THIS.this_nNvencs) + "," + ;
                       " contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " flags = " + IIF(THIS.this_lFlags, "1", "0") + "," + ;
                       " tipos = " + EscaparSQL(THIS.this_cTipos) + "," + ;
                       " vencis = " + FormatarDataSQL(THIS.this_dVencis) + "," + ;
                       " aplictabds = " + FormatarNumeroSQL(THIS.this_nAplictabds) + "," + ;
                       " descos = " + FormatarNumeroSQL(THIS.this_nDescos) + "," + ;
                       " tabds = " + EscaparSQL(THIS.this_cTabds) + "," + ;
                       " codigos = " + FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
                       " emps = " + EscaparSQL(THIS.this_cEmps) + "," + ;
                       " nqtdes = " + FormatarNumeroSQL(THIS.this_nNqtdes) + ;
                       " WHERE lprecos = " + EscaparSQL(THIS.this_cLprecos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar lista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdLpi (itens) e SigCdLpc (cabecalho)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir itens primeiro (FK)
            loc_cSQL = "DELETE FROM SigCdLpi WHERE lprecos = " + ;
                       EscaparSQL(THIS.this_cLprecos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir cabecalho
                loc_cSQL = "DELETE FROM SigCdLpc WHERE lprecos = " + ;
                           EscaparSQL(THIS.this_cLprecos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir lista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItens - Carrega SigCdLpi de uma lista no cursor_4c_Itens
    * par_cLprecos: codigo da lista de precos
    * par_cTipos  : "C"=compra, " "=venda (determina colunas do grid)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens(par_cLprecos, par_cTipos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cLprecos))
            RETURN .F.
        ENDIF

        TRY

            IF VARTYPE(par_cTipos) != "C"
                par_cTipos = " "
            ENDIF

            IF ALLTRIM(par_cTipos) = "C"
                *-- Modo compra: colunas cpros, dpros, reffs, ean13, pcuss, moevs + custo novo
                loc_cSQL = "SELECT a.cidchaves, a.lprecos, a.cpros, a.dpros," + ;
                           " a.reffs, a.ean13, a.pcuss, a.moevs," + ;
                           " a.pvens, a.vencis, a.vencfs, a.comiss," + ;
                           " a.cgrus, a.flagutabs, a.ordems, a.ccontroles, a.precode" + ;
                           " FROM SigCdLpi a" + ;
                           " WHERE a.lprecos = " + EscaparSQL(par_cLprecos) + ;
                           " ORDER BY a.cpros"
            ELSE
                *-- Modo venda: colunas cpros, dpros, pvens, moevs, comiss, vencis, vencfs
                loc_cSQL = "SELECT a.cidchaves, a.lprecos, a.cpros, a.dpros," + ;
                           " a.pvens, a.moevs, a.comiss, a.vencis, a.vencfs," + ;
                           " a.cgrus, a.flagutabs, a.ordems, a.ccontroles," + ;
                           " a.ean13, a.pcuss, a.reffs, a.precode" + ;
                           " FROM SigCdLpi a" + ;
                           " WHERE a.lprecos = " + EscaparSQL(par_cLprecos) + ;
                           " ORDER BY a.cpros"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")
            IF loc_nResultado >= 0
                GO TOP IN cursor_4c_Itens
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar itens:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarItens - Persiste cursor_4c_Itens no SQL Server via DELETE+INSERT
    * par_cLprecos: codigo da lista de precos
    * Estrategia: DELETE todos do lprecos + INSERT dos nao-deletados do cursor
    *--------------------------------------------------------------------------
    PROCEDURE SalvarItens(par_cLprecos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lErroItem
        LOCAL loc_cCidchave, loc_cCpros, loc_cDpros, loc_cMoevs
        LOCAL loc_nPvens, loc_nComiss, loc_dVencis, loc_dVencfs
        LOCAL loc_cCgrus, loc_cReffs, loc_nEan13, loc_nPcuss
        LOCAL loc_nPrecode, loc_cOrdems
        loc_lSucesso = .F.
        loc_lErroItem = .F.

        IF !USED("cursor_4c_Itens")
            RETURN .F.
        ENDIF

        TRY
            *-- Excluir todos os itens existentes para este lprecos
            loc_cSQL = "DELETE FROM SigCdLpi WHERE lprecos = " + EscaparSQL(par_cLprecos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao limpar itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Inserir todos os itens nao-deletados do cursor
                SELECT cursor_4c_Itens
                GO TOP
                DO WHILE !EOF("cursor_4c_Itens") AND !loc_lErroItem
                    IF !DELETED("cursor_4c_Itens")
                        loc_cCpros   = ALLTRIM(TratarNulo(cpros,  "C"))
                        loc_cDpros   = ALLTRIM(TratarNulo(dpros,  "C"))
                        loc_cMoevs   = ALLTRIM(TratarNulo(moevs,  "C"))
                        loc_nPvens   = TratarNulo(pvens,   "N")
                        loc_nComiss  = TratarNulo(comiss,  "N")
                        loc_dVencis  = TratarNulo(vencis,  "D")
                        loc_dVencfs  = TratarNulo(vencfs,  "D")
                        loc_cCgrus   = ALLTRIM(TratarNulo(cgrus,  "C"))
                        loc_cReffs   = ALLTRIM(TratarNulo(reffs,  "C"))
                        loc_nEan13   = TratarNulo(ean13,   "N")
                        loc_nPcuss   = TratarNulo(pcuss,   "N")
                        loc_nPrecode = TratarNulo(precode, "N")
                        loc_cOrdems  = ALLTRIM(TratarNulo(ordems, "C"))

                        *-- Gerar cidchaves unico se vazio
                        loc_cCidchave = ALLTRIM(TratarNulo(cidchaves, "C"))
                        IF EMPTY(loc_cCidchave)
                            loc_cCidchave = THIS.GerarCidchave()
                        ENDIF

                        IF !EMPTY(loc_cCpros)
                            loc_cSQL = "INSERT INTO SigCdLpi" + ;
                                       " (cidchaves, lprecos, cpros, dpros, moevs," + ;
                                       " pvens, comiss, vencis, vencfs, cgrus," + ;
                                       " reffs, ean13, pcuss, precode, ordems," + ;
                                       " flagutabs, ccontroles)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cCidchave) + "," + ;
                                       EscaparSQL(par_cLprecos) + "," + ;
                                       EscaparSQL(loc_cCpros) + "," + ;
                                       EscaparSQL(loc_cDpros) + "," + ;
                                       EscaparSQL(loc_cMoevs) + "," + ;
                                       FormatarNumeroSQL(loc_nPvens) + "," + ;
                                       FormatarNumeroSQL(loc_nComiss) + "," + ;
                                       FormatarDataSQL(loc_dVencis) + "," + ;
                                       FormatarDataSQL(loc_dVencfs) + "," + ;
                                       EscaparSQL(loc_cCgrus) + "," + ;
                                       EscaparSQL(loc_cReffs) + "," + ;
                                       FormatarNumeroSQL(loc_nEan13) + "," + ;
                                       FormatarNumeroSQL(loc_nPcuss) + "," + ;
                                       FormatarNumeroSQL(loc_nPrecode) + "," + ;
                                       EscaparSQL(loc_cOrdems) + "," + ;
                                       "0,'')"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado < 0
                                MsgErro("Erro ao inserir item [" + loc_cCpros + "]:" + ;
                                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lErroItem = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_Itens
                    SKIP
                ENDDO

                IF !loc_lErroItem
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar itens:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCidchave - Gera chave unica para SigCdLpi.cidchaves (char 20)
    * Formato: emps(3) + lprecos(8) + cpros(5) + seq(4)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarCidchave()
        LOCAL loc_cChave, loc_nSeq, loc_cSQL, loc_nResult
        loc_nSeq = 0

        TRY
            loc_cSQL = "SELECT COUNT(1) AS nTotal FROM SigCdLpi" + ;
                       " WHERE lprecos = " + EscaparSQL(THIS.this_cLprecos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Seq")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_Seq")
                loc_nSeq = TratarNulo(cursor_4c_Seq.nTotal, "N")
            ENDIF
            IF USED("cursor_4c_Seq")
                USE IN cursor_4c_Seq
            ENDIF
        CATCH TO loc_oErro
            *-- ignorar, loc_nSeq = 0
        ENDTRY

        loc_cChave = PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3) + ;
                     PADR(LEFT(ALLTRIM(THIS.this_cLprecos), 8), 8) + ;
                     TRANSFORM(DATETIME(), "YYYYMMDDHHMMSS")
        loc_cChave = LEFT(ALLTRIM(loc_cChave) + TRANSFORM(loc_nSeq), 20)

        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * ChecaGrpVenda - Verifica se produto pertence a grupo permitido para venda
    * Consulta SigCdPam.GrPadFors para obter grupo padrao e valida no produto
    * Retorna .T. se pode alterar preco, .F. se grupo bloqueado
    *--------------------------------------------------------------------------
    PROCEDURE ChecaGrpVenda(par_cCpros)
        LOCAL loc_cSQL, loc_nResult, loc_lPode, loc_cGrPadFors, loc_cCgrus
        loc_lPode = .T.

        TRY
            *-- Ler grupo padrao de fornecedores em SigCdPam
            loc_cSQL = "SELECT GrPadFors FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_Pam") AND !EMPTY(ALLTRIM(cursor_4c_Pam.GrPadFors))
                loc_cGrPadFors = ALLTRIM(cursor_4c_Pam.GrPadFors)
            ELSE
                loc_cGrPadFors = ""
            ENDIF
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            IF EMPTY(loc_cGrPadFors) OR EMPTY(ALLTRIM(par_cCpros))
                loc_lPode = .T.
            ELSE
                *-- Verificar grupo do produto
                loc_cSQL = "SELECT cgrus FROM SigCdPro WHERE cpros = " + EscaparSQL(par_cCpros)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pro")
                IF loc_nResult >= 0 AND !EOF("cursor_4c_Pro")
                    loc_cCgrus = ALLTRIM(cursor_4c_Pro.cgrus)
                    IF loc_cCgrus = loc_cGrPadFors
                        MsgAviso("Produto do grupo " + loc_cGrPadFors + " n" + CHR(227) + "o pode ter pre" + ;
                                 CHR(231) + "o alterado nesta lista!", "Aviso")
                        loc_lPode = .F.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Pro")
                    USE IN cursor_4c_Pro
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lPode
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarFlags - Marca SigCdLpc.flags=1 (lista atualizada no sistema)
    * e persiste os itens de SigCdLpi via SalvarItens
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarFlags(par_cLprecos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdLpc SET flags = 1" + ;
                       " WHERE lprecos = " + EscaparSQL(par_cLprecos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.this_lFlags = .T.
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar flags:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar flags:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlterarVencimentos - Altera vencfs de todos os itens de uma lista
    * Equivalente ao cmdSalva do cntVencimentos no legado
    *--------------------------------------------------------------------------
    PROCEDURE AlterarVencimentos(par_cLprecos, par_dVencfs)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(par_dVencfs)
            MsgErro("Data de vencimento inv" + CHR(225) + "lida!", "Aviso")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdLpi SET vencfs = " + FormatarDataSQL(par_dVencfs) + ;
                       " WHERE lprecos = " + EscaparSQL(par_cLprecos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
                MsgInfo("Vencimentos alterados para " + DTOC(par_dVencfs) + "!", "")
            ELSE
                MsgErro("Erro ao alterar vencimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao alterar vencimentos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE


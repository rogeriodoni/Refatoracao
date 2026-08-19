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

### FORM (C:\4c\projeto\app\forms\cadastros\FormLpr.prg) - TRECHOS RELEVANTES PARA PASS SQL (3490 linhas total):

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
1193:                 .FontName        = "Tahoma"
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
1215:                 .FontName        = "Tahoma"
1216:                 .FontSize        = 8
1217:                 .FontBold        = .T.
1218:                 .FontItalic      = .T.
1219:                 .ForeColor       = RGB(90, 90, 90)
1220:                 .Themes          = .F.
1221:                 .SpecialEffect   = 0
1222:                 .MousePointer    = 15

*-- Linhas 1662 a 1680:
1662:             * BINDEVENTs para controles adicionados na Fase 6
1663:             *----------------------------------------------------------------------
1664:             BINDEVENT(loc_oPagina.cmd_4c_INSERE,        "Click",            THIS, "BtnINSEREClick")
1665:             BINDEVENT(loc_oPagina.cmd_4c_DELETE,        "Click",            THIS, "BtnDELETEClick")
1666:             BINDEVENT(loc_oPagina.cmd_4c_COPIA,         "Click",            THIS, "BtnCOPIAClick")
1667:             BINDEVENT(loc_oPagina.cmd_4c_Seleciona,     "Click",            THIS, "BtnSelecionaClick")
1668:             BINDEVENT(loc_oPagina.cmd_4c_CmdVencimento, "Click",            THIS, "BtnCmdVencimentoClick")
1669:             BINDEVENT(loc_oPagina.cnt_4c_Vencimentos.cmd_4c_SalvaVenc, "Click", THIS, "BtnSalvaVencimentoClick")
1670:             BINDEVENT(loc_oPagina.cnt_4c_Vencimentos.cmd_4c_FechaVenc, "Click", THIS, "BtnFechaVencimentoClick")
1671:             BINDEVENT(loc_oPagina.cmd_4c_SelecionaC,   "Click",            THIS, "BtnSelecionaCClick")
1672:             BINDEVENT(loc_oPagina.grd_4c_Grade,  "AfterRowColChange", THIS, "GradeAfterRowColChange")
1673:             BINDEVENT(loc_oPagina.grd_4c_GradeC, "AfterRowColChange", THIS, "GradeAfterRowColChange")
1674:             BINDEVENT(loc_oPagina.txt_4c_Tabd, "KeyPress", THIS, "ValidarTabd")
1675:             BINDEVENT(loc_oPagina.txt_4c_Tabd, "KeyPress",  THIS, "TeclaTabd")
1676:             BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetConta,  "KeyPress", THIS, "ValidarGetConta")
1677:             BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetConta,  "KeyPress",  THIS, "TeclaGetConta")
1678:             BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetDconta, "KeyPress", THIS, "ValidarGetDconta")
1679:             BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetDconta, "KeyPress",  THIS, "TeclaGetDconta")
1680: 

*-- Linhas 1717 a 1737:
1717:         TRY
1718:             THIS.FormParaBO()
1719:             IF THIS.this_oBusinessObject.Salvar()
1720:                 LOCAL loc_cLprecoSalvo
1721:                 loc_cLprecoSalvo = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
1722:                 IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0
1723:                     IF THIS.this_oBusinessObject.SalvarItens(loc_cLprecoSalvo)
1724:                         MsgInfo("Lista salva com sucesso!", "")
1725:                         THIS.AlternarPagina(1)
1726:                     ELSE
1727:                         MsgErro("Cabe" + CHR(231) + "alho salvo mas houve erro ao salvar itens.", "Aviso")
1728:                     ENDIF
1729:                 ELSE
1730:                     MsgInfo("Lista salva com sucesso!", "")
1731:                     THIS.AlternarPagina(1)
1732:                 ENDIF
1733:             ENDIF
1734:         CATCH TO loException
1735:             MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, "FormLpr.BtnSalvarClick")
1736:         ENDTRY
1737:     ENDPROC

*-- Linhas 1765 a 1785:
1765:             ELSE
1766:                 *-- Verificar se empresa existe em SigCdEmp
1767:                 LOCAL loc_cSQL
1768:                 loc_cSQL = "SELECT TOP 1 CEmps FROM SigCdEmp WHERE CEmps = " + ;
1769:                            EscaparSQL(loc_cEmps)
1770:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldEmps")
1771:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldEmps") = 0
1772:                     MsgErro("Empresa [" + loc_cEmps + "] n" + CHR(227) + "o encontrada!", "Aviso")
1773:                     loc_oPg2.txt_4c_Emps.Value = ALLTRIM(go_4c_Sistema.cCodEmpresa)
1774:                 ENDIF
1775:                 IF USED("cursor_4c_VldEmps")
1776:                     USE IN cursor_4c_VldEmps
1777:                 ENDIF
1778:             ENDIF
1779: 
1780:         CATCH TO loException
1781:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarEmpresa")
1782:         ENDTRY
1783:     ENDPROC
1784: 
1785:     *==========================================================================

*-- Linhas 1801 a 1821:
1801:             IF THIS.this_cPcEscolha = "INSERIR"
1802:                 *-- Verificar duplicata
1803:                 LOCAL loc_cSQL2
1804:                 loc_cSQL2 = "SELECT TOP 1 lprecos FROM SigCdLpc WHERE lprecos = " + ;
1805:                             EscaparSQL(loc_cLpreco)
1806:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL2, "cursor_4c_VldLpr")
1807:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldLpr") > 0
1808:                     MsgErro("Lista de Pre" + CHR(231) + "o [" + loc_cLpreco + ;
1809:                         "] j" + CHR(225) + " cadastrada!", "Aviso")
1810:                     loc_oPg2.txt_4c_Lpreco.Value = THIS.this_cAntLPreco
1811:                 ENDIF
1812:                 IF USED("cursor_4c_VldLpr")
1813:                     USE IN cursor_4c_VldLpr
1814:                 ENDIF
1815:             ELSE
1816:                 IF THIS.this_cPcEscolha = "PROCURAR"
1817:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLpreco)
1818:                     THIS.BOParaForm()
1819:                 ELSE
1820:                     MsgAviso("Lista [" + loc_cLpreco + "] n" + CHR(227) + ;
1821:                         "o encontrada!", "Aviso")

*-- Linhas 1846 a 1866:
1846:         TRY
1847:             LOCAL loc_oBusca, loc_cSQL3
1848:             *-- Verificar se fpag existe
1849:             loc_cSQL3 = "SELECT TOP 1 fpags FROM SigOpFp WHERE fpags = " + EscaparSQL(loc_cFpg)
1850:             LOCAL loc_nRes
1851:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL3, "cursor_4c_BuscaFpg")
1852:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_BuscaFpg") = 0
1853:                 *-- Nao encontrou exato - abrir lookup
1854:                 IF USED("cursor_4c_BuscaFpg")
1855:                     USE IN cursor_4c_BuscaFpg
1856:                 ENDIF
1857:                 THIS.AbrirBuscaFpg(loc_cFpg)
1858:             ELSE
1859:                 IF USED("cursor_4c_BuscaFpg")
1860:                     USE IN cursor_4c_BuscaFpg
1861:                 ENDIF
1862:             ENDIF
1863: 
1864:         CATCH TO loException
1865:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarFpg")
1866:         ENDTRY

*-- Linhas 1886 a 1904:
1886:                 ENDIF
1887: 
1888:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
1889:                     SELECT cursor_4c_BuscaFpg
1890:                     loc_oPg2.txt_4c_Fpg.Value = ALLTRIM(cursor_4c_BuscaFpg.fpags)
1891:                 ELSE
1892:                     IF !loc_oBusca.this_lAchouRegistro
1893:                         loc_oPg2.txt_4c_Fpg.Value = ""
1894:                     ENDIF
1895:                 ENDIF
1896:                 loc_oBusca.Release()
1897:             ENDIF
1898: 
1899:             IF USED("cursor_4c_BuscaFpg")
1900:                 USE IN cursor_4c_BuscaFpg
1901:             ENDIF
1902: 
1903:         CATCH TO loException
1904:             MsgErro("Erro: " + loException.Message, "FormLpr.AbrirBuscaFpg")

*-- Linhas 1932 a 1950:
1932:                 ENDIF
1933: 
1934:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1935:                     SELECT cursor_4c_BuscaProd
1936:                     loc_oPg2.txt_4c_Txtcpros.Value = ALLTRIM(cursor_4c_BuscaProd.cpros)
1937:                     loc_oPg2.txt_4c_Txtdpros.Value = ALLTRIM(cursor_4c_BuscaProd.dpros)
1938:                     THIS.this_cAntCPro = ALLTRIM(cursor_4c_BuscaProd.cpros)
1939:                     THIS.this_cAntDPro = ALLTRIM(cursor_4c_BuscaProd.dpros)
1940:                 ELSE
1941:                     IF !loc_oBusca.this_lAchouRegistro
1942:                         loc_oPg2.txt_4c_Txtcpros.Value = ""
1943:                         loc_oPg2.txt_4c_Txtdpros.Value = ""
1944:                         THIS.this_cAntCPro = ""
1945:                         THIS.this_cAntDPro = ""
1946:                     ENDIF
1947:                 ENDIF
1948:                 loc_oBusca.Release()
1949:             ENDIF
1950: 

*-- Linhas 1988 a 2041:
1988:                 ENDIF
1989: 
1990:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1991:                     SELECT cursor_4c_BuscaProd
1992:                     loc_oPg2.txt_4c_Txtdpros.Value = ALLTRIM(cursor_4c_BuscaProd.dpros)
1993:                     loc_oPg2.txt_4c_Txtcpros.Value = ALLTRIM(cursor_4c_BuscaProd.cpros)
1994:                     THIS.this_cAntDPro = ALLTRIM(cursor_4c_BuscaProd.dpros)
1995:                     THIS.this_cAntCPro = ALLTRIM(cursor_4c_BuscaProd.cpros)
1996:                 ELSE
1997:                     IF !loc_oBusca.this_lAchouRegistro
1998:                         loc_oPg2.txt_4c_Txtdpros.Value = ""
1999:                         THIS.this_cAntDPro = ""
2000:                     ENDIF
2001:                 ENDIF
2002:                 loc_oBusca.Release()
2003:             ENDIF
2004: 
2005:             IF USED("cursor_4c_BuscaProd")
2006:                 USE IN cursor_4c_BuscaProd
2007:             ENDIF
2008: 
2009:         CATCH TO loException
2010:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarDpros")
2011:         ENDTRY
2012:     ENDPROC
2013: 
2014:     *==========================================================================
2015:     * BtnBuscaGradeClick - Click do botao Busca na area de pesquisa da grade
2016:     * Busca no cursor de itens (cursor_4c_Itens) pelo cpros digitado e
2017:     * posiciona o foco na grade (grade sera vinculada na Fase 6)
2018:     *==========================================================================
2019:     PROCEDURE BtnBuscaGradeClick()
2020:         LOCAL loc_oPg2, loc_cCpros
2021:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
2022:         loc_cCpros = ALLTRIM(loc_oPg2.txt_4c_Txtcpros.Value)
2023: 
2024:         TRY
2025:             IF USED("cursor_4c_Itens")
2026:                 SELECT cursor_4c_Itens
2027:                 SET NEAR ON
2028:                 IF !EMPTY(loc_cCpros)
2029:                     SEEK PADR(loc_cCpros, 14) ORDER "cpros"
2030:                 ENDIF
2031:                 SET NEAR OFF
2032: 
2033:                 *-- Tentar focar na grade de itens (adicionada na Fase 6)
2034:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5)
2035:                     loc_oPg2.grd_4c_Grade.Column1.SetFocus()
2036:                 ELSE
2037:                     IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5)
2038:                     loc_oPg2.grd_4c_GradeC.Column1.SetFocus()
2039:                     ENDIF
2040:                 ENDIF
2041:             ENDIF

*-- Linhas 2134 a 2262:
2134:             *-- Verificar se a lista ja foi publicada (flags=1)
2135:             IF THIS.this_cPcEscolha = "ALTERAR" AND ;
2136:                USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2137:                 SELECT cursor_4c_Dados
2138:                 loc_lFlags = (TratarNulo(cursor_4c_Dados.flags, "N") = 1)
2139:             ENDIF
2140: 
2141:             *-- Emps: editavel apenas em INSERIR e quando nao flags
2142:             loc_oPg2.txt_4c_Emps.ReadOnly   = !(par_lHabilitar AND !loc_lFlags)
2143:             *-- Lpreco: editavel apenas em INSERIR (nao pode mudar PK em ALTERAR)
2144:             loc_oPg2.txt_4c_Lpreco.ReadOnly = !(par_lHabilitar AND THIS.this_cPcEscolha = "INSERIR")
2145:             *-- Fpg: editavel em INSERIR e ALTERAR (quando nao flags)
2146:             loc_oPg2.txt_4c_Fpg.ReadOnly    = !(par_lHabilitar AND !loc_lFlags)
2147:             *-- Campos de busca na grade: sempre editaveis quando ha lista selecionada
2148:             loc_oPg2.txt_4c_Txtcpros.ReadOnly = !par_lHabilitar
2149:             loc_oPg2.txt_4c_Txtdpros.ReadOnly = !par_lHabilitar
2150:             *-- Botoes acao
2151:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
2152:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2153: 
2154:         CATCH TO loException
2155:             MsgErro("Erro: " + loException.Message, "FormLpr.HabilitarCampos")
2156:         ENDTRY
2157:     ENDPROC
2158: 
2159:     *==========================================================================
2160:     * CarregarItens - Carrega SigCdLpi no cursor_4c_Itens e vincula grids
2161:     * par_cLprecos: codigo da lista; vazio = nova lista (cursor nao carregado)
2162:     *==========================================================================
2163:     PROTECTED PROCEDURE CarregarItens(par_cLprecos)
2164:         LOCAL loc_lSucesso
2165:         loc_lSucesso = .F.
2166: 
2167:         TRY
2168:             IF USED("cursor_4c_Itens")
2169:                 USE IN cursor_4c_Itens
2170:             ENDIF
2171: 
2172:             IF !EMPTY(ALLTRIM(par_cLprecos))
2173:                 loc_lSucesso = THIS.this_oBusinessObject.CarregarItens(par_cLprecos, THIS.this_cCompVenda)
2174:             ENDIF
2175: 
2176:             IF loc_lSucesso AND USED("cursor_4c_Itens")
2177:                 *-- Criar indice para SEEK em BtnBuscaGradeClick
2178:                 SELECT cursor_4c_Itens
2179:                 INDEX ON PADR(cpros, 14) TAG cpros ADDITIVE
2180:                 GO TOP
2181:             ENDIF
2182: 
2183:             THIS.VincularGrade()
2184: 
2185:         CATCH TO loException
2186:             MsgErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "FormLpr.CarregarItens")
2187:         ENDTRY
2188:     ENDPROC
2189: 
2190:     *==========================================================================
2191:     * VincularGrade - Define RecordSource, ControlSources e Headers dos grids
2192:     * Exibe grd_4c_GradeC em modo compra; grd_4c_Grade em modo venda
2193:     *==========================================================================
2194:     PROTECTED PROCEDURE VincularGrade()
2195:         LOCAL loc_oPg2, loc_lModoCompra, loc_oGrid
2196:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
2197:         loc_lModoCompra = (THIS.this_cCompVenda = "C")
2198: 
2199:         TRY
2200:             IF loc_lModoCompra
2201:                 *-- Modo compra: grd_4c_GradeC visivel, grd_4c_Grade oculta
2202:                 IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5)
2203:                     loc_oGrid = loc_oPg2.grd_4c_GradeC
2204:                     IF USED("cursor_4c_Itens")
2205:                         loc_oGrid.ColumnCount = 7
2206:                         loc_oGrid.RecordSource         = "cursor_4c_Itens"
2207:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Itens.cpros"
2208:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Itens.dpros"
2209:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Itens.reffs"
2210:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Itens.ean13"
2211:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Itens.pcuss"
2212:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Itens.moevs"
2213:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Itens.pvens"
2214:                     ELSE
2215:                         loc_oGrid.RecordSource = ""
2216:                     ENDIF
2217:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
2218:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
2219:                     loc_oGrid.Column3.Header1.Caption = "Ref.Fornecedor"
2220:                     loc_oGrid.Column4.Header1.Caption = "EAN"
2221:                     loc_oGrid.Column5.Header1.Caption = "Custo Atual"
2222:                     loc_oGrid.Column6.Header1.Caption = "Moe"
2223:                     loc_oGrid.Column7.Header1.Caption = "Custo Novo"
2224:                     loc_oGrid.FontName = "Verdana"
2225:                     loc_oGrid.FontSize = 8
2226:                     loc_oGrid.Visible = .T.
2227:                     loc_oGrid.Refresh()
2228:                 ENDIF
2229:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5)
2230:                     loc_oPg2.grd_4c_Grade.Visible = .F.
2231:                 ENDIF
2232:             ELSE
2233:                 *-- Modo venda: grd_4c_Grade visivel, grd_4c_GradeC oculta
2234:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5)
2235:                     loc_oGrid = loc_oPg2.grd_4c_Grade
2236:                     IF USED("cursor_4c_Itens")
2237:                         loc_oGrid.ColumnCount = 9
2238:                         loc_oGrid.RecordSource         = "cursor_4c_Itens"
2239:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Itens.cpros"
2240:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Itens.dpros"
2241:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Itens.pvens"
2242:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Itens.moevs"
2243:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Itens.comiss"
2244:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Itens.vencis"
2245:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Itens.vencfs"
2246:                         loc_oGrid.Column8.ControlSource = "cursor_4c_Itens.cgrus"
2247:                         loc_oGrid.Column9.ControlSource = "cursor_4c_Itens.precode"
2248:                     ELSE
2249:                         loc_oGrid.RecordSource = ""
2250:                     ENDIF
2251:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
2252:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
2253:                     loc_oGrid.Column3.Header1.Caption = "Pr. Venda"
2254:                     loc_oGrid.Column4.Header1.Caption = "Moe"
2255:                     loc_oGrid.Column5.Header1.Caption = "Comiss."
2256:                     loc_oGrid.Column6.Header1.Caption = "Venc. Inicial"
2257:                     loc_oGrid.Column7.Header1.Caption = "Venc. Final"
2258:                     loc_oGrid.Column8.Header1.Caption = "C"
2259:                     loc_oGrid.Column9.Header1.Caption = "Pr. De"
2260:                     loc_oGrid.FontName = "Verdana"
2261:                     loc_oGrid.FontSize = 8
2262:                     loc_oGrid.Visible = .T.

*-- Linhas 2284 a 2410:
2284:             MsgAviso("Salve o cabe" + CHR(231) + "alho da lista antes de inserir itens.", "Aviso")
2285:             RETURN
2286:         ENDIF
2287: 
2288:         TRY
2289:             IF !USED("cursor_4c_Itens")
2290:                 SET NULL ON
2291:                 CREATE CURSOR cursor_4c_Itens (cidchaves c(20), lprecos c(30), ;
2292:                     cpros c(14), dpros c(40), reffs c(20), ean13 n(13,0), ;
2293:                     pcuss n(16,6), moevs c(3), pvens n(16,6), vencis d, ;
2294:                     vencfs d, comiss n(7,4), cgrus c(3), flagutabs n(1,0), ;
2295:                     ordems c(11), ccontroles c(30), precode n(16,6))
2296:                 SET NULL OFF
2297:             ENDIF
2298: 
2299:             SELECT cursor_4c_Itens
2300:             SET FILTER TO
2301:             INSERT INTO cursor_4c_Itens (lprecos, ordems) VALUES (loc_cLpreco, CHR(255))
2302:             SET FILTER TO !DELETED("cursor_4c_Itens")
2303: 
2304:             THIS.VincularGrade()
2305: 
2306:             SELECT cursor_4c_Itens
2307:             GO BOTTOM
2308: 
2309:             IF THIS.this_cCompVenda = "C" AND PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5) ;
2310:                     AND loc_oPg2.grd_4c_GradeC.Visible
2311:                 loc_oPg2.grd_4c_GradeC.Column1.SetFocus()
2312:             ELSE
2313:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5) AND loc_oPg2.grd_4c_Grade.Visible
2314:                 loc_oPg2.grd_4c_Grade.Column1.SetFocus()
2315:                 ENDIF
2316:             ENDIF
2317: 
2318:         CATCH TO loException
2319:             MsgErro("Erro ao inserir item:" + CHR(13) + loException.Message, "FormLpr.BtnINSEREClick")
2320:         ENDTRY
2321:     ENDPROC
2322: 
2323:     *==========================================================================
2324:     * BtnDELETEClick - Marca item atual como excluido no cursor de itens
2325:     *==========================================================================
2326:     PROCEDURE BtnDELETEClick()
2327:         LOCAL loc_oPg2
2328:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2329: 
2330:         TRY
2331:             IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0 AND ;
2332:                !EOF("cursor_4c_Itens") AND !BOF("cursor_4c_Itens")
2333:                 IF MsgConfirma("Confirma exclus" + CHR(227) + "o do item?", "Confirmar")
2334:                     SELECT cursor_4c_Itens
2335:                     IF !DELETED()
2336:                         DELETE
2337:                         SET FILTER TO !DELETED("cursor_4c_Itens")
2338:                         GO TOP
2339:                     ENDIF
2340:                     IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5) AND loc_oPg2.grd_4c_Grade.Visible
2341:                         loc_oPg2.grd_4c_Grade.Refresh()
2342:                     ENDIF
2343:                     IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5) AND loc_oPg2.grd_4c_GradeC.Visible
2344:                         loc_oPg2.grd_4c_GradeC.Refresh()
2345:                     ENDIF
2346:                 ENDIF
2347:             ELSE
2348:                 MsgAviso("Nenhum item selecionado para excluir.", "Aviso")
2349:             ENDIF
2350:         CATCH TO loException
2351:             MsgErro("Erro ao excluir item:" + CHR(13) + loException.Message, "FormLpr.BtnDELETEClick")
2352:         ENDTRY
2353:     ENDPROC
2354: 
2355:     *==========================================================================
2356:     * BtnCOPIAClick - Duplica o item atual no cursor de itens
2357:     *==========================================================================
2358:     PROCEDURE BtnCOPIAClick()
2359:         LOCAL loc_oPg2, loc_cLpreco
2360:         LOCAL loc_cCpros, loc_cDpros, loc_cMoevs, loc_cCgrus, loc_cReffs
2361:         LOCAL loc_nPvens, loc_nComiss, loc_nEan13, loc_nPcuss, loc_nPrecode
2362:         LOCAL loc_dVencis, loc_dVencfs
2363:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2364:         loc_cLpreco = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
2365: 
2366:         TRY
2367:             IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0 AND ;
2368:                !EOF("cursor_4c_Itens") AND !BOF("cursor_4c_Itens")
2369:                 SELECT cursor_4c_Itens
2370:                 loc_cCpros   = ALLTRIM(TratarNulo(cpros,   "C"))
2371:                 loc_cDpros   = ALLTRIM(TratarNulo(dpros,   "C"))
2372:                 loc_cMoevs   = ALLTRIM(TratarNulo(moevs,   "C"))
2373:                 loc_cCgrus   = ALLTRIM(TratarNulo(cgrus,   "C"))
2374:                 loc_cReffs   = ALLTRIM(TratarNulo(reffs,   "C"))
2375:                 loc_nPvens   = TratarNulo(pvens,   "N")
2376:                 loc_nComiss  = TratarNulo(comiss,  "N")
2377:                 loc_nEan13   = TratarNulo(ean13,   "N")
2378:                 loc_nPcuss   = TratarNulo(pcuss,   "N")
2379:                 loc_nPrecode = TratarNulo(precode, "N")
2380:                 loc_dVencis  = TratarNulo(vencis,  "D")
2381:                 loc_dVencfs  = TratarNulo(vencfs,  "D")
2382: 
2383:                 SET FILTER TO
2384:                 INSERT INTO cursor_4c_Itens ;
2385:                     (lprecos, cpros, dpros, moevs, cgrus, reffs, pvens, comiss, ;
2386:                      ean13, pcuss, precode, vencis, vencfs, ordems) ;
2387:                     VALUES (loc_cLpreco, loc_cCpros, loc_cDpros, loc_cMoevs, ;
2388:                             loc_cCgrus, loc_cReffs, loc_nPvens, loc_nComiss, ;
2389:                             loc_nEan13, loc_nPcuss, loc_nPrecode, loc_dVencis, ;
2390:                             loc_dVencfs, CHR(255))
2391:                 SET FILTER TO !DELETED("cursor_4c_Itens")
2392: 
2393:                 THIS.VincularGrade()
2394: 
2395:                 SELECT cursor_4c_Itens
2396:                 GO BOTTOM
2397:             ELSE
2398:                 MsgAviso("Nenhum item selecionado para duplicar.", "Aviso")
2399:             ENDIF
2400:         CATCH TO loException
2401:             MsgErro("Erro ao duplicar item:" + CHR(13) + loException.Message, "FormLpr.BtnCOPIAClick")
2402:         ENDTRY
2403:     ENDPROC
2404: 
2405:     *==========================================================================
2406:     * BtnSelecionaClick - Abre browser de produtos para adicionar item a lista
2407:     *==========================================================================
2408:     PROCEDURE BtnSelecionaClick()
2409:         LOCAL loc_oPg2, loc_oBusca, loc_nResult, loc_cSQL, loc_cLpreco
2410:         LOCAL loc_cCpros, loc_cDpros, loc_nPvens, loc_nPcuss, loc_cMoevs

*-- Linhas 2418 a 2478:
2418:         ENDIF
2419: 
2420:         TRY
2421:             loc_cSQL = "SELECT TOP 500 cpros, dpros, pvens, pcuss, moevs, cgrus, reffs, ean13" + ;
2422:                        " FROM SigCdPro ORDER BY cpros"
2423:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProd")
2424: 
2425:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaProd") > 0
2426:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2427:                 IF VARTYPE(loc_oBusca) = "O"
2428:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaProd", "cpros", "dpros", ;
2429:                         "Selecionar Produto")
2430:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaProd"
2431:                     loc_oBusca.Mostrar()
2432: 
2433:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
2434:                         SELECT cursor_4c_BuscaProd
2435:                         loc_cCpros  = ALLTRIM(cursor_4c_BuscaProd.cpros)
2436:                         loc_cDpros  = ALLTRIM(cursor_4c_BuscaProd.dpros)
2437:                         loc_nPvens  = TratarNulo(cursor_4c_BuscaProd.pvens,  "N")
2438:                         loc_nPcuss  = TratarNulo(cursor_4c_BuscaProd.pcuss,  "N")
2439:                         loc_cMoevs  = ALLTRIM(TratarNulo(cursor_4c_BuscaProd.moevs, "C"))
2440:                         loc_cCgrus  = ALLTRIM(TratarNulo(cursor_4c_BuscaProd.cgrus, "C"))
2441:                         loc_cReffs  = ALLTRIM(TratarNulo(cursor_4c_BuscaProd.reffs, "C"))
2442:                         loc_nEan13  = TratarNulo(cursor_4c_BuscaProd.ean13,  "N")
2443: 
2444:                         IF !USED("cursor_4c_Itens")
2445:                             SET NULL ON
2446:                             CREATE CURSOR cursor_4c_Itens (cidchaves c(20), lprecos c(30), ;
2447:                                 cpros c(14), dpros c(40), reffs c(20), ean13 n(13,0), ;
2448:                                 pcuss n(16,6), moevs c(3), pvens n(16,6), vencis d, ;
2449:                                 vencfs d, comiss n(7,4), cgrus c(3), flagutabs n(1,0), ;
2450:                                 ordems c(11), ccontroles c(30), precode n(16,6))
2451:                             SET NULL OFF
2452:                         ENDIF
2453: 
2454:                         SELECT cursor_4c_Itens
2455:                         SET FILTER TO
2456:                         INSERT INTO cursor_4c_Itens ;
2457:                             (lprecos, cpros, dpros, moevs, cgrus, reffs, ean13, ordems, ;
2458:                              pvens, pcuss) ;
2459:                             VALUES (loc_cLpreco, loc_cCpros, loc_cDpros, loc_cMoevs, ;
2460:                                     loc_cCgrus, loc_cReffs, loc_nEan13, CHR(255), ;
2461:                                     IIF(THIS.this_cCompVenda = "C", loc_nPcuss, loc_nPvens), ;
2462:                                     loc_nPcuss)
2463:                         SET FILTER TO !DELETED("cursor_4c_Itens")
2464:                         GO BOTTOM
2465: 
2466:                         THIS.VincularGrade()
2467:                     ENDIF
2468:                     loc_oBusca.Release()
2469:                 ENDIF
2470:             ELSE
2471:                 MsgAviso("Nenhum produto encontrado.", "Aviso")
2472:             ENDIF
2473: 
2474:             IF USED("cursor_4c_BuscaProd")
2475:                 USE IN cursor_4c_BuscaProd
2476:             ENDIF
2477: 
2478:         CATCH TO loException

*-- Linhas 2514 a 2543:
2514:                 loc_dVenc = loc_oPg2.cnt_4c_Vencimentos.txt_4c_GetVencs.Value
2515:             ELSE
2516:                 loc_dVenc = DATE()
2517:             ENDIF
2518: 
2519:             IF USED("cursor_4c_Itens") AND VARTYPE(loc_dVenc) = "D" AND !EMPTY(loc_dVenc)
2520:                 SELECT cursor_4c_Itens
2521:                 SET FILTER TO
2522:                 GO TOP
2523:                 SCAN
2524:                     IF !DELETED()
2525:                         REPLACE vencis WITH loc_dVenc
2526:                     ENDIF
2527:                 ENDSCAN
2528:                 SET FILTER TO !DELETED("cursor_4c_Itens")
2529:                 GO TOP
2530:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5) AND loc_oPg2.grd_4c_Grade.Visible
2531:                     loc_oPg2.grd_4c_Grade.Refresh()
2532:                 ENDIF
2533:                 IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5) AND loc_oPg2.grd_4c_GradeC.Visible
2534:                     loc_oPg2.grd_4c_GradeC.Refresh()
2535:                 ENDIF
2536:             ENDIF
2537: 
2538:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Vencimentos", 5)
2539:                 loc_oPg2.cnt_4c_Vencimentos.Visible = .F.
2540:             ENDIF
2541: 
2542:         CATCH TO loException
2543:             MsgErro("Erro ao aplicar vencimento:" + CHR(13) + loException.Message, "FormLpr.BtnSalvaVencimentoClick")

*-- Linhas 2574 a 2616:
2574:         LOCAL loc_cCpros, loc_nResult, loc_cSQL, loc_lContinuar
2575:         loc_cCpros     = ""
2576:         loc_lContinuar = .T.
2577: 
2578:         TRY
2579:             IF par_nColIndex = 1 AND USED("cursor_4c_Itens") AND ;
2580:                !EOF("cursor_4c_Itens") AND !BOF("cursor_4c_Itens")
2581:                 SELECT cursor_4c_Itens
2582:                 loc_cCpros = ALLTRIM(TratarNulo(cpros, "C"))
2583: 
2584:                 IF !EMPTY(loc_cCpros)
2585:                     *-- Verificar grupo em modo venda (bloqueado para certos grupos)
2586:                     IF THIS.this_cCompVenda <> "C"
2587:                         IF !THIS.this_oBusinessObject.ChecaGrpVenda(loc_cCpros)
2588:                             SELECT cursor_4c_Itens
2589:                             REPLACE cpros WITH "", dpros WITH ""
2590:                             loc_lContinuar = .F.
2591:                         ENDIF
2592:                     ENDIF
2593: 
2594:                     IF loc_lContinuar
2595:                         *-- Buscar produto no catalogo e pre-preencher campos da linha
2596:                         loc_cSQL = "SELECT cpros, dpros, pvens, pcuss, moevs, cgrus, reffs, ean13" + ;
2597:                                    " FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
2598:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldPro")
2599: 
2600:                         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldPro") > 0
2601:                             SELECT cursor_4c_Itens
2602:                             REPLACE dpros WITH ALLTRIM(cursor_4c_VldPro.dpros)
2603:                             IF EMPTY(ALLTRIM(TratarNulo(moevs, "C")))
2604:                                 REPLACE moevs WITH ALLTRIM(cursor_4c_VldPro.moevs)
2605:                             ENDIF
2606:                             IF EMPTY(ALLTRIM(TratarNulo(cgrus, "C")))
2607:                                 REPLACE cgrus WITH ALLTRIM(cursor_4c_VldPro.cgrus)
2608:                             ENDIF
2609:                             IF THIS.this_cCompVenda = "C"
2610:                                 *-- Modo compra: custo atual + reffs + ean
2611:                                 IF TratarNulo(pcuss, "N") = 0
2612:                                     REPLACE pcuss WITH TratarNulo(cursor_4c_VldPro.pcuss, "N")
2613:                                 ENDIF
2614:                                 IF EMPTY(ALLTRIM(TratarNulo(reffs, "C")))
2615:                                     REPLACE reffs WITH ALLTRIM(cursor_4c_VldPro.reffs)
2616:                                 ENDIF

*-- Linhas 2622 a 2642:
2622:                                 IF TratarNulo(pvens, "N") = 0
2623:                                     REPLACE pvens WITH TratarNulo(cursor_4c_VldPro.pvens, "N")
2624:                                 ENDIF
2625:                             ENDIF
2626:                         ELSE
2627:                             SELECT cursor_4c_Itens
2628:                             REPLACE dpros WITH ""
2629:                         ENDIF
2630: 
2631:                         IF USED("cursor_4c_VldPro")
2632:                             USE IN cursor_4c_VldPro
2633:                         ENDIF
2634:                     ENDIF
2635:                 ENDIF
2636:             ENDIF
2637: 
2638:         CATCH TO loException
2639:             MsgErro("Erro na grade (col " + TRANSFORM(par_nColIndex) + "):" + ;
2640:                     CHR(13) + loException.Message, "FormLpr.GradeAfterRowColChange")
2641:         ENDTRY
2642:     ENDPROC

*-- Linhas 2662 a 2702:
2662:                     ENDIF
2663: 
2664:                     IF USED("cursor_4c_Dados")
2665:                         SELECT cursor_4c_Dados
2666:                         DO CASE
2667:                             CASE loc_nFiltroVenc = 2
2668:                                 SET FILTER TO vencis >= DATE()
2669:                             CASE loc_nFiltroVenc = 3
2670:                                 SET FILTER TO !EMPTY(vencis) AND vencis < DATE()
2671:                             OTHERWISE
2672:                                 SET FILTER TO
2673:                         ENDCASE
2674:                         GO TOP
2675:                     ENDIF
2676: 
2677:                     *-- Vincular grid: RecordSource -> ControlSources -> Headers
2678:                     *   VFP9 sobrescreve ControlSources e Headers ao trocar RecordSource
2679:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
2680:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2681:                         IF USED("cursor_4c_Dados")
2682:                             loc_oGrid.ColumnCount = 4
2683:                             loc_oGrid.RecordSource = "cursor_4c_Dados"
2684:                             loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.lprecos"
2685:                             loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.fpags"
2686:                             loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.vencis"
2687:                             loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.flags"
2688:                             loc_oGrid.Column1.Header1.Caption = "Lista de Pre" + CHR(231) + "os"
2689:                             loc_oGrid.Column2.Header1.Caption = "Cond. Pagamento"
2690:                             loc_oGrid.Column3.Header1.Caption = "Vencimento"
2691:                             loc_oGrid.Column4.Header1.Caption = "Atualizada"
2692:                             THIS.FormatarGridLista(loc_oGrid)
2693:                             loc_oGrid.Refresh()
2694:                         ENDIF
2695:                     ENDIF
2696: 
2697:                     loc_lResultado = .T.
2698:                 ELSE
2699:                     loc_lResultado = .F.
2700:                 ENDIF
2701:             ENDIF
2702: 

*-- Linhas 2815 a 2833:
2815:         TRY
2816:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
2817:                !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
2818:                 SELECT cursor_4c_Dados
2819:                 loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
2820:                 loc_lOk = .T.
2821:             ENDIF
2822: 
2823:             IF loc_lOk AND !EMPTY(loc_cLprecos)
2824:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLprecos)
2825:                     THIS.this_cPcEscolha    = "PROCURAR"
2826:                     THIS.this_cLprecosAtual = loc_cLprecos
2827:                     THIS.AlternarPagina(2)
2828:                 ENDIF
2829:             ELSE
2830:                 MsgAviso("Selecione uma lista de pre" + CHR(231) + "os!", "Aviso")
2831:             ENDIF
2832:         CATCH TO loException
2833:             MsgErro("Erro ao visualizar:" + CHR(13) + loException.Message, "FormLpr.BtnVisualizarClick")

*-- Linhas 2848 a 2866:
2848:         TRY
2849:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
2850:                !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
2851:                 SELECT cursor_4c_Dados
2852:                 loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
2853:                 loc_nFlags   = TratarNulo(cursor_4c_Dados.flags, "N")
2854:                 loc_lOk = .T.
2855:             ENDIF
2856: 
2857:             IF loc_lOk AND !EMPTY(loc_cLprecos)
2858:                 IF loc_nFlags = 1
2859:                     loc_lProsseguir = MsgConfirma("Esta lista j" + CHR(225) + ;
2860:                         " foi atualizada no sistema." + CHR(13) + ;
2861:                         "Deseja alterar mesmo assim?", "Aten" + CHR(231) + CHR(227) + "o")
2862:                 ENDIF
2863: 
2864:                 IF loc_lProsseguir
2865:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLprecos)
2866:                         THIS.this_cPcEscolha    = "ALTERAR"

*-- Linhas 2889 a 2907:
2889:         TRY
2890:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
2891:                !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
2892:                 SELECT cursor_4c_Dados
2893:                 loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
2894:                 loc_nFlags   = TratarNulo(cursor_4c_Dados.flags, "N")
2895:                 loc_lOk = .T.
2896:             ENDIF
2897: 
2898:             IF loc_lOk AND !EMPTY(loc_cLprecos)
2899:                 IF loc_nFlags = 1
2900:                     MsgErro("Lista j" + CHR(225) + " atualizada no sistema." + CHR(13) + ;
2901:                             "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
2902:                             "vel excluir!", "Aviso")
2903:                 ELSE
2904:                     IF MsgConfirma("Confirma exclus" + CHR(227) + "o da lista [" + ;
2905:                                    loc_cLprecos + "]?", "Confirmar")
2906:                         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLprecos)
2907:                             IF THIS.this_oBusinessObject.Excluir()

*-- Linhas 2955 a 2973:
2955:         TRY
2956:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
2957:                !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
2958:                 SELECT cursor_4c_Dados
2959:                 loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
2960:                 loc_nFlags   = TratarNulo(cursor_4c_Dados.flags, "N")
2961:                 loc_lOk = .T.
2962:             ENDIF
2963: 
2964:             IF loc_lOk AND !EMPTY(loc_cLprecos)
2965:                 IF loc_nFlags = 1
2966:                     loc_lProsseguir = MsgConfirma("Lista j" + CHR(225) + ;
2967:                         " atualizada no sistema." + CHR(13) + ;
2968:                         "Deseja atualizar novamente?", "Confirmar")
2969:                 ENDIF
2970: 
2971:                 IF loc_lProsseguir
2972:                     IF THIS.this_oBusinessObject.AtualizarFlags(loc_cLprecos)
2973:                         MsgInfo("Lista [" + loc_cLprecos + "] atualizada com sucesso!", "")

*-- Linhas 3031 a 3060:
3031:                     loc_cFiltroTipo = ""
3032:             ENDCASE
3033: 
3034:             loc_cSQL = "SELECT b.lprecos, b.fpags, b.vencis AS vencis_lista," + ;
3035:                        " b.flags, b.tipos," + ;
3036:                        " a.cpros, a.dpros, a.pvens, a.pcuss, a.moevs," + ;
3037:                        " a.comiss, a.vencis AS vencis_item, a.vencfs," + ;
3038:                        " a.cgrus, a.ean13, a.reffs, a.ordems, a.precode" + ;
3039:                        " FROM SigCdLpi a" + ;
3040:                        " INNER JOIN SigCdLpc b ON a.lprecos = b.lprecos" + ;
3041:                        " WHERE b.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
3042:                        loc_cFiltroTipo + ;
3043:                        " ORDER BY b.lprecos, a.ordems, a.cpros"
3044: 
3045:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Relatorio")
3046:             IF loc_nResult >= 0
3047:                 GO TOP IN cursor_4c_Relatorio
3048:                 loc_lSucesso = .T.
3049:             ELSE
3050:                 MsgErro("Erro ao montar relat" + CHR(243) + "rio:" + CHR(13) + ;
3051:                         CapturarErroSQL(), "Erro SQL")
3052:             ENDIF
3053:         CATCH TO loException
3054:             MsgErro("Erro ao montar relat" + CHR(243) + "rio:" + CHR(13) + ;
3055:                     loException.Message, "FormLpr.MontarRelatorio")
3056:         ENDTRY
3057: 
3058:         RETURN loc_lSucesso
3059:     ENDFUNC
3060: 

*-- Linhas 3108 a 3126:
3108: 
3109:             IF THIS.MontarRelatorio(loc_nTipo)
3110:                 IF USED("cursor_4c_Relatorio")
3111:                     SELECT cursor_4c_Relatorio
3112:                     COPY TO (loc_cArquivo) TYPE XL5
3113:                     MsgInfo("Arquivo exportado:" + CHR(13) + loc_cArquivo, "")
3114:                 ENDIF
3115:             ENDIF
3116:         CATCH TO loException
3117:             MsgErro("Erro ao exportar Excel:" + CHR(13) + loException.Message, "FormLpr.BtnImpExcelClick")
3118:         ENDTRY
3119:     ENDPROC
3120: 
3121:     *==========================================================================
3122:     * BtnImpFecharClick - Oculta o painel de impressao cnt_4c_ImpLista
3123:     *==========================================================================
3124:     PROCEDURE BtnImpFecharClick()
3125:         TRY
3126:             THIS.pgf_4c_Paginas.Page1.cnt_4c_ImpLista.Visible = .F.

*-- Linhas 3144 a 3163:
3144: 
3145:         TRY
3146:             LOCAL loc_cSQL
3147:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigOpTdz WHERE codigos = " + EscaparSQL(loc_cTabd)
3148:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaTabd")
3149:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaTabd") = 0
3150:                 IF USED("cursor_4c_BuscaTabd")
3151:                     USE IN cursor_4c_BuscaTabd
3152:                 ENDIF
3153:                 THIS.AbrirBuscaTabd()
3154:             ELSE
3155:                 IF USED("cursor_4c_BuscaTabd")
3156:                     USE IN cursor_4c_BuscaTabd
3157:                 ENDIF
3158:             ENDIF
3159:         CATCH TO loException
3160:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarTabd")
3161:         ENDTRY
3162:     ENDPROC
3163: 

*-- Linhas 3182 a 3200:
3182:                 ENDIF
3183: 
3184:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTabd")
3185:                     SELECT cursor_4c_BuscaTabd
3186:                     loc_oPg2.txt_4c_Tabd.Value = ALLTRIM(cursor_4c_BuscaTabd.codigos)
3187:                 ELSE
3188:                     IF !loc_oBusca.this_lAchouRegistro
3189:                         loc_oPg2.txt_4c_Tabd.Value = ""
3190:                     ENDIF
3191:                 ENDIF
3192:                 loc_oBusca.Release()
3193:             ENDIF
3194: 
3195:             IF USED("cursor_4c_BuscaTabd")
3196:                 USE IN cursor_4c_BuscaTabd
3197:             ENDIF
3198: 
3199:         CATCH TO loException
3200:             MsgErro("Erro: " + loException.Message, "FormLpr.AbrirBuscaTabd")

*-- Linhas 3232 a 3253:
3232: 
3233:         TRY
3234:             LOCAL loc_cSQL
3235:             loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta)
3236:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaForns")
3237:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaForns") > 0
3238:                 SELECT cursor_4c_BuscaForns
3239:                 loc_oCnt.txt_4c_GetDconta.Value = ALLTRIM(cursor_4c_BuscaForns.rclis)
3240:             ELSE
3241:                 IF USED("cursor_4c_BuscaForns")
3242:                     USE IN cursor_4c_BuscaForns
3243:                 ENDIF
3244:                 THIS.AbrirBuscaGetConta()
3245:             ENDIF
3246:             IF USED("cursor_4c_BuscaForns")
3247:                 USE IN cursor_4c_BuscaForns
3248:             ENDIF
3249:         CATCH TO loException
3250:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarGetConta")
3251:         ENDTRY
3252:     ENDPROC
3253: 

*-- Linhas 3274 a 3292:
3274:                 ENDIF
3275: 
3276:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaForns")
3277:                     SELECT cursor_4c_BuscaForns
3278:                     loc_oCnt.txt_4c_GetConta.Value  = ALLTRIM(cursor_4c_BuscaForns.iclis)
3279:                     loc_oCnt.txt_4c_GetDconta.Value = ALLTRIM(cursor_4c_BuscaForns.rclis)
3280:                 ELSE
3281:                     IF !loc_oBusca.this_lAchouRegistro
3282:                         loc_oCnt.txt_4c_GetConta.Value  = ""
3283:                         loc_oCnt.txt_4c_GetDconta.Value = ""
3284:                     ENDIF
3285:                 ENDIF
3286:                 loc_oBusca.Release()
3287:             ENDIF
3288: 
3289:             IF USED("cursor_4c_BuscaForns")
3290:                 USE IN cursor_4c_BuscaForns
3291:             ENDIF
3292: 

*-- Linhas 3355 a 3373:
3355:                 ENDIF
3356: 
3357:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaForns")
3358:                     SELECT cursor_4c_BuscaForns
3359:                     loc_oCnt.txt_4c_GetConta.Value  = ALLTRIM(cursor_4c_BuscaForns.iclis)
3360:                     loc_oCnt.txt_4c_GetDconta.Value = ALLTRIM(cursor_4c_BuscaForns.rclis)
3361:                 ELSE
3362:                     IF !loc_oBusca.this_lAchouRegistro
3363:                         loc_oCnt.txt_4c_GetDconta.Value = ""
3364:                     ENDIF
3365:                 ENDIF
3366:                 loc_oBusca.Release()
3367:             ENDIF
3368: 
3369:             IF USED("cursor_4c_BuscaForns")
3370:                 USE IN cursor_4c_BuscaForns
3371:             ENDIF
3372: 
3373:         CATCH TO loException

*-- Linhas 3456 a 3480:
3456: 
3457:             *-- Fechar cursores de trabalho
3458:             IF USED("cursor_4c_Dados")
3459:                 USE IN cursor_4c_Dados
3460:             ENDIF
3461:             IF USED("cursor_4c_Itens")
3462:                 USE IN cursor_4c_Itens
3463:             ENDIF
3464:             IF USED("cursor_4c_ItensCopia")
3465:                 USE IN cursor_4c_ItensCopia
3466:             ENDIF
3467:             IF USED("cursor_4c_BuscaProd")
3468:                 USE IN cursor_4c_BuscaProd
3469:             ENDIF
3470:             IF USED("cursor_4c_BuscaMoe")
3471:                 USE IN cursor_4c_BuscaMoe
3472:             ENDIF
3473:             IF USED("cursor_4c_BuscaFpg")
3474:                 USE IN cursor_4c_BuscaFpg
3475:             ENDIF
3476:             IF USED("cursor_4c_BuscaTabd")
3477:                 USE IN cursor_4c_BuscaTabd
3478:             ENDIF
3479:             IF USED("cursor_4c_Relatorio")
3480:                 USE IN cursor_4c_Relatorio


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


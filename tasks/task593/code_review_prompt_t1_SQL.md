# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, CORES, TAMS, EMPS, ICLIS, EXISTES, PCESCOLHA, GESIND
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, CORES, TAMS, EMPS, ICLIS, EXISTES, PCESCOLHA, GESIND
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'REFFS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CGRUS, CORES, TAMS, EMPS, ICLIS, EXISTES, PCESCOLHA, GESIND

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
Select CrSigCdMax
	.Column1.ControlSource = 'CrSigCdMax.emps'
	.Column2.ControlSource = 'CrSigCdMax.Qmaxs'
	.Column3.ControlSource = 'CrSigCdMax.codtams'
	.Column4.ControlSource = 'CrSigCdMax.codcores'
	.Column5.ControlSource = 'CrSigCdMax.Deptos'
Insert Into CrSigCdMax (cpros,cidchaves) Values (ThisForm.Pagina.Dados.Get_Produto.Value,fUniqueIds())
Select CrSigCdMax
Select CrSigCdMax
	lStrQuery = [Select b.cores,b.tams,b.tipoestos From SigCdPro a, SigCdGrp b ]+;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpProGru') < 1
	Select TmpProGru
lcQProds  = [Select a.cpros,b.dpros,b.ifors,b.reffs,b.cgrus,b.sgrus,b.situas,c.rclis,g.dgrus ]+;
			[From SigCdMax a ]+;
			[Inner Join SigCdPro b On b.cpros = a.cpros ]+;
			[Left Join SigCdCli c On b.ifors = c.iclis ]+;
			[Left Join SigCdGrp g On b.cgrus = g.cgrus ]+;
LcQprCom  = [Select a.*,b.dpros,b.ifors,b.reffs,b.cgrus,b.situas,c.rclis,g.dgrus ]+;
			[From SigCdMax a, SigCdPro b ]+;
			[Left Join SigCdCli c On b.ifors = c.iclis ]+;
			[Left Join SigCdGrp g On b.cgrus = g.cgrus ]+;
lcQCopia  = [Select 1 As marcas,0 As existes,a.cpros,a.emps,a.Qmaxs,a.codtams,a.codcores,a.cidchaves ]+;
			[From SigCdMax a ]+;
 				[(Select b.cpros + b.codtams + b.codcores As cprotamcores From SigCdMax b ]+;
			[Select 0 As marcas,1 As existes,a.cpros,a.emps,a.Qmaxs,a.codtams,a.codcores,a.cidchaves ]+;
			[From SigCdMax a ]+;
 				[(Select b.cpros + b.codtams + b.codcores As cprotamcores From SigCdMax b ]+;
			[Select 0 As marcas,2 As existes,a.cpros,a.emps,a.Qmaxs,a.codtams,a.codcores,a.cidchaves ]+;
			[From SigCdMax a ]+;
 				[(Select b.cpros + b.codtams + b.codcores As cprotamcores From SigCdMax b ]+;
If ThisForm.poDataMgr.SqlExecute([Select gesind From SigCdPam ],'CrSigCdPam') < 1
ThisForm.poDataMgr.Update('CrSigCdMax')
Select CrSigCdMax
Delete From CrSigCdMax
Delete From CrSigCdMax
ThisForm.poDataMgr.Update('CrSigCdMax')
ThisForm.poDataMgr.Update('CrSigCdMax')
Select CrProdutos
Select Distinct cpros,dpros,cgrus,dgrus,ifors,rclis,reffs,Qmaxs,situas ;
  From CrSigCdMax ;
	Insert Into CsCabec (cpros,dpros,cgrus,dgrus,ifors,rclis,reffs,Qmaxs,situas) ;
Select CrSigCdMax
	lStrQuery = [Select rclis From SigCdCli Where iclis = ']+ThisForm.pcIFors+[']
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpIFors') < 1
	lStrQuery = [Select Dgrus From SigCdGrp Where CGrus = ']+ThisForm.pcCGrus+[']
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpCGrus') < 1
	Select CrSigCdMax
	Insert Into CrSigCdMax (cpros,cidchaves) Values (ThisForm.pcCPros,fUniqueIds())
	Select CrSigCdMax
	Insert Into CsCabec (cpros,dpros,ifors,rclis,cgrus,dgrus,reffs,situas) ;
		Select CrSigCdMax
	Select CrSigCdMax
			Delete
	Select CrSigCdMax
		Insert Into CrSigCdMax (cpros,cidchaves) Values (Thisform.pagina.dados.get_Produto.Value,fUniqueIds())
		Select CrSigCdMax
Select CsCopia
		Insert Into CrSigCdMax (cpros,emps,Qmaxs,codtams,codcores,cidchaves,Deptos) ;
ThisForm.poDataMgr.Update('CrSigCdMax')
	Select CsCopia
	Select CsCopia
		.Column1.ControlSource = 'CsCopia.marcas'
		.Column2.ControlSource = 'CsCopia.cpros'
		.Column3.ControlSource = 'CsCopia.Qmaxs'
		.Column4.ControlSource = 'CsCopia.codtams'
		.Column5.ControlSource = 'CsCopia.codcores'
		.Column6.ControlSource = 'CsCopia.Deptos'
Select CsCopia
Update CsCopia Set Marcas = 1 Where existes = 0
Select CsCopia
Update CsCopia Set Marcas = 0 Where existes = 0
		lStrQuery = [Select a.cpros,a.dpros,a.cgrus,a.ifors,a.reffs,a.situas,c.rclis,g.dgrus ]+;
					[From SigCdPro a ]+;
					[Left Join SigCdGrp g On g.cgrus = a.cgrus ]+;
					[Left Join SigCdCli c On c.iclis = a.ifors ]+;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
		Select TmpPro
			Select CrSigCdMax
		Insert Into CrSigCdMax (cpros,cidchaves) Values (TmpPro.cpros,fUniqueIds())
		Select CrSigCdMax
		Insert Into CsCabec (cpros,dpros,ifors,rclis,cgrus,dgrus,reffs,situas) ;
Select CrSigCdMax
Delete From CrSigCdMax Where emps = lcEmps
Select CrSigCdMax
	Insert Into CrSigCdMax (cpros,cidchaves) Values (This.Parent.Get_Produto.Value,fUniqueIds())
Select CrSigCdMax
	Select CrSigCdMax
		lStrQuery = [Select a.cpros,a.dpros,a.cgrus,a.ifors,a.reffs,a.situas,c.rclis,g.dgrus ]+;
					[From SigCdPro a ]+;
					[Left Join SigCdGrp g On g.cgrus = a.cgrus ]+;
					[Left Join SigCdCli c On c.iclis = a.ifors ]+;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
		Select TmpPro
			Select CrSigCdMax
		Insert Into CrSigCdMax (cpros,cidchaves) Values (TmpPro.cpros,fUniqueIds())
		Select CrSigCdMax
		Insert Into CsCabec (cpros,dpros,ifors,rclis,cgrus,dgrus,reffs,situas) ;

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprcom.prg) - TRECHOS RELEVANTES PARA PASS SQL (1951 linhas total):

*-- Linhas 346 a 364:
346:         loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
347:         loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
348:         loc_oGrid.HighlightStyle     = 2
349:         loc_oGrid.DeleteMark         = .F.
350:         loc_oGrid.RecordMark         = .F.
351:         loc_oGrid.RowHeight          = 16
352:         loc_oGrid.ScrollBars         = 2
353:         loc_oGrid.GridLines          = 3
354:         loc_oGrid.ReadOnly           = .T.
355:         WITH loc_oGrid
356:             .Column1.Width = 108
357:             .Column2.Width = 285
358:             .Column3.Width = 75
359:             .Column4.Width = 150
360:             .Column5.Width = 45
361:         ENDWITH
362: 
363:         THIS.TornarControlesVisiveis(loc_oPagina)
364:     ENDPROC

*-- Linhas 709 a 751:
709: 
710:         *-- Cursor placeholder da grade de itens (deve existir ANTES do Grid.Init - regra #41)
711:         *-- cidchaves NAO tem coluna na grade: carrega a PK da linha JA gravada em
712:         *-- SigCdMax, para o Confirmar saber se cada linha eh INSERT (chave vazia)
713:         *-- ou UPDATE (chave preenchida). Sem isso, ALTERAR reinseria tudo.
714:         IF USED("cursor_4c_Itens")
715:             USE IN cursor_4c_Itens
716:         ENDIF
717:         SET NULL ON
718:         CREATE CURSOR cursor_4c_Itens ;
719:             (cidchaves C(20), cpros C(14), emps C(3), qmaxs N(7,2), codtams C(4), codcores C(4), deptos C(10))
720:         SET NULL OFF
721: 
722:         *-- gradei - Grade de Itens (Empresa/Qtde.Maxima/Tamanho/Cor/Departamento) do Produto selecionado
723:         loc_oPagina.AddObject("grd_4c_Itens", "Grid")
724:         loc_oGridItens                    = loc_oPagina.grd_4c_Itens
725:         loc_oGridItens.Top                = 221
726:         loc_oGridItens.Left               = 309
727:         loc_oGridItens.Width              = 387
728:         loc_oGridItens.Height             = 472
729:         loc_oGridItens.ColumnCount = 5
730:         loc_oGridItens.RecordSource       = "cursor_4c_Itens"
731:         loc_oGridItens.ColumnCount        = 5
732:         loc_oGridItens.Column1.ControlSource = "cursor_4c_Itens.emps"
733:         loc_oGridItens.Column2.ControlSource = "cursor_4c_Itens.qmaxs"
734:         loc_oGridItens.Column3.ControlSource = "cursor_4c_Itens.codtams"
735:         loc_oGridItens.Column4.ControlSource = "cursor_4c_Itens.codcores"
736:         loc_oGridItens.Column5.ControlSource = "cursor_4c_Itens.deptos"
737:         loc_oGridItens.Column1.Width       = 50
738:         loc_oGridItens.Column2.Width       = 100
739:         loc_oGridItens.Column3.Width       = 90
740:         loc_oGridItens.Column4.Width       = 90
741:         loc_oGridItens.Column5.Width       = 57
742:         loc_oGridItens.Column1.Header1.Caption = "Emp"
743:         loc_oGridItens.Column2.Header1.Caption = "Qtde. M" + CHR(225) + "xima"
744:         loc_oGridItens.Column3.Header1.Caption = "Tamanho"
745:         loc_oGridItens.Column4.Header1.Caption = "Cor"
746:         loc_oGridItens.Column5.Header1.Caption = "Departamento"
747:         loc_oGridItens.Column1.Text1.MaxLength = 3
748:         loc_oGridItens.Column1.Text1.Format    = "!"
749:         loc_oGridItens.Column2.Text1.InputMask = "99999.99"
750:         loc_oGridItens.Column3.Text1.MaxLength = 4
751:         loc_oGridItens.Column3.Text1.Format    = "!"

*-- Linhas 758 a 776:
758:         loc_oGridItens.ForeColor           = RGB(0, 0, 0)
759:         loc_oGridItens.BackColor           = RGB(255, 255, 255)
760:         loc_oGridItens.GridLineColor       = RGB(238, 238, 238)
761:         loc_oGridItens.DeleteMark          = .F.
762:         loc_oGridItens.ScrollBars          = 2
763:         loc_oGridItens.GridLines           = 3
764:         BINDEVENT(loc_oGridItens, "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
765:         BINDEVENT(loc_oGridItens.Column1.Text1, "KeyPress", THIS, "GradeItensEmpresaLostFocus")
766:         BINDEVENT(loc_oGridItens.Column3.Text1, "KeyPress", THIS, "GradeItensTamanhoLostFocus")
767:         BINDEVENT(loc_oGridItens.Column4.Text1, "KeyPress", THIS, "GradeItensCorLostFocus")
768:         BINDEVENT(loc_oGridItens.Column5.Text1, "KeyPress", THIS, "GradeItensDepartamentoLostFocus")
769: 
770:         *-- Container BotoesAcao (Grupo_Salva no legado) - Confirmar/Cancelar
771:         loc_oCntAcao = loc_oPagina.cnt_4c_BotoesAcao
772:         loc_oCntAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
773:         WITH loc_oCntAcao.cmd_4c_Confirmar
774:             .Caption         = "Confirmar"
775:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
776:             .PicturePosition = 13

*-- Linhas 831 a 864:
831:             IF USED("cursor_4c_Lista")
832:                 USE IN cursor_4c_Lista
833:             ENDIF
834:             CREATE CURSOR cursor_4c_Lista ;
835:                 (cpros C(14), dpros C(40), ifors C(10), reffs C(20), sgrus C(6))
836:             RETURN .T.
837:         ENDIF
838: 
839:         TRY
840:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
841: 
842:             IF THIS.this_oBusinessObject.Buscar("")
843:                 loc_oGrid.ColumnCount            = 5
844:                 loc_oGrid.RecordSource            = "cursor_4c_Lista"
845:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Lista.cpros"
846:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Lista.dpros"
847:                 loc_oGrid.Column3.ControlSource   = "cursor_4c_Lista.ifors"
848:                 loc_oGrid.Column4.ControlSource   = "cursor_4c_Lista.reffs"
849:                 loc_oGrid.Column5.ControlSource   = "cursor_4c_Lista.sgrus"
850: 
851:                 *-- Reconfigurar cabecalhos APOS RecordSource (obrigatorio)
852:                 loc_oGrid.Column1.Header1.Caption = "Produto"
853:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
854:                 loc_oGrid.Column3.Header1.Caption = "Fornecedor"
855:                 loc_oGrid.Column4.Header1.Caption = "Refer" + CHR(234) + "ncia"
856:                 loc_oGrid.Column5.Header1.Caption = "Sub Grp"
857: 
858:                 loc_oGrid.Column1.Width = 108
859:                 loc_oGrid.Column2.Width = 285
860:                 loc_oGrid.Column3.Width = 75
861:                 loc_oGrid.Column4.Width = 150
862:                 loc_oGrid.Column5.Width = 45
863: 
864:                 THIS.FormatarGridLista(loc_oGrid)

*-- Linhas 997 a 1016:
997: 
998:         IF loc_lConfirmou
999:             TRY
1000:                 loc_cSQL = "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(loc_cCodigo)
1001:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
1002: 
1003:                 IF loc_nResultado >= 0
1004:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
1005:                     THIS.CarregarLista()
1006:                 ELSE
1007:                     MsgErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1008:                 ENDIF
1009:             CATCH TO loc_oErro
1010:                 MsgErro(loc_oErro.Message, "BtnExcluirClick")
1011:             ENDTRY
1012:         ENDIF
1013:     ENDPROC
1014: 
1015:     *===========================================================================
1016:     * BtnBuscarClick - Coloca o form em modo BUSCAR (busca por exemplo).

*-- Linhas 1058 a 1090:
1058:         TRY
1059:             DO CASE
1060:                 CASE !EMPTY(loc_cCodigo)
1061:                     loc_cSQL = "SELECT cpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCodigo)
1062:                 CASE !EMPTY(loc_cDescricao)
1063:                     loc_cSQL = "SELECT cpros FROM SigCdPro WHERE dpros = " + EscaparSQL(loc_cDescricao)
1064:                 CASE !EMPTY(loc_cFornecedor)
1065:                     loc_cSQL = "SELECT cpros FROM SigCdPro WHERE ifors = " + EscaparSQL(loc_cFornecedor)
1066:                 CASE !EMPTY(loc_cReferencia)
1067:                     loc_cSQL = "SELECT cpros FROM SigCdPro WHERE reffs = " + EscaparSQL(loc_cReferencia)
1068:                 OTHERWISE
1069:                     loc_cSQL = ""
1070:             ENDCASE
1071: 
1072:             IF EMPTY(loc_cSQL)
1073:                 MsgAviso("Informe ao menos um crit" + CHR(233) + "rio de busca !!!")
1074:             ELSE
1075:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaExemplo")
1076:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaExemplo") AND !EOF("cursor_4c_BuscaExemplo")
1077:                     loc_cCodigoEncontrado = ALLTRIM(cursor_4c_BuscaExemplo.cpros)
1078:                 ELSE
1079:                     MsgAviso("Produto n" + CHR(227) + "o encontrado !!!")
1080:                 ENDIF
1081:             ENDIF
1082:         CATCH TO loc_oErro
1083:             MsgErro(loc_oErro.Message, "ExecutarBusca")
1084:         ENDTRY
1085: 
1086:         IF USED("cursor_4c_BuscaExemplo")
1087:             USE IN cursor_4c_BuscaExemplo
1088:         ENDIF
1089: 
1090:         IF !EMPTY(loc_cCodigoEncontrado)

*-- Linhas 1165 a 1183:
1165:         loc_oBO     = THIS.this_oBusinessObject
1166:         loc_cProduto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.Value)
1167: 
1168:         SELECT cursor_4c_Itens
1169: 
1170:         *-- cidchaves vazio = linha nova (o Inserir do BO gera a PK com fUniqueIds)
1171:         loc_oBO.this_cCidChaves = ALLTRIM(NVL(cursor_4c_Itens.cidchaves, ""))
1172: 
1173:         *-- A linha pode ter sido criada em branco por AdicionarNovaLinhaItem
1174:         *-- antes do Produto estar escolhido: o cabecalho eh a fonte de verdade
1175:         loc_oBO.this_cCPros     = IIF(EMPTY(loc_cProduto), ;
1176:                                       ALLTRIM(NVL(cursor_4c_Itens.cpros, "")), loc_cProduto)
1177:         loc_oBO.this_cEmps      = ALLTRIM(NVL(cursor_4c_Itens.emps, ""))
1178:         loc_oBO.this_cCodTams   = ALLTRIM(NVL(cursor_4c_Itens.codtams, ""))
1179:         loc_oBO.this_cCodCores  = ALLTRIM(NVL(cursor_4c_Itens.codcores, ""))
1180:         loc_oBO.this_cDeptos    = ALLTRIM(NVL(cursor_4c_Itens.deptos, ""))
1181:         loc_oBO.this_nQMaxs     = NVL(cursor_4c_Itens.qmaxs, 0)
1182: 
1183:         *-- ordems eh char(1) NOT NULL sem campo na tela (o legado grava o

*-- Linhas 1210 a 1228:
1210:         ENDIF
1211: 
1212:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1213:             SELECT cursor_4c_Itens
1214:             REPLACE cidchaves WITH loc_oBO.this_cCidChaves, ;
1215:                     cpros     WITH loc_oBO.this_cCPros, ;
1216:                     emps      WITH loc_oBO.this_cEmps, ;
1217:                     codtams   WITH loc_oBO.this_cCodTams, ;
1218:                     codcores  WITH loc_oBO.this_cCodCores, ;
1219:                     deptos    WITH loc_oBO.this_cDeptos, ;
1220:                     qmaxs     WITH loc_oBO.this_nQMaxs ;
1221:                 IN cursor_4c_Itens
1222:         ENDIF
1223: 
1224:         RETURN .T.
1225:     ENDPROC
1226: 
1227:     *===========================================================================
1228:     * LimparCampos - Hook do FormBase: limpa a ficha do Produto e a grade de

*-- Linhas 1251 a 1281:
1251:         loc_lSucesso = .F.
1252: 
1253:         TRY
1254:             loc_cSQL = "SELECT a.cpros, a.dpros, a.cgrus, a.ifors, a.reffs, a.situas," + ;
1255:                 " c.rclis, g.dgrus, g.tipoestos, g.cores, g.tams" + ;
1256:                 " FROM SigCdPro a" + ;
1257:                 " LEFT JOIN SigCdGrp g ON g.cgrus = a.cgrus" + ;
1258:                 " LEFT JOIN SigCdCli c ON c.iclis = a.ifors" + ;
1259:                 " WHERE a.cpros = " + EscaparSQL(par_cCodigo)
1260: 
1261:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutoInfo")
1262: 
1263:             IF loc_nResultado < 1 OR !USED("cursor_4c_ProdutoInfo") OR EOF("cursor_4c_ProdutoInfo")
1264:                 MsgErro("Produto n" + CHR(227) + "o encontrado.", "Erro")
1265:             ELSE
1266:                 SELECT cursor_4c_ProdutoInfo
1267: 
1268:                 loc_oPagina.txt_4c__Produto.Value     = TratarNulo(cpros, "")
1269:                 loc_oPagina.txt_4c_Dpro.Value          = TratarNulo(dpros, "")
1270:                 loc_oPagina.txt_4c_Cgru.Value          = TratarNulo(cgrus, "")
1271:                 loc_oPagina.txt_4c_Dgru.Value          = TratarNulo(dgrus, "")
1272:                 loc_oPagina.txt_4c_Ifor.Value           = TratarNulo(ifors, "")
1273:                 loc_oPagina.txt_4c_Dfor.Value           = TratarNulo(rclis, "")
1274:                 loc_oPagina.txt_4c_Refs.Value           = TratarNulo(reffs, "")
1275:                 loc_oPagina.obj_4c_Opc_situacao.Value  = IIF(NVL(situas, 1) = 2, 2, 1)
1276: 
1277:                 THIS.this_nTipoEstos = TratarNulo(tipoestos, 0)
1278:                 THIS.this_lTemCor    = INLIST(THIS.this_nTipoEstos, 2, 4) OR TratarNulo(cores, 0) = 1
1279:                 THIS.this_lTemTam    = INLIST(THIS.this_nTipoEstos, 3, 4) OR TratarNulo(tams, 0) = 1
1280: 
1281:                 IF THIS.CarregarItensGravados(par_cCodigo)

*-- Linhas 1307 a 1348:
1307:         loc_lSucesso = .F.
1308: 
1309:         TRY
1310:             loc_cSQL = "SELECT cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos" + ;
1311:                 " FROM SigCdMax WHERE cpros = " + EscaparSQL(par_cCodigo) + ;
1312:                 " ORDER BY emps, codtams, codcores"
1313: 
1314:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensTemp")
1315: 
1316:             IF loc_nResultado >= 0 AND USED("cursor_4c_Itens")
1317:                 SELECT cursor_4c_Itens
1318:                 ZAP
1319: 
1320:                 IF USED("cursor_4c_ItensTemp")
1321:                     SELECT cursor_4c_ItensTemp
1322:                     SCAN
1323:                         INSERT INTO cursor_4c_Itens (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos) ;
1324:                             VALUES (cursor_4c_ItensTemp.cidchaves, cursor_4c_ItensTemp.cpros, ;
1325:                                     cursor_4c_ItensTemp.emps, cursor_4c_ItensTemp.qmaxs, ;
1326:                                     cursor_4c_ItensTemp.codtams, cursor_4c_ItensTemp.codcores, ;
1327:                                     cursor_4c_ItensTemp.deptos)
1328:                     ENDSCAN
1329:                 ENDIF
1330: 
1331:                 SELECT cursor_4c_Itens
1332:                 IF RECCOUNT("cursor_4c_Itens") = 0
1333:                     INSERT INTO cursor_4c_Itens (cpros) VALUES (par_cCodigo)
1334:                 ENDIF
1335:                 GO TOP IN cursor_4c_Itens
1336:                 loc_lSucesso = .T.
1337:             ENDIF
1338:         CATCH TO loc_oErro
1339:             MsgErro(loc_oErro.Message, "CarregarItensGravados")
1340:         ENDTRY
1341: 
1342:         IF USED("cursor_4c_ItensTemp")
1343:             USE IN cursor_4c_ItensTemp
1344:         ENDIF
1345: 
1346:         RETURN loc_lSucesso
1347:     ENDPROC
1348: 

*-- Linhas 1463 a 1504:
1463:     ENDPROC
1464: 
1465:     *===========================================================================
1466:     * CarregarProdutoSelecionado - Carrega dados do Produto (join Grupo/Fornecedor),
1467:     * valida situacao/duplicidade e prepara a grade de itens para inclusao
1468:     * Legado: get_produto.Valid + ThisForm.AcertaGrade() + ThisForm.MRefreshGet()
1469:     *===========================================================================
1470:     PROCEDURE CarregarProdutoSelecionado(par_cCodigo)
1471:         LOCAL loc_oPagina, loc_cSQL, loc_nResultado, loc_lInativo
1472: 
1473:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1474: 
1475:         TRY
1476:             loc_cSQL = "SELECT a.cpros, a.dpros, a.cgrus, a.ifors, a.reffs, a.situas," + ;
1477:                 " c.rclis, g.dgrus, g.tipoestos, g.cores, g.tams" + ;
1478:                 " FROM SigCdPro a" + ;
1479:                 " LEFT JOIN SigCdGrp g ON g.cgrus = a.cgrus" + ;
1480:                 " LEFT JOIN SigCdCli c ON c.iclis = a.ifors" + ;
1481:                 " WHERE a.cpros = " + EscaparSQL(par_cCodigo)
1482: 
1483:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutoInfo")
1484: 
1485:             IF loc_nResultado < 1 OR !USED("cursor_4c_ProdutoInfo") OR EOF("cursor_4c_ProdutoInfo")
1486:                 MsgErro("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
1487:                 THIS.LimparDadosProduto()
1488:             ELSE
1489:                 SELECT cursor_4c_ProdutoInfo
1490: 
1491:                 *-- Verifica se produto esta inativo (bloqueia se parametro gesind=1)
1492:                 loc_lInativo = .F.
1493:                 IF NVL(situas, 0) = 2
1494:                     IF THIS.ParametroGestaoIndireta()
1495:                         loc_lInativo = .T.
1496:                     ENDIF
1497:                 ENDIF
1498: 
1499:                 IF loc_lInativo
1500:                     MsgAviso("Produto Inativo !!!")
1501:                     THIS.LimparDadosProduto()
1502:                 ELSE
1503:                     IF THIS.this_oBusinessObject.ExistemItensParaProduto(par_cCodigo)
1504:                         MsgAviso("Produto j" + CHR(225) + " cadastrado !!!")

*-- Linhas 1520 a 1538:
1520:                         *-- Prepara a grade com UMA linha em branco para o usuario preencher
1521:                         IF USED("cursor_4c_Itens")
1522:                             ZAP IN cursor_4c_Itens
1523:                             INSERT INTO cursor_4c_Itens (cpros) VALUES (par_cCodigo)
1524:                         ENDIF
1525: 
1526:                         loc_oPagina.grd_4c_Itens.Column3.Enabled = THIS.this_lTemTam
1527:                         loc_oPagina.grd_4c_Itens.Column4.Enabled = THIS.this_lTemCor
1528:                         loc_oPagina.grd_4c_Itens.Refresh()
1529: 
1530:                         loc_oPagina.cmd_4c_BtnExcluir.Visible = .T.
1531:                         THIS.this_cModoAtual = "INCLUIR"
1532:                     ENDIF
1533:                 ENDIF
1534:             ENDIF
1535:         CATCH TO loc_oErro
1536:             MsgErro(loc_oErro.Message, "CarregarProdutoSelecionado")
1537:             THIS.LimparDadosProduto()
1538:         ENDTRY

*-- Linhas 1550 a 1568:
1550:         loc_lResultado = .F.
1551: 
1552:         TRY
1553:             IF SQLEXEC(gnConnHandle, "SELECT gesind FROM SigCdPam", "cursor_4c_Param") > 0
1554:                 IF USED("cursor_4c_Param") AND !EOF("cursor_4c_Param")
1555:                     loc_lResultado = (TratarNulo(cursor_4c_Param.gesind, 0) = 1)
1556:                 ENDIF
1557:             ENDIF
1558:         CATCH TO loc_oErro
1559:             loc_lResultado = .F.
1560:         ENDTRY
1561: 
1562:         IF USED("cursor_4c_Param")
1563:             USE IN cursor_4c_Param
1564:         ENDIF
1565: 
1566:         RETURN loc_lResultado
1567:     ENDPROC
1568: 

*-- Linhas 1747 a 1811:
1747:         loc_oGrid   = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
1748:         loc_cProduto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.Value)
1749: 
1750:         SELECT cursor_4c_Itens
1751:         LOCATE FOR EMPTY(emps)
1752:         IF !FOUND()
1753:             INSERT INTO cursor_4c_Itens (cpros) VALUES (loc_cProduto)
1754:         ENDIF
1755: 
1756:         loc_oGrid.Refresh()
1757:     ENDPROC
1758: 
1759:     *===========================================================================
1760:     * BtnExcluirItemClick - Remove da grade local os itens da Empresa corrente
1761:     * Legado: btnExcluir.Click
1762:     *===========================================================================
1763:     PROCEDURE BtnExcluirItemClick()
1764:         LOCAL loc_cEmps, loc_cProduto, loc_oGrid
1765: 
1766:         IF !USED("cursor_4c_Itens")
1767:             RETURN
1768:         ENDIF
1769: 
1770:         loc_oGrid    = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
1771:         loc_cProduto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.Value)
1772:         loc_cEmps    = ""
1773: 
1774:         SELECT cursor_4c_Itens
1775:         IF !EOF() AND !EMPTY(emps)
1776:             loc_cEmps = emps
1777:         ENDIF
1778: 
1779:         IF !EMPTY(loc_cEmps)
1780:             DELETE FROM cursor_4c_Itens WHERE emps == loc_cEmps
1781:             SELECT cursor_4c_Itens
1782:             PACK
1783:         ENDIF
1784: 
1785:         SELECT cursor_4c_Itens
1786:         LOCATE
1787:         IF EOF()
1788:             INSERT INTO cursor_4c_Itens (cpros) VALUES (loc_cProduto)
1789:         ENDIF
1790: 
1791:         loc_oGrid.Refresh()
1792:     ENDPROC
1793: 
1794:     *===========================================================================
1795:     * BtnConfirmarClick - Grava na tabela SigCdMax cada linha valida da grade
1796:     * Legado: btnConfirma equivalente (TableUpdate do cursor CrSigCdMax)
1797:     *===========================================================================
1798:     PROCEDURE BtnConfirmarClick()
1799:         LOCAL loc_lSucesso, loc_nLinhasGravadas, loc_cProduto, loc_cChavesMantidas
1800:         LOCAL loc_lLinhaNova, loc_lEraAlteracao
1801: 
1802:         *-- Em modo BUSCAR, Confirmar executa a busca por exemplo (legado: msv_procurar)
1803:         IF THIS.this_cModoAtual == "BUSCAR"
1804:             THIS.ExecutarBusca()
1805:             RETURN
1806:         ENDIF
1807: 
1808:         *-- VISUALIZAR nao grava (HabilitarCampos(.F.) ja desliga o botao; esta
1809:         *-- guarda cobre a chamada por teclado/atalho)
1810:         IF THIS.this_cModoAtual == "VISUALIZAR" OR !USED("cursor_4c_Itens")
1811:             RETURN

*-- Linhas 1825 a 1857:
1825:         loc_cChavesMantidas = ""
1826:         loc_lEraAlteracao   = (THIS.this_cModoAtual == "ALTERAR")
1827: 
1828:         SELECT cursor_4c_Itens
1829:         SCAN FOR !EMPTY(emps)
1830:             IF THIS.this_lTemTam AND EMPTY(codtams)
1831:                 MsgAviso("Obrigat" + CHR(243) + "rio informar Tamanho !!!")
1832:                 loc_lSucesso = .F.
1833:                 EXIT
1834:             ENDIF
1835:             IF THIS.this_lTemCor AND EMPTY(codcores)
1836:                 MsgAviso("Obrigat" + CHR(243) + "rio informar C" + CHR(243) + "digo da Cor !!!")
1837:                 loc_lSucesso = .F.
1838:                 EXIT
1839:             ENDIF
1840: 
1841:             *-- Linha SEM cidchaves eh nova (INSERT); com chave, eh uma linha ja
1842:             *-- gravada em SigCdMax e o que se quer eh UPDATE. Sem esta distincao
1843:             *-- o ALTERAR reinseria todas as linhas do Produto.
1844:             loc_lLinhaNova = EMPTY(NVL(cursor_4c_Itens.cidchaves, ""))
1845: 
1846:             IF loc_lLinhaNova
1847:                 THIS.this_oBusinessObject.NovoRegistro()
1848:             ELSE
1849:                 *-- CancelarEdicao zera this_lNovoRegistro (que BtnAlterarClick
1850:                 *-- deixou ligado); sem isso EditarRegistro recusa e o Salvar
1851:                 *-- cairia no Inserir, duplicando o registro
1852:                 THIS.this_oBusinessObject.CancelarEdicao()
1853:                 THIS.this_oBusinessObject.EditarRegistro()
1854:             ENDIF
1855: 
1856:             *-- FormParaBO depois de NovoRegistro/EditarRegistro: NovoRegistro
1857:             *-- chama LimparDados e apagaria o que fosse mapeado antes

*-- Linhas 1873 a 1892:
1873:         ENDSCAN
1874: 
1875:         *-- Linhas que o usuario removeu da grade com btnExcluir precisam sair do
1876:         *-- banco: no legado o cursor era uma view atualizavel e o Delete local
1877:         *-- ia junto no Update/Commit; aqui a grade eh um cursor local.
1878:         IF loc_lSucesso AND loc_lEraAlteracao
1879:             loc_lSucesso = THIS.this_oBusinessObject.ExcluirItensRemovidos(loc_cProduto, loc_cChavesMantidas)
1880:         ENDIF
1881: 
1882:         IF loc_lSucesso
1883:             IF loc_nLinhasGravadas = 0 AND !loc_lEraAlteracao
1884:                 MsgAviso("Nenhum item informado para grava" + CHR(231) + CHR(227) + "o.")
1885:             ELSE
1886:                 MsgInfo("Registro salvo com sucesso!", "Confirmar")
1887:                 THIS.LimparCampos()
1888:                 THIS.AlternarPagina(1)
1889:             ENDIF
1890:         ENDIF
1891:     ENDPROC
1892: 


### BO (C:\4c\projeto\app\classes\sigprcomBO.prg):
*====================================================================
* sigprcomBO.prg
*
* Business Object para Estoque Maximo por Produto/Empresa/Tamanho/Cor
* Tabela: SigCdMax
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigprcomBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdMax)
    this_cCidChaves = ""    && cidchaves char(20) - PK
    this_cCPros     = ""    && cpros char(14)
    this_cEmps      = ""    && emps char(3)
    this_cCodTams   = ""    && codtams char(4)
    this_cCodCores  = ""    && codcores char(4)
    this_cDeptos    = ""    && deptos char(10)
    this_cOrdems    = ""    && ordems char(1)
    this_nQMaxs     = 0     && qmaxs numeric(7,2)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMax"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigprcomBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * LimparDados - Reseta as propriedades da entidade
    * CRITICO: sem este override, this_cCidChaves sobrevive entre chamadas
    * de NovoRegistro() e o Inserir() reaproveita a MESMA chave gerada na
    * linha anterior (EMPTY() so gera nova se estiver vazia) - a 2a linha
    * de uma grade com N linhas estoura violacao de PK unica em silencio
    * (o loop do form para no primeiro Salvar() que falhar).
    *====================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCidChaves = ""
        THIS.this_cCPros     = ""
        THIS.this_cEmps      = ""
        THIS.this_cCodTams   = ""
        THIS.this_cCodCores  = ""
        THIS.this_cDeptos    = ""
        THIS.this_cOrdems    = ""
        THIS.this_nQMaxs     = 0
    ENDPROC

    *====================================================================
    * Buscar - Lista, na Pagina Lista, os Produtos com registro em SigCdMax
    * Legado: lcQProds (Init) -> AddCursor('SigCdMax','cpros','CrProdutos',...)
    * Cursor de saida: cursor_4c_Lista (cpros/dpros/ifors/reffs/sgrus)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Lista")
                USE IN cursor_4c_Lista
            ENDIF

            loc_cSQL = "SELECT a.cpros, b.dpros, b.ifors, b.reffs, b.sgrus" + ;
                " FROM SigCdMax a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                " GROUP BY a.cpros, b.dpros, b.ifors, b.reffs, b.sgrus" + ;
                " ORDER BY a.cpros"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Estoque M" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "sigprcomBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            *-- TratarNulo(valor, PADRAO): o 2o argumento eh o VALOR de retorno
            *-- quando a coluna vem NULL - NAO um codigo de tipo. Passar "C"/"N"
            *-- gravaria a letra na property (e a STRING "N" em this_nQMaxs, que
            *-- depois estoura no FormatarNumeroSQL do Inserir/Atualizar).
            THIS.this_cCidChaves = TratarNulo(cidchaves, "")
            THIS.this_cCPros     = TratarNulo(cpros, "")
            THIS.this_cEmps      = TratarNulo(emps, "")
            THIS.this_cCodTams   = TratarNulo(codtams, "")
            THIS.this_cCodCores  = TratarNulo(codcores, "")
            THIS.this_cDeptos    = TratarNulo(deptos, "")
            THIS.this_cOrdems    = TratarNulo(ordems, "")
            THIS.this_nQMaxs     = TratarNulo(qmaxs, 0)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT na tabela SigCdMax
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdMax" + ;
                       " (cidchaves, cpros, emps, codtams, codcores, deptos, ordems, qmaxs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cCPros) + "," + ;
                       EscaparSQL(THIS.this_cEmps) + "," + ;
                       EscaparSQL(THIS.this_cCodTams) + "," + ;
                       EscaparSQL(THIS.this_cCodCores) + "," + ;
                       EscaparSQL(THIS.this_cDeptos) + "," + ;
                       EscaparSQL(THIS.this_cOrdems) + "," + ;
                       FormatarNumeroSQL(THIS.this_nQMaxs, 2) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao inserir estoque m" + CHR(225) + "ximo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE na tabela SigCdMax
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMax SET" + ;
                       " cpros = "    + EscaparSQL(THIS.this_cCPros) + "," + ;
                       " emps = "     + EscaparSQL(THIS.this_cEmps) + "," + ;
                       " codtams = "  + EscaparSQL(THIS.this_cCodTams) + "," + ;
                       " codcores = " + EscaparSQL(THIS.this_cCodCores) + "," + ;
                       " deptos = "   + EscaparSQL(THIS.this_cDeptos) + "," + ;
                       " ordems = "   + EscaparSQL(THIS.this_cOrdems) + "," + ;
                       " qmaxs = "    + FormatarNumeroSQL(THIS.this_nQMaxs, 2) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao atualizar estoque m" + CHR(225) + "ximo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExistemItensParaProduto - Verifica se o Produto ja possui registros
    * gravados em SigCdMax (legado: ThisForm.AcertaGrade requery + !Eof())
    *====================================================================
    FUNCTION ExistemItensParaProduto(par_cCodigo)
        LOCAL loc_lExiste, loc_nResultado
        loc_lExiste = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT cidchaves FROM SigCdMax WHERE cpros = " + EscaparSQL(par_cCodigo), ;
                "cursor_4c_VerificaMax")
            IF loc_nResultado > 0
                loc_lExiste = (RECCOUNT("cursor_4c_VerificaMax") > 0)
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigprcomBO.ExistemItensParaProduto")
        ENDTRY

        IF USED("cursor_4c_VerificaMax")
            USE IN cursor_4c_VerificaMax
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *====================================================================
    * ExcluirItensRemovidos - Apaga de SigCdMax as linhas do Produto que
    * NAO estao mais na grade (o usuario removeu com btnExcluir no modo
    * ALTERAR). No legado o cursor CrSigCdMax eh uma view atualizavel e o
    * Delete local + Update/Commit levava a remocao ao banco; aqui a grade
    * eh um cursor local, entao a remocao tem de ser dita ao SQL Server.
    *
    * par_cProduto        - cpros do Produto em edicao
    * par_cChavesMantidas - cidchaves que PERMANECEM, separadas por virgula
    *                       (vazio = nenhuma linha gravada permaneceu)
    *====================================================================
    FUNCTION ExcluirItensRemovidos(par_cProduto, par_cChavesMantidas)
        LOCAL loc_cSQL, loc_cLista, loc_nResultado, loc_lSucesso, loc_nI, loc_nQtde
        LOCAL ARRAY loc_aChaves[1]
        loc_lSucesso = .F.
        loc_cLista   = ""

        TRY
            IF VARTYPE(par_cChavesMantidas) = "C" AND !EMPTY(par_cChavesMantidas)
                loc_nQtde = ALINES(loc_aChaves, par_cChavesMantidas, 1, ",")
                FOR loc_nI = 1 TO loc_nQtde
                    IF !EMPTY(loc_aChaves[loc_nI])
                        loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ;
                            EscaparSQL(ALLTRIM(loc_aChaves[loc_nI]))
                    ENDIF
                ENDFOR
            ENDIF

            loc_cSQL = "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(par_cProduto)
            IF !EMPTY(loc_cLista)
                loc_cSQL = loc_cSQL + " AND cidchaves NOT IN (" + loc_cLista + ")"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao remover itens do estoque m" + CHR(225) + "ximo:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "sigprcomBO.ExcluirItensRemovidos")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE


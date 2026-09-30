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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprcom.prg) - TRECHOS RELEVANTES PARA PASS SQL (1953 linhas total):

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

*-- Linhas 832 a 866:
832:                 USE IN cursor_4c_Lista
833:             ENDIF
834:             SET NULL ON
835:             CREATE CURSOR cursor_4c_Lista ;
836:                 (cpros C(14), dpros C(40), ifors C(10), reffs C(20), sgrus C(6))
837:             SET NULL OFF
838:             RETURN .T.
839:         ENDIF
840: 
841:         TRY
842:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
843: 
844:             IF THIS.this_oBusinessObject.Buscar("")
845:                 loc_oGrid.ColumnCount            = 5
846:                 loc_oGrid.RecordSource            = "cursor_4c_Lista"
847:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Lista.cpros"
848:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Lista.dpros"
849:                 loc_oGrid.Column3.ControlSource   = "cursor_4c_Lista.ifors"
850:                 loc_oGrid.Column4.ControlSource   = "cursor_4c_Lista.reffs"
851:                 loc_oGrid.Column5.ControlSource   = "cursor_4c_Lista.sgrus"
852: 
853:                 *-- Reconfigurar cabecalhos APOS RecordSource (obrigatorio)
854:                 loc_oGrid.Column1.Header1.Caption = "Produto"
855:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
856:                 loc_oGrid.Column3.Header1.Caption = "Fornecedor"
857:                 loc_oGrid.Column4.Header1.Caption = "Refer" + CHR(234) + "ncia"
858:                 loc_oGrid.Column5.Header1.Caption = "Sub Grp"
859: 
860:                 loc_oGrid.Column1.Width = 108
861:                 loc_oGrid.Column2.Width = 285
862:                 loc_oGrid.Column3.Width = 75
863:                 loc_oGrid.Column4.Width = 150
864:                 loc_oGrid.Column5.Width = 45
865: 
866:                 THIS.FormatarGridLista(loc_oGrid)

*-- Linhas 999 a 1018:
999: 
1000:         IF loc_lConfirmou
1001:             TRY
1002:                 loc_cSQL = "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(loc_cCodigo)
1003:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
1004: 
1005:                 IF loc_nResultado >= 0
1006:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
1007:                     THIS.CarregarLista()
1008:                 ELSE
1009:                     MsgErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1010:                 ENDIF
1011:             CATCH TO loc_oErro
1012:                 MsgErro(loc_oErro.Message, "BtnExcluirClick")
1013:             ENDTRY
1014:         ENDIF
1015:     ENDPROC
1016: 
1017:     *===========================================================================
1018:     * BtnBuscarClick - Coloca o form em modo BUSCAR (busca por exemplo).

*-- Linhas 1060 a 1092:
1060:         TRY
1061:             DO CASE
1062:                 CASE !EMPTY(loc_cCodigo)
1063:                     loc_cSQL = "SELECT cpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCodigo)
1064:                 CASE !EMPTY(loc_cDescricao)
1065:                     loc_cSQL = "SELECT cpros FROM SigCdPro WHERE dpros = " + EscaparSQL(loc_cDescricao)
1066:                 CASE !EMPTY(loc_cFornecedor)
1067:                     loc_cSQL = "SELECT cpros FROM SigCdPro WHERE ifors = " + EscaparSQL(loc_cFornecedor)
1068:                 CASE !EMPTY(loc_cReferencia)
1069:                     loc_cSQL = "SELECT cpros FROM SigCdPro WHERE reffs = " + EscaparSQL(loc_cReferencia)
1070:                 OTHERWISE
1071:                     loc_cSQL = ""
1072:             ENDCASE
1073: 
1074:             IF EMPTY(loc_cSQL)
1075:                 MsgAviso("Informe ao menos um crit" + CHR(233) + "rio de busca !!!")
1076:             ELSE
1077:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaExemplo")
1078:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaExemplo") AND !EOF("cursor_4c_BuscaExemplo")
1079:                     loc_cCodigoEncontrado = ALLTRIM(cursor_4c_BuscaExemplo.cpros)
1080:                 ELSE
1081:                     MsgAviso("Produto n" + CHR(227) + "o encontrado !!!")
1082:                 ENDIF
1083:             ENDIF
1084:         CATCH TO loc_oErro
1085:             MsgErro(loc_oErro.Message, "ExecutarBusca")
1086:         ENDTRY
1087: 
1088:         IF USED("cursor_4c_BuscaExemplo")
1089:             USE IN cursor_4c_BuscaExemplo
1090:         ENDIF
1091: 
1092:         IF !EMPTY(loc_cCodigoEncontrado)

*-- Linhas 1167 a 1185:
1167:         loc_oBO     = THIS.this_oBusinessObject
1168:         loc_cProduto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.Value)
1169: 
1170:         SELECT cursor_4c_Itens
1171: 
1172:         *-- cidchaves vazio = linha nova (o Inserir do BO gera a PK com fUniqueIds)
1173:         loc_oBO.this_cCidChaves = ALLTRIM(NVL(cursor_4c_Itens.cidchaves, ""))
1174: 
1175:         *-- A linha pode ter sido criada em branco por AdicionarNovaLinhaItem
1176:         *-- antes do Produto estar escolhido: o cabecalho eh a fonte de verdade
1177:         loc_oBO.this_cCPros     = IIF(EMPTY(loc_cProduto), ;
1178:                                       ALLTRIM(NVL(cursor_4c_Itens.cpros, "")), loc_cProduto)
1179:         loc_oBO.this_cEmps      = ALLTRIM(NVL(cursor_4c_Itens.emps, ""))
1180:         loc_oBO.this_cCodTams   = ALLTRIM(NVL(cursor_4c_Itens.codtams, ""))
1181:         loc_oBO.this_cCodCores  = ALLTRIM(NVL(cursor_4c_Itens.codcores, ""))
1182:         loc_oBO.this_cDeptos    = ALLTRIM(NVL(cursor_4c_Itens.deptos, ""))
1183:         loc_oBO.this_nQMaxs     = NVL(cursor_4c_Itens.qmaxs, 0)
1184: 
1185:         *-- ordems eh char(1) NOT NULL sem campo na tela (o legado grava o

*-- Linhas 1212 a 1230:
1212:         ENDIF
1213: 
1214:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1215:             SELECT cursor_4c_Itens
1216:             REPLACE cidchaves WITH loc_oBO.this_cCidChaves, ;
1217:                     cpros     WITH loc_oBO.this_cCPros, ;
1218:                     emps      WITH loc_oBO.this_cEmps, ;
1219:                     codtams   WITH loc_oBO.this_cCodTams, ;
1220:                     codcores  WITH loc_oBO.this_cCodCores, ;
1221:                     deptos    WITH loc_oBO.this_cDeptos, ;
1222:                     qmaxs     WITH loc_oBO.this_nQMaxs ;
1223:                 IN cursor_4c_Itens
1224:         ENDIF
1225: 
1226:         RETURN .T.
1227:     ENDPROC
1228: 
1229:     *===========================================================================
1230:     * LimparCampos - Hook do FormBase: limpa a ficha do Produto e a grade de

*-- Linhas 1253 a 1283:
1253:         loc_lSucesso = .F.
1254: 
1255:         TRY
1256:             loc_cSQL = "SELECT a.cpros, a.dpros, a.cgrus, a.ifors, a.reffs, a.situas," + ;
1257:                 " c.rclis, g.dgrus, g.tipoestos, g.cores, g.tams" + ;
1258:                 " FROM SigCdPro a" + ;
1259:                 " LEFT JOIN SigCdGrp g ON g.cgrus = a.cgrus" + ;
1260:                 " LEFT JOIN SigCdCli c ON c.iclis = a.ifors" + ;
1261:                 " WHERE a.cpros = " + EscaparSQL(par_cCodigo)
1262: 
1263:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutoInfo")
1264: 
1265:             IF loc_nResultado < 1 OR !USED("cursor_4c_ProdutoInfo") OR EOF("cursor_4c_ProdutoInfo")
1266:                 MsgErro("Produto n" + CHR(227) + "o encontrado.", "Erro")
1267:             ELSE
1268:                 SELECT cursor_4c_ProdutoInfo
1269: 
1270:                 loc_oPagina.txt_4c__Produto.Value     = TratarNulo(cpros, "")
1271:                 loc_oPagina.txt_4c_Dpro.Value          = TratarNulo(dpros, "")
1272:                 loc_oPagina.txt_4c_Cgru.Value          = TratarNulo(cgrus, "")
1273:                 loc_oPagina.txt_4c_Dgru.Value          = TratarNulo(dgrus, "")
1274:                 loc_oPagina.txt_4c_Ifor.Value           = TratarNulo(ifors, "")
1275:                 loc_oPagina.txt_4c_Dfor.Value           = TratarNulo(rclis, "")
1276:                 loc_oPagina.txt_4c_Refs.Value           = TratarNulo(reffs, "")
1277:                 loc_oPagina.obj_4c_Opc_situacao.Value  = IIF(NVL(situas, 1) = 2, 2, 1)
1278: 
1279:                 THIS.this_nTipoEstos = TratarNulo(tipoestos, 0)
1280:                 THIS.this_lTemCor    = INLIST(THIS.this_nTipoEstos, 2, 4) OR TratarNulo(cores, 0) = 1
1281:                 THIS.this_lTemTam    = INLIST(THIS.this_nTipoEstos, 3, 4) OR TratarNulo(tams, 0) = 1
1282: 
1283:                 IF THIS.CarregarItensGravados(par_cCodigo)

*-- Linhas 1309 a 1350:
1309:         loc_lSucesso = .F.
1310: 
1311:         TRY
1312:             loc_cSQL = "SELECT cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos" + ;
1313:                 " FROM SigCdMax WHERE cpros = " + EscaparSQL(par_cCodigo) + ;
1314:                 " ORDER BY emps, codtams, codcores"
1315: 
1316:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensTemp")
1317: 
1318:             IF loc_nResultado >= 0 AND USED("cursor_4c_Itens")
1319:                 SELECT cursor_4c_Itens
1320:                 ZAP
1321: 
1322:                 IF USED("cursor_4c_ItensTemp")
1323:                     SELECT cursor_4c_ItensTemp
1324:                     SCAN
1325:                         INSERT INTO cursor_4c_Itens (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos) ;
1326:                             VALUES (cursor_4c_ItensTemp.cidchaves, cursor_4c_ItensTemp.cpros, ;
1327:                                     cursor_4c_ItensTemp.emps, cursor_4c_ItensTemp.qmaxs, ;
1328:                                     cursor_4c_ItensTemp.codtams, cursor_4c_ItensTemp.codcores, ;
1329:                                     cursor_4c_ItensTemp.deptos)
1330:                     ENDSCAN
1331:                 ENDIF
1332: 
1333:                 SELECT cursor_4c_Itens
1334:                 IF RECCOUNT("cursor_4c_Itens") = 0
1335:                     INSERT INTO cursor_4c_Itens (cpros) VALUES (par_cCodigo)
1336:                 ENDIF
1337:                 GO TOP IN cursor_4c_Itens
1338:                 loc_lSucesso = .T.
1339:             ENDIF
1340:         CATCH TO loc_oErro
1341:             MsgErro(loc_oErro.Message, "CarregarItensGravados")
1342:         ENDTRY
1343: 
1344:         IF USED("cursor_4c_ItensTemp")
1345:             USE IN cursor_4c_ItensTemp
1346:         ENDIF
1347: 
1348:         RETURN loc_lSucesso
1349:     ENDPROC
1350: 

*-- Linhas 1465 a 1506:
1465:     ENDPROC
1466: 
1467:     *===========================================================================
1468:     * CarregarProdutoSelecionado - Carrega dados do Produto (join Grupo/Fornecedor),
1469:     * valida situacao/duplicidade e prepara a grade de itens para inclusao
1470:     * Legado: get_produto.Valid + ThisForm.AcertaGrade() + ThisForm.MRefreshGet()
1471:     *===========================================================================
1472:     PROCEDURE CarregarProdutoSelecionado(par_cCodigo)
1473:         LOCAL loc_oPagina, loc_cSQL, loc_nResultado, loc_lInativo
1474: 
1475:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1476: 
1477:         TRY
1478:             loc_cSQL = "SELECT a.cpros, a.dpros, a.cgrus, a.ifors, a.reffs, a.situas," + ;
1479:                 " c.rclis, g.dgrus, g.tipoestos, g.cores, g.tams" + ;
1480:                 " FROM SigCdPro a" + ;
1481:                 " LEFT JOIN SigCdGrp g ON g.cgrus = a.cgrus" + ;
1482:                 " LEFT JOIN SigCdCli c ON c.iclis = a.ifors" + ;
1483:                 " WHERE a.cpros = " + EscaparSQL(par_cCodigo)
1484: 
1485:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutoInfo")
1486: 
1487:             IF loc_nResultado < 1 OR !USED("cursor_4c_ProdutoInfo") OR EOF("cursor_4c_ProdutoInfo")
1488:                 MsgErro("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
1489:                 THIS.LimparDadosProduto()
1490:             ELSE
1491:                 SELECT cursor_4c_ProdutoInfo
1492: 
1493:                 *-- Verifica se produto esta inativo (bloqueia se parametro gesind=1)
1494:                 loc_lInativo = .F.
1495:                 IF NVL(situas, 0) = 2
1496:                     IF THIS.ParametroGestaoIndireta()
1497:                         loc_lInativo = .T.
1498:                     ENDIF
1499:                 ENDIF
1500: 
1501:                 IF loc_lInativo
1502:                     MsgAviso("Produto Inativo !!!")
1503:                     THIS.LimparDadosProduto()
1504:                 ELSE
1505:                     IF THIS.this_oBusinessObject.ExistemItensParaProduto(par_cCodigo)
1506:                         MsgAviso("Produto j" + CHR(225) + " cadastrado !!!")

*-- Linhas 1522 a 1540:
1522:                         *-- Prepara a grade com UMA linha em branco para o usuario preencher
1523:                         IF USED("cursor_4c_Itens")
1524:                             ZAP IN cursor_4c_Itens
1525:                             INSERT INTO cursor_4c_Itens (cpros) VALUES (par_cCodigo)
1526:                         ENDIF
1527: 
1528:                         loc_oPagina.grd_4c_Itens.Column3.Enabled = THIS.this_lTemTam
1529:                         loc_oPagina.grd_4c_Itens.Column4.Enabled = THIS.this_lTemCor
1530:                         loc_oPagina.grd_4c_Itens.Refresh()
1531: 
1532:                         loc_oPagina.cmd_4c_BtnExcluir.Visible = .T.
1533:                         THIS.this_cModoAtual = "INCLUIR"
1534:                     ENDIF
1535:                 ENDIF
1536:             ENDIF
1537:         CATCH TO loc_oErro
1538:             MsgErro(loc_oErro.Message, "CarregarProdutoSelecionado")
1539:             THIS.LimparDadosProduto()
1540:         ENDTRY

*-- Linhas 1552 a 1570:
1552:         loc_lResultado = .F.
1553: 
1554:         TRY
1555:             IF SQLEXEC(gnConnHandle, "SELECT gesind FROM SigCdPam", "cursor_4c_Param") > 0
1556:                 IF USED("cursor_4c_Param") AND !EOF("cursor_4c_Param")
1557:                     loc_lResultado = (TratarNulo(cursor_4c_Param.gesind, 0) = 1)
1558:                 ENDIF
1559:             ENDIF
1560:         CATCH TO loc_oErro
1561:             loc_lResultado = .F.
1562:         ENDTRY
1563: 
1564:         IF USED("cursor_4c_Param")
1565:             USE IN cursor_4c_Param
1566:         ENDIF
1567: 
1568:         RETURN loc_lResultado
1569:     ENDPROC
1570: 

*-- Linhas 1749 a 1813:
1749:         loc_oGrid   = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
1750:         loc_cProduto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.Value)
1751: 
1752:         SELECT cursor_4c_Itens
1753:         LOCATE FOR EMPTY(emps)
1754:         IF !FOUND()
1755:             INSERT INTO cursor_4c_Itens (cpros) VALUES (loc_cProduto)
1756:         ENDIF
1757: 
1758:         loc_oGrid.Refresh()
1759:     ENDPROC
1760: 
1761:     *===========================================================================
1762:     * BtnExcluirItemClick - Remove da grade local os itens da Empresa corrente
1763:     * Legado: btnExcluir.Click
1764:     *===========================================================================
1765:     PROCEDURE BtnExcluirItemClick()
1766:         LOCAL loc_cEmps, loc_cProduto, loc_oGrid
1767: 
1768:         IF !USED("cursor_4c_Itens")
1769:             RETURN
1770:         ENDIF
1771: 
1772:         loc_oGrid    = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
1773:         loc_cProduto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.Value)
1774:         loc_cEmps    = ""
1775: 
1776:         SELECT cursor_4c_Itens
1777:         IF !EOF() AND !EMPTY(emps)
1778:             loc_cEmps = emps
1779:         ENDIF
1780: 
1781:         IF !EMPTY(loc_cEmps)
1782:             DELETE FROM cursor_4c_Itens WHERE emps == loc_cEmps
1783:             SELECT cursor_4c_Itens
1784:             PACK
1785:         ENDIF
1786: 
1787:         SELECT cursor_4c_Itens
1788:         LOCATE
1789:         IF EOF()
1790:             INSERT INTO cursor_4c_Itens (cpros) VALUES (loc_cProduto)
1791:         ENDIF
1792: 
1793:         loc_oGrid.Refresh()
1794:     ENDPROC
1795: 
1796:     *===========================================================================
1797:     * BtnConfirmarClick - Grava na tabela SigCdMax cada linha valida da grade
1798:     * Legado: btnConfirma equivalente (TableUpdate do cursor CrSigCdMax)
1799:     *===========================================================================
1800:     PROCEDURE BtnConfirmarClick()
1801:         LOCAL loc_lSucesso, loc_nLinhasGravadas, loc_cProduto, loc_cChavesMantidas
1802:         LOCAL loc_lLinhaNova, loc_lEraAlteracao
1803: 
1804:         *-- Em modo BUSCAR, Confirmar executa a busca por exemplo (legado: msv_procurar)
1805:         IF THIS.this_cModoAtual == "BUSCAR"
1806:             THIS.ExecutarBusca()
1807:             RETURN
1808:         ENDIF
1809: 
1810:         *-- VISUALIZAR nao grava (HabilitarCampos(.F.) ja desliga o botao; esta
1811:         *-- guarda cobre a chamada por teclado/atalho)
1812:         IF THIS.this_cModoAtual == "VISUALIZAR" OR !USED("cursor_4c_Itens")
1813:             RETURN

*-- Linhas 1827 a 1859:
1827:         loc_cChavesMantidas = ""
1828:         loc_lEraAlteracao   = (THIS.this_cModoAtual == "ALTERAR")
1829: 
1830:         SELECT cursor_4c_Itens
1831:         SCAN FOR !EMPTY(emps)
1832:             IF THIS.this_lTemTam AND EMPTY(codtams)
1833:                 MsgAviso("Obrigat" + CHR(243) + "rio informar Tamanho !!!")
1834:                 loc_lSucesso = .F.
1835:                 EXIT
1836:             ENDIF
1837:             IF THIS.this_lTemCor AND EMPTY(codcores)
1838:                 MsgAviso("Obrigat" + CHR(243) + "rio informar C" + CHR(243) + "digo da Cor !!!")
1839:                 loc_lSucesso = .F.
1840:                 EXIT
1841:             ENDIF
1842: 
1843:             *-- Linha SEM cidchaves eh nova (INSERT); com chave, eh uma linha ja
1844:             *-- gravada em SigCdMax e o que se quer eh UPDATE. Sem esta distincao
1845:             *-- o ALTERAR reinseria todas as linhas do Produto.
1846:             loc_lLinhaNova = EMPTY(NVL(cursor_4c_Itens.cidchaves, ""))
1847: 
1848:             IF loc_lLinhaNova
1849:                 THIS.this_oBusinessObject.NovoRegistro()
1850:             ELSE
1851:                 *-- CancelarEdicao zera this_lNovoRegistro (que BtnAlterarClick
1852:                 *-- deixou ligado); sem isso EditarRegistro recusa e o Salvar
1853:                 *-- cairia no Inserir, duplicando o registro
1854:                 THIS.this_oBusinessObject.CancelarEdicao()
1855:                 THIS.this_oBusinessObject.EditarRegistro()
1856:             ENDIF
1857: 
1858:             *-- FormParaBO depois de NovoRegistro/EditarRegistro: NovoRegistro
1859:             *-- chama LimparDados e apagaria o que fosse mapeado antes

*-- Linhas 1875 a 1894:
1875:         ENDSCAN
1876: 
1877:         *-- Linhas que o usuario removeu da grade com btnExcluir precisam sair do
1878:         *-- banco: no legado o cursor era uma view atualizavel e o Delete local
1879:         *-- ia junto no Update/Commit; aqui a grade eh um cursor local.
1880:         IF loc_lSucesso AND loc_lEraAlteracao
1881:             loc_lSucesso = THIS.this_oBusinessObject.ExcluirItensRemovidos(loc_cProduto, loc_cChavesMantidas)
1882:         ENDIF
1883: 
1884:         IF loc_lSucesso
1885:             IF loc_nLinhasGravadas = 0 AND !loc_lEraAlteracao
1886:                 MsgAviso("Nenhum item informado para grava" + CHR(231) + CHR(227) + "o.")
1887:             ELSE
1888:                 MsgInfo("Registro salvo com sucesso!", "Confirmar")
1889:                 THIS.LimparCampos()
1890:                 THIS.AlternarPagina(1)
1891:             ENDIF
1892:         ENDIF
1893:     ENDPROC
1894: 


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


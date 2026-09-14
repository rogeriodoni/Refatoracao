# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [GRID-SQL] Campo 'emps' usado em ControlSource de cursor_4c_Dados mas NAO existe no CREATE CURSOR
- [GRID-SQL] Campo 'emps' usado em ControlSource de cursor_4c_Dados mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NNUMES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: X, CODIGOS, EMPS, DOPES, CIDCHAVES, NOPS, DESCS, TUBOS, EMPDOPNUMS, NDOPES, NSTATUS, DATAS, CTRLLOTES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: X, CODIGOS, EMPS, DOPES, CIDCHAVES, NOPS, DESCS, TUBOS, EMPDOPNUMS, NDOPES, NSTATUS, DATAS, CTRLLOTES

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
  ControlSource = "crSigCdFun.obss"
  ControlSource = "TmpCera.obss"
  ControlSource = "crSigCdFun.codigos"
  ControlSource = "crSigCdFun.datas"
  ControlSource = "crSigCdFun.usuars"
  ControlSource = "crSigCdFun.codmaqfs"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "TmpCera.TempMets"
  ControlSource = "tmpcera.TempTubs"
  ControlSource = "TmpCera.TempAmbs"
  ControlSource = "tmpcera.Tempagus"
  ControlSource = "TmpCera.CodArvs"
  ControlSource = ""
  ControlSource = "TmpCera.Bceras"
  ControlSource = "tmpcera.bases"
  ControlSource = "tmpcera.ceras"
  ControlSource = "tmpcera.pmetals"
  ControlSource = "TmpCera.CodCors"
  ControlSource = "tmpcera.pmetalrs"
  ControlSource = "tmpcera.metalnvs"
  ControlSource = ""
  DeleteMark = .F.
  Column2.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column2.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column2.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
			Select TmpCera
			If Seek(x)
	Select TmpCera
Select TmpTrf
Select TmpNop
		Select TmpTrf
		If Seek(Str(x, 2)) Or Seek(Str(x, 2), 'TmpNop', 'Tubos')
			Select TmpCera
			If Not Seek(_Tubo)
			Select crSigCdArv
			Select TmpCera
			Seek(x)
	Select TmpCera
	Seek(_Tubo)
	Select TmpTrf
	Select TmpNop
	Select TmpCera
Select crSigCdFun
lcQryCFund = [Select * From SigCdFun]
lcQryCFund = [Select * ] + ;
			   [From SigCdFun ] + ;
lcQryIFund = [Select * From SigCdFud]
		ThisForm.Pagina.Lista.Grade.Column5.ControlSource = 'Left(Nvl(Obss, []),80)'
		lcQuery = [Select * from SigCdArv]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdArv') < 1)
		lcQuery = [Select a.Emps, a.Dopes, a.Numes, a.Datas ] + ;
					[From SigMvCab a, SigCdOpe b ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpLote') < 1)
		Select TmpLote
		Select crSigCdFun
			.Column1.ControlSource = 'TmpTrf.Dopes'
			.Column2.ControlSource = 'TmpTrf.Numes'
			.Column1.ControlSource = 'TmpNop.Nops'
			.Column2.ControlSource = 'TmpNop.Cpros'
			.Column3.ControlSource = 'TmpNop.Qtdos'
			.Column4.ControlSource = 'TmpNop.Numes'
			.Column5.ControlSource = 'TmpNop.DtEnts'
	lcQuery = [Delete From SigCdFun Where Codigos = ?pCod]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Delete From SigCdFud Where Codigos = ?pCod]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
If Not ThisForm.poDataMgr.Update('crSigCdFun')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Alterar - Update - crSigCdFun)')
If Not ThisForm.poDataMgr.Update('crSigCdFud')
	lcQuery = [Delete From SigCdFun Where Codigos = ?pCod]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Delete From SigCdFud Where Codigos = ?pCod]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
If Not ThisForm.poDataMgr.Update('crSigCdFud')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdFud)')
	Select LocalIfund
			Insert Into TmpTrf (Dopes, Numes, Tubos, nNumes) Values (Dope, Nume, LocalIfund.Tubos, LocalIfund.nNumes)
				Insert Into TmpNop (Nops, Cpros, Qtds, tubos, Qtdos, Numes, EmpDopNums, DtEnts) ;
				Select TmpCera
	Select LocalMaqf
			Select crSigCdFun
Select crSigCdFun
		Select crSigCdFun
		Delete
		Select TmpNop
			Select crSigOpPic
					lcQuery = [Update SigOpPic Set QtdTubos = 0 Where cIdChaves = '] + crSigOpPic.cIdChaves + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigOpPic - 1)')
					lcQuery = [Update SigOpPic Set QtdTubos = ?pDtq Where cIdChaves = '] + crSigOpPic.cIdChaves + [']
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigOpPic - 2)')
			Select crSigOpPic
				lcQuery = [Update SigOpPic Set nFunds = 0, DtFunds = Null Where Nops = ] + Str(Nop, 10)
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
					=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigOpPic - 3)')
	lcQuery = [Delete From SigCdFud Where Codigos = ] + Str(m.Codigos, 6)
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigCdFud)')
	Select TmpTrf
		Select crSigCdFud
	Select TmpNop
		Select crSigCdFud
	Select TmpCera
		Select crSigCdFud
	Select Count(1) as TotFund from TmpCera where InList(nStatus,2,3) group by CodArvs into cursor TmpTot
Select crSigCdFun
	Select crSigCdArv
	Select crSigCdArv
Select TmpTrf
	Delete
Select TmpNop
	Select crSigOpPic
			lcQuery = [Update SigOpPic Set QtdTubos = 0 Where cIdChaves = '] + crSigOpPic.cIdChaves + [']
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update Command1 - SigOpPic - 1)')
			lcQuery = [Update SigOpPic Set QtdTubos = ?pDtq Where cIdChaves = '] + crSigOpPic.cIdChaves + [']
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update Command1 - SigOpPic - 2)')
	Select crSigOpPic
		lcQuery = [Update SigOpPic Set nFunds = 0, DtFunds = Null Where Nops = ] + Str(Nop, 10)
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigOpPic - 3)')
	Select TmpNop
	Delete
	If Seek(Str(ThisForm.Tubo, 2) + Dope + Str(Nume, 6), 'TmpTrf', 'Tubos')
	Insert Into TmpTrf (Dopes, Numes, Tubos, nNumes) Values (Dope, Nume, ThisForm.Tubo, This.Value)
		Select TmpTrf
		Select TmpNop
			If Seek(Str(x, 2), 'TmpNop', 'Tubos') And Not Seek(Str(x, 2) + Dope + Str(Nume, 6), 'TmpTrf', 'Tubos')
				Insert Into TmpTrf (Dopes, Numes, Tubos, nNumes) Values (Dope, Nume, x, This.Value)
		Select TmpTrf
		Select TmpNop
	Select TmpTrf
	If Seek(Str(This.Value, 2))
		Select * From TmpTrf Where Tubos = This.Value ;
		Select Tempo
			Insert Into TmpTrf From Array Memvar
	Select TmpTrf
Return InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR') And Not Seek(Str(ThisForm.Tubo, 2), 'TmpTrf', 'Tubos')
	Select TmpNop
	=Seek(Str(ThisForm.Tubo, 2) + Str(Nop, 10), 'TmpNop', 'Tubos')
	Select crSigOpPic
				lcQuery = [Update SigOpPic Set QtdTubos = ?pDtq Where cIdChaves = '] + crSigOpPic.cIdChaves + [']
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
					=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update Get_QtTb - SigOpPic - 1)')
				lcQuery = [Update SigOpPic Set QtdTubos = ?pDtq Where cIdChaves = '] + crSigOpPic.cIdChaves + [']
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
					=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update Get_QtTb - SigOpPic - 2)')
			lcQuery = [Update SigOpPic Set Nfunds = ?pDtq Where cIdChaves = '] + crSigOpPic.cIdChaves + [']
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update Get_QtTb - SigOpPic - 3)')
			lcQuery = [Update SigOpPic Set DtFunds = ?pDtq Where cIdChaves = '] + crSigOpPic.cIdChaves + [']
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update Get_QtTb - SigOpPic - 3)')
	If Seek(Str(ThisForm.Tubo, 2) + Str(lnOp, 10), 'TmpNop', 'Tubos')
	Select crSigOpPic
	Insert Into TmpNop (Nops, Cpros, Qtds, Tubos, Numes, EmpDopNums, DtEnts) Values (lnOp, lcPro, lnQtd, ThisForm.Tubo, lnNumes, lcEDN, ldDtEnt)
lcQuery = [Select EmpSubns, Codigos from SigMvPec where EmpDopNums = '] + TmpNop.EmpDopNums + [']
If Thisform.PoDataMgr.SqlExecute(lcQuery,'CrSigMvPec') < 1
Select CrSigMvPec
	lcSql = [Select Dopes From SigCdOpe Where nDopes = ?_nDopes]
	If Thisform.PoDataMgr.SqlExecute(lcSql,'CrxOpe') < 1
Select CodArvs, Sum(pmetalrs) as MetalTotal, Sum(Metalnvs) as MetalNovo, Sum(pmetalrs-Metalnvs) as MetalLiga ;
from TmpCera where nStatus = 3 group by CodArvs into cursor TmpTot
Select TmpTot
lcQuery = [Select EmpSubns, Codigos from SigMvPec where EmpDopNums = '] + TmpNop.EmpDopNums + [']
If Thisform.PoDataMgr.SqlExecute(lcQuery,'CrSigMvPec') < 1
Select CrSigMvPec
	lcSql = [Select Dopes From SigCdOpe Where nDopes = ?_nDopes]
	If Thisform.PoDataMgr.SqlExecute(lcSql,'CrxOpe') < 1

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormFUN.prg) - TRECHOS RELEVANTES PARA PASS SQL (3793 linhas total):

*-- Linhas 55 a 102:
55:                 SET SAFETY OFF
56:                 SET NULL ON
57: 
58:                 CREATE CURSOR TmpCera ( ;
59:                     Tubos    N(2,0),   ;
60:                     BCeras   N(12,2),  ;
61:                     Bases    N(12,2),  ;
62:                     Ceras    N(12,2),  ;
63:                     PMetals  N(12,2),  ;
64:                     CodCors  C(4)  NULL, ;
65:                     Obss     M     NULL, ;
66:                     TempMets C(15) NULL, ;
67:                     TempAmbs C(15) NULL, ;
68:                     TempTubs C(15) NULL, ;
69:                     TempAgus C(15) NULL, ;
70:                     CodArvs  C(10) NULL, ;
71:                     Descs    C(40) NULL, ;
72:                     Formulas M     NULL, ;
73:                     MetalNvs N(12,2),  ;
74:                     pmetalrs N(12,2),  ;
75:                     nStatus  N(1,0)    ;
76:                 )
77:                 INDEX ON STR(Tubos, 2) TAG Tubos
78: 
79:                 CREATE CURSOR TmpTrf ( ;
80:                     Dopes    C(20),  ;
81:                     Numes    N(6,0), ;
82:                     Tubos    N(2,0), ;
83:                     nNumes   N(10,0) ;
84:                 )
85:                 INDEX ON STR(Tubos, 2) + Dopes + STR(Numes, 6) TAG Tubos
86: 
87:                 CREATE CURSOR TmpNop ( ;
88:                     Nops       N(10,0),  ;
89:                     Cpros      C(14),    ;
90:                     Qtds       N(10,3),  ;
91:                     Tubos      N(2,0),   ;
92:                     Qtdos      N(10,3),  ;
93:                     Numes      N(6,0),   ;
94:                     EmpDopNums C(29),    ;
95:                     DtEnts     D         ;
96:                 )
97:                 INDEX ON STR(Tubos, 2) + STR(Nops, 10) TAG Tubos
98: 
99:                 SET NULL OFF
100: 
101:                 *-- Carregar tipos de arvore para lookup local
102:                 THIS.CarregarArvores()

*-- Linhas 562 a 623:
562:             .HighlightBackColor = RGB(255, 255, 255)
563:             .HighlightForeColor = RGB(15, 41, 104)
564:             .HighlightStyle     = 2
565:             .DeleteMark         = .F.
566:             .RecordMark         = .F.
567:             .RowHeight          = 16
568:             .ScrollBars         = 2
569:             .GridLines          = 3
570:             .ReadOnly           = .T.
571:             .RecordSource       = "cursor_4c_Dados"
572:             .RecordSourceType   = 1
573:         ENDWITH
574: 
575:         WITH loc_oPagina.grd_4c_Dados.Column1
576:             .ControlSource   = "cursor_4c_Dados.codigos"
577:             .Width           = 70
578:             .Alignment       = 2
579:             .Header1.Caption = "N" + CHR(186) + " Fundi" + CHR(231) + CHR(227) + "o"
580:         ENDWITH
581: 
582:         WITH loc_oPagina.grd_4c_Dados.Column2
583:             .ControlSource   = "cursor_4c_Dados.emps"
584:             .Width           = 60
585:             .Header1.Caption = "Empresa"
586:         ENDWITH
587: 
588:         WITH loc_oPagina.grd_4c_Dados.Column3
589:             .ControlSource   = "cursor_4c_Dados.datas"
590:             .Width           = 140
591:             .Header1.Caption = "Data"
592:         ENDWITH
593: 
594:         WITH loc_oPagina.grd_4c_Dados.Column4
595:             .ControlSource   = "cursor_4c_Dados.codmaqfs"
596:             .Width           = 100
597:             .Header1.Caption = "M" + CHR(225) + "quina"
598:         ENDWITH
599: 
600:         WITH loc_oPagina.grd_4c_Dados.Column5
601:             .ControlSource   = "cursor_4c_Dados.ntubos"
602:             .Width           = 60
603:             .Alignment       = 2
604:             .Header1.Caption = "Tubos"
605:         ENDWITH
606: 
607:         WITH loc_oPagina.grd_4c_Dados.Column6
608:             .ControlSource   = "cursor_4c_Dados.usuars"
609:             .Width           = 100
610:             .Header1.Caption = "Usu" + CHR(225) + "rio"
611:         ENDWITH
612: 
613:         BINDEVENT(loc_oPagina.grd_4c_Dados, "DblClick", THIS, "BtnVisualizarClick")
614: 
615:         THIS.TornarControlesVisiveis(loc_oPagina)
616:     ENDPROC
617: 
618:     *==========================================================================
619:     PROTECTED PROCEDURE ConfigurarPaginaDados()
620:     *==========================================================================
621:         LOCAL loc_oPagina
622:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
623: 

*-- Linhas 823 a 844:
823:                     USE IN cursor_4c_Arvores
824:                 ENDIF
825: 
826:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
827:                     "SELECT a.codigos, a.descs, a.formulas, a.percs," + ;
828:                     " a.tempmets, a.temptubs, a.tempambs, a.tempagus" + ;
829:                     " FROM sigcdarv a ORDER BY a.codigos", ;
830:                     "cursor_4c_Arvores")
831: 
832:                 IF loc_nResultado < 0
833:                     MsgErro("Erro ao carregar " + CHR(225) + "rvores:" + ;
834:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
835:                 ENDIF
836:             ENDIF
837:         CATCH TO loc_oErro
838:             MsgErro("Erro em FormFUN.CarregarArvores: " + loc_oErro.Message, "Erro")
839:         ENDTRY
840:     ENDPROC
841: 
842:     *==========================================================================
843:     FUNCTION CarregarLista()
844:     *==========================================================================

*-- Linhas 881 a 899:
881:                 loc_cDtIniSQL = "'" + STUFF(STUFF(DTOS(loc_dDtIni), 5, 0, "-"), 8, 0, "-") + " 00:00:00'"
882:                 loc_cDtFimSQL = "'" + STUFF(STUFF(DTOS(loc_dDtFim), 5, 0, "-"), 8, 0, "-") + " 23:59:59'"
883: 
884:                 loc_cFiltro = "a.emps = " + EscaparSQL(loc_cEmps) + ;
885:                     " AND a.datas >= " + loc_cDtIniSQL + ;
886:                     " AND a.datas <= " + loc_cDtFimSQL
887: 
888:                 loc_lSucesso = THIS.this_oBusinessObject.Buscar(loc_cFiltro)
889: 
890:                 *-- Ocultar aguarde
891:                 THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnAguarde.Visible = .F.
892:             ENDIF
893:         CATCH TO loc_oErro
894:             MsgErro("Erro em FormFUN.CarregarLista: " + loc_oErro.Message, "Erro")
895:             TRY
896:                 THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnAguarde.Visible = .F.
897:             CATCH
898:             ENDTRY
899:             loc_lSucesso = .F.

*-- Linhas 1004 a 1028:
1004:     *==========================================================================
1005:         LOCAL loc_nCodigos, loc_lSucesso
1006:         loc_lSucesso = .F.
1007: 
1008:         TRY
1009:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1010:                 MsgAviso("Nenhum registro selecionado.", "Alterar")
1011:             ELSE
1012:                 SELECT cursor_4c_Dados
1013:                 loc_nCodigos = cursor_4c_Dados.codigos
1014: 
1015:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
1016:                     THIS.BOParaForm()
1017:                     THIS.this_cModoAtual = "ALTERAR"
1018:                     THIS.this_lEmEdicao  = .T.
1019:                     THIS.AlternarPagina(2)
1020:                     THIS.ChkTubo(1)
1021:                     THIS.AtualizarEstadoControles()
1022:                     loc_lSucesso = .T.
1023:                 ENDIF
1024:             ENDIF
1025:         CATCH TO loc_oErro
1026:             MsgErro("Erro em FormFUN.BtnAlterarClick: " + loc_oErro.Message, "Erro")
1027:         ENDTRY
1028: 

*-- Linhas 1034 a 1058:
1034:     *==========================================================================
1035:         LOCAL loc_nCodigos, loc_lSucesso
1036:         loc_lSucesso = .F.
1037: 
1038:         TRY
1039:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1040:                 MsgAviso("Nenhum registro selecionado.", "Visualizar")
1041:             ELSE
1042:                 SELECT cursor_4c_Dados
1043:                 loc_nCodigos = cursor_4c_Dados.codigos
1044: 
1045:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
1046:                     THIS.BOParaForm()
1047:                     THIS.this_cModoAtual = "VISUALIZAR"
1048:                     THIS.this_lEmEdicao  = .F.
1049:                     THIS.AlternarPagina(2)
1050:                     THIS.ChkTubo(1)
1051:                     THIS.AtualizarEstadoControles()
1052:                     loc_lSucesso = .T.
1053:                 ENDIF
1054:             ENDIF
1055:         CATCH TO loc_oErro
1056:             MsgErro("Erro em FormFUN.BtnVisualizarClick: " + loc_oErro.Message, "Erro")
1057:         ENDTRY
1058: 

*-- Linhas 1064 a 1088:
1064:     *==========================================================================
1065:         LOCAL loc_nCodigos, loc_lSucesso
1066:         loc_lSucesso = .F.
1067: 
1068:         TRY
1069:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1070:                 MsgAviso("Nenhum registro selecionado.", "Excluir")
1071:             ELSE
1072:                 SELECT cursor_4c_Dados
1073:                 loc_nCodigos = cursor_4c_Dados.codigos
1074: 
1075:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da fundi" + CHR(231) + ;
1076:                     CHR(227) + "o " + TRANSFORM(loc_nCodigos) + "?", "Excluir")
1077:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
1078:                         IF THIS.this_oBusinessObject.Excluir()
1079:                             THIS.CarregarLista()
1080:                             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
1081:                                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1082:                             ENDIF
1083:                             loc_lSucesso = .T.
1084:                         ENDIF
1085:                     ENDIF
1086:                 ENDIF
1087:             ENDIF
1088:         CATCH TO loc_oErro

*-- Linhas 1209 a 1230:
1209:                 USE IN TmpNop
1210:             ENDIF
1211:             IF USED("cursor_4c_Arvores")
1212:                 USE IN cursor_4c_Arvores
1213:             ENDIF
1214:             IF USED("cursor_4c_Dados")
1215:                 USE IN cursor_4c_Dados
1216:             ENDIF
1217:             IF USED("cursor_4c_TubosFund")
1218:                 USE IN cursor_4c_TubosFund
1219:             ENDIF
1220:             IF USED("cursor_4c_BuscaAux")
1221:                 USE IN cursor_4c_BuscaAux
1222:             ENDIF
1223:             IF USED("cursor_4c_TmpTot")
1224:                 USE IN cursor_4c_TmpTot
1225:             ENDIF
1226:         CATCH
1227:             *-- Silencioso no Destroy
1228:         ENDTRY
1229: 
1230:         DODEFAULT()

*-- Linhas 1493 a 1511:
1493:                 loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
1494:                 IF PEMSTATUS(loc_oCnt, loc_cNomeChk, 5)
1495:                     IF loc_oCnt.Value = 1
1496:                         SELECT TmpCera
1497:                         SET ORDER TO Tubos
1498:                         IF SEEK(STR(loc_n, 2))
1499:                             DO CASE
1500:                                 CASE loc_nStatus = 1
1501:                                     REPLACE nStatus WITH 1 IN TmpCera
1502:                                     loc_oCnt.Picture = ""
1503:                                 CASE loc_nStatus = 2
1504:                                     REPLACE nStatus WITH 2 IN TmpCera
1505:                                     loc_oCnt.Picture = gc_4c_CaminhoIcones + "geral_arvore_cera_60.jpg"
1506:                                 CASE loc_nStatus = 3
1507:                                     REPLACE nStatus WITH 3 IN TmpCera
1508:                                     loc_oCnt.Picture = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
1509:                                 CASE loc_nStatus = 4
1510:                                     REPLACE nStatus WITH 4 IN TmpCera
1511:                                     loc_oCnt.Picture = gc_4c_CaminhoIcones + "geral_pecapronta_60.jpg"

*-- Linhas 1532 a 1558:
1532:                 THIS.this_nMaqTubos = 0
1533:                 THIS.AtualizarVisibilidadeCheckboxes(0)
1534:             ELSE
1535:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1536:                     "SELECT m.codigos, m.tubos FROM SigCfMqf m WHERE m.codigos = " + ;
1537:                     EscaparSQL(loc_cCodMaq), ;
1538:                     "cursor_4c_BuscaMaq")
1539: 
1540:                 loc_nTubos = 0
1541:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaMaq") AND ;
1542:                         RECCOUNT("cursor_4c_BuscaMaq") > 0
1543:                     SELECT cursor_4c_BuscaMaq
1544:                     loc_nTubos = cursor_4c_BuscaMaq.tubos
1545:                     THIS.this_nMaqTubos = loc_nTubos
1546:                     THIS.AtualizarVisibilidadeCheckboxes(loc_nTubos)
1547:                 ELSE
1548:                     MsgAviso("M" + CHR(225) + "quina '" + loc_cCodMaq + ;
1549:                         "' n" + CHR(227) + "o encontrada.", ;
1550:                         "M" + CHR(225) + "quina")
1551:                     loc_oCnt1.txt_4c_Maq.Value = ""
1552:                     THIS.this_nMaqTubos = 0
1553:                     THIS.AtualizarVisibilidadeCheckboxes(0)
1554:                 ENDIF
1555: 
1556:                 IF USED("cursor_4c_BuscaMaq")
1557:                     USE IN cursor_4c_BuscaMaq
1558:                 ENDIF

*-- Linhas 1613 a 1669:
1613: 
1614:                     *-- Tubo com transformacao metalica em andamento
1615:                     IF USED("TmpTrf") AND RECCOUNT("TmpTrf") > 0
1616:                         SELECT TmpTrf
1617:                         SET ORDER TO 0
1618:                         LOCATE FOR TmpTrf.Tubos = loc_n
1619:                         IF FOUND()
1620:                             loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
1621:                         ENDIF
1622:                     ENDIF
1623: 
1624:                     *-- Tubo com peca pronta (ordem de producao concluida)
1625:                     IF USED("TmpNop") AND RECCOUNT("TmpNop") > 0
1626:                         SELECT TmpNop
1627:                         SET ORDER TO 0
1628:                         LOCATE FOR TmpNop.Tubos = loc_n
1629:                         IF FOUND()
1630:                             loc_cPic = gc_4c_CaminhoIcones + "geral_pecapronta_60.jpg"
1631:                         ENDIF
1632:                     ENDIF
1633: 
1634:                     *-- Tubo com status Cera (sem transformacao/nop)
1635:                     IF EMPTY(loc_cPic) AND USED("TmpCera") AND RECCOUNT("TmpCera") > 0
1636:                         SELECT TmpCera
1637:                         SET ORDER TO Tubos
1638:                         IF SEEK(STR(loc_n, 2)) AND TmpCera.nStatus = 2
1639:                             loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_cera_60.jpg"
1640:                         ENDIF
1641:                     ENDIF
1642: 
1643:                     loc_oCnt.Picture = loc_cPic
1644:                 ENDIF
1645:             ENDFOR
1646: 
1647:             *-- Carregar dados do tubo selecionado nas abas Container5/6/4 e Page2
1648:             IF par_nTubo > 0 AND USED("TmpCera")
1649:                 loc_oCnt4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4
1650:                 loc_oCnt5 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
1651:                 loc_oCnt6 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container6
1652:                 loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1653: 
1654:                 SELECT TmpCera
1655:                 SET ORDER TO Tubos
1656:                 IF SEEK(STR(par_nTubo, 2))
1657:                     *-- Container5: Cera/Metal
1658:                     IF PEMSTATUS(loc_oCnt5, "txt_4c_Cor", 5)
1659:                         loc_oCnt5.txt_4c_Cor.Value     = ALLTRIM(NVL(TmpCera.CodCors, ""))
1660:                         loc_oCnt5.txt_4c_Basec.Value   = NVL(TmpCera.BCeras, 0)
1661:                         loc_oCnt5.txt_4c_Base.Value    = NVL(TmpCera.Bases, 0)
1662:                         loc_oCnt5.txt_4c_Cera.Value    = NVL(TmpCera.Ceras, 0)
1663:                         loc_oCnt5.txt_4c_Metal.Value   = NVL(TmpCera.PMetals, 0)
1664:                         loc_oCnt5.txt_4c_Mreal.Value   = NVL(TmpCera.pmetalrs, 0)
1665:                         loc_oCnt5.txt_4c_metnovo.Value = NVL(TmpCera.MetalNvs, 0)
1666:                     ENDIF
1667:                     *-- Container6: Temperaturas
1668:                     IF PEMSTATUS(loc_oCnt6, "txt_4c_TempMet", 5)
1669:                         loc_oCnt6.txt_4c_TempMet.Value = ALLTRIM(NVL(TmpCera.TempMets, ""))

*-- Linhas 1686 a 1710:
1686: 
1687:                 *-- Filtrar TmpNop e TmpTrf para o tubo corrente e atualizar grades
1688:                 IF USED("TmpNop")
1689:                     SELECT TmpNop
1690:                     SET ORDER TO Tubos
1691:                     SET FILTER TO TmpNop.Tubos = THIS.this_nTuboAtual
1692:                     GO TOP
1693:                 ENDIF
1694:                 IF USED("TmpTrf")
1695:                     SELECT TmpTrf
1696:                     SET ORDER TO Tubos
1697:                     SET FILTER TO TmpTrf.Tubos = THIS.this_nTuboAtual
1698:                     GO TOP
1699:                 ENDIF
1700:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3, "grd_4c_Gradenop", 5)
1701:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3.grd_4c_Gradenop.Refresh()
1702:                 ENDIF
1703:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3, "grd_4c_GradeTrf", 5)
1704:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3.grd_4c_GradeTrf.Refresh()
1705:                 ENDIF
1706:             ELSE
1707:                 THIS.LimparCamposTubo()
1708:             ENDIF
1709:         CATCH TO loc_oErro
1710:             MsgErro("Erro em FormFUN.ChkTubo " + TRANSFORM(par_nTubo) + ": " + ;

*-- Linhas 1844 a 1995:
1844: 
1845:             *-- Carregar detalhe dos tubos de SigCdFud para TmpCera
1846:             IF loc_nCodigos > 0
1847:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1848:                     "SELECT d.tubos, d.bceras, d.bases," + ;
1849:                     " CAST(0 AS NUMERIC(12,2)) AS ceras," + ;
1850:                     " d.metals AS pmetals," + ;
1851:                     " d.codcors, d.obss, d.tempmets, d.tempambs, d.temptubs," + ;
1852:                     " d.tempagus, d.codarvs," + ;
1853:                     " ISNULL(a.descs, '') AS descs," + ;
1854:                     " ISNULL(a.formulas, '') AS formulas," + ;
1855:                     " d.metalnvs, CAST(0 AS NUMERIC(12,2)) AS pmetalrs, d.nstatus" + ;
1856:                     " FROM SigCdFud d" + ;
1857:                     " LEFT JOIN SigCdArv a ON a.codigos = d.codarvs" + ;
1858:                     " WHERE d.codigos = " + TRANSFORM(loc_nCodigos) + ;
1859:                     " AND d.nops = 0 AND d.nnumes = 0" + ;
1860:                     " ORDER BY d.tubos", ;
1861:                     "cursor_4c_TubosFund")
1862: 
1863:                 IF loc_nResultado > 0 AND USED("cursor_4c_TubosFund") AND ;
1864:                         RECCOUNT("cursor_4c_TubosFund") > 0
1865:                     SELECT cursor_4c_TubosFund
1866:                     GO TOP
1867:                     DO WHILE !EOF()
1868:                         loc_nTubo     = cursor_4c_TubosFund.tubos
1869:                         loc_nBCeras   = cursor_4c_TubosFund.bceras
1870:                         loc_nBases    = cursor_4c_TubosFund.bases
1871:                         loc_nCeras    = cursor_4c_TubosFund.ceras
1872:                         loc_nPMetals  = cursor_4c_TubosFund.pmetals
1873:                         loc_cCodCors  = cursor_4c_TubosFund.codcors
1874:                         loc_mObss     = cursor_4c_TubosFund.obss
1875:                         loc_cTmpMets  = cursor_4c_TubosFund.tempmets
1876:                         loc_cTmpAmbs  = cursor_4c_TubosFund.tempambs
1877:                         loc_cTmpTubs  = cursor_4c_TubosFund.temptubs
1878:                         loc_cTmpAgus  = cursor_4c_TubosFund.tempagus
1879:                         loc_cCodArvs  = cursor_4c_TubosFund.codarvs
1880:                         loc_cDescs    = cursor_4c_TubosFund.descs
1881:                         loc_mFormulas = cursor_4c_TubosFund.formulas
1882:                         loc_nMetalNvs = cursor_4c_TubosFund.metalnvs
1883:                         loc_nPmetalrs = cursor_4c_TubosFund.pmetalrs
1884:                         loc_nNStatus  = cursor_4c_TubosFund.nstatus
1885: 
1886:                         INSERT INTO TmpCera (Tubos, BCeras, Bases, Ceras, PMetals, ;
1887:                             CodCors, Obss, TempMets, TempAmbs, TempTubs, TempAgus, ;
1888:                             CodArvs, Descs, Formulas, MetalNvs, pmetalrs, nStatus) ;
1889:                         VALUES (loc_nTubo, loc_nBCeras, loc_nBases, loc_nCeras, ;
1890:                             loc_nPMetals, loc_cCodCors, loc_mObss, loc_cTmpMets, ;
1891:                             loc_cTmpAmbs, loc_cTmpTubs, loc_cTmpAgus, loc_cCodArvs, ;
1892:                             loc_cDescs, loc_mFormulas, loc_nMetalNvs, loc_nPmetalrs, ;
1893:                             loc_nNStatus)
1894: 
1895:                         SELECT cursor_4c_TubosFund
1896:                         SKIP
1897:                     ENDDO
1898:                 ENDIF
1899:             ENDIF
1900: 
1901:             *-- Carregar TmpTrf de SigCdFud (nnumes <> 0 = linhas de transferencia)
1902:             IF loc_nCodigos > 0
1903:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1904:                     "SELECT d.tubos, d.nnumes," + ;
1905:                     " ISNULL(m.dopes, '') AS dopes" + ;
1906:                     " FROM SigCdFud d" + ;
1907:                     " LEFT JOIN SigMvCab m ON m.numes = d.nnumes" + ;
1908:                     " WHERE d.codigos = " + TRANSFORM(loc_nCodigos) + ;
1909:                     " AND d.nnumes <> 0" + ;
1910:                     " ORDER BY d.tubos", ;
1911:                     "cursor_4c_TrfFund")
1912: 
1913:                 IF loc_nResultado > 0 AND USED("cursor_4c_TrfFund") AND ;
1914:                         RECCOUNT("cursor_4c_TrfFund") > 0
1915:                     SELECT cursor_4c_TrfFund
1916:                     GO TOP
1917:                     DO WHILE !EOF()
1918:                         INSERT INTO TmpTrf (Dopes, Numes, Tubos, nNumes) ;
1919:                             VALUES (ALLTRIM(NVL(cursor_4c_TrfFund.dopes, "")), ;
1920:                                     0, ;
1921:                                     cursor_4c_TrfFund.tubos, ;
1922:                                     cursor_4c_TrfFund.nnumes)
1923:                         SELECT cursor_4c_TrfFund
1924:                         SKIP
1925:                     ENDDO
1926:                 ENDIF
1927:                 IF USED("cursor_4c_TrfFund")
1928:                     USE IN cursor_4c_TrfFund
1929:                 ENDIF
1930:             ENDIF
1931: 
1932:             *-- Carregar TmpNop de SigCdFud (nops <> 0 e nnumes = 0 = ordens de producao)
1933:             IF loc_nCodigos > 0
1934:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1935:                     "SELECT d.tubos, d.nops, d.qtds, d.qtdos," + ;
1936:                     " ISNULL(o.cpros, '') AS cpros," + ;
1937:                     " ISNULL(o.numes, 0) AS numes," + ;
1938:                     " ISNULL(CAST(o.dtents AS DATE), CAST(GETDATE() AS DATE)) AS dtents" + ;
1939:                     " FROM SigCdFud d" + ;
1940:                     " OUTER APPLY (SELECT TOP 1 oo.cpros, oo.numes, oo.dtents" + ;
1941:                     " FROM SigOpPic oo WHERE oo.nops = d.nops" + ;
1942:                     " AND oo.emps = " + EscaparSQL(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))) + ;
1943:                     ") o WHERE d.codigos = " + TRANSFORM(loc_nCodigos) + ;
1944:                     " AND d.nops <> 0 AND d.nnumes = 0" + ;
1945:                     " ORDER BY d.tubos, d.nops", ;
1946:                     "cursor_4c_NopFund")
1947: 
1948:                 IF loc_nResultado > 0 AND USED("cursor_4c_NopFund") AND ;
1949:                         RECCOUNT("cursor_4c_NopFund") > 0
1950:                     SELECT cursor_4c_NopFund
1951:                     GO TOP
1952:                     DO WHILE !EOF()
1953:                         INSERT INTO TmpNop (Nops, Cpros, Qtds, Tubos, Qtdos, Numes, ;
1954:                                             EmpDopNums, DtEnts) ;
1955:                             VALUES (cursor_4c_NopFund.nops, ;
1956:                                     ALLTRIM(NVL(cursor_4c_NopFund.cpros, "")), ;
1957:                                     cursor_4c_NopFund.qtds, ;
1958:                                     cursor_4c_NopFund.tubos, ;
1959:                                     cursor_4c_NopFund.qtdos, ;
1960:                                     cursor_4c_NopFund.numes, ;
1961:                                     PADR(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, "")), 29), ;
1962:                                     cursor_4c_NopFund.dtents)
1963:                         SELECT cursor_4c_NopFund
1964:                         SKIP
1965:                     ENDDO
1966:                 ENDIF
1967:                 IF USED("cursor_4c_NopFund")
1968:                     USE IN cursor_4c_NopFund
1969:                 ENDIF
1970:             ENDIF
1971: 
1972:             *-- Carregar observacao geral
1973:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4, "edt_4c_ObsG", 5)
1974:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4.edt_4c_ObsG.Value = ;
1975:                     NVL(loc_oBO.this_mObsG, "")
1976:             ENDIF
1977: 
1978:             *-- Atualizar imagens dos checkboxes baseado em TmpCera.nStatus
1979:             IF USED("TmpCera") AND RECCOUNT("TmpCera") > 0
1980:                 SELECT TmpCera
1981:                 SET ORDER TO Tubos
1982:                 GO TOP
1983:                 DO WHILE !EOF()
1984:                     loc_n = TmpCera.Tubos
1985:                     IF loc_n >= 1 AND loc_n <= 24
1986:                         loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
1987:                         IF PEMSTATUS(loc_oCnt2, loc_cNomeChk, 5)
1988:                             DO CASE
1989:                                 CASE TmpCera.nStatus = 2
1990:                                     loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_cera_60.jpg"
1991:                                 CASE TmpCera.nStatus = 3
1992:                                     loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
1993:                                 CASE TmpCera.nStatus = 4
1994:                                     loc_cPic = gc_4c_CaminhoIcones + "geral_pecapronta_60.jpg"
1995:                                 OTHERWISE

*-- Linhas 2160 a 2193:
2160:             .HeaderHeight            = 17
2161:             .RowHeight               = 17
2162:             .Column1.Header1.Caption = "O.P."
2163:             .Column1.ControlSource   = "TmpNop.Nops"
2164:             .Column1.Width           = 60
2165:             .Column2.Header1.Caption = "Produto"
2166:             .Column2.ControlSource   = "TmpNop.Cpros"
2167:             .Column2.Width           = 110
2168:             .Column3.Header1.Caption = "Qtde"
2169:             .Column3.ControlSource   = "TmpNop.Qtds"
2170:             .Column3.Width           = 60
2171:             .Column4.Header1.Caption = "Pedido"
2172:             .Column4.ControlSource   = "TmpNop.Numes"
2173:             .Column4.Width           = 50
2174:             .Column5.Header1.Caption = "Data Entrega"
2175:             .Column5.ControlSource   = "TmpNop.DtEnts"
2176:             .Column5.Width           = 90
2177:             .RecordMark   = .F.
2178:             .DeleteMark   = .F.
2179:         ENDWITH
2180:         BINDEVENT(loc_oCnt.grd_4c_Gradenop, "AfterRowColChange", THIS, "GradenopAfterRowColChange")
2181: 
2182:         loc_oCnt.AddObject("txt_4c_Operacao", "TextBox")
2183:         WITH loc_oCnt.txt_4c_Operacao
2184:             .Value     = ""
2185:             .Left      = 18
2186:             .Top       = 171
2187:             .Width     = 290
2188:             .Height    = 25
2189:             .ReadOnly  = .T.
2190:             .FontName  = "Tahoma"
2191:             .FontSize  = 8
2192:             .BackColor = RGB(240, 240, 240)
2193:         ENDWITH

*-- Linhas 2283 a 2307:
2283:             .HeaderHeight            = 17
2284:             .RowHeight               = 17
2285:             .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
2286:             .Column1.ControlSource   = "TmpTrf.Dopes"
2287:             .Column1.Width           = 155
2288:             .Column2.Header1.Caption = "Numes"
2289:             .Column2.ControlSource   = "TmpTrf.Numes"
2290:             .Column2.Width           = 55
2291:             .RecordMark   = .F.
2292:             .DeleteMark   = .F.
2293:         ENDWITH
2294: 
2295:         loc_oCnt.AddObject("cmd_4c_RemoverTrf", "CommandButton")
2296:         WITH loc_oCnt.cmd_4c_RemoverTrf
2297:             .Caption         = ""
2298:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
2299:             .PicturePosition = 4
2300:             .Top             = 297
2301:             .Left            = 165
2302:             .Width           = 40
2303:             .Height          = 40
2304:             .Themes          = .T.
2305:             .SpecialEffect   = 0
2306:             .MousePointer    = 15
2307:         ENDWITH

*-- Linhas 2716 a 2734:
2716:             .Column4.Header1.Caption = "Metal Ligado"
2717:             .Column4.Width           = 80
2718:             .RecordMark   = .F.
2719:             .DeleteMark   = .F.
2720:         ENDWITH
2721: 
2722:         loc_oCnt.AddObject("cmd_4c_Retornar", "CommandButton")
2723:         WITH loc_oCnt.cmd_4c_Retornar
2724:             .Caption         = "Retornar"
2725:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_26.jpg"
2726:             .PicturePosition = 13
2727:             .Top             = 11
2728:             .Left            = 415
2729:             .Width           = 75
2730:             .Height          = 75
2731:             .FontName        = "Tahoma"
2732:             .FontBold        = .T.
2733:             .FontItalic      = .T.
2734:             .FontSize        = 8

*-- Linhas 2824 a 2842:
2824: 
2825:         TRY
2826:             IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
2827:                 SELECT TmpCera
2828:                 SET ORDER TO Tubos
2829:                 IF SEEK(STR(THIS.this_nTuboAtual, 2))
2830:                     loc_oCnt4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4
2831:                     loc_oCnt5 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
2832:                     loc_oCnt6 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container6
2833: 
2834:                     IF PEMSTATUS(loc_oCnt4, "edt_4c_Obs", 5)
2835:                         REPLACE Obss WITH loc_oCnt4.edt_4c_Obs.Value IN TmpCera
2836:                     ENDIF
2837:                     IF PEMSTATUS(loc_oCnt5, "txt_4c_Mreal", 5)
2838:                         REPLACE pmetalrs WITH NVL(loc_oCnt5.txt_4c_Mreal.Value, 0) IN TmpCera
2839:                     ENDIF
2840:                     IF PEMSTATUS(loc_oCnt6, "txt_4c_TempMet", 5)
2841:                         REPLACE TempMets WITH ALLTRIM(NVL(loc_oCnt6.txt_4c_TempMet.Value, "")) IN TmpCera
2842:                         REPLACE TempTubs WITH ALLTRIM(NVL(loc_oCnt6.txt_4c_TempTub.Value, "")) IN TmpCera

*-- Linhas 2907 a 2941:
2907: 
2908:             IF EMPTY(loc_cCodCor)
2909:                 IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
2910:                     SELECT TmpCera
2911:                     SET ORDER TO Tubos
2912:                     IF SEEK(STR(THIS.this_nTuboAtual, 2))
2913:                         REPLACE CodCors WITH "" IN TmpCera
2914:                     ENDIF
2915:                 ENDIF
2916:                 loc_lSucesso = .T.
2917:             ELSE
2918:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2919:                     "SELECT c.cgrus FROM SigCdCor c WHERE c.cgrus = " + ;
2920:                     EscaparSQL(loc_cCodCor), ;
2921:                     "cursor_4c_BuscaCor")
2922: 
2923:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaCor") AND ;
2924:                         RECCOUNT("cursor_4c_BuscaCor") > 0
2925:                     IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
2926:                         SELECT TmpCera
2927:                         SET ORDER TO Tubos
2928:                         IF SEEK(STR(THIS.this_nTuboAtual, 2))
2929:                             REPLACE CodCors WITH loc_cCodCor IN TmpCera
2930:                         ENDIF
2931:                     ENDIF
2932:                     loc_lSucesso = .T.
2933:                 ELSE
2934:                     MsgAviso("Cor '" + loc_cCodCor + "' n" + CHR(227) + "o encontrada.", "Cor")
2935:                     loc_oCnt5.txt_4c_Cor.Value = ""
2936:                 ENDIF
2937: 
2938:                 IF USED("cursor_4c_BuscaCor")
2939:                     USE IN cursor_4c_BuscaCor
2940:                 ENDIF
2941:             ENDIF

*-- Linhas 3007 a 3046:
3007:                     loc_oPg2.txt_4c_descarvore.Value = ""
3008:                 ENDIF
3009:                 IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3010:                     SELECT TmpCera
3011:                     SET ORDER TO Tubos
3012:                     IF SEEK(STR(THIS.this_nTuboAtual, 2))
3013:                         REPLACE CodArvs WITH "", Descs WITH "" IN TmpCera
3014:                     ENDIF
3015:                 ENDIF
3016:                 loc_lSucesso = .T.
3017:             ELSE
3018:                 IF !USED("cursor_4c_Arvores")
3019:                     THIS.CarregarArvores()
3020:                 ENDIF
3021: 
3022:                 IF USED("cursor_4c_Arvores")
3023:                     SELECT cursor_4c_Arvores
3024:                     LOCATE FOR ALLTRIM(cursor_4c_Arvores.codigos) = loc_cCodArv
3025:                     IF FOUND()
3026:                         loc_cDescs = ALLTRIM(NVL(cursor_4c_Arvores.descs, ""))
3027:                         IF PEMSTATUS(loc_oPg2, "txt_4c_descarvore", 5)
3028:                             loc_oPg2.txt_4c_descarvore.Value = loc_cDescs
3029:                         ENDIF
3030:                         IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3031:                             SELECT TmpCera
3032:                             SET ORDER TO Tubos
3033:                             IF SEEK(STR(THIS.this_nTuboAtual, 2))
3034:                                 REPLACE CodArvs WITH loc_cCodArv, Descs WITH loc_cDescs IN TmpCera
3035:                             ENDIF
3036:                         ENDIF
3037:                         THIS.CalcMetal()
3038:                         loc_lSucesso = .T.
3039:                     ELSE
3040:                         MsgAviso(CHR(193) + "rvore '" + loc_cCodArv + ;
3041:                             "' n" + CHR(227) + "o encontrada.", CHR(193) + "rvore")
3042:                         loc_oPg2.txt_4c_codarvore.Value  = ""
3043:                         IF PEMSTATUS(loc_oPg2, "txt_4c_descarvore", 5)
3044:                             loc_oPg2.txt_4c_descarvore.Value = ""
3045:                         ENDIF
3046:                     ENDIF

*-- Linhas 3109 a 3127:
3109: 
3110:         TRY
3111:             IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3112:                 SELECT TmpCera
3113:                 SET ORDER TO Tubos
3114:                 IF SEEK(STR(THIS.this_nTuboAtual, 2))
3115:                     loc_nBCeras = NVL(TmpCera.BCeras, 0)
3116:                     loc_nBases  = NVL(TmpCera.Bases, 0)
3117: 
3118:                     IF loc_nBCeras > 0 AND loc_nBases > 0 AND loc_nBCeras < loc_nBases
3119:                         MsgAviso("Base com Cera n" + CHR(227) + "o pode ser menor que a Base.", "Aviso")
3120:                         REPLACE Bases WITH 0 IN TmpCera
3121:                         loc_nBases = 0
3122:                     ENDIF
3123: 
3124:                     loc_nCeras = loc_nBCeras - loc_nBases
3125:                     REPLACE Ceras WITH loc_nCeras IN TmpCera
3126: 
3127:                     loc_oCnt5 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5

*-- Linhas 3140 a 3175:
3140:                     loc_nPercs     = 0
3141: 
3142:                     IF !EMPTY(loc_cCodArv) AND USED("cursor_4c_Arvores")
3143:                         SELECT cursor_4c_Arvores
3144:                         LOCATE FOR ALLTRIM(cursor_4c_Arvores.codigos) = loc_cCodArv
3145:                         IF FOUND()
3146:                             loc_cFormula = ALLTRIM(NVL(cursor_4c_Arvores.formulas, ""))
3147:                             loc_nPercs   = NVL(cursor_4c_Arvores.percs, 0)
3148:                             IF !EMPTY(loc_cFormula)
3149:                                 SELECT TmpCera
3150:                                 TRY
3151:                                     loc_nPesoMetal = EVALUATE(loc_cFormula)
3152:                                 CATCH
3153:                                     loc_nPesoMetal = 0
3154:                                 ENDTRY
3155:                                 loc_nMetalNovo = (loc_nPesoMetal * loc_nPercs) / 100
3156:                             ENDIF
3157:                         ENDIF
3158:                     ENDIF
3159: 
3160:                     SELECT TmpCera
3161:                     SET ORDER TO Tubos
3162:                     IF SEEK(STR(THIS.this_nTuboAtual, 2))
3163:                         REPLACE PMetals WITH loc_nPesoMetal, MetalNvs WITH loc_nMetalNovo IN TmpCera
3164:                     ENDIF
3165: 
3166:                     IF PEMSTATUS(loc_oCnt5, "txt_4c_Metal", 5)
3167:                         loc_oCnt5.txt_4c_Metal.Value   = loc_nPesoMetal
3168:                     ENDIF
3169:                     IF PEMSTATUS(loc_oCnt5, "txt_4c_metnovo", 5)
3170:                         loc_oCnt5.txt_4c_metnovo.Value = loc_nMetalNovo
3171:                     ENDIF
3172: 
3173:                     loc_lSucesso = .T.
3174:                 ENDIF
3175:             ENDIF

*-- Linhas 3191 a 3209:
3191:             loc_nBCeras = NVL(loc_oCnt5.txt_4c_Basec.Value, 0)
3192: 
3193:             IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3194:                 SELECT TmpCera
3195:                 SET ORDER TO Tubos
3196:                 IF SEEK(STR(THIS.this_nTuboAtual, 2))
3197:                     REPLACE BCeras WITH loc_nBCeras IN TmpCera
3198:                 ENDIF
3199:             ENDIF
3200: 
3201:             THIS.CalcMetal()
3202:             loc_lSucesso = .T.
3203:         CATCH TO loc_oErro
3204:             MsgErro("Erro em FormFUN.BasecLostFocus: " + loc_oErro.Message, "Erro")
3205:         ENDTRY
3206: 
3207:         RETURN loc_lSucesso
3208:     ENDPROC
3209: 

*-- Linhas 3218 a 3236:
3218:             loc_nBases = NVL(loc_oCnt5.txt_4c_Base.Value, 0)
3219: 
3220:             IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3221:                 SELECT TmpCera
3222:                 SET ORDER TO Tubos
3223:                 IF SEEK(STR(THIS.this_nTuboAtual, 2))
3224:                     REPLACE Bases WITH loc_nBases IN TmpCera
3225:                 ENDIF
3226:             ENDIF
3227: 
3228:             THIS.CalcMetal()
3229:             loc_lSucesso = .T.
3230:         CATCH TO loc_oErro
3231:             MsgErro("Erro em FormFUN.BaseLostFocus: " + loc_oErro.Message, "Erro")
3232:         ENDTRY
3233: 
3234:         RETURN loc_lSucesso
3235:     ENDPROC
3236: 

*-- Linhas 3316 a 3343:
3316:                 ENDIF
3317:                 loc_lSucesso = .T.
3318:             ELSE
3319:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
3320:                     "SELECT o.nops, o.cpros, o.qtds, o.numes, o.dtents" + ;
3321:                     " FROM SigOpPic o" + ;
3322:                     " WHERE o.nops = " + TRANSFORM(loc_nNop) + ;
3323:                     " AND o.emps = " + EscaparSQL(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))), ;
3324:                     "cursor_4c_BuscaNop")
3325: 
3326:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaNop") AND ;
3327:                         RECCOUNT("cursor_4c_BuscaNop") > 0
3328:                     SELECT cursor_4c_BuscaNop
3329:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
3330:                         loc_oCnt3.txt_4c_Qtd.Value = NVL(cursor_4c_BuscaNop.qtds, 0)
3331:                     ENDIF
3332:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Pecas", 5)
3333:                         loc_oCnt3.txt_4c_Pecas.Value = NVL(cursor_4c_BuscaNop.qtds, 0)
3334:                     ENDIF
3335:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
3336:                         loc_oCnt3.txt_4c_Operacao.Value = ALLTRIM(NVL(cursor_4c_BuscaNop.cpros, ""))
3337:                     ENDIF
3338:                     loc_lSucesso = .T.
3339:                 ELSE
3340:                     MsgAviso("O.P. n" + CHR(186) + " " + TRANSFORM(loc_nNop) + ;
3341:                         " n" + CHR(227) + "o encontrada.", "O.P.")
3342:                     loc_oCnt3.txt_4c_Nop.Value = 0
3343:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)

*-- Linhas 3408 a 3448:
3408:             IF loc_nTuboFonte > 0 AND loc_nTuboAtual > 0 AND ;
3409:                     loc_nTuboFonte != loc_nTuboAtual AND USED("TmpTrf")
3410:                 *-- Coletar registros do tubo fonte
3411:                 SELECT TmpTrf
3412:                 SET ORDER TO 0
3413:                 GO TOP
3414:                 DO WHILE !EOF("TmpTrf")
3415:                     IF TmpTrf.Tubos = loc_nTuboFonte
3416:                         loc_nTotal = loc_nTotal + 1
3417:                         DIMENSION loc_aTrfs[loc_nTotal, 3]
3418:                         loc_aTrfs[loc_nTotal, 1] = TmpTrf.Dopes
3419:                         loc_aTrfs[loc_nTotal, 2] = TmpTrf.Numes
3420:                         loc_aTrfs[loc_nTotal, 3] = TmpTrf.nNumes
3421:                     ENDIF
3422:                     SKIP
3423:                 ENDDO
3424: 
3425:                 *-- Inserir no tubo destino se nao existir
3426:                 FOR loc_nI = 1 TO loc_nTotal
3427:                     loc_cDopes  = loc_aTrfs[loc_nI, 1]
3428:                     loc_nNumes  = loc_aTrfs[loc_nI, 2]
3429:                     loc_nNNumes = loc_aTrfs[loc_nI, 3]
3430:                     SELECT TmpTrf
3431:                     LOCATE FOR TmpTrf.Tubos = loc_nTuboAtual AND TmpTrf.Dopes = loc_cDopes
3432:                     IF !FOUND()
3433:                         INSERT INTO TmpTrf (Dopes, Numes, Tubos, nNumes) ;
3434:                             VALUES (loc_cDopes, loc_nNumes, loc_nTuboAtual, loc_nNNumes)
3435:                     ENDIF
3436:                 ENDFOR
3437: 
3438:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3, "grd_4c_GradeTrf", 5)
3439:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3.grd_4c_GradeTrf.Refresh()
3440:                 ENDIF
3441:             ENDIF
3442:             loc_lSucesso = .T.
3443:         CATCH TO loc_oErro
3444:             MsgErro("Erro em FormFUN.TuboLostFocus: " + loc_oErro.Message, "Erro")
3445:         ENDTRY
3446: 
3447:         RETURN loc_lSucesso
3448:     ENDPROC

*-- Linhas 3461 a 3511:
3461:             IF EMPTY(loc_cTrf)
3462:                 loc_lSucesso = .T.
3463:             ELSE
3464:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
3465:                     "SELECT TOP 1 m.dopes, m.numes FROM SigMvCab m" + ;
3466:                     " WHERE m.dopes = " + EscaparSQL(loc_cTrf) + ;
3467:                     " AND m.emps = " + EscaparSQL(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))) + ;
3468:                     " ORDER BY m.numes DESC", ;
3469:                     "cursor_4c_BuscaTrf")
3470: 
3471:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaTrf") AND ;
3472:                         RECCOUNT("cursor_4c_BuscaTrf") > 0
3473:                     loc_nTuboAtual = THIS.this_nTuboAtual
3474:                     loc_lRep       = .F.
3475:                     IF PEMSTATUS(loc_oCnt3, "chk_4c_ChkRep", 5)
3476:                         loc_lRep = (loc_oCnt3.chk_4c_ChkRep.Value = 1)
3477:                     ENDIF
3478: 
3479:                     SELECT cursor_4c_BuscaTrf
3480:                     loc_nNNumes = NVL(cursor_4c_BuscaTrf.numes, 0)
3481: 
3482:                     IF loc_nTuboAtual > 0 AND USED("TmpTrf")
3483:                         SELECT TmpTrf
3484:                         LOCATE FOR TmpTrf.Tubos = loc_nTuboAtual AND TmpTrf.Dopes = loc_cTrf
3485:                         IF !FOUND()
3486:                             INSERT INTO TmpTrf (Dopes, Numes, Tubos, nNumes) ;
3487:                                 VALUES (loc_cTrf, 0, loc_nTuboAtual, loc_nNNumes)
3488:                         ENDIF
3489: 
3490:                         IF loc_lRep
3491:                             FOR loc_nT = 1 TO THIS.this_nMaqTubos
3492:                                 IF loc_nT != loc_nTuboAtual
3493:                                     SELECT TmpTrf
3494:                                     LOCATE FOR TmpTrf.Tubos = loc_nT AND TmpTrf.Dopes = loc_cTrf
3495:                                     IF !FOUND()
3496:                                         INSERT INTO TmpTrf (Dopes, Numes, Tubos, nNumes) ;
3497:                                             VALUES (loc_cTrf, 0, loc_nT, loc_nNNumes)
3498:                                     ENDIF
3499:                                 ENDIF
3500:                             ENDFOR
3501:                         ENDIF
3502: 
3503:                         IF PEMSTATUS(loc_oCnt3, "grd_4c_GradeTrf", 5)
3504:                             loc_oCnt3.grd_4c_GradeTrf.Refresh()
3505:                         ENDIF
3506:                     ENDIF
3507:                     loc_oCnt3.txt_4c_Trf.Value = ""
3508:                     loc_lSucesso = .T.
3509:                 ELSE
3510:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o '" + loc_cTrf + ;
3511:                         "' n" + CHR(227) + "o encontrada.", ;

*-- Linhas 3551 a 3591:
3551:                 loc_nQtds  = 0
3552:                 loc_nNumes = 0
3553: 
3554:                 loc_nRes2 = SQLEXEC(gnConnHandle, ;
3555:                     "SELECT o.cpros, o.qtds, o.numes FROM SigOpPic o" + ;
3556:                     " WHERE o.nops = " + TRANSFORM(loc_nNop) + ;
3557:                     " AND o.emps = " + EscaparSQL(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))), ;
3558:                     "cursor_4c_BuscaNop2")
3559: 
3560:                 IF loc_nRes2 > 0 AND USED("cursor_4c_BuscaNop2") AND ;
3561:                         RECCOUNT("cursor_4c_BuscaNop2") > 0
3562:                     SELECT cursor_4c_BuscaNop2
3563:                     loc_cCpros = ALLTRIM(NVL(cursor_4c_BuscaNop2.cpros, ""))
3564:                     loc_nQtds  = NVL(cursor_4c_BuscaNop2.qtds, 0)
3565:                     loc_nNumes = NVL(cursor_4c_BuscaNop2.numes, 0)
3566: 
3567:                     IF USED("cursor_4c_BuscaNop2")
3568:                         USE IN cursor_4c_BuscaNop2
3569:                     ENDIF
3570: 
3571:                     IF USED("TmpNop")
3572:                         SELECT TmpNop
3573:                         LOCATE FOR TmpNop.Tubos = loc_nTuboAtual AND TmpNop.Nops = loc_nNop
3574:                         IF !FOUND()
3575:                             loc_dDtEnt = DATE()
3576:                             INSERT INTO TmpNop (Nops, Cpros, Qtds, Tubos, Qtdos, Numes, ;
3577:                                                EmpDopNums, DtEnts) ;
3578:                                 VALUES (loc_nNop, loc_cCpros, loc_nQtTb, loc_nTuboAtual, ;
3579:                                         loc_nQtds, loc_nNumes, ;
3580:                                         PADR(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, "")), 29), ;
3581:                                         loc_dDtEnt)
3582:                         ENDIF
3583: 
3584:                         IF PEMSTATUS(loc_oCnt3, "grd_4c_Gradenop", 5)
3585:                             loc_oCnt3.grd_4c_Gradenop.Refresh()
3586:                         ENDIF
3587:                     ENDIF
3588: 
3589:                     loc_oCnt3.txt_4c_Nop.Value  = 0
3590:                     loc_oCnt3.txt_4c_QtTb.Value = 0
3591:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)

*-- Linhas 3628 a 3648:
3628:             loc_nTuboAtual = THIS.this_nTuboAtual
3629: 
3630:             IF PEMSTATUS(loc_oCnt3, "grd_4c_GradeTrf", 5) AND USED("TmpTrf")
3631:                 SELECT TmpTrf
3632:                 IF !EOF("TmpTrf") AND TmpTrf.Tubos = loc_nTuboAtual
3633:                     DELETE
3634:                     SET FILTER TO
3635:                     PACK NOOPTIMIZE
3636:                     SET FILTER TO TmpTrf.Tubos = THIS.this_nTuboAtual
3637:                     GO TOP
3638:                     loc_oCnt3.grd_4c_GradeTrf.Refresh()
3639:                 ENDIF
3640:             ENDIF
3641:             loc_lSucesso = .T.
3642:         CATCH TO loc_oErro
3643:             MsgErro("Erro em FormFUN.RemoverTrfClick: " + loc_oErro.Message, "Erro")
3644:         ENDTRY
3645: 
3646:         RETURN loc_lSucesso
3647:     ENDPROC
3648: 

*-- Linhas 3656 a 3674:
3656:         TRY
3657:             loc_oCnt3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
3658:             IF USED("TmpNop") AND !EOF("TmpNop") AND PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
3659:                 SELECT TmpNop
3660:                 IF !EOF("TmpNop")
3661:                     loc_oCnt3.txt_4c_Operacao.Value = ALLTRIM(NVL(TmpNop.Cpros, "")) + ;
3662:                         "  Qt: " + TRANSFORM(NVL(TmpNop.Qtds, 0), "999,999.999")
3663:                 ENDIF
3664:             ENDIF
3665:             loc_lSucesso = .T.
3666:         CATCH TO loc_oErro
3667:             MsgErro("Erro em FormFUN.GradenopAfterRowColChange: " + loc_oErro.Message, "Erro")
3668:         ENDTRY
3669: 
3670:         RETURN loc_lSucesso
3671:     ENDPROC
3672: 
3673:     *==========================================================================
3674:     PROCEDURE BtnTotalClick()

*-- Linhas 3682 a 3726:
3682:             ENDIF
3683: 
3684:             IF USED("TmpCera") AND RECCOUNT("TmpCera") > 0
3685:                 SELECT TmpCera.CodArvs AS CodArvs, ;
3686:                        TmpCera.Descs   AS Descs,   ;
3687:                        SUM(TmpCera.pmetalrs) AS PesoRealTotal, ;
3688:                        SUM(TmpCera.MetalNvs) AS MetalNovoTotal, ;
3689:                        SUM(TmpCera.PMetals)  AS PesoMetalTotal  ;
3690:                 FROM TmpCera ;
3691:                 WHERE TmpCera.nStatus = 3 ;
3692:                 GROUP BY TmpCera.CodArvs, TmpCera.Descs ;
3693:                 INTO CURSOR cursor_4c_TmpTot NOFILTER
3694:             ELSE
3695:                 CREATE CURSOR cursor_4c_TmpTot ( ;
3696:                     CodArvs        C(10), ;
3697:                     Descs          C(40), ;
3698:                     PesoRealTotal  N(12,2), ;
3699:                     MetalNovoTotal N(12,2), ;
3700:                     PesoMetalTotal N(12,2) ;
3701:                 )
3702:             ENDIF
3703: 
3704:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Total
3705:             IF PEMSTATUS(loc_oCnt, "grd_4c_TmpTot", 5)
3706:                 loc_oCnt.grd_4c_TmpTot.ColumnCount = 4
3707:                 loc_oCnt.grd_4c_TmpTot.RecordSource            = "cursor_4c_TmpTot"
3708:                 loc_oCnt.grd_4c_TmpTot.Column1.ControlSource   = "cursor_4c_TmpTot.CodArvs"
3709:                 loc_oCnt.grd_4c_TmpTot.Column2.ControlSource   = "cursor_4c_TmpTot.PesoRealTotal"
3710:                 loc_oCnt.grd_4c_TmpTot.Column3.ControlSource   = "cursor_4c_TmpTot.MetalNovoTotal"
3711:                 loc_oCnt.grd_4c_TmpTot.Column4.ControlSource   = "cursor_4c_TmpTot.PesoMetalTotal"
3712:                 loc_oCnt.grd_4c_TmpTot.Refresh()
3713:             ENDIF
3714: 
3715:             loc_oCnt.Visible = .T.
3716:             loc_oCnt.ZOrder(0)
3717:             loc_lSucesso = .T.
3718:         CATCH TO loc_oErro
3719:             MsgErro("Erro em FormFUN.BtnTotalClick: " + loc_oErro.Message, "Erro")
3720:         ENDTRY
3721: 
3722:         RETURN loc_lSucesso
3723:     ENDPROC
3724: 
3725:     *==========================================================================
3726:     PROCEDURE BtnCancelarTotalClick()

*-- Linhas 3776 a 3793:
3776:             ENDIF
3777: 
3778:             IF USED("TmpNop")
3779:                 SELECT TmpNop
3780:                 SET FILTER TO
3781:                 GO TOP
3782:             ENDIF
3783:             IF USED("TmpTrf")
3784:                 SELECT TmpTrf
3785:                 SET FILTER TO
3786:                 GO TOP
3787:             ENDIF
3788:         CATCH TO loc_oErro
3789:             MsgErro("Erro em FormFUN.LimparCamposTubo: " + loc_oErro.Message, "Erro")
3790:         ENDTRY
3791:     ENDPROC
3792: 
3793: ENDDEFINE


### BO (C:\4c\projeto\app\classes\FUNBO.prg):
*==============================================================================
* FUNBO.prg - Business Object para Cadastro de Fundicoes (SIGCDFUN)
* Tabela principal : SIGCDFUN (cabecalho)
* Tabela detalhe   : SigCdFud (tubos, ordens de producao, transferencias)
*==============================================================================

DEFINE CLASS FUNBO AS BusinessBase

	*-- SIGCDFUN: campos do cabecalho
	this_nCodigos   = 0    && codigos   numeric(6,0) - ID da fundicao
	this_cCidChaves = ""   && cidchaves char(20)     - PK fisica
	this_cEmps      = ""   && emps      char(3)      - empresa
	this_dDatas     = {}   && datas     datetime     - data da fundicao
	this_cCodMaqfs  = ""   && codmaqfs  char(10)     - codigo da maquina
	this_cUsuars    = ""   && usuars    char(10)      - usuario que registrou
	this_mObsG      = ""   && obss      text         - observacao geral do cabecalho

	*-- Propriedade de trabalho: numero de tubos da maquina (SigCfMqf.Tubos)
	*   Lido no CarregarPorCodigo via JOIN, devolvido ao form em BOParaForm
	this_nNTubos    = 0

	*==========================================================================
	PROCEDURE Init()
	*==========================================================================
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDFUN"
		THIS.this_cCampoChave = "codigos"
		RETURN .T.
	ENDPROC

	*==========================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
	*==========================================================================
		RETURN TRANSFORM(THIS.this_nCodigos)
	ENDPROC

	*==========================================================================
	* Buscar - Retorna lista de fundicoes em cursor_4c_Dados
	* par_cFiltro: fragmento WHERE sem a palavra WHERE
	*==========================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF VARTYPE(par_cFiltro) != "C"
				par_cFiltro = ""
			ENDIF

			loc_cSQL = "SELECT f.codigos, f.datas, f.usuars, f.codmaqfs," + ;
			           " f.ntubos," + ;
			           " ISNULL(CAST(f.obss AS NVARCHAR(200)), '') AS obss" + ;
			           " FROM SIGCDFUN f"

			IF !EMPTY(ALLTRIM(par_cFiltro))
				loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY f.datas DESC, f.codigos DESC"

			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				IF !USED("cursor_4c_Dados")
					CREATE CURSOR cursor_4c_Dados (codigos N(6,0), datas T, ;
					    usuars C(10), codmaqfs C(10), ntubos N(2,0), obss C(200))
				ENDIF
				MsgErro("Erro ao buscar fundi" + CHR(231) + CHR(245) + "es:" + ;
				    CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em FUNBO.Buscar: " + loc_oErro.Message, "Erro")
			IF !USED("cursor_4c_Dados")
				CREATE CURSOR cursor_4c_Dados (codigos N(6,0), datas T, ;
				    usuars C(10), codmaqfs C(10), ntubos N(2,0), obss C(200))
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CarregarPorCodigo - Carrega registro pelo codigos (ID numerico)
	* Tambem carrega this_nNTubos (numero de tubos da maquina) via JOIN SigCfMqf
	*==========================================================================
	PROCEDURE CarregarPorCodigo(par_nCodigos)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT f.codigos, f.cidchaves, f.emps, f.datas," + ;
			           " f.codmaqfs, f.usuars," + ;
			           " ISNULL(CAST(f.obss AS NVARCHAR(MAX)), '') AS obss," + ;
			           " ISNULL(m.tubos, 24) AS ntubos" + ;
			           " FROM SIGCDFUN f" + ;
			           " LEFT JOIN SigCfMqf m ON m.codigos = f.codmaqfs" + ;
			           " WHERE f.codigos = " + TRANSFORM(par_nCodigos)

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega") AND ;
			        RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				MsgErro("Fundi" + CHR(231) + CHR(227) + "o " + ;
				    TRANSFORM(par_nCodigos) + " n" + CHR(227) + "o encontrada.", "Aviso")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em FUNBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CarregarDoCursor - Popula propriedades a partir de cursor aberto
	*==========================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_nCodigos   = TratarNulo(codigos,   "N")
			THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
			THIS.this_cEmps      = TratarNulo(emps,      "C")
			THIS.this_dDatas     = TratarNulo(datas,     "D")
			THIS.this_cCodMaqfs  = TratarNulo(codmaqfs,  "C")
			THIS.this_cUsuars    = TratarNulo(usuars,    "C")
			THIS.this_mObsG      = TratarNulo(obss,      "C")
			THIS.this_nNTubos    = TratarNulo(ntubos,    "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Inserir - INSERT SIGCDFUN + SigCdFud (PROTECTED - chamado por Salvar())
	*==========================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
		LOCAL loc_nCodigos, loc_cChave, loc_nNTuboFlag
		loc_lSucesso = .F.

		TRY
			*-- Flag de tubos em producao (nTubos em SIGCDFUN): 1 se nStatus 2 ou 3
			loc_nNTuboFlag = THIS.CalcularFlagNTubos()

			*-- Gerar proximo codigos via SQL Server
			loc_nResultado = SQLEXEC(gnConnHandle, ;
			    "SELECT ISNULL(MAX(codigos), 0) + 1 AS prox FROM SIGCDFUN", ;
			    "cursor_4c_FunNextId")
			IF loc_nResultado < 0 OR !USED("cursor_4c_FunNextId")
				MsgErro("Erro ao gerar ID de fundi" + CHR(231) + CHR(227) + "o: " + ;
				    CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_nCodigos = cursor_4c_FunNextId.prox
				USE IN cursor_4c_FunNextId

				THIS.this_nCodigos = loc_nCodigos

				*-- Gerar cidchaves (20 chars via SYS(2015))
				loc_cChave = SYS(2015) + SYS(2015)
				THIS.this_cCidChaves = loc_cChave

				*-- Campos automaticos
				IF EMPTY(THIS.this_cUsuars)
					THIS.this_cUsuars = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
				ENDIF
				IF EMPTY(THIS.this_cEmps)
					THIS.this_cEmps = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
				ENDIF

				SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

				loc_cSQL = "INSERT INTO SIGCDFUN" + ;
				    " (cidchaves, codigos, emps, datas, datars," + ;
				    " codmaqfs, horas, ntubos, usuars, obss)" + ;
				    " VALUES (" + ;
				    EscaparSQL(loc_cChave) + "," + ;
				    TRANSFORM(loc_nCodigos) + "," + ;
				    EscaparSQL(THIS.this_cEmps) + "," + ;
				    FormatarDataSQL(THIS.this_dDatas) + "," + ;
				    GETDATE() + "," + ;
				    EscaparSQL(ALLTRIM(NVL(THIS.this_cCodMaqfs, ""))) + "," + ;
				    EscaparSQL(SUBSTR(TIME(), 1, 8)) + "," + ;
				    TRANSFORM(loc_nNTuboFlag) + "," + ;
				    EscaparSQL(ALLTRIM(NVL(THIS.this_cUsuars, ""))) + "," + ;
				    THIS.PrepararMemoSQL(THIS.this_mObsG) + ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResultado < 0
					SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					MsgErro("Erro ao inserir fundi" + CHR(231) + CHR(227) + "o:" + ;
					    CHR(13) + CapturarErroSQL(), "Erro SQL")
				ELSE
					IF THIS.InserirDetalhesSigCdFud(loc_nCodigos)
						SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
						THIS.RegistrarAuditoria("INSERT")
						loc_lSucesso = .T.
					ELSE
						SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro em FUNBO.Inserir: " + loc_oErro.Message + ;
			    " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Atualizar - UPDATE SIGCDFUN + recriar SigCdFud (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nNTuboFlag
		loc_lSucesso = .F.

		TRY
			loc_nNTuboFlag = THIS.CalcularFlagNTubos()

			IF EMPTY(THIS.this_cUsuars)
				THIS.this_cUsuars = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
			ENDIF

			SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

			loc_cSQL = "UPDATE SIGCDFUN SET" + ;
			    " emps     = " + EscaparSQL(THIS.this_cEmps) + "," + ;
			    " datas    = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
			    " datars   = " + GETDATE() + "," + ;
			    " codmaqfs = " + EscaparSQL(ALLTRIM(NVL(THIS.this_cCodMaqfs, ""))) + "," + ;
			    " horas    = " + EscaparSQL(SUBSTR(TIME(), 1, 8)) + "," + ;
			    " ntubos   = " + TRANSFORM(loc_nNTuboFlag) + "," + ;
			    " usuars   = " + EscaparSQL(ALLTRIM(NVL(THIS.this_cUsuars, ""))) + "," + ;
			    " obss     = " + THIS.PrepararMemoSQL(THIS.this_mObsG) + ;
			    " WHERE codigos = " + TRANSFORM(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado < 0
				SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
				MsgErro("Erro ao atualizar fundi" + CHR(231) + CHR(227) + "o:" + ;
				    CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				*-- Excluir detalhes antigos e reinserir dos cursores de trabalho
				loc_nResultado = SQLEXEC(gnConnHandle, ;
				    "DELETE FROM SigCdFud WHERE codigos = " + TRANSFORM(THIS.this_nCodigos))
				IF loc_nResultado < 0
					SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					MsgErro("Erro ao excluir detalhes antigos da fundi" + CHR(231) + CHR(227) + "o:" + ;
					    CHR(13) + CapturarErroSQL(), "Erro SQL")
				ELSE
					IF THIS.InserirDetalhesSigCdFud(THIS.this_nCodigos)
						SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
						THIS.RegistrarAuditoria("UPDATE")
						loc_lSucesso = .T.
					ELSE
						SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro em FUNBO.Atualizar: " + loc_oErro.Message + ;
			    " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ExecutarExclusao - DELETE SIGCDFUN + SigCdFud (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lSucesso, loc_nResultado
		loc_lSucesso = .F.

		TRY
			SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

			loc_nResultado = SQLEXEC(gnConnHandle, ;
			    "DELETE FROM SIGCDFUN WHERE codigos = " + TRANSFORM(THIS.this_nCodigos))
			IF loc_nResultado < 0
				SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
				MsgErro("Erro ao excluir fundi" + CHR(231) + CHR(227) + "o:" + ;
				    CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_nResultado = SQLEXEC(gnConnHandle, ;
				    "DELETE FROM SigCdFud WHERE codigos = " + TRANSFORM(THIS.this_nCodigos))
				IF loc_nResultado < 0
					SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					MsgErro("Erro ao excluir detalhes da fundi" + CHR(231) + CHR(227) + "o:" + ;
					    CHR(13) + CapturarErroSQL(), "Erro SQL")
				ELSE
					SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
					THIS.RegistrarAuditoria("DELETE")
					loc_lSucesso = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro em FUNBO.ExecutarExclusao: " + loc_oErro.Message + ;
			    " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* InserirDetalhesSigCdFud - Insere linhas de SigCdFud a partir de
	*   TmpTrf (transferencias), TmpNop (ordens de producao), TmpCera (tubos)
	*==========================================================================
	PROTECTED PROCEDURE InserirDetalhesSigCdFud(par_nCodigos)
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cChave
		LOCAL loc_cDopes, loc_nNNumes, loc_nTubos
		LOCAL loc_nNops, loc_nQtds, loc_nQtdos
		LOCAL loc_nBCeras, loc_nBases, loc_cCodCors, loc_cCodArvs
		LOCAL loc_nMetals, loc_nMetalNvs, loc_nNStatus
		LOCAL loc_cTmpMets, loc_cTmpAmbs, loc_cTmpTubs, loc_cTmpAgus
		loc_lSucesso = .T.

		TRY
			*------------------------------------------------------------------
			* 1. TmpTrf -> SigCdFud (transferencias/lancamentos de operacao)
			*    Condicao de skip: Dopes vazio OU nNumes = 0
			*------------------------------------------------------------------
			IF USED("TmpTrf") AND RECCOUNT("TmpTrf") > 0
				SELECT TmpTrf
				SET ORDER TO
				GO TOP
				DO WHILE !EOF() AND loc_lSucesso
					loc_cDopes  = ALLTRIM(TmpTrf.Dopes)
					loc_nNNumes = TmpTrf.nNumes
					loc_nTubos  = TmpTrf.Tubos

					IF !EMPTY(loc_cDopes) AND loc_nNNumes > 0
						loc_cChave  = SYS(2015) + SYS(2015)
						loc_cSQL = "INSERT INTO SigCdFud" + ;
						    " (cidchaves, codigos, tubos, nnumes, nops, qtds, qtdos," + ;
						    " bceras, bases, metals, metalnvs, nstatus," + ;
						    " codcors, codarvs, obss," + ;
						    " tempmets, tempambs, temptubs, tempagus)" + ;
						    " VALUES (" + ;
						    EscaparSQL(loc_cChave) + "," + ;
						    TRANSFORM(par_nCodigos) + "," + ;
						    TRANSFORM(loc_nTubos) + "," + ;
						    TRANSFORM(loc_nNNumes) + "," + ;
						    "0,0,0," + ;
						    "0,0,0,0,0," + ;
						    "'','',NULL," + ;
						    "'','','','')"
						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
						IF loc_nResultado < 0
							MsgErro("Erro ao inserir transfer" + CHR(234) + "ncia" + ;
							    " (tubo " + TRANSFORM(loc_nTubos) + ") em SigCdFud:" + ;
							    CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
						ENDIF
					ENDIF

					SELECT TmpTrf
					SKIP
				ENDDO
			ENDIF

			*------------------------------------------------------------------
			* 2. TmpNop -> SigCdFud (ordens de producao)
			*    Condicao de skip: nops = 0 OU qtdos = 0
			*------------------------------------------------------------------
			IF loc_lSucesso AND USED("TmpNop") AND RECCOUNT("TmpNop") > 0
				SELECT TmpNop
				SET ORDER TO
				GO TOP
				DO WHILE !EOF() AND loc_lSucesso
					loc_nNops  = TmpNop.Nops
					loc_nQtds  = TmpNop.Qtds
					loc_nTubos = TmpNop.Tubos
					loc_nQtdos = TmpNop.Qtdos

					IF loc_nNops > 0 AND loc_nQtdos > 0
						loc_cChave = SYS(2015) + SYS(2015)
						loc_cSQL = "INSERT INTO SigCdFud" + ;
						    " (cidchaves, codigos, tubos, nops, qtds, qtdos, nnumes," + ;
						    " bceras, bases, metals, metalnvs, nstatus," + ;
						    " codcors, codarvs, obss," + ;
						    " tempmets, tempambs, temptubs, tempagus)" + ;
						    " VALUES (" + ;
						    EscaparSQL(loc_cChave) + "," + ;
						    TRANSFORM(par_nCodigos) + "," + ;
						    TRANSFORM(loc_nTubos) + "," + ;
						    TRANSFORM(loc_nNops) + "," + ;
						    FormatarNumeroSQL(loc_nQtds, 3) + "," + ;
						    FormatarNumeroSQL(loc_nQtdos, 3) + "," + ;
						    "0," + ;
						    "0,0,0,0,0," + ;
						    "'','',NULL," + ;
						    "'','','','')"
						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
						IF loc_nResultado < 0
							MsgErro("Erro ao inserir O.P. " + TRANSFORM(loc_nNops) + ;
							    " (tubo " + TRANSFORM(loc_nTubos) + ") em SigCdFud:" + ;
							    CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
						ENDIF
					ENDIF

					SELECT TmpNop
					SKIP
				ENDDO
			ENDIF

			*------------------------------------------------------------------
			* 3. TmpCera -> SigCdFud (dados de cera/metal por tubo)
			*    Condicao de skip: bceras = 0 E bases = 0 (tubo sem dados)
			*    metals em SigCdFud = pmetalrs (peso real do metal, digitado)
			*------------------------------------------------------------------
			IF loc_lSucesso AND USED("TmpCera") AND RECCOUNT("TmpCera") > 0
				SELECT TmpCera
				SET ORDER TO
				GO TOP
				DO WHILE !EOF() AND loc_lSucesso
					loc_nBCeras   = TmpCera.BCeras
					loc_nBases    = TmpCera.Bases
					loc_nTubos    = TmpCera.Tubos
					loc_cCodCors  = ALLTRIM(NVL(TmpCera.CodCors, ""))
					loc_cCodArvs  = ALLTRIM(NVL(TmpCera.CodArvs, ""))
					loc_nMetals   = TmpCera.pmetalrs   && peso real (digitado)
					loc_nMetalNvs = TmpCera.MetalNvs
					loc_nNStatus  = TmpCera.nStatus
					loc_cTmpMets  = ALLTRIM(NVL(TmpCera.TempMets, ""))
					loc_cTmpAmbs  = ALLTRIM(NVL(TmpCera.TempAmbs, ""))
					loc_cTmpTubs  = ALLTRIM(NVL(TmpCera.TempTubs, ""))
					loc_cTmpAgus  = ALLTRIM(NVL(TmpCera.TempAgus, ""))

					IF !(loc_nBCeras = 0 AND loc_nBases = 0)
						loc_cChave = SYS(2015) + SYS(2015)
						loc_cSQL = "INSERT INTO SigCdFud" + ;
						    " (cidchaves, codigos, tubos," + ;
						    " bceras, bases, metals, metalnvs, nstatus," + ;
						    " codcors, codarvs, nnumes, nops, qtds, qtdos," + ;
						    " obss, tempmets, tempambs, temptubs, tempagus)" + ;
						    " VALUES (" + ;
						    EscaparSQL(loc_cChave) + "," + ;
						    TRANSFORM(par_nCodigos) + "," + ;
						    TRANSFORM(loc_nTubos) + "," + ;
						    FormatarNumeroSQL(loc_nBCeras, 2) + "," + ;
						    FormatarNumeroSQL(loc_nBases,  2) + "," + ;
						    FormatarNumeroSQL(loc_nMetals,   2) + "," + ;
						    FormatarNumeroSQL(loc_nMetalNvs, 2) + "," + ;
						    TRANSFORM(loc_nNStatus) + "," + ;
						    EscaparSQL(loc_cCodCors) + "," + ;
						    EscaparSQL(loc_cCodArvs) + "," + ;
						    "0,0,0,0," + ;
						    THIS.PrepararMemoSQL(NVL(TmpCera.Obss, "")) + "," + ;
						    EscaparSQL(loc_cTmpMets) + "," + ;
						    EscaparSQL(loc_cTmpAmbs) + "," + ;
						    EscaparSQL(loc_cTmpTubs) + "," + ;
						    EscaparSQL(loc_cTmpAgus) + ")"

						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
						IF loc_nResultado < 0
							MsgErro("Erro ao inserir tubo " + TRANSFORM(loc_nTubos) + ;
							    " em SigCdFud:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
						ENDIF
					ENDIF

					SELECT TmpCera
					SKIP
				ENDDO
			ENDIF

		CATCH TO loc_oErro
			MsgErro("Erro em FUNBO.InserirDetalhesSigCdFud: " + loc_oErro.Message + ;
			    " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CalcularFlagNTubos - Retorna 1 se ha tubos em producao (nStatus 2 ou 3)
	*   Corresponde ao campo SIGCDFUN.ntubos (flag vermelho na grade)
	*==========================================================================
	PROTECTED PROCEDURE CalcularFlagNTubos()
		LOCAL loc_nFlag
		loc_nFlag = 0

		IF USED("TmpCera") AND RECCOUNT("TmpCera") > 0
			SELECT TmpCera
			LOCATE FOR TmpCera.nStatus = 2 OR TmpCera.nStatus = 3
			IF FOUND()
				loc_nFlag = 1
			ENDIF
		ENDIF

		RETURN loc_nFlag
	ENDPROC

	*==========================================================================
	* PrepararMemoSQL - Prepara campo memo/texto para SQL (NULL ou 'texto')
	*==========================================================================
	PROTECTED PROCEDURE PrepararMemoSQL(par_mTexto)
		LOCAL loc_cValor
		loc_cValor = ALLTRIM(NVL(CAST(par_mTexto AS CHARACTER), ""))

		IF EMPTY(loc_cValor)
			RETURN "NULL"
		ENDIF

		loc_cValor = SUBSTR(loc_cValor, 1, 4000)
		loc_cValor = STRTRAN(loc_cValor, "'", "''")

		RETURN "'" + loc_cValor + "'"
	ENDPROC

ENDDEFINE


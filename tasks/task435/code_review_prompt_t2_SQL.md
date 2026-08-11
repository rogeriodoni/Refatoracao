# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFUN.prg) - TRECHOS RELEVANTES PARA PASS SQL (3824 linhas total):

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

*-- Linhas 564 a 618:
564:             .HighlightBackColor = RGB(255, 255, 255)
565:             .HighlightForeColor = RGB(15, 41, 104)
566:             .HighlightStyle     = 2
567:             .DeleteMark         = .F.
568:             .RecordMark         = .F.
569:             .RowHeight          = 16
570:             .ScrollBars         = 2
571:             .GridLines          = 3
572:             .ReadOnly           = .T.
573:             .RecordSource       = "cursor_4c_Dados"
574:             .RecordSourceType   = 1
575:         ENDWITH
576: 
577:         WITH loc_oPagina.grd_4c_Dados.Column1
578:             .ControlSource   = "cursor_4c_Dados.codigos"
579:             .Width           = 52
580:             .Alignment       = 2
581:             .Header1.Caption = "C" + CHR(243) + "digo"
582:         ENDWITH
583: 
584:         WITH loc_oPagina.grd_4c_Dados.Column2
585:             .ControlSource   = "cursor_4c_Dados.datas"
586:             .Width           = 75
587:             .Header1.Caption = "Data"
588:         ENDWITH
589: 
590:         WITH loc_oPagina.grd_4c_Dados.Column3
591:             .ControlSource   = "cursor_4c_Dados.usuars"
592:             .Width           = 80
593:             .Header1.Caption = "Usu" + CHR(225) + "rio"
594:         ENDWITH
595: 
596:         WITH loc_oPagina.grd_4c_Dados.Column4
597:             .ControlSource   = "cursor_4c_Dados.codmaqfs"
598:             .Width           = 80
599:             .Header1.Caption = "M" + CHR(225) + "quina"
600:         ENDWITH
601: 
602:         WITH loc_oPagina.grd_4c_Dados.Column5
603:             .ControlSource   = "cursor_4c_Dados.obss"
604:             .Width           = 330
605:             .Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
606:         ENDWITH
607: 
608:         BINDEVENT(loc_oPagina.grd_4c_Dados, "DblClick", THIS, "BtnVisualizarClick")
609: 
610:         THIS.TornarControlesVisiveis(loc_oPagina)
611:     ENDPROC
612: 
613:     *==========================================================================
614:     PROTECTED PROCEDURE ConfigurarPaginaDados()
615:     *==========================================================================
616:         LOCAL loc_oPagina
617:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
618: 

*-- Linhas 818 a 839:
818:                     USE IN cursor_4c_Arvores
819:                 ENDIF
820: 
821:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
822:                     "SELECT a.codigos, a.descs, a.formulas, a.percs," + ;
823:                     " a.tempmets, a.temptubs, a.tempambs, a.tempagus" + ;
824:                     " FROM sigcdarv a ORDER BY a.codigos", ;
825:                     "cursor_4c_Arvores")
826: 
827:                 IF loc_nResultado < 0
828:                     MsgErro("Erro ao carregar " + CHR(225) + "rvores:" + ;
829:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
830:                 ENDIF
831:             ENDIF
832:         CATCH TO loc_oErro
833:             MsgErro("Erro em FormFUN.CarregarArvores: " + loc_oErro.Message, "Erro")
834:         ENDTRY
835:     ENDPROC
836: 
837:     *==========================================================================
838:     FUNCTION CarregarLista()
839:     *==========================================================================

*-- Linhas 876 a 910:
876:                 loc_cDtIniSQL = "'" + STUFF(STUFF(DTOS(loc_dDtIni), 5, 0, "-"), 8, 0, "-") + " 00:00:00'"
877:                 loc_cDtFimSQL = "'" + STUFF(STUFF(DTOS(loc_dDtFim), 5, 0, "-"), 8, 0, "-") + " 23:59:59'"
878: 
879:                 loc_cFiltro = "a.emps = " + EscaparSQL(loc_cEmps) + ;
880:                     " AND a.datas >= " + loc_cDtIniSQL + ;
881:                     " AND a.datas <= " + loc_cDtFimSQL
882: 
883:                 loc_lSucesso = THIS.this_oBusinessObject.Buscar(loc_cFiltro)
884: 
885:                 *-- Re-definir ControlSources apos Buscar() recriar cursor_4c_Dados (autobind por posicao)
886:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5) AND USED("cursor_4c_Dados")
887:                     LOCAL loc_oGrd
888:                     loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
889:                     loc_oGrd.ColumnCount = 5
890:                     loc_oGrd.RecordSource          = "cursor_4c_Dados"
891:                     loc_oGrd.Column1.ControlSource = "cursor_4c_Dados.codigos"
892:                     loc_oGrd.Column2.ControlSource = "cursor_4c_Dados.datas"
893:                     loc_oGrd.Column3.ControlSource = "cursor_4c_Dados.usuars"
894:                     loc_oGrd.Column4.ControlSource = "cursor_4c_Dados.codmaqfs"
895:                     loc_oGrd.Column5.ControlSource = "cursor_4c_Dados.obss"
896:                 ENDIF
897: 
898:                 *-- Ocultar aguarde
899:                 THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnAguarde.Visible = .F.
900:             ENDIF
901:         CATCH TO loc_oErro
902:             MsgErro("Erro em FormFUN.CarregarLista: " + loc_oErro.Message, "Erro")
903:             TRY
904:                 THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnAguarde.Visible = .F.
905:             CATCH
906:             ENDTRY
907:             loc_lSucesso = .F.
908:         ENDTRY
909: 
910:         RETURN loc_lSucesso

*-- Linhas 1017 a 1035:
1017:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1018:                 MsgAviso("Nenhum registro selecionado.", "Alterar")
1019:             ELSE
1020:                 SELECT cursor_4c_Dados
1021:                 loc_nCodigos = cursor_4c_Dados.codigos
1022: 
1023:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
1024:                     THIS.BOParaForm()
1025:                     THIS.this_cModoAtual = "ALTERAR"
1026:                     THIS.this_lEmEdicao  = .T.
1027:                     THIS.AlternarPagina(2)
1028:                     THIS.ChkTubo(1)
1029:                     THIS.AtualizarEstadoControles()
1030:                     loc_lSucesso = .T.
1031:                 ENDIF
1032:             ENDIF
1033:         CATCH TO loc_oErro
1034:             MsgErro("Erro em FormFUN.BtnAlterarClick: " + loc_oErro.Message, "Erro")
1035:         ENDTRY

*-- Linhas 1047 a 1065:
1047:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1048:                 MsgAviso("Nenhum registro selecionado.", "Visualizar")
1049:             ELSE
1050:                 SELECT cursor_4c_Dados
1051:                 loc_nCodigos = cursor_4c_Dados.codigos
1052: 
1053:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
1054:                     THIS.BOParaForm()
1055:                     THIS.this_cModoAtual = "VISUALIZAR"
1056:                     THIS.this_lEmEdicao  = .F.
1057:                     THIS.AlternarPagina(2)
1058:                     THIS.ChkTubo(1)
1059:                     THIS.AtualizarEstadoControles()
1060:                     loc_lSucesso = .T.
1061:                 ENDIF
1062:             ENDIF
1063:         CATCH TO loc_oErro
1064:             MsgErro("Erro em FormFUN.BtnVisualizarClick: " + loc_oErro.Message, "Erro")
1065:         ENDTRY

*-- Linhas 1077 a 1095:
1077:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1078:                 MsgAviso("Nenhum registro selecionado.", "Excluir")
1079:             ELSE
1080:                 SELECT cursor_4c_Dados
1081:                 loc_nCodigos = cursor_4c_Dados.codigos
1082: 
1083:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da fundi" + CHR(231) + ;
1084:                     CHR(227) + "o " + TRANSFORM(loc_nCodigos) + "?", "Excluir")
1085:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
1086:                         IF THIS.this_oBusinessObject.Excluir()
1087:                             THIS.CarregarLista()
1088:                             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
1089:                                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1090:                             ENDIF
1091:                             loc_lSucesso = .T.
1092:                         ENDIF
1093:                     ENDIF
1094:                 ENDIF
1095:             ENDIF

*-- Linhas 1501 a 1519:
1501:                 loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
1502:                 IF PEMSTATUS(loc_oCnt, loc_cNomeChk, 5)
1503:                     IF loc_oCnt.Value = 1
1504:                         SELECT TmpCera
1505:                         SET ORDER TO Tubos
1506:                         IF SEEK(STR(loc_n, 2))
1507:                             DO CASE
1508:                                 CASE loc_nStatus = 1
1509:                                     REPLACE nStatus WITH 1 IN TmpCera
1510:                                     loc_oCnt.Picture = ""
1511:                                 CASE loc_nStatus = 2
1512:                                     REPLACE nStatus WITH 2 IN TmpCera
1513:                                     loc_oCnt.Picture = gc_4c_CaminhoIcones + "geral_arvore_cera_60.jpg"
1514:                                 CASE loc_nStatus = 3
1515:                                     REPLACE nStatus WITH 3 IN TmpCera
1516:                                     loc_oCnt.Picture = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
1517:                                 CASE loc_nStatus = 4
1518:                                     REPLACE nStatus WITH 4 IN TmpCera
1519:                                     loc_oCnt.Picture = gc_4c_CaminhoIcones + "geral_pecapronta_60.jpg"

*-- Linhas 1540 a 1566:
1540:                 THIS.this_nMaqTubos = 0
1541:                 THIS.AtualizarVisibilidadeCheckboxes(0)
1542:             ELSE
1543:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1544:                     "SELECT m.codigos, m.tubos FROM SigCfMqf m WHERE m.codigos = " + ;
1545:                     EscaparSQL(loc_cCodMaq), ;
1546:                     "cursor_4c_BuscaMaq")
1547: 
1548:                 loc_nTubos = 0
1549:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaMaq") AND ;
1550:                         RECCOUNT("cursor_4c_BuscaMaq") > 0
1551:                     SELECT cursor_4c_BuscaMaq
1552:                     loc_nTubos = cursor_4c_BuscaMaq.tubos
1553:                     THIS.this_nMaqTubos = loc_nTubos
1554:                     THIS.AtualizarVisibilidadeCheckboxes(loc_nTubos)
1555:                 ELSE
1556:                     MsgAviso("M" + CHR(225) + "quina '" + loc_cCodMaq + ;
1557:                         "' n" + CHR(227) + "o encontrada.", ;
1558:                         "M" + CHR(225) + "quina")
1559:                     loc_oCnt1.txt_4c_Maq.Value = ""
1560:                     THIS.this_nMaqTubos = 0
1561:                     THIS.AtualizarVisibilidadeCheckboxes(0)
1562:                 ENDIF
1563: 
1564:                 IF USED("cursor_4c_BuscaMaq")
1565:                     USE IN cursor_4c_BuscaMaq
1566:                 ENDIF

*-- Linhas 1621 a 1677:
1621: 
1622:                     *-- Tubo com transformacao metalica em andamento
1623:                     IF USED("TmpTrf") AND RECCOUNT("TmpTrf") > 0
1624:                         SELECT TmpTrf
1625:                         SET ORDER TO 0
1626:                         LOCATE FOR TmpTrf.Tubos = loc_n
1627:                         IF FOUND()
1628:                             loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
1629:                         ENDIF
1630:                     ENDIF
1631: 
1632:                     *-- Tubo com peca pronta (ordem de producao concluida)
1633:                     IF USED("TmpNop") AND RECCOUNT("TmpNop") > 0
1634:                         SELECT TmpNop
1635:                         SET ORDER TO 0
1636:                         LOCATE FOR TmpNop.Tubos = loc_n
1637:                         IF FOUND()
1638:                             loc_cPic = gc_4c_CaminhoIcones + "geral_pecapronta_60.jpg"
1639:                         ENDIF
1640:                     ENDIF
1641: 
1642:                     *-- Tubo com status Cera (sem transformacao/nop)
1643:                     IF EMPTY(loc_cPic) AND USED("TmpCera") AND RECCOUNT("TmpCera") > 0
1644:                         SELECT TmpCera
1645:                         SET ORDER TO Tubos
1646:                         IF SEEK(STR(loc_n, 2)) AND TmpCera.nStatus = 2
1647:                             loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_cera_60.jpg"
1648:                         ENDIF
1649:                     ENDIF
1650: 
1651:                     loc_oCnt.Picture = loc_cPic
1652:                 ENDIF
1653:             ENDFOR
1654: 
1655:             *-- Carregar dados do tubo selecionado nas abas Container5/6/4 e Page2
1656:             IF par_nTubo > 0 AND USED("TmpCera")
1657:                 loc_oCnt4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4
1658:                 loc_oCnt5 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
1659:                 loc_oCnt6 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container6
1660:                 loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1661: 
1662:                 SELECT TmpCera
1663:                 SET ORDER TO Tubos
1664:                 IF SEEK(STR(par_nTubo, 2))
1665:                     *-- Container5: Cera/Metal
1666:                     IF PEMSTATUS(loc_oCnt5, "txt_4c_Cor", 5)
1667:                         loc_oCnt5.txt_4c_Cor.Value     = ALLTRIM(NVL(TmpCera.CodCors, ""))
1668:                         loc_oCnt5.txt_4c_Basec.Value   = NVL(TmpCera.BCeras, 0)
1669:                         loc_oCnt5.txt_4c_Base.Value    = NVL(TmpCera.Bases, 0)
1670:                         loc_oCnt5.txt_4c_Cera.Value    = NVL(TmpCera.Ceras, 0)
1671:                         loc_oCnt5.txt_4c_Metal.Value   = NVL(TmpCera.PMetals, 0)
1672:                         loc_oCnt5.txt_4c_Mreal.Value   = NVL(TmpCera.pmetalrs, 0)
1673:                         loc_oCnt5.txt_4c_metnovo.Value = NVL(TmpCera.MetalNvs, 0)
1674:                     ENDIF
1675:                     *-- Container6: Temperaturas
1676:                     IF PEMSTATUS(loc_oCnt6, "txt_4c_TempMet", 5)
1677:                         loc_oCnt6.txt_4c_TempMet.Value = ALLTRIM(NVL(TmpCera.TempMets, ""))

*-- Linhas 1694 a 1718:
1694: 
1695:                 *-- Filtrar TmpNop e TmpTrf para o tubo corrente e atualizar grades
1696:                 IF USED("TmpNop")
1697:                     SELECT TmpNop
1698:                     SET ORDER TO Tubos
1699:                     SET FILTER TO TmpNop.Tubos = THIS.this_nTuboAtual
1700:                     GO TOP
1701:                 ENDIF
1702:                 IF USED("TmpTrf")
1703:                     SELECT TmpTrf
1704:                     SET ORDER TO Tubos
1705:                     SET FILTER TO TmpTrf.Tubos = THIS.this_nTuboAtual
1706:                     GO TOP
1707:                 ENDIF
1708:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3, "grd_4c_Gradenop", 5)
1709:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3.grd_4c_Gradenop.Refresh()
1710:                 ENDIF
1711:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3, "grd_4c_GradeTrf", 5)
1712:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3.grd_4c_GradeTrf.Refresh()
1713:                 ENDIF
1714:             ELSE
1715:                 THIS.LimparCamposTubo()
1716:             ENDIF
1717:         CATCH TO loc_oErro
1718:             MsgErro("Erro em FormFUN.ChkTubo " + TRANSFORM(par_nTubo) + ": " + ;

*-- Linhas 1852 a 2003:
1852: 
1853:             *-- Carregar detalhe dos tubos de SigCdFud para TmpCera
1854:             IF loc_nCodigos > 0
1855:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1856:                     "SELECT d.tubos, d.bceras, d.bases," + ;
1857:                     " CAST(0 AS NUMERIC(12,2)) AS ceras," + ;
1858:                     " d.metals AS pmetals," + ;
1859:                     " d.codcors, d.obss, d.tempmets, d.tempambs, d.temptubs," + ;
1860:                     " d.tempagus, d.codarvs," + ;
1861:                     " ISNULL(a.descs, '') AS descs," + ;
1862:                     " ISNULL(a.formulas, '') AS formulas," + ;
1863:                     " d.metalnvs, CAST(0 AS NUMERIC(12,2)) AS pmetalrs, d.nstatus" + ;
1864:                     " FROM SigCdFud d" + ;
1865:                     " LEFT JOIN SigCdArv a ON a.codigos = d.codarvs" + ;
1866:                     " WHERE d.codigos = " + TRANSFORM(loc_nCodigos) + ;
1867:                     " AND d.nops = 0 AND d.nnumes = 0" + ;
1868:                     " ORDER BY d.tubos", ;
1869:                     "cursor_4c_TubosFund")
1870: 
1871:                 IF loc_nResultado > 0 AND USED("cursor_4c_TubosFund") AND ;
1872:                         RECCOUNT("cursor_4c_TubosFund") > 0
1873:                     SELECT cursor_4c_TubosFund
1874:                     GO TOP
1875:                     DO WHILE !EOF()
1876:                         loc_nTubo     = cursor_4c_TubosFund.tubos
1877:                         loc_nBCeras   = cursor_4c_TubosFund.bceras
1878:                         loc_nBases    = cursor_4c_TubosFund.bases
1879:                         loc_nCeras    = cursor_4c_TubosFund.ceras
1880:                         loc_nPMetals  = cursor_4c_TubosFund.pmetals
1881:                         loc_cCodCors  = cursor_4c_TubosFund.codcors
1882:                         loc_mObss     = cursor_4c_TubosFund.obss
1883:                         loc_cTmpMets  = cursor_4c_TubosFund.tempmets
1884:                         loc_cTmpAmbs  = cursor_4c_TubosFund.tempambs
1885:                         loc_cTmpTubs  = cursor_4c_TubosFund.temptubs
1886:                         loc_cTmpAgus  = cursor_4c_TubosFund.tempagus
1887:                         loc_cCodArvs  = cursor_4c_TubosFund.codarvs
1888:                         loc_cDescs    = cursor_4c_TubosFund.descs
1889:                         loc_mFormulas = cursor_4c_TubosFund.formulas
1890:                         loc_nMetalNvs = cursor_4c_TubosFund.metalnvs
1891:                         loc_nPmetalrs = cursor_4c_TubosFund.pmetalrs
1892:                         loc_nNStatus  = cursor_4c_TubosFund.nstatus
1893: 
1894:                         INSERT INTO TmpCera (Tubos, BCeras, Bases, Ceras, PMetals, ;
1895:                             CodCors, Obss, TempMets, TempAmbs, TempTubs, TempAgus, ;
1896:                             CodArvs, Descs, Formulas, MetalNvs, pmetalrs, nStatus) ;
1897:                         VALUES (loc_nTubo, loc_nBCeras, loc_nBases, loc_nCeras, ;
1898:                             loc_nPMetals, loc_cCodCors, loc_mObss, loc_cTmpMets, ;
1899:                             loc_cTmpAmbs, loc_cTmpTubs, loc_cTmpAgus, loc_cCodArvs, ;
1900:                             loc_cDescs, loc_mFormulas, loc_nMetalNvs, loc_nPmetalrs, ;
1901:                             loc_nNStatus)
1902: 
1903:                         SELECT cursor_4c_TubosFund
1904:                         SKIP
1905:                     ENDDO
1906:                 ENDIF
1907:             ENDIF
1908: 
1909:             *-- Carregar TmpTrf de SigCdFud (nnumes <> 0 = linhas de transferencia)
1910:             IF loc_nCodigos > 0
1911:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1912:                     "SELECT d.tubos, d.nnumes," + ;
1913:                     " ISNULL(m.dopes, '') AS dopes" + ;
1914:                     " FROM SigCdFud d" + ;
1915:                     " LEFT JOIN SigMvCab m ON m.numes = d.nnumes" + ;
1916:                     " WHERE d.codigos = " + TRANSFORM(loc_nCodigos) + ;
1917:                     " AND d.nnumes <> 0" + ;
1918:                     " ORDER BY d.tubos", ;
1919:                     "cursor_4c_TrfFund")
1920: 
1921:                 IF loc_nResultado > 0 AND USED("cursor_4c_TrfFund") AND ;
1922:                         RECCOUNT("cursor_4c_TrfFund") > 0
1923:                     SELECT cursor_4c_TrfFund
1924:                     GO TOP
1925:                     DO WHILE !EOF()
1926:                         INSERT INTO TmpTrf (Dopes, Numes, Tubos, nNumes) ;
1927:                             VALUES (ALLTRIM(NVL(cursor_4c_TrfFund.dopes, "")), ;
1928:                                     0, ;
1929:                                     cursor_4c_TrfFund.tubos, ;
1930:                                     cursor_4c_TrfFund.nnumes)
1931:                         SELECT cursor_4c_TrfFund
1932:                         SKIP
1933:                     ENDDO
1934:                 ENDIF
1935:                 IF USED("cursor_4c_TrfFund")
1936:                     USE IN cursor_4c_TrfFund
1937:                 ENDIF
1938:             ENDIF
1939: 
1940:             *-- Carregar TmpNop de SigCdFud (nops <> 0 e nnumes = 0 = ordens de producao)
1941:             IF loc_nCodigos > 0
1942:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1943:                     "SELECT d.tubos, d.nops, d.qtds, d.qtdos," + ;
1944:                     " ISNULL(o.cpros, '') AS cpros," + ;
1945:                     " ISNULL(o.numes, 0) AS numes," + ;
1946:                     " ISNULL(CAST(o.dtents AS DATE), CAST(GETDATE() AS DATE)) AS dtents" + ;
1947:                     " FROM SigCdFud d" + ;
1948:                     " OUTER APPLY (SELECT TOP 1 oo.cpros, oo.numes, oo.dtents" + ;
1949:                     " FROM SigOpPic oo WHERE oo.nops = d.nops" + ;
1950:                     " AND oo.emps = " + EscaparSQL(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))) + ;
1951:                     ") o WHERE d.codigos = " + TRANSFORM(loc_nCodigos) + ;
1952:                     " AND d.nops <> 0 AND d.nnumes = 0" + ;
1953:                     " ORDER BY d.tubos, d.nops", ;
1954:                     "cursor_4c_NopFund")
1955: 
1956:                 IF loc_nResultado > 0 AND USED("cursor_4c_NopFund") AND ;
1957:                         RECCOUNT("cursor_4c_NopFund") > 0
1958:                     SELECT cursor_4c_NopFund
1959:                     GO TOP
1960:                     DO WHILE !EOF()
1961:                         INSERT INTO TmpNop (Nops, Cpros, Qtds, Tubos, Qtdos, Numes, ;
1962:                                             EmpDopNums, DtEnts) ;
1963:                             VALUES (cursor_4c_NopFund.nops, ;
1964:                                     ALLTRIM(NVL(cursor_4c_NopFund.cpros, "")), ;
1965:                                     cursor_4c_NopFund.qtds, ;
1966:                                     cursor_4c_NopFund.tubos, ;
1967:                                     cursor_4c_NopFund.qtdos, ;
1968:                                     cursor_4c_NopFund.numes, ;
1969:                                     PADR(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, "")), 29), ;
1970:                                     cursor_4c_NopFund.dtents)
1971:                         SELECT cursor_4c_NopFund
1972:                         SKIP
1973:                     ENDDO
1974:                 ENDIF
1975:                 IF USED("cursor_4c_NopFund")
1976:                     USE IN cursor_4c_NopFund
1977:                 ENDIF
1978:             ENDIF
1979: 
1980:             *-- Carregar observacao geral
1981:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4, "edt_4c_ObsG", 5)
1982:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4.edt_4c_ObsG.Value = ;
1983:                     NVL(loc_oBO.this_mObsG, "")
1984:             ENDIF
1985: 
1986:             *-- Atualizar imagens dos checkboxes baseado em TmpCera.nStatus
1987:             IF USED("TmpCera") AND RECCOUNT("TmpCera") > 0
1988:                 SELECT TmpCera
1989:                 SET ORDER TO Tubos
1990:                 GO TOP
1991:                 DO WHILE !EOF()
1992:                     loc_n = TmpCera.Tubos
1993:                     IF loc_n >= 1 AND loc_n <= 24
1994:                         loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
1995:                         IF PEMSTATUS(loc_oCnt2, loc_cNomeChk, 5)
1996:                             DO CASE
1997:                                 CASE TmpCera.nStatus = 2
1998:                                     loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_cera_60.jpg"
1999:                                 CASE TmpCera.nStatus = 3
2000:                                     loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
2001:                                 CASE TmpCera.nStatus = 4
2002:                                     loc_cPic = gc_4c_CaminhoIcones + "geral_pecapronta_60.jpg"
2003:                                 OTHERWISE

*-- Linhas 2168 a 2215:
2168:             .HeaderHeight = 17
2169:             .RowHeight    = 17
2170:             .RecordMark   = .F.
2171:             .DeleteMark   = .F.
2172:         ENDWITH
2173: 
2174:         WITH loc_oCnt.grd_4c_Gradenop.Column1
2175:             .Header1.Caption = "O.P."
2176:             .ControlSource   = "TmpNop.Nops"
2177:             .Width           = 60
2178:         ENDWITH
2179: 
2180:         WITH loc_oCnt.grd_4c_Gradenop.Column2
2181:             .Header1.Caption = "Produto"
2182:             .ControlSource   = "TmpNop.Cpros"
2183:             .Width           = 110
2184:         ENDWITH
2185: 
2186:         WITH loc_oCnt.grd_4c_Gradenop.Column3
2187:             .Header1.Caption = "Qtde"
2188:             .ControlSource   = "TmpNop.Qtds"
2189:             .Width           = 60
2190:         ENDWITH
2191: 
2192:         WITH loc_oCnt.grd_4c_Gradenop.Column4
2193:             .Header1.Caption = "Pedido"
2194:             .ControlSource   = "TmpNop.Numes"
2195:             .Width           = 50
2196:         ENDWITH
2197: 
2198:         WITH loc_oCnt.grd_4c_Gradenop.Column5
2199:             .Header1.Caption = "Data Entrega"
2200:             .ControlSource   = "TmpNop.DtEnts"
2201:             .Width           = 90
2202:         ENDWITH
2203:         BINDEVENT(loc_oCnt.grd_4c_Gradenop, "AfterRowColChange", THIS, "GradenopAfterRowColChange")
2204: 
2205:         loc_oCnt.AddObject("txt_4c_Operacao", "TextBox")
2206:         WITH loc_oCnt.txt_4c_Operacao
2207:             .Value     = ""
2208:             .Left      = 18
2209:             .Top       = 171
2210:             .Width     = 290
2211:             .Height    = 25
2212:             .ReadOnly  = .T.
2213:             .FontName  = "Tahoma"
2214:             .FontSize  = 8
2215:             .BackColor = RGB(240, 240, 240)

*-- Linhas 2306 a 2335:
2306:             .HeaderHeight = 17
2307:             .RowHeight    = 17
2308:             .RecordMark   = .F.
2309:             .DeleteMark   = .F.
2310:         ENDWITH
2311: 
2312:         WITH loc_oCnt.grd_4c_GradeTrf.Column1
2313:             .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
2314:             .ControlSource   = "TmpTrf.Dopes"
2315:             .Width           = 155
2316:         ENDWITH
2317: 
2318:         WITH loc_oCnt.grd_4c_GradeTrf.Column2
2319:             .Header1.Caption = "Numes"
2320:             .ControlSource   = "TmpTrf.Numes"
2321:             .Width           = 55
2322:         ENDWITH
2323: 
2324:         loc_oCnt.AddObject("cmd_4c_RemoverTrf", "CommandButton")
2325:         WITH loc_oCnt.cmd_4c_RemoverTrf
2326:             .Caption         = ""
2327:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
2328:             .PicturePosition = 4
2329:             .Top             = 297
2330:             .Left            = 165
2331:             .Width           = 40
2332:             .Height          = 40
2333:             .Themes          = .T.
2334:             .SpecialEffect   = 0
2335:             .MousePointer    = 15

*-- Linhas 2745 a 2763:
2745:             .Column4.Header1.Caption = "Metal Ligado"
2746:             .Column4.Width           = 80
2747:             .RecordMark   = .F.
2748:             .DeleteMark   = .F.
2749:         ENDWITH
2750: 
2751:         loc_oCnt.AddObject("cmd_4c_Retornar", "CommandButton")
2752:         WITH loc_oCnt.cmd_4c_Retornar
2753:             .Caption         = "Retornar"
2754:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_26.jpg"
2755:             .PicturePosition = 13
2756:             .Top             = 5
2757:             .Left            = 415
2758:             .Width           = 75
2759:             .Height          = 75
2760:             .FontName        = "Tahoma"
2761:             .FontBold        = .T.
2762:             .FontItalic      = .T.
2763:             .FontSize        = 8

*-- Linhas 2853 a 2871:
2853: 
2854:         TRY
2855:             IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
2856:                 SELECT TmpCera
2857:                 SET ORDER TO Tubos
2858:                 IF SEEK(STR(THIS.this_nTuboAtual, 2))
2859:                     loc_oCnt4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4
2860:                     loc_oCnt5 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
2861:                     loc_oCnt6 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container6
2862: 
2863:                     IF PEMSTATUS(loc_oCnt4, "edt_4c_Obs", 5)
2864:                         REPLACE Obss WITH loc_oCnt4.edt_4c_Obs.Value IN TmpCera
2865:                     ENDIF
2866:                     IF PEMSTATUS(loc_oCnt5, "txt_4c_Mreal", 5)
2867:                         REPLACE pmetalrs WITH NVL(loc_oCnt5.txt_4c_Mreal.Value, 0) IN TmpCera
2868:                     ENDIF
2869:                     IF PEMSTATUS(loc_oCnt6, "txt_4c_TempMet", 5)
2870:                         REPLACE TempMets WITH ALLTRIM(NVL(loc_oCnt6.txt_4c_TempMet.Value, "")) IN TmpCera
2871:                         REPLACE TempTubs WITH ALLTRIM(NVL(loc_oCnt6.txt_4c_TempTub.Value, "")) IN TmpCera

*-- Linhas 2936 a 2970:
2936: 
2937:             IF EMPTY(loc_cCodCor)
2938:                 IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
2939:                     SELECT TmpCera
2940:                     SET ORDER TO Tubos
2941:                     IF SEEK(STR(THIS.this_nTuboAtual, 2))
2942:                         REPLACE CodCors WITH "" IN TmpCera
2943:                     ENDIF
2944:                 ENDIF
2945:                 loc_lSucesso = .T.
2946:             ELSE
2947:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2948:                     "SELECT c.cgrus FROM SigCdCor c WHERE c.cgrus = " + ;
2949:                     EscaparSQL(loc_cCodCor), ;
2950:                     "cursor_4c_BuscaCor")
2951: 
2952:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaCor") AND ;
2953:                         RECCOUNT("cursor_4c_BuscaCor") > 0
2954:                     IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
2955:                         SELECT TmpCera
2956:                         SET ORDER TO Tubos
2957:                         IF SEEK(STR(THIS.this_nTuboAtual, 2))
2958:                             REPLACE CodCors WITH loc_cCodCor IN TmpCera
2959:                         ENDIF
2960:                     ENDIF
2961:                     loc_lSucesso = .T.
2962:                 ELSE
2963:                     MsgAviso("Cor '" + loc_cCodCor + "' n" + CHR(227) + "o encontrada.", "Cor")
2964:                     loc_oCnt5.txt_4c_Cor.Value = ""
2965:                 ENDIF
2966: 
2967:                 IF USED("cursor_4c_BuscaCor")
2968:                     USE IN cursor_4c_BuscaCor
2969:                 ENDIF
2970:             ENDIF

*-- Linhas 3036 a 3075:
3036:                     loc_oPg2.txt_4c_descarvore.Value = ""
3037:                 ENDIF
3038:                 IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3039:                     SELECT TmpCera
3040:                     SET ORDER TO Tubos
3041:                     IF SEEK(STR(THIS.this_nTuboAtual, 2))
3042:                         REPLACE CodArvs WITH "", Descs WITH "" IN TmpCera
3043:                     ENDIF
3044:                 ENDIF
3045:                 loc_lSucesso = .T.
3046:             ELSE
3047:                 IF !USED("cursor_4c_Arvores")
3048:                     THIS.CarregarArvores()
3049:                 ENDIF
3050: 
3051:                 IF USED("cursor_4c_Arvores")
3052:                     SELECT cursor_4c_Arvores
3053:                     LOCATE FOR ALLTRIM(cursor_4c_Arvores.codigos) = loc_cCodArv
3054:                     IF FOUND()
3055:                         loc_cDescs = ALLTRIM(NVL(cursor_4c_Arvores.descs, ""))
3056:                         IF PEMSTATUS(loc_oPg2, "txt_4c_descarvore", 5)
3057:                             loc_oPg2.txt_4c_descarvore.Value = loc_cDescs
3058:                         ENDIF
3059:                         IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3060:                             SELECT TmpCera
3061:                             SET ORDER TO Tubos
3062:                             IF SEEK(STR(THIS.this_nTuboAtual, 2))
3063:                                 REPLACE CodArvs WITH loc_cCodArv, Descs WITH loc_cDescs IN TmpCera
3064:                             ENDIF
3065:                         ENDIF
3066:                         THIS.CalcMetal()
3067:                         loc_lSucesso = .T.
3068:                     ELSE
3069:                         MsgAviso(CHR(193) + "rvore '" + loc_cCodArv + ;
3070:                             "' n" + CHR(227) + "o encontrada.", CHR(193) + "rvore")
3071:                         loc_oPg2.txt_4c_codarvore.Value  = ""
3072:                         IF PEMSTATUS(loc_oPg2, "txt_4c_descarvore", 5)
3073:                             loc_oPg2.txt_4c_descarvore.Value = ""
3074:                         ENDIF
3075:                     ENDIF

*-- Linhas 3138 a 3156:
3138: 
3139:         TRY
3140:             IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3141:                 SELECT TmpCera
3142:                 SET ORDER TO Tubos
3143:                 IF SEEK(STR(THIS.this_nTuboAtual, 2))
3144:                     loc_nBCeras = NVL(TmpCera.BCeras, 0)
3145:                     loc_nBases  = NVL(TmpCera.Bases, 0)
3146: 
3147:                     IF loc_nBCeras > 0 AND loc_nBases > 0 AND loc_nBCeras < loc_nBases
3148:                         MsgAviso("Base com Cera n" + CHR(227) + "o pode ser menor que a Base.", "Aviso")
3149:                         REPLACE Bases WITH 0 IN TmpCera
3150:                         loc_nBases = 0
3151:                     ENDIF
3152: 
3153:                     loc_nCeras = loc_nBCeras - loc_nBases
3154:                     REPLACE Ceras WITH loc_nCeras IN TmpCera
3155: 
3156:                     loc_oCnt5 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5

*-- Linhas 3169 a 3204:
3169:                     loc_nPercs     = 0
3170: 
3171:                     IF !EMPTY(loc_cCodArv) AND USED("cursor_4c_Arvores")
3172:                         SELECT cursor_4c_Arvores
3173:                         LOCATE FOR ALLTRIM(cursor_4c_Arvores.codigos) = loc_cCodArv
3174:                         IF FOUND()
3175:                             loc_cFormula = ALLTRIM(NVL(cursor_4c_Arvores.formulas, ""))
3176:                             loc_nPercs   = NVL(cursor_4c_Arvores.percs, 0)
3177:                             IF !EMPTY(loc_cFormula)
3178:                                 SELECT TmpCera
3179:                                 TRY
3180:                                     loc_nPesoMetal = EVALUATE(loc_cFormula)
3181:                                 CATCH
3182:                                     loc_nPesoMetal = 0
3183:                                 ENDTRY
3184:                                 loc_nMetalNovo = (loc_nPesoMetal * loc_nPercs) / 100
3185:                             ENDIF
3186:                         ENDIF
3187:                     ENDIF
3188: 
3189:                     SELECT TmpCera
3190:                     SET ORDER TO Tubos
3191:                     IF SEEK(STR(THIS.this_nTuboAtual, 2))
3192:                         REPLACE PMetals WITH loc_nPesoMetal, MetalNvs WITH loc_nMetalNovo IN TmpCera
3193:                     ENDIF
3194: 
3195:                     IF PEMSTATUS(loc_oCnt5, "txt_4c_Metal", 5)
3196:                         loc_oCnt5.txt_4c_Metal.Value   = loc_nPesoMetal
3197:                     ENDIF
3198:                     IF PEMSTATUS(loc_oCnt5, "txt_4c_metnovo", 5)
3199:                         loc_oCnt5.txt_4c_metnovo.Value = loc_nMetalNovo
3200:                     ENDIF
3201: 
3202:                     loc_lSucesso = .T.
3203:                 ENDIF
3204:             ENDIF

*-- Linhas 3220 a 3238:
3220:             loc_nBCeras = NVL(loc_oCnt5.txt_4c_Basec.Value, 0)
3221: 
3222:             IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3223:                 SELECT TmpCera
3224:                 SET ORDER TO Tubos
3225:                 IF SEEK(STR(THIS.this_nTuboAtual, 2))
3226:                     REPLACE BCeras WITH loc_nBCeras IN TmpCera
3227:                 ENDIF
3228:             ENDIF
3229: 
3230:             THIS.CalcMetal()
3231:             loc_lSucesso = .T.
3232:         CATCH TO loc_oErro
3233:             MsgErro("Erro em FormFUN.BasecLostFocus: " + loc_oErro.Message, "Erro")
3234:         ENDTRY
3235: 
3236:         RETURN loc_lSucesso
3237:     ENDPROC
3238: 

*-- Linhas 3247 a 3265:
3247:             loc_nBases = NVL(loc_oCnt5.txt_4c_Base.Value, 0)
3248: 
3249:             IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3250:                 SELECT TmpCera
3251:                 SET ORDER TO Tubos
3252:                 IF SEEK(STR(THIS.this_nTuboAtual, 2))
3253:                     REPLACE Bases WITH loc_nBases IN TmpCera
3254:                 ENDIF
3255:             ENDIF
3256: 
3257:             THIS.CalcMetal()
3258:             loc_lSucesso = .T.
3259:         CATCH TO loc_oErro
3260:             MsgErro("Erro em FormFUN.BaseLostFocus: " + loc_oErro.Message, "Erro")
3261:         ENDTRY
3262: 
3263:         RETURN loc_lSucesso
3264:     ENDPROC
3265: 

*-- Linhas 3345 a 3372:
3345:                 ENDIF
3346:                 loc_lSucesso = .T.
3347:             ELSE
3348:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
3349:                     "SELECT o.nops, o.cpros, o.qtds, o.numes, o.dtents" + ;
3350:                     " FROM SigOpPic o" + ;
3351:                     " WHERE o.nops = " + TRANSFORM(loc_nNop) + ;
3352:                     " AND o.emps = " + EscaparSQL(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))), ;
3353:                     "cursor_4c_BuscaNop")
3354: 
3355:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaNop") AND ;
3356:                         RECCOUNT("cursor_4c_BuscaNop") > 0
3357:                     SELECT cursor_4c_BuscaNop
3358:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
3359:                         loc_oCnt3.txt_4c_Qtd.Value = NVL(cursor_4c_BuscaNop.qtds, 0)
3360:                     ENDIF
3361:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Pecas", 5)
3362:                         loc_oCnt3.txt_4c_Pecas.Value = NVL(cursor_4c_BuscaNop.qtds, 0)
3363:                     ENDIF
3364:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
3365:                         loc_oCnt3.txt_4c_Operacao.Value = ALLTRIM(NVL(cursor_4c_BuscaNop.cpros, ""))
3366:                     ENDIF
3367:                     loc_lSucesso = .T.
3368:                 ELSE
3369:                     MsgAviso("O.P. n" + CHR(186) + " " + TRANSFORM(loc_nNop) + ;
3370:                         " n" + CHR(227) + "o encontrada.", "O.P.")
3371:                     loc_oCnt3.txt_4c_Nop.Value = 0
3372:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)

*-- Linhas 3437 a 3477:
3437:             IF loc_nTuboFonte > 0 AND loc_nTuboAtual > 0 AND ;
3438:                     loc_nTuboFonte != loc_nTuboAtual AND USED("TmpTrf")
3439:                 *-- Coletar registros do tubo fonte
3440:                 SELECT TmpTrf
3441:                 SET ORDER TO 0
3442:                 GO TOP
3443:                 DO WHILE !EOF("TmpTrf")
3444:                     IF TmpTrf.Tubos = loc_nTuboFonte
3445:                         loc_nTotal = loc_nTotal + 1
3446:                         DIMENSION loc_aTrfs[loc_nTotal, 3]
3447:                         loc_aTrfs[loc_nTotal, 1] = TmpTrf.Dopes
3448:                         loc_aTrfs[loc_nTotal, 2] = TmpTrf.Numes
3449:                         loc_aTrfs[loc_nTotal, 3] = TmpTrf.nNumes
3450:                     ENDIF
3451:                     SKIP
3452:                 ENDDO
3453: 
3454:                 *-- Inserir no tubo destino se nao existir
3455:                 FOR loc_nI = 1 TO loc_nTotal
3456:                     loc_cDopes  = loc_aTrfs[loc_nI, 1]
3457:                     loc_nNumes  = loc_aTrfs[loc_nI, 2]
3458:                     loc_nNNumes = loc_aTrfs[loc_nI, 3]
3459:                     SELECT TmpTrf
3460:                     LOCATE FOR TmpTrf.Tubos = loc_nTuboAtual AND TmpTrf.Dopes = loc_cDopes
3461:                     IF !FOUND()
3462:                         INSERT INTO TmpTrf (Dopes, Numes, Tubos, nNumes) ;
3463:                             VALUES (loc_cDopes, loc_nNumes, loc_nTuboAtual, loc_nNNumes)
3464:                     ENDIF
3465:                 ENDFOR
3466: 
3467:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3, "grd_4c_GradeTrf", 5)
3468:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3.grd_4c_GradeTrf.Refresh()
3469:                 ENDIF
3470:             ENDIF
3471:             loc_lSucesso = .T.
3472:         CATCH TO loc_oErro
3473:             MsgErro("Erro em FormFUN.TuboLostFocus: " + loc_oErro.Message, "Erro")
3474:         ENDTRY
3475: 
3476:         RETURN loc_lSucesso
3477:     ENDPROC

*-- Linhas 3490 a 3540:
3490:             IF EMPTY(loc_cTrf)
3491:                 loc_lSucesso = .T.
3492:             ELSE
3493:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
3494:                     "SELECT TOP 1 m.dopes, m.numes FROM SigMvCab m" + ;
3495:                     " WHERE m.dopes = " + EscaparSQL(loc_cTrf) + ;
3496:                     " AND m.emps = " + EscaparSQL(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))) + ;
3497:                     " ORDER BY m.numes DESC", ;
3498:                     "cursor_4c_BuscaTrf")
3499: 
3500:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaTrf") AND ;
3501:                         RECCOUNT("cursor_4c_BuscaTrf") > 0
3502:                     loc_nTuboAtual = THIS.this_nTuboAtual
3503:                     loc_lRep       = .F.
3504:                     IF PEMSTATUS(loc_oCnt3, "chk_4c_ChkRep", 5)
3505:                         loc_lRep = (loc_oCnt3.chk_4c_ChkRep.Value = 1)
3506:                     ENDIF
3507: 
3508:                     SELECT cursor_4c_BuscaTrf
3509:                     loc_nNNumes = NVL(cursor_4c_BuscaTrf.numes, 0)
3510: 
3511:                     IF loc_nTuboAtual > 0 AND USED("TmpTrf")
3512:                         SELECT TmpTrf
3513:                         LOCATE FOR TmpTrf.Tubos = loc_nTuboAtual AND TmpTrf.Dopes = loc_cTrf
3514:                         IF !FOUND()
3515:                             INSERT INTO TmpTrf (Dopes, Numes, Tubos, nNumes) ;
3516:                                 VALUES (loc_cTrf, 0, loc_nTuboAtual, loc_nNNumes)
3517:                         ENDIF
3518: 
3519:                         IF loc_lRep
3520:                             FOR loc_nT = 1 TO THIS.this_nMaqTubos
3521:                                 IF loc_nT != loc_nTuboAtual
3522:                                     SELECT TmpTrf
3523:                                     LOCATE FOR TmpTrf.Tubos = loc_nT AND TmpTrf.Dopes = loc_cTrf
3524:                                     IF !FOUND()
3525:                                         INSERT INTO TmpTrf (Dopes, Numes, Tubos, nNumes) ;
3526:                                             VALUES (loc_cTrf, 0, loc_nT, loc_nNNumes)
3527:                                     ENDIF
3528:                                 ENDIF
3529:                             ENDFOR
3530:                         ENDIF
3531: 
3532:                         IF PEMSTATUS(loc_oCnt3, "grd_4c_GradeTrf", 5)
3533:                             loc_oCnt3.grd_4c_GradeTrf.Refresh()
3534:                         ENDIF
3535:                     ENDIF
3536:                     loc_oCnt3.txt_4c_Trf.Value = ""
3537:                     loc_lSucesso = .T.
3538:                 ELSE
3539:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o '" + loc_cTrf + ;
3540:                         "' n" + CHR(227) + "o encontrada.", ;

*-- Linhas 3580 a 3620:
3580:                 loc_nQtds  = 0
3581:                 loc_nNumes = 0
3582: 
3583:                 loc_nRes2 = SQLEXEC(gnConnHandle, ;
3584:                     "SELECT o.cpros, o.qtds, o.numes FROM SigOpPic o" + ;
3585:                     " WHERE o.nops = " + TRANSFORM(loc_nNop) + ;
3586:                     " AND o.emps = " + EscaparSQL(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))), ;
3587:                     "cursor_4c_BuscaNop2")
3588: 
3589:                 IF loc_nRes2 > 0 AND USED("cursor_4c_BuscaNop2") AND ;
3590:                         RECCOUNT("cursor_4c_BuscaNop2") > 0
3591:                     SELECT cursor_4c_BuscaNop2
3592:                     loc_cCpros = ALLTRIM(NVL(cursor_4c_BuscaNop2.cpros, ""))
3593:                     loc_nQtds  = NVL(cursor_4c_BuscaNop2.qtds, 0)
3594:                     loc_nNumes = NVL(cursor_4c_BuscaNop2.numes, 0)
3595: 
3596:                     IF USED("cursor_4c_BuscaNop2")
3597:                         USE IN cursor_4c_BuscaNop2
3598:                     ENDIF
3599: 
3600:                     IF USED("TmpNop")
3601:                         SELECT TmpNop
3602:                         LOCATE FOR TmpNop.Tubos = loc_nTuboAtual AND TmpNop.Nops = loc_nNop
3603:                         IF !FOUND()
3604:                             loc_dDtEnt = DATE()
3605:                             INSERT INTO TmpNop (Nops, Cpros, Qtds, Tubos, Qtdos, Numes, ;
3606:                                                EmpDopNums, DtEnts) ;
3607:                                 VALUES (loc_nNop, loc_cCpros, loc_nQtTb, loc_nTuboAtual, ;
3608:                                         loc_nQtds, loc_nNumes, ;
3609:                                         PADR(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, "")), 29), ;
3610:                                         loc_dDtEnt)
3611:                         ENDIF
3612: 
3613:                         IF PEMSTATUS(loc_oCnt3, "grd_4c_Gradenop", 5)
3614:                             loc_oCnt3.grd_4c_Gradenop.Refresh()
3615:                         ENDIF
3616:                     ENDIF
3617: 
3618:                     loc_oCnt3.txt_4c_Nop.Value  = 0
3619:                     loc_oCnt3.txt_4c_QtTb.Value = 0
3620:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)

*-- Linhas 3657 a 3677:
3657:             loc_nTuboAtual = THIS.this_nTuboAtual
3658: 
3659:             IF PEMSTATUS(loc_oCnt3, "grd_4c_GradeTrf", 5) AND USED("TmpTrf")
3660:                 SELECT TmpTrf
3661:                 IF !EOF("TmpTrf") AND TmpTrf.Tubos = loc_nTuboAtual
3662:                     DELETE
3663:                     SET FILTER TO
3664:                     PACK NOOPTIMIZE
3665:                     SET FILTER TO TmpTrf.Tubos = THIS.this_nTuboAtual
3666:                     GO TOP
3667:                     loc_oCnt3.grd_4c_GradeTrf.Refresh()
3668:                 ENDIF
3669:             ENDIF
3670:             loc_lSucesso = .T.
3671:         CATCH TO loc_oErro
3672:             MsgErro("Erro em FormFUN.RemoverTrfClick: " + loc_oErro.Message, "Erro")
3673:         ENDTRY
3674: 
3675:         RETURN loc_lSucesso
3676:     ENDPROC
3677: 

*-- Linhas 3685 a 3703:
3685:         TRY
3686:             loc_oCnt3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
3687:             IF USED("TmpNop") AND !EOF("TmpNop") AND PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
3688:                 SELECT TmpNop
3689:                 IF !EOF("TmpNop")
3690:                     loc_oCnt3.txt_4c_Operacao.Value = ALLTRIM(NVL(TmpNop.Cpros, "")) + ;
3691:                         "  Qt: " + TRANSFORM(NVL(TmpNop.Qtds, 0), "999,999.999")
3692:                 ENDIF
3693:             ENDIF
3694:             loc_lSucesso = .T.
3695:         CATCH TO loc_oErro
3696:             MsgErro("Erro em FormFUN.GradenopAfterRowColChange: " + loc_oErro.Message, "Erro")
3697:         ENDTRY
3698: 
3699:         RETURN loc_lSucesso
3700:     ENDPROC
3701: 
3702:     *==========================================================================
3703:     PROCEDURE BtnTotalClick()

*-- Linhas 3711 a 3757:
3711:             ENDIF
3712: 
3713:             IF USED("TmpCera") AND RECCOUNT("TmpCera") > 0
3714:                 SELECT TmpCera.CodArvs AS CodArvs, ;
3715:                        TmpCera.Descs   AS Descs,   ;
3716:                        SUM(TmpCera.pmetalrs) AS PesoRealTotal, ;
3717:                        SUM(TmpCera.MetalNvs) AS MetalNovoTotal, ;
3718:                        SUM(TmpCera.PMetals)  AS PesoMetalTotal  ;
3719:                 FROM TmpCera ;
3720:                 WHERE TmpCera.nStatus = 3 ;
3721:                 GROUP BY TmpCera.CodArvs, TmpCera.Descs ;
3722:                 INTO CURSOR cursor_4c_TmpTot NOFILTER
3723:             ELSE
3724:                 SET NULL ON
3725:                 CREATE CURSOR cursor_4c_TmpTot ( ;
3726:                     CodArvs        C(10), ;
3727:                     Descs          C(40), ;
3728:                     PesoRealTotal  N(12,2), ;
3729:                     MetalNovoTotal N(12,2), ;
3730:                     PesoMetalTotal N(12,2) ;
3731:                 )
3732:                 SET NULL OFF
3733:             ENDIF
3734: 
3735:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Total
3736:             IF PEMSTATUS(loc_oCnt, "grd_4c_TmpTot", 5)
3737:                 loc_oCnt.grd_4c_TmpTot.ColumnCount = 4
3738:                 loc_oCnt.grd_4c_TmpTot.RecordSource            = "cursor_4c_TmpTot"
3739:                 loc_oCnt.grd_4c_TmpTot.Column1.ControlSource   = "cursor_4c_TmpTot.CodArvs"
3740:                 loc_oCnt.grd_4c_TmpTot.Column2.ControlSource   = "cursor_4c_TmpTot.PesoRealTotal"
3741:                 loc_oCnt.grd_4c_TmpTot.Column3.ControlSource   = "cursor_4c_TmpTot.MetalNovoTotal"
3742:                 loc_oCnt.grd_4c_TmpTot.Column4.ControlSource   = "cursor_4c_TmpTot.PesoMetalTotal"
3743:                 loc_oCnt.grd_4c_TmpTot.Refresh()
3744:             ENDIF
3745: 
3746:             loc_oCnt.Visible = .T.
3747:             loc_oCnt.ZOrder(0)
3748:             loc_lSucesso = .T.
3749:         CATCH TO loc_oErro
3750:             MsgErro("Erro em FormFUN.BtnTotalClick: " + loc_oErro.Message, "Erro")
3751:         ENDTRY
3752: 
3753:         RETURN loc_lSucesso
3754:     ENDPROC
3755: 
3756:     *==========================================================================
3757:     PROCEDURE BtnCancelarTotalClick()

*-- Linhas 3807 a 3824:
3807:             ENDIF
3808: 
3809:             IF USED("TmpNop")
3810:                 SELECT TmpNop
3811:                 SET FILTER TO
3812:                 GO TOP
3813:             ENDIF
3814:             IF USED("TmpTrf")
3815:                 SELECT TmpTrf
3816:                 SET FILTER TO
3817:                 GO TOP
3818:             ENDIF
3819:         CATCH TO loc_oErro
3820:             MsgErro("Erro em FormFUN.LimparCamposTubo: " + loc_oErro.Message, "Erro")
3821:         ENDTRY
3822:     ENDPROC
3823: 
3824: ENDDEFINE


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

			loc_cSQL = "SELECT f.codigos, f.emps, f.datas, f.usuars, f.codmaqfs," + ;
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
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (codigos N(6,0), emps C(3), datas T, ;
					    usuars C(10), codmaqfs C(10), ntubos N(2,0), obss C(200))
					SET NULL OFF
				ENDIF
				MsgErro("Erro ao buscar fundi" + CHR(231) + CHR(245) + "es:" + ;
				    CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em FUNBO.Buscar: " + loc_oErro.Message, "Erro")
			IF !USED("cursor_4c_Dados")
				SET NULL ON
				CREATE CURSOR cursor_4c_Dados (codigos N(6,0), emps C(3), datas T, ;
				    usuars C(10), codmaqfs C(10), ntubos N(2,0), obss C(200))
				SET NULL OFF
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


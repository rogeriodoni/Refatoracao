# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (13)
- [GRID-SQL] Campo 'numes' usado em ControlSource de cursor_4c_Filtro mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'rclis' usado em ControlSource de cursor_4c_Filtro mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'vencs' usado em ControlSource de cursor_4c_Filtro mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'fpags' usado em ControlSource de cursor_4c_Filtro mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'valos' usado em ControlSource de cursor_4c_Filtro mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'titulos' usado em ControlSource de cursor_4c_Filtro mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPERS, INFOS, VPAGS, TIPOS, ENDERRO, GRUCONTAS, EMPDOPNUMS, LCT085A087, PROCESSOS, DOPEDS, MSGMULTA, LCBARRA, LCT079A081, LCT140A142, LCQ019A033, LCQ034A073, LCQ074A113, LCQ114A128, LCQ129A136, LCQ137A151, LCQ152A153, LCQ154A154, LCB019A032, LCB033A062, SITUAS, PARCONTAS, VALPENDS, OPERS, EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPERS, INFOS, VPAGS, TIPOS, ENDERRO, GRUCONTAS, EMPDOPNUMS, LCT085A087, PROCESSOS, DOPEDS, MSGMULTA, LCBARRA, LCT079A081, LCT140A142, LCQ019A033, LCQ034A073, LCQ074A113, LCQ114A128, LCQ129A136, LCQ137A151, LCQ152A153, LCQ154A154, LCB019A032, LCB033A062, SITUAS, PARCONTAS, VALPENDS, OPERS, EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPERS, INFOS, VPAGS, TIPOS, ENDERRO, GRUCONTAS, EMPDOPNUMS, LCT085A087, PROCESSOS, DOPEDS, MSGMULTA, LCBARRA, LCT079A081, LCT140A142, LCQ019A033, LCQ034A073, LCQ074A113, LCQ114A128, LCQ129A136, LCQ137A151, LCQ152A153, LCQ154A154, LCB019A032, LCB033A062, SITUAS, PARCONTAS, VALPENDS, OPERS, EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPERS, INFOS, VPAGS, TIPOS, ENDERRO, GRUCONTAS, EMPDOPNUMS, LCT085A087, PROCESSOS, DOPEDS, MSGMULTA, LCBARRA, LCT079A081, LCT140A142, LCQ019A033, LCQ034A073, LCQ074A113, LCQ114A128, LCQ129A136, LCQ137A151, LCQ152A153, LCQ154A154, LCB019A032, LCB033A062, SITUAS, PARCONTAS, VALPENDS, OPERS, EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZSOCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPERS, INFOS, VPAGS, TIPOS, ENDERRO, GRUCONTAS, EMPDOPNUMS, LCT085A087, PROCESSOS, DOPEDS, MSGMULTA, LCBARRA, LCT079A081, LCT140A142, LCQ019A033, LCQ034A073, LCQ074A113, LCQ114A128, LCQ129A136, LCQ137A151, LCQ152A153, LCQ154A154, LCB019A032, LCB033A062, SITUAS, PARCONTAS, VALPENDS, OPERS, EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPERS, INFOS, VPAGS, TIPOS, ENDERRO, GRUCONTAS, EMPDOPNUMS, LCT085A087, PROCESSOS, DOPEDS, MSGMULTA, LCBARRA, LCT079A081, LCT140A142, LCQ019A033, LCQ034A073, LCQ074A113, LCQ114A128, LCQ129A136, LCQ137A151, LCQ152A153, LCQ154A154, LCB019A032, LCB033A062, SITUAS, PARCONTAS, VALPENDS, OPERS, EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COLUMNCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPERS, INFOS, VPAGS, TIPOS, ENDERRO, GRUCONTAS, EMPDOPNUMS, LCT085A087, PROCESSOS, DOPEDS, MSGMULTA, LCBARRA, LCT079A081, LCT140A142, LCQ019A033, LCQ034A073, LCQ074A113, LCQ114A128, LCQ129A136, LCQ137A151, LCQ152A153, LCQ154A154, LCB019A032, LCB033A062, SITUAS, PARCONTAS, VALPENDS, OPERS, EMPS

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
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
Select crSigCdOpe
lcquery = [select ?ltru as marca, e.titulos, a.dopes, a.numes, d.rclis, a.vencs, b.fpags, a.valos, a.datas, a.vpags, ] +;
	[from SigMvPar a inner join SigOpFp b on a.fpags = b.fpags ] +;
	[left join SigMvCab c on a.empdopnums = c.empdopnums ] +;
	[left join SigCdCli d on c.contads = d.iclis ] +;
	[left join SigMvCcr e on a.empdopnums = e.empdopnums and a.nopers = e.nopers ] +;
	[In (Select e.EmpDopNums+substring(e.dopeds,1,10) ] + ;
	[From SigPcOol e ] + ;
Thisform.podatamgr.sqlexecute(lcquery,[crFiltro])
Select crFiltro
	Select crFiltro
	lcQuery = [Select * ] + ;
				[From SigCdCeb ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConvenio') < 1)
	lcQuery = [Select * ] + ;
			    [From SigCdCeb ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crConvenio') < 1)
	Insert Into crcabecalho(titulo,periodo,empresa) Values ('Dados para geração do CNAB',lcdata,lcemp + [ - ] + crEmpresa.RazSocs)
	Select *, Space(11) as SeqNums From crFiltro Where marca Into Cursor crFiltro2
	Select crFiltro2
Select *, Space(11) as SeqNums  From crfiltro Where marca Into Cursor crFiltro2 ReadWrite
Select crFiltro2
	Insert Into crSigPcOol (EmpDopNums, Emps, Dopes, Numes, Usuars, Tipos, Processos, Produtos, Datas, cIdChaves, DopeDs,NumeDs ) ;
	If Not ThisForm.poDataMgr.Update([crSigPcOol])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update)])	
		Select crFiltro2
			lcQuery = [Select Titulos, TitBans ] + ;
					    [From SigMvCcr ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigMvCcr]) < 1)
			Select crSigMvCcr
				lcQuery = [Update SigMvCcr ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery) < 1)
					=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update)])	
SELECT * from crfiltro where marca into cursor crFiltro2
SELECT crFiltro2
	Insert into crSigPcOol(empdopnums,emps,dopes,numes,usuars,tipos,processos,produtos,datas,cidchaves,dopeds) values ;
	If ! thisform.podatamgr.Update('crSigPcOol')
		MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')	
		Select crFiltro2
			thisform.podatamgr.Sqlexecute('select titulos, titbans from SigMvCcr where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers','crSigMvCcr')
			Select crSigMvCcr
				lcquery = 'Update SigMvCcr set titbans = ?lctit where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers'
				If thisform.podatamgr.Sqlexecute(lcquery) < 1
					MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')	
Select *, Space(5) as SeqNums  From crfiltro Where marca Into Cursor crFiltro2 ReadWrite
Select crFiltro2
	Insert Into crSigPcOol(empdopnums,emps,dopes,numes,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,NumeDs) Values ;
	If ! Thisform.podatamgr.Update('crSigPcOol')
		Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
		Select crFiltro2
			Thisform.podatamgr.Sqlexecute('select titulos, titbans from SigMvCcr where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers','crSigMvCcr')
			Select crSigMvCcr
				lcquery = 'Update SigMvCcr set titbans = ?lctit where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers'
				If Thisform.podatamgr.Sqlexecute(lcquery) < 1
					Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
Select a.*, Space(44) as nBarras, Space(30) as ImgBarra, lcRaz as Cedente, Space(50) as NomeCli, Space(50) as Instr1, Space(50) as Instr2, Space(50) as Instr3, ;
		from crFiltro2 a, crEmpresa b into cursor crFiltro2 ReadWrite
Select crFiltro2
		If thisform.podatamgr.SqlExecute([Select top 1 NumeDs from SigPcOol where Processos = 'CNAB' And DopeDs = ?crFiltro2.titulos order by Datas Desc],[crTmpPcOol]) < 1
		Select crFiltro2
Select crFiltro2
Select crFiltro2
Select *, Space(5) as SeqNums  From crfiltro Where marca Into Cursor crFiltro2 ReadWrite
Select crFiltro2
	Insert Into crSigPcOol(empdopnums,emps,dopes,numes,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,NumeDs) Values ;
	If ! Thisform.podatamgr.Update('crSigPcOol')
		Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
		Select crFiltro2
			Thisform.podatamgr.Sqlexecute('select titulos, titbans from SigMvCcr where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers','crSigMvCcr')
			Select crSigMvCcr
				lcquery = 'Update SigMvCcr set titbans = ?lctit where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers'
				If Thisform.podatamgr.Sqlexecute(lcquery) < 1
					Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
Select *, Space(5) as SeqNums From crfiltro Where marca Into Cursor crFiltro2 ReadWrite
Select crFiltro2
	Insert Into crSigPcOol(empdopnums,emps,dopes,numes,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,NumeDs) Values ;
Select crFiltro2
	If ! Thisform.podatamgr.Update('crSigPcOol')
		Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
		Select crFiltro2
			Thisform.podatamgr.Sqlexecute('select titulos, titbans from SigMvCcr where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers','crSigMvCcr')
			Select crSigMvCcr
				lcquery = 'Update SigMvCcr set titbans = ?lctit where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers'
				If Thisform.podatamgr.Sqlexecute(lcquery) < 1
					Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
Select *, Space(5) as SeqNums From crfiltro Where marca Into Cursor crFiltro2 ReadWrite
Select crFiltro2
	Insert Into crSigPcOol(empdopnums,emps,dopes,numes,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,NumeDs) Values ;
	If ! Thisform.podatamgr.Update('crSigPcOol')
		Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
		Select crFiltro2
			Thisform.podatamgr.Sqlexecute('select titulos, titbans from SigMvCcr where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers','crSigMvCcr')
			Select crSigMvCcr
				lcquery = 'Update SigMvCcr set titbans = ?lctit where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers'
				If Thisform.podatamgr.Sqlexecute(lcquery) < 1
					Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
Select *, Space(5) As SeqNums From crfiltro Where marca Into Cursor crFiltro2 Readwrite
Select crFiltro2
	Insert Into crSigPcOol(empdopnums,emps,dopes,numes,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,NumeDs) Values ;
	If ! Thisform.podatamgr.Update('crSigPcOol')
		Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
		Select crFiltro2
			Thisform.podatamgr.Sqlexecute('select titulos, titbans from SigMvCcr where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers','crSigMvCcr')
			Select crSigMvCcr
				lcquery = 'Update SigMvCcr set titbans = ?lctit where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers'
				If Thisform.podatamgr.Sqlexecute(lcquery) < 1
					Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
	lcQuery = [Select * ] + ;
		[From SigOpFp ] + ;
	Thisform.poDataMgr.SqlExecute(lcQuery, [CrSigOpFp])
	Select CrSigOpFp
	Thisform.poDataMgr.SqlExecute([select dopes, ?lltru as marca from SigCdOpe where Parcontas = 1 And ValPends = 1 order by dopes],[crSigCdOpe])
	Select crSigCdOpe
	Thisform.pgfprincipal.pgfiltro.grdope.column1.ControlSource = [crSigCdOpe.marca]
	Thisform.pgfprincipal.pgfiltro.grdope.column2.ControlSource = [crSigCdOpe.dopes]
Select crSigCdOpe
	Select * ;
	  From CrSigOpFp ;
	Select LocalFpag
	If Not Seek(This.Value)
Select crSigCdOpe
Update crSigCdOpe Set marca = .T.
Select crSigCdOpe
Update crSigCdOpe Set marca = .F.
SELECT crfiltro
Update crfiltro set marca = .t.
SELECT crfiltro
Update crfiltro set marca = .f.

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCNB.prg) - TRECHOS RELEVANTES PARA PASS SQL (2813 linhas total):

*-- Linhas 518 a 536:
518:             .FontName          = "Tahoma"
519:             .AllowHeaderSizing = .F.
520:             .AllowRowSizing    = .F.
521:             .DeleteMark        = .F.
522:             .GridLines         = 3
523:             .Height            = 344
524:             .Left              = 350
525:             .Panel             = 1
526:             .ScrollBars        = 2
527:             .SplitBar          = .F.
528:             .TabIndex          = 10
529:             .Top               = 232
530:             .Width             = 202
531:             .GridLineColor     = RGB(238,238,238)
532:             .Themes            = .F.
533:             .Column1.Width     = 18
534:             .Column1.Movable   = .F.
535:             .Column1.Resizable = .F.
536:             .Column1.Sparse    = .F.

*-- Linhas 684 a 702:
684:             .FontName          = "Tahoma"
685:             .AllowHeaderSizing = .F.
686:             .AllowRowSizing    = .F.
687:             .DeleteMark        = .F.
688:             .Height            = 401
689:             .Left              = 7
690:             .Panel             = 1
691:             .RecordMark        = .F.
692:             .ScrollBars        = 2
693:             .SplitBar          = .F.
694:             .TabIndex          = 1
695:             .Top               = 134
696:             .Width             = 981
697:             .GridLineColor     = RGB(238,238,238)
698:             .Themes            = .F.
699:             .Column1.Width     = 18
700:             .Column1.Movable   = .F.
701:             .Column1.Resizable = .F.
702:             .Column1.Sparse    = .F.

*-- Linhas 980 a 1126:
980:             loc_oGrd = THIS.pgf_4c_Principal.Page1.grd_4c_Operacoes
981:             loc_oGrd.ColumnCount            = 2
982:             loc_oGrd.RecordSource           = "cursor_4c_Operacoes"
983:             loc_oGrd.Column1.ControlSource  = "cursor_4c_Operacoes.marca"
984:             loc_oGrd.Column2.ControlSource  = "cursor_4c_Operacoes.Dopes"
985:             loc_oGrd.Column1.Header1.Caption = ""
986:             loc_oGrd.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
987:             loc_oGrd.Column2.Header1.Alignment = 2
988:             loc_oGrd.Refresh()
989:         ENDIF
990: 
991:         IF THIS.this_oBusinessObject.CarregarFormasPagto()
992:             IF USED("cursor_4c_FormaPagto")
993:                 SELECT cursor_4c_FormaPagto
994:                 INDEX ON fpags TAG FpagSgru
995:                 SET NEAR ON
996:             ENDIF
997:         ENDIF
998: 
999:         THIS.pgf_4c_Principal.Page1.txt_4c_CdEmpresa.SetFocus()
1000:     ENDPROC
1001: 
1002:     *==========================================================================
1003:     * VALIDADORES DOS CAMPOS
1004:     *==========================================================================
1005: 
1006:     PROCEDURE ValidarCdEmpresa()
1007:         LOCAL loc_cCod, loc_cSQL
1008:         loc_cCod = ALLTRIM(THIS.pgf_4c_Principal.Page1.txt_4c_CdEmpresa.Value)
1009:         IF EMPTY(loc_cCod)
1010:             THIS.pgf_4c_Principal.Page1.txt_4c_DsEmpresa.Value = ""
1011:             RETURN
1012:         ENDIF
1013:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1014:             RETURN
1015:         ENDIF
1016:         loc_cSQL = "SELECT TOP 1 RazSocs FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCod)
1017:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmpV") >= 1 AND RECCOUNT("cursor_4c_EmpTmpV") > 0
1018:             SELECT cursor_4c_EmpTmpV
1019:             THIS.pgf_4c_Principal.Page1.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpTmpV.RazSocs)
1020:         ELSE
1021:             THIS.pgf_4c_Principal.Page1.txt_4c_CdEmpresa.Value = ""
1022:             THIS.pgf_4c_Principal.Page1.txt_4c_DsEmpresa.Value = ""
1023:             MsgAviso("Empresa inv" + CHR(225) + "lida.")
1024:         ENDIF
1025:         IF USED("cursor_4c_EmpTmpV")
1026:             USE IN cursor_4c_EmpTmpV
1027:         ENDIF
1028:     ENDPROC
1029: 
1030:     PROCEDURE ValidarDsEmpresa()
1031:         LOCAL loc_cDs, loc_cSQL
1032:         loc_cDs = ALLTRIM(THIS.pgf_4c_Principal.Page1.txt_4c_DsEmpresa.Value)
1033:         IF EMPTY(loc_cDs)
1034:             RETURN
1035:         ENDIF
1036:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1037:             RETURN
1038:         ENDIF
1039:         loc_cSQL = "SELECT TOP 1 Cemps, RazSocs FROM SigCdEmp WHERE RazSocs LIKE " + EscaparSQL(loc_cDs + "%")
1040:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmpV") >= 1 AND RECCOUNT("cursor_4c_EmpTmpV") > 0
1041:             SELECT cursor_4c_EmpTmpV
1042:             THIS.pgf_4c_Principal.Page1.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpTmpV.Cemps)
1043:             THIS.pgf_4c_Principal.Page1.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpTmpV.RazSocs)
1044:         ELSE
1045:             THIS.pgf_4c_Principal.Page1.txt_4c_CdEmpresa.Value = ""
1046:             THIS.pgf_4c_Principal.Page1.txt_4c_DsEmpresa.Value = ""
1047:         ENDIF
1048:         IF USED("cursor_4c_EmpTmpV")
1049:             USE IN cursor_4c_EmpTmpV
1050:         ENDIF
1051:     ENDPROC
1052: 
1053:     PROCEDURE ValidarCdConta()
1054:         LOCAL loc_cCod, loc_cSQL
1055:         loc_cCod = ALLTRIM(THIS.pgf_4c_Principal.Page1.txt_4c_CdConta.Value)
1056:         IF EMPTY(loc_cCod)
1057:             THIS.pgf_4c_Principal.Page1.txt_4c_DsConta.Value = ""
1058:             RETURN
1059:         ENDIF
1060:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1061:             RETURN
1062:         ENDIF
1063:         loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cCod)
1064:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaTmpV") >= 1 AND RECCOUNT("cursor_4c_ContaTmpV") > 0
1065:             SELECT cursor_4c_ContaTmpV
1066:             THIS.pgf_4c_Principal.Page1.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_ContaTmpV.IClis)
1067:             THIS.pgf_4c_Principal.Page1.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_ContaTmpV.RClis)
1068:         ELSE
1069:             THIS.pgf_4c_Principal.Page1.txt_4c_CdConta.Value = ""
1070:             THIS.pgf_4c_Principal.Page1.txt_4c_DsConta.Value = ""
1071:             MsgAviso("Conta inv" + CHR(225) + "lida.")
1072:         ENDIF
1073:         IF USED("cursor_4c_ContaTmpV")
1074:             USE IN cursor_4c_ContaTmpV
1075:         ENDIF
1076:     ENDPROC
1077: 
1078:     PROCEDURE ValidarDsConta()
1079:         LOCAL loc_cDs, loc_cSQL
1080:         loc_cDs = ALLTRIM(THIS.pgf_4c_Principal.Page1.txt_4c_DsConta.Value)
1081:         IF EMPTY(loc_cDs)
1082:             RETURN
1083:         ENDIF
1084:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1085:             RETURN
1086:         ENDIF
1087:         loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RClis LIKE " + EscaparSQL(loc_cDs + "%")
1088:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaTmpV") >= 1 AND RECCOUNT("cursor_4c_ContaTmpV") > 0
1089:             SELECT cursor_4c_ContaTmpV
1090:             THIS.pgf_4c_Principal.Page1.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_ContaTmpV.IClis)
1091:             THIS.pgf_4c_Principal.Page1.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_ContaTmpV.RClis)
1092:         ELSE
1093:             THIS.pgf_4c_Principal.Page1.txt_4c_CdConta.Value = ""
1094:             THIS.pgf_4c_Principal.Page1.txt_4c_DsConta.Value = ""
1095:         ENDIF
1096:         IF USED("cursor_4c_ContaTmpV")
1097:             USE IN cursor_4c_ContaTmpV
1098:         ENDIF
1099:     ENDPROC
1100: 
1101:     PROCEDURE ValidarTitBan()
1102:         LOCAL loc_cCod
1103:         loc_cCod = ALLTRIM(THIS.pgf_4c_Principal.Page1.txt_4c_TitBan.Value)
1104:         IF EMPTY(loc_cCod)
1105:             RETURN
1106:         ENDIF
1107:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1108:             RETURN
1109:         ENDIF
1110:         IF USED("cursor_4c_FormaPagto")
1111:             SELECT cursor_4c_FormaPagto
1112:             SEEK PADR(loc_cCod, 12) ORDER TAG FpagSgru
1113:             IF !FOUND("cursor_4c_FormaPagto")
1114:                 MsgAviso("T" + CHR(237) + "tulo Banco inv" + CHR(225) + "lido.")
1115:                 THIS.pgf_4c_Principal.Page1.txt_4c_TitBan.Value = ""
1116:             ENDIF
1117:         ENDIF
1118:     ENDPROC
1119: 
1120:     PROCEDURE ValidarDataf()
1121:         LOCAL loc_dDatf, loc_dDati
1122:         loc_dDatf = THIS.pgf_4c_Principal.Page1.txt_4c_Dataf.Value
1123:         loc_dDati = THIS.pgf_4c_Principal.Page1.txt_4c_Datai.Value
1124:         IF !EMPTY(loc_dDati) AND !EMPTY(loc_dDatf) AND loc_dDatf < loc_dDati
1125:             MsgAviso("Data Final Deve Ser Maior Que a Inicial!!!")
1126:             THIS.pgf_4c_Principal.Page1.txt_4c_Dataf.Value = {}

*-- Linhas 1194 a 1235:
1194:         loc_oBusca.mAddColuna("Cgcs",    "", "CNPJ")
1195:         loc_oBusca.Show()
1196:         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
1197:             SELECT cursor_4c_BuscaEmpresa
1198:             loc_oP1.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
1199:             loc_oP1.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.RazSocs)
1200:         ENDIF
1201:         IF USED("cursor_4c_BuscaEmpresa")
1202:             USE IN cursor_4c_BuscaEmpresa
1203:         ENDIF
1204:         loc_oBusca.Release()
1205:     ENDPROC
1206: 
1207:     PROCEDURE AbrirLookupConta()
1208:         LOCAL loc_oBusca, loc_oP1
1209:         loc_oP1 = THIS.pgf_4c_Principal.Page1
1210:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1211:             RETURN
1212:         ENDIF
1213:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1214:             "SigCdCli", "cursor_4c_BuscaConta", "IClis", ;
1215:             ALLTRIM(loc_oP1.txt_4c_CdConta.Value), "Buscar Conta Banc" + CHR(225) + "ria")
1216:         loc_oBusca.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
1217:         loc_oBusca.mAddColuna("Rclis",  "", "Descri" + CHR(231) + CHR(227) + "o")
1218:         loc_oBusca.Show()
1219:         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1220:             SELECT cursor_4c_BuscaConta
1221:             loc_oP1.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.IClis)
1222:             loc_oP1.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
1223:         ENDIF
1224:         IF USED("cursor_4c_BuscaConta")
1225:             USE IN cursor_4c_BuscaConta
1226:         ENDIF
1227:         loc_oBusca.Release()
1228:     ENDPROC
1229: 
1230:     PROCEDURE AbrirLookupTitBan()
1231:         LOCAL loc_oBusca, loc_oP1
1232:         loc_oP1 = THIS.pgf_4c_Principal.Page1
1233:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1234:             RETURN
1235:         ENDIF

*-- Linhas 1241 a 1259:
1241:         loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
1242:         loc_oBusca.Show()
1243:         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTitBan")
1244:             SELECT cursor_4c_BuscaTitBan
1245:             loc_oP1.txt_4c_TitBan.Value = PADR(ALLTRIM(cursor_4c_BuscaTitBan.Fpags), 12)
1246:         ENDIF
1247:         IF USED("cursor_4c_BuscaTitBan")
1248:             USE IN cursor_4c_BuscaTitBan
1249:         ENDIF
1250:         loc_oBusca.Release()
1251:     ENDPROC
1252: 
1253:     *==========================================================================
1254:     * HANDLERS DOS BOTOES
1255:     *==========================================================================
1256: 
1257:     PROCEDURE ClickProcessar()
1258:         LOCAL loc_cCdEmp, loc_dDati, loc_dDatf, loc_cCdConta, loc_nCont
1259: 

*-- Linhas 1280 a 1298:
1280: 
1281:         loc_nCont = 0
1282:         IF USED("cursor_4c_Operacoes")
1283:             SELECT cursor_4c_Operacoes
1284:             SCAN
1285:                 IF cursor_4c_Operacoes.marca
1286:                     loc_nCont = loc_nCont + 1
1287:                 ENDIF
1288:             ENDSCAN
1289:         ENDIF
1290:         IF loc_nCont = 0
1291:             MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o foi selecionada")
1292:             RETURN
1293:         ENDIF
1294: 
1295:         THIS.Processamento()
1296:     ENDPROC
1297: 
1298:     PROCEDURE ClickEncerrarFiltro()

*-- Linhas 1318 a 1363:
1318: 
1319:     PROCEDURE ClickMarcarOpe()
1320:         IF USED("cursor_4c_Operacoes")
1321:             SELECT cursor_4c_Operacoes
1322:             REPLACE ALL marca WITH .T.
1323:             GO TOP
1324:             THIS.pgf_4c_Principal.Page1.grd_4c_Operacoes.Refresh()
1325:         ENDIF
1326:     ENDPROC
1327: 
1328:     PROCEDURE ClickDesmarcarOpe()
1329:         IF USED("cursor_4c_Operacoes")
1330:             SELECT cursor_4c_Operacoes
1331:             REPLACE ALL marca WITH .F.
1332:             GO TOP
1333:             THIS.pgf_4c_Principal.Page1.grd_4c_Operacoes.Refresh()
1334:         ENDIF
1335:     ENDPROC
1336: 
1337:     PROCEDURE ClickMarcarTitulos()
1338:         IF USED("cursor_4c_Filtro")
1339:             SELECT cursor_4c_Filtro
1340:             REPLACE ALL marca WITH .T.
1341:             GO TOP
1342:             THIS.pgf_4c_Principal.Page2.grd_4c_Dados.Refresh()
1343:         ENDIF
1344:     ENDPROC
1345: 
1346:     PROCEDURE ClickDesmarcarTitulos()
1347:         IF USED("cursor_4c_Filtro")
1348:             SELECT cursor_4c_Filtro
1349:             REPLACE ALL marca WITH .F.
1350:             GO TOP
1351:             THIS.pgf_4c_Principal.Page2.grd_4c_Dados.Refresh()
1352:         ENDIF
1353:     ENDPROC
1354: 
1355:     *==========================================================================
1356:     * Processamento - Executa busca de titulos e muda para page2
1357:     *==========================================================================
1358:     PROCEDURE Processamento()
1359:         LOCAL loc_oP1, loc_oP2, loc_oGrd, loc_oBO
1360:         LOCAL loc_cCdEmp, loc_cCdConta, loc_dDati, loc_dDatf
1361:         LOCAL loc_lNaoProc, loc_nPeriodo, loc_cOpeIN
1362: 
1363:         loc_oP1  = THIS.pgf_4c_Principal.Page1

*-- Linhas 1375 a 1441:
1375:         *-- Monta clausula IN das operacoes marcadas (sem parenteses externos - BO os adiciona)
1376:         loc_cOpeIN = ""
1377:         IF USED("cursor_4c_Operacoes")
1378:             SELECT cursor_4c_Operacoes
1379:             SCAN
1380:                 IF cursor_4c_Operacoes.marca
1381:                     loc_cOpeIN = loc_cOpeIN + IIF(EMPTY(loc_cOpeIN), "", ",") + ;
1382:                                  "'" + ALLTRIM(cursor_4c_Operacoes.Dopes) + "'"
1383:                 ENDIF
1384:             ENDSCAN
1385:         ENDIF
1386: 
1387:         *-- Limpa grid
1388:         loc_oGrd.RecordSource = ""
1389:         loc_oGrd.Refresh()
1390: 
1391:         *-- Seta propriedades de filtro do BO antes de chamar BuscarTitulos
1392:         loc_oBO.this_cEmps           = loc_cCdEmp
1393:         loc_oBO.this_dDatIni         = loc_dDati
1394:         loc_oBO.this_dDatFim         = loc_dDatf
1395:         loc_oBO.this_lNaoProcessadas = loc_lNaoProc
1396:         loc_oBO.this_nPeriodo        = loc_nPeriodo
1397: 
1398:         IF !loc_oBO.BuscarTitulos(loc_cOpeIN)
1399:             RETURN
1400:         ENDIF
1401: 
1402:         IF RECCOUNT("cursor_4c_Filtro") = 0
1403:             MsgAviso("Nenhum dado foi encontrado")
1404:             RETURN
1405:         ENDIF
1406: 
1407:         *-- Liga grid ao cursor
1408:         loc_oGrd.ColumnCount            = 8
1409:         loc_oGrd.RecordSource           = "cursor_4c_Filtro"
1410:         loc_oGrd.Column1.ControlSource  = "cursor_4c_Filtro.marca"
1411:         loc_oGrd.Column2.ControlSource  = "cursor_4c_Filtro.dopes"
1412:         loc_oGrd.Column3.ControlSource  = "cursor_4c_Filtro.numes"
1413:         loc_oGrd.Column4.ControlSource  = "cursor_4c_Filtro.rclis"
1414:         loc_oGrd.Column5.ControlSource  = "cursor_4c_Filtro.vencs"
1415:         loc_oGrd.Column6.ControlSource  = "cursor_4c_Filtro.fpags"
1416:         loc_oGrd.Column7.ControlSource  = "cursor_4c_Filtro.valos"
1417:         loc_oGrd.Column8.ControlSource  = "cursor_4c_Filtro.titulos"
1418:         loc_oGrd.Column1.Header1.Caption = ""
1419:         loc_oGrd.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1420:         loc_oGrd.Column3.Header1.Caption = "C" + CHR(243) + "digo"
1421:         loc_oGrd.Column4.Header1.Caption = "Cliente"
1422:         loc_oGrd.Column5.Header1.Caption = "Vencimento"
1423:         loc_oGrd.Column6.Header1.Caption = "Forma Pagto"
1424:         loc_oGrd.Column7.Header1.Caption = "Valor"
1425:         loc_oGrd.Column8.Header1.Caption = "T" + CHR(237) + "tulo"
1426:         loc_oGrd.SetAll("DynamicForeColor", "IIF(cursor_4c_Filtro.EndErro=1,RGB(255,0,0),RGB(0,0,0))", "Column")
1427:         loc_oGrd.Refresh()
1428: 
1429:         *-- Habilita boleto apenas quando mostrando "Ja Processados"
1430:         loc_oP2.cgp_4c_Acoes.Command3.Enabled = !loc_lNaoProc
1431: 
1432:         *-- Ativa protestar dias
1433:         loc_oP2.lbl_4c_Protestar.Enabled = .T.
1434:         loc_oP2.spn_4c_Dias.Enabled      = .T.
1435:         loc_oP2.lbl_4c_Dias.Enabled      = .T.
1436: 
1437:         *-- Muda para page2
1438:         loc_oP1.Enabled = .F.
1439:         loc_oP2.Enabled = .T.
1440:         THIS.pgf_4c_Principal.ActivePage = 2
1441:     ENDPROC

*-- Linhas 1471 a 1489:
1471: 
1472:         IF loc_oBO.BuscarClientePorConta(par_cCdConta)
1473:             IF USED("cursor_4c_ClienteConta") AND RECCOUNT("cursor_4c_ClienteConta") > 0
1474:                 SELECT cursor_4c_ClienteConta
1475:                 par_cGrupo = ALLTRIM(cursor_4c_ClienteConta.grupos)
1476:                 loc_lResultado = loc_oBO.BuscarConvenio(par_cGrupo, par_cCdConta)
1477:             ENDIF
1478:         ENDIF
1479: 
1480:         RETURN loc_lResultado
1481:     ENDPROC
1482: 
1483:     *==========================================================================
1484:     * GerarCNAB - Despacha geracao de arquivo CNAB por banco ou cria preview
1485:     * par_cTipo: "A"=Gerar arquivo, "V"=Preview relatorio, "I"=Prep boleto
1486:     *==========================================================================
1487:     PROCEDURE GerarCNAB(par_cTipo)
1488:         LOCAL loc_oBO, loc_oP1, loc_oP2
1489:         LOCAL loc_cCdEmp, loc_cCdConta, loc_cTitBan

*-- Linhas 1512 a 1543:
1512:                      "CNPJ da Empresa [" + loc_cCdEmp + "].")
1513:             RETURN
1514:         ENDIF
1515:         SELECT cursor_4c_Empresa
1516:         IF EMPTY(ALLTRIM(cursor_4c_Empresa.razsocs)) OR EMPTY(ALLTRIM(cursor_4c_Empresa.cgcs))
1517:             MsgAviso("N" + CHR(227) + "o foi encontrada a Raz" + CHR(227) + "o Social e/ou o " + ;
1518:                      "CNPJ da Empresa [" + loc_cCdEmp + "].")
1519:             RETURN
1520:         ENDIF
1521: 
1522:         IF par_cTipo = "A"
1523:             *-- Valida selecao de registros
1524:             loc_nCont = 0
1525:             IF USED("cursor_4c_Filtro")
1526:                 SELECT cursor_4c_Filtro
1527:                 SCAN
1528:                     IF cursor_4c_Filtro.marca
1529:                         loc_nCont = loc_nCont + 1
1530:                     ENDIF
1531:                 ENDSCAN
1532:             ENDIF
1533:             IF loc_nCont = 0
1534:                 MsgAviso("Nenhum registro foi selecionado")
1535:                 RETURN
1536:             ENDIF
1537: 
1538:             *-- Confirma geracao
1539:             IF !EMPTY(ALLTRIM(loc_cTitBan))
1540:                 IF !MsgConfirma("Confirma gera" + CHR(231) + CHR(227) + "o do arquivo de remessa?")
1541:                     RETURN
1542:                 ENDIF
1543:             ELSE

*-- Linhas 1556 a 1574:
1556:             ENDIF
1557: 
1558:             *-- Atualiza spinner dias do convenio
1559:             SELECT cursor_4c_Convenio
1560:             IF cursor_4c_Convenio.diasprots > 0
1561:                 loc_oP2.spn_4c_Dias.Value = cursor_4c_Convenio.diasprots
1562:             ELSE
1563:                 loc_oP2.spn_4c_Dias.Value = 5
1564:             ENDIF
1565: 
1566:             SET SAFETY OFF
1567: 
1568:             loc_cBancoNr = ALLTRIM(cursor_4c_Convenio.nbancos)
1569: 
1570:             *-- Despacha por banco
1571:             DO CASE
1572:                 CASE loc_cBancoNr = "001"
1573:                     THIS.CnabBrasil()
1574: 

*-- Linhas 1591 a 1650:
1591:                     MsgAviso("Banco " + CHR(34) + loc_cBancoNr + CHR(34) + ;
1592:                              " n" + CHR(227) + "o suportado para gera" + CHR(231) + CHR(227) + "o CNAB.")
1593:             ENDCASE
1594: 
1595:         ELSE
1596:             *-- "V" ou "I": carrega convenio e cria cursor_4c_Filtro2 para relatorio/boleto
1597:             IF !THIS.CarregarConvenioLocal(loc_cCdConta, loc_cGrupo)
1598:                 MsgAviso("Conv" + CHR(234) + "nio n" + CHR(227) + "o encontrado para a conta [" + ;
1599:                          loc_cCdConta + "].")
1600:                 RETURN
1601:             ENDIF
1602: 
1603:             IF USED("cursor_4c_Filtro2")
1604:                 USE IN cursor_4c_Filtro2
1605:             ENDIF
1606: 
1607:             SELECT *, SPACE(15) AS SeqNums FROM cursor_4c_Filtro WHERE marca ;
1608:                 INTO CURSOR cursor_4c_Filtro2 READWRITE
1609: 
1610:             SELECT cursor_4c_Filtro2
1611:             GO TOP
1612: 
1613:             IF par_cTipo = "V"
1614:                 THIS.ExecutarReportForm("sigrecnb", "PREVIEW", "cursor_4c_Filtro2")
1615:             ENDIF
1616:         ENDIF
1617:     ENDPROC
1618: 
1619:     *==========================================================================
1620:     * CnabBrasil - Gera arquivo CNAB 400 para Banco do Brasil (001)
1621:     *==========================================================================
1622:     PROTECTED PROCEDURE CnabBrasil()
1623:         LOCAL loc_oBO, loc_oP2
1624:         LOCAL lcTit, lcBanco, lcCnv, lcAge, lcbco, lcRaz, lcCgc, lctpcgc, lcrazbco
1625:         LOCAL lcDat, lnMor, lcPri, lcprot, lcCdC, lcTpCtArq, lcTpCtBol, lcEnv, lcArq
1626:         LOCAL lcStrg, lnSeq, lcSeq, lcSeqNum, lcVenc, lcValor, lnMora, lcMora
1627:         LOCAL lccgccli, lctpcgccli, lcnome, lcende, lcbair, lccep, lccida, lcesta, lcnumtit
1628:         LOCAL lnCont, lok, llAtu, lcTitBanAtual, loc_oErro
1629:         LOCAL lcArqCnabs, loc_cCidChave
1630: 
1631:         loc_oBO = THIS.this_oBusinessObject
1632:         loc_oP2 = THIS.pgf_4c_Principal.Page2
1633: 
1634:         SELECT cursor_4c_Convenio
1635:         SELECT cursor_4c_Empresa
1636: 
1637:         lcArqCnabs = ALLTRIM(cursor_4c_Convenio.arqcnabs)
1638: 
1639:         lcTit     = PADR(THIS.pgf_4c_Principal.Page1.txt_4c_TitBan.Value, 12)
1640:         lcBanco   = PADL(ALLTRIM(cursor_4c_Convenio.nbancos), 3, "0")
1641:         lcCnv     = PADL(ALLTRIM(cursor_4c_Convenio.convenios), 3, "0")
1642:         lcAge     = PADL(ALLTRIM(cursor_4c_Convenio.nagencias), 5, "0")
1643:         lcbco     = PADL(ALLTRIM(CHRTRAN(ALLTRIM(cursor_4c_Convenio.contas) + ;
1644:                           PADL(cursor_4c_Convenio.digiagen, 1, "0"), ".-", "")), 9, "0")
1645:         lcRaz     = PADR(ALLTRIM(cursor_4c_Empresa.razsocs), 30)
1646:         lcCgc     = PADL(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Empresa.cgcs, "/", ""), ".", ""), "-", ""), 14, "0")
1647:         lctpcgc   = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Empresa.cgcs, "/.-", ""))) = 11, "01", "02")
1648:         lcrazbco  = PADR(ALLTRIM(cursor_4c_Convenio.bancos), 15)
1649:         lcDat     = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 9, 2)
1650:         lnMor     = IIF(EMPTY(cursor_4c_Convenio.moras), 0.23, cursor_4c_Convenio.moras)

*-- Linhas 1663 a 1770:
1663:                  "001BANCO DO BRASIL" + lcDat + lcEnv + SPACE(22) + lcCdC + ;
1664:                  SPACE(258) + "000001" + CHR(13) + CHR(10)
1665:         lcStrg = fLimpaTexto(lcStrg)
1666:         STRTOFILE(lcStrg, lcArq, 0)
1667: 
1668:         IF USED("cursor_4c_Filtro2")
1669:             USE IN cursor_4c_Filtro2
1670:         ENDIF
1671:         SELECT *, SPACE(5) AS SeqNums FROM cursor_4c_Filtro WHERE marca ;
1672:             INTO CURSOR cursor_4c_Filtro2 READWRITE
1673: 
1674:         lnSeq = 2
1675:         SELECT cursor_4c_Filtro2
1676:         SCAN
1677:             lcSeqNum   = fGerUniqueKey("BBNOSSONUM")
1678:             lcSeq      = TRANSFORM(lnSeq, "@L 999999")
1679:             lcVenc     = SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 1, 2) + ;
1680:                          SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 4, 2) + ;
1681:                          SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 9, 2)
1682:             lcValor    = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 11, 2), ",.", "")), 13, "0")
1683:             lnMora     = ROUND((cursor_4c_Filtro2.valos * 0.23) / 100, 2)
1684:             lcMora     = PADL(ALLTRIM(CHRTRAN(STR(lnMora, 11, 2), ",.", "")), 13, "0")
1685:             lccgccli   = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-,", "")), 14, "0")
1686:             lctpcgccli = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-", ""))) = 11, "01", "02")
1687:             lcnome     = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 37)
1688:             lcnome     = PADR(CHRTRAN(lcnome, "/.-,", ""), 37)
1689:             IF EMPTY(cursor_4c_Filtro2.endcobs) OR EMPTY(cursor_4c_Filtro2.cepcobs) OR ;
1690:                EMPTY(cursor_4c_Filtro2.estcobs) OR EMPTY(cursor_4c_Filtro2.baicobs) OR ;
1691:                EMPTY(cursor_4c_Filtro2.cidcobs)
1692:                 lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endes) + " " + ;
1693:                               ALLTRIM(cursor_4c_Filtro2.nums) + " " + ;
1694:                               ALLTRIM(cursor_4c_Filtro2.compls), 40)
1695:                 lcbair = PADR(cursor_4c_Filtro2.bairs, 12)
1696:                 lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.ceps, ".-", "")), 8, "0")
1697:                 lccida = PADR(cursor_4c_Filtro2.cidas, 15)
1698:                 lcesta = PADR(cursor_4c_Filtro2.estas, 2)
1699:             ELSE
1700:                 lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endcobs), 40)
1701:                 lcbair = PADR(cursor_4c_Filtro2.baicobs, 12)
1702:                 lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cepcobs, ".-", "")), 8, "0")
1703:                 lccida = PADR(cursor_4c_Filtro2.cidcobs, 15)
1704:                 lcesta = PADR(cursor_4c_Filtro2.estcobs, 2)
1705:             ENDIF
1706:             lcende   = PADR(CHRTRAN(lcende, "/.-,", ""), 40)
1707:             lcnumtit = PADL(CHRTRAN(cursor_4c_Filtro2.titulos, "/", ""), 8, "0")
1708: 
1709:             lcStrg = "7" + lctpcgc + lcCgc + lcAge + lcbco + lcCdC + ;
1710:                      PADR(lcnumtit, 25) + lcCdC + PADL(lcSeqNum, 10, "0") + ;
1711:                      "00" + "00" + "   " + " " + "   " + lcTpCtBol + "0" + "000000" + "     " + ;
1712:                      lcTpCtArq + "01" + PADR(lcnumtit, 10) + lcVenc + lcValor + "001" + ;
1713:                      "0000" + " " + "01" + "N" + lcDat + lcPri + "00" + lcMora + ;
1714:                      "000000" + "0000000000000" + "0000000000000" + "0000000000000" + ;
1715:                      lctpcgccli + lccgccli + UPPER(lcnome) + "   " + UPPER(lcende) + ;
1716:                      UPPER(lcbair) + lccep + UPPER(lccida) + UPPER(lcesta) + ;
1717:                      SPACE(40) + "  " + " " + lcSeq + CHR(13) + CHR(10)
1718: 
1719:             lcStrg = fLimpaTexto(lcStrg)
1720:             STRTOFILE(lcStrg, lcArq, 1)
1721: 
1722:             REPLACE SeqNums WITH PADL(lcSeqNum, 5, "0") IN cursor_4c_Filtro2
1723: 
1724:             loc_cCidChave = LEFT(SYS(2015) + SYS(2015), 20)
1725:             loc_oBO.InserirRegistroCNAB(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.emps, ;
1726:                 cursor_4c_Filtro2.dopes, cursor_4c_Filtro2.numes, ;
1727:                 gc_4c_UsuarioLogado, loc_cCidChave, ;
1728:                 cursor_4c_Filtro2.titulos, VAL(lcSeqNum), "CNAB", lcStrg)
1729: 
1730:             lnSeq = lnSeq + 1
1731:         ENDSCAN
1732: 
1733:         *-- Trailer
1734:         lcSeq  = TRANSFORM(lnSeq, "@L 999999")
1735:         lcStrg = "9" + SPACE(393) + lcSeq + CHR(13) + CHR(10)
1736:         STRTOFILE(lcStrg, lcArq, 1)
1737: 
1738:         IF FILE(lcArq)
1739:             lok = .T.
1740:             IF !loc_oBO.CommitAlteracoes()
1741:                 loc_oBO.RollbackAlteracoes()
1742:                 lok = .F.
1743:             ENDIF
1744: 
1745:             IF lok
1746:                 SELECT cursor_4c_Filtro2
1747:                 SCAN
1748:                     llAtu = .T.
1749:                     lcTitBanAtual = THIS.ObterTituloBancoAtual(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers)
1750:                     IF !EMPTY(ALLTRIM(lcTitBanAtual))
1751:                         llAtu = MsgConfirma("T" + CHR(237) + "tulo " + CHR(34) + lcTitBanAtual + CHR(34) + ;
1752:                                             " j" + CHR(225) + " possui T" + CHR(237) + "tulo do Banco preenchido. Sobrescrever?")
1753:                     ENDIF
1754:                     IF llAtu
1755:                         loc_oBO.MarcarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers, lcTit)
1756:                     ENDIF
1757:                 ENDSCAN
1758:             ENDIF
1759: 
1760:             IF lok
1761:                 MsgInfo("Arquivo " + CHR(34) + ALLTRIM(lcArq) + CHR(34) + " gerado com sucesso!")
1762:             ENDIF
1763: 
1764:             *-- BB auto-imprime boleto apos geracao
1765:             THIS.pgf_4c_Principal.Page2.cgp_4c_Acoes.Command3.Enabled = .T.
1766:             THIS.ImpBoleto(.F.)
1767:         ENDIF
1768:     ENDPROC
1769: 
1770:     *==========================================================================

*-- Linhas 1784 a 1903:
1784:         loc_oP2 = THIS.pgf_4c_Principal.Page2
1785:         lcarq   = THIS.this_cArqCNAB
1786: 
1787:         SELECT cursor_4c_Convenio
1788:         SELECT cursor_4c_Empresa
1789: 
1790:         lcTit    = PADR(THIS.pgf_4c_Principal.Page1.txt_4c_TitBan.Value, 12)
1791:         lcCnv    = PADL(ALLTRIM(cursor_4c_Convenio.convenios), 8, "0")
1792:         lcAge    = PADL(ALLTRIM(cursor_4c_Convenio.nagencias), 4, "0")
1793:         lcbco    = PADL(ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")), 5, "0") + cursor_4c_Convenio.digiagen
1794:         lcRaz    = PADR(ALLTRIM(cursor_4c_Empresa.razsocs), 30)
1795:         lcCgc    = PADL(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Empresa.cgcs, "/", ""), ".", ""), "-", ""), 14, "0")
1796:         lctpcgc  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Empresa.cgcs, "/.-", ""))) = 11, "01", "02")
1797:         lcrazbco = PADR(ALLTRIM(cursor_4c_Convenio.bancos), 15)
1798:         lcDat    = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 9, 2)
1799:         lcprot   = IIF(loc_oP2.spn_4c_Dias.Value = 0, 5, loc_oP2.spn_4c_Dias.Value)
1800:         lcprot   = PADL(ALLTRIM(STR(lcprot)), 2, "0")
1801: 
1802:         *-- Header
1803:         lcStrg = "0" + "1" + "REMESSA" + "01" + "COBRANCA       " + ;
1804:                  lcAge + "00" + lcbco + SPACE(8) + lcRaz + "341" + ;
1805:                  lcrazbco + lcDat + SPACE(294) + "000001" + CHR(13) + CHR(10)
1806:         lcStrg = fLimpaTexto(lcStrg)
1807:         STRTOFILE(lcStrg, lcarq, 0)
1808: 
1809:         IF USED("cursor_4c_Filtro2")
1810:             USE IN cursor_4c_Filtro2
1811:         ENDIF
1812:         SELECT * FROM cursor_4c_Filtro WHERE marca INTO CURSOR cursor_4c_Filtro2 READWRITE
1813: 
1814:         lnSeq = 2
1815:         SELECT cursor_4c_Filtro2
1816:         SCAN
1817:             lcSeq      = TRANSFORM(lnSeq, "@L 999999")
1818:             lcnumes    = TRANSFORM(cursor_4c_Filtro2.numes, "@L 9999999999")
1819:             lcVenc     = SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 1, 2) + ;
1820:                          SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 4, 2) + ;
1821:                          SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 9, 2)
1822:             lcValor    = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 11, 2), ",.", "")), 13, "0")
1823:             lccgccli   = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-,", "")), 14, "0")
1824:             lctpcgcCli = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-", ""))) = 11, "01", "02")
1825:             lcnome     = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 30)
1826:             IF EMPTY(cursor_4c_Filtro2.endcobs) OR EMPTY(cursor_4c_Filtro2.cepcobs) OR ;
1827:                EMPTY(cursor_4c_Filtro2.estcobs) OR EMPTY(cursor_4c_Filtro2.baicobs) OR ;
1828:                EMPTY(cursor_4c_Filtro2.cidcobs)
1829:                 lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endes) + "," + cursor_4c_Filtro2.nums, 40)
1830:                 lcbair = PADR(cursor_4c_Filtro2.bairs, 12)
1831:                 lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.ceps, ".-", "")), 8, "0")
1832:                 lccida = PADR(cursor_4c_Filtro2.cidas, 15)
1833:                 lcesta = PADR(cursor_4c_Filtro2.estas, 2)
1834:             ELSE
1835:                 lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endcobs), 40)
1836:                 lcbair = PADR(cursor_4c_Filtro2.baicobs, 12)
1837:                 lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cepcobs, ".-", "")), 8, "0")
1838:                 lccida = PADR(cursor_4c_Filtro2.cidcobs, 15)
1839:                 lcesta = PADR(cursor_4c_Filtro2.estcobs, 2)
1840:             ENDIF
1841:             lcnumtit = PADL(STRTRAN(cursor_4c_Filtro2.titulos, "/", ""), 8, "0")
1842: 
1843:             lcStrg = "1" + lctpcgcCli + lcCgc + lcAge + "00" + lcbco + SPACE(4) + ;
1844:                      "0000" + PADR(lcnumtit, 25) + lcnumtit + ;
1845:                      "0000000000000" + "112" + SPACE(21) + "I" + "01" + ;
1846:                      PADR(lcnumtit, 10) + lcVenc + lcValor + "341" + "00000" + ;
1847:                      "01" + "A" + lcDat + "81" + "19" + "0000000000000" + ;
1848:                      "000000" + "0000000000000" + "0000000000000" + "0000000000000" + ;
1849:                      lctpcgcCli + lccgccli + lcnome + SPACE(10) + ;
1850:                      lcende + lcbair + lccep + lccida + lcesta + ;
1851:                      SPACE(30) + SPACE(4) + "000000" + lcprot + SPACE(1) + ;
1852:                      lcSeq + CHR(13) + CHR(10)
1853: 
1854:             lcStrg = fLimpaTexto(lcStrg)
1855:             STRTOFILE(lcStrg, lcarq, 1)
1856: 
1857:             loc_cCidChave = LEFT(SYS(2015) + SYS(2015), 20)
1858:             loc_oBO.InserirRegistroCNAB(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.emps, ;
1859:                 cursor_4c_Filtro2.dopes, cursor_4c_Filtro2.numes, ;
1860:                 gc_4c_UsuarioLogado, loc_cCidChave, ;
1861:                 cursor_4c_Filtro2.titulos, 0, "CNAB", lcStrg)
1862: 
1863:             lnSeq = lnSeq + 1
1864:         ENDSCAN
1865: 
1866:         *-- Trailer
1867:         lcSeq  = TRANSFORM(lnSeq, "@L 999999")
1868:         lcStrg = "9" + SPACE(393) + lcSeq + CHR(13) + CHR(10)
1869:         STRTOFILE(lcStrg, lcarq, 1)
1870: 
1871:         IF FILE(lcarq)
1872:             lok = .T.
1873:             IF !loc_oBO.CommitAlteracoes()
1874:                 loc_oBO.RollbackAlteracoes()
1875:                 lok = .F.
1876:             ENDIF
1877: 
1878:             IF lok
1879:                 SELECT cursor_4c_Filtro2
1880:                 SCAN
1881:                     llAtu = .T.
1882:                     lcTitBanAtual = THIS.ObterTituloBancoAtual(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers)
1883:                     IF !EMPTY(ALLTRIM(lcTitBanAtual))
1884:                         llAtu = MsgConfirma("T" + CHR(237) + "tulo " + CHR(34) + lcTitBanAtual + CHR(34) + ;
1885:                                             " j" + CHR(225) + " possui T" + CHR(237) + "tulo do Banco. Sobrescrever?")
1886:                     ENDIF
1887:                     IF llAtu
1888:                         loc_oBO.MarcarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers, lcTit)
1889:                     ENDIF
1890:                 ENDSCAN
1891:             ENDIF
1892: 
1893:             IF lok
1894:                 MsgInfo("Arquivo " + CHR(34) + ALLTRIM(lcarq) + CHR(34) + " gerado com sucesso!")
1895:             ENDIF
1896:         ENDIF
1897:     ENDPROC
1898: 
1899:     *==========================================================================
1900:     * CnabBradesco - Gera arquivo CNAB 400 para Bradesco (237)
1901:     *==========================================================================
1902:     PROTECTED PROCEDURE CnabBradesco()
1903:         LOCAL loc_oBO, loc_oP2

*-- Linhas 1910 a 1929:
1910:         loc_oBO = THIS.this_oBusinessObject
1911:         loc_oP2 = THIS.pgf_4c_Principal.Page2
1912: 
1913:         SELECT cursor_4c_Convenio
1914:         SELECT cursor_4c_Empresa
1915: 
1916:         lcTit  = PADR(THIS.pgf_4c_Principal.Page1.txt_4c_TitBan.Value, 12)
1917:         lcBcn  = PADL(ALLTRIM(cursor_4c_Convenio.nbancos), 3, "0")
1918:         lcCnv  = "009"
1919:         lcAge  = PADL(ALLTRIM(cursor_4c_Convenio.nagencias), 5, "0")
1920:         lcBco  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")), 7, "0") + ;
1921:                  PADL(cursor_4c_Convenio.digiagen, 1, "0")
1922:         lcRaz  = PADR(ALLTRIM(cursor_4c_Empresa.razsocs), 30)
1923:         lcCgc  = PADL(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Empresa.cgcs, "/", ""), ".", ""), "-", ""), 14, "0")
1924:         lcTpC  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Empresa.cgcs, "/.-", ""))) = 11, "01", "02")
1925:         lcRbc  = PADR(ALLTRIM(cursor_4c_Convenio.bancos), 15)
1926:         lcDat  = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 9, 2)
1927:         lcEnv  = PADL(fGerUniqueKey("BRADESCOENV"), 7, "0")
1928:         lnMor  = IIF(EMPTY(cursor_4c_Convenio.moras), 0.17, cursor_4c_Convenio.moras)
1929:         lcPri  = PADL(IIF(EMPTY(ALLTRIM(cursor_4c_Convenio.instrus)), "00", cursor_4c_Convenio.instrus), 2, "0")

*-- Linhas 1942 a 2047:
1942:                  lcRaz + lcBcn + lcRbc + lcDat + SPACE(8) + "MX" + ;
1943:                  lcEnv + SPACE(277) + "000001" + CHR(13) + CHR(10)
1944:         lcStrg = fLimpaTexto(lcStrg)
1945:         STRTOFILE(lcStrg, lcArq, 0)
1946: 
1947:         IF USED("cursor_4c_Filtro2")
1948:             USE IN cursor_4c_Filtro2
1949:         ENDIF
1950:         SELECT *, SPACE(11) AS SeqNums FROM cursor_4c_Filtro WHERE marca ;
1951:             INTO CURSOR cursor_4c_Filtro2 READWRITE
1952: 
1953:         lnSeq = 2
1954:         SELECT cursor_4c_Filtro2
1955:         SCAN
1956:             lcSeqNum  = fGerUniqueKey("BRNOSSONUM")
1957:             REPLACE SeqNums WITH PADL(lcSeqNum, 11, "0") IN cursor_4c_Filtro2
1958: 
1959:             lcSeq  = TRANSFORM(lnSeq, "@L 999999")
1960:             lcVenc = SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 1, 2) + ;
1961:                      SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 4, 2) + ;
1962:                      SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 9, 2)
1963:             lcVal  = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 11, 2), ",.", "")), 13, "0")
1964:             lcMor  = PADL(ALLTRIM(CHRTRAN(STR(ROUND((cursor_4c_Filtro2.valos * lnMor) / 100, 2), 11, 2), ",.", "")), 13, "0")
1965:             lcCpf  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-,", "")), 14, "0")
1966:             lcTpC  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-", ""))) = 11, "01", "02")
1967:             lcNom  = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 40)
1968:             lcNom  = PADR(CHRTRAN(lcNom, "/.-,", ""), 40)
1969:             IF EMPTY(cursor_4c_Filtro2.EndCobs) OR EMPTY(cursor_4c_Filtro2.CepCobs)
1970:                 lcEnd = PADR(ALLTRIM(cursor_4c_Filtro2.endes) + " " + cursor_4c_Filtro2.nums, 40)
1971:                 lcCep = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.ceps, ".-", "")), 8, "0")
1972:             ELSE
1973:                 lcEnd = PADR(ALLTRIM(cursor_4c_Filtro2.EndCobs), 40)
1974:                 lcCep = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.CepCobs, ".-", "")), 8, "0")
1975:             ENDIF
1976:             lcEnd = PADR(CHRTRAN(lcEnd, "/.-,", ""), 40)
1977:             lcNtt = PADL(STRTRAN(cursor_4c_Filtro2.titulos, "/", ""), 8, "0")
1978: 
1979:             lcNossoNum = "00000000000"
1980:             lcDV = "0"
1981:             IF lcBol = "2"
1982:                 lcNossoNum = PADL(cursor_4c_Filtro2.SeqNums, 11, "0")
1983:                 lcDV = fCalcMod11B7(lcCar + lcNossoNum)
1984:             ENDIF
1985: 
1986:             lcStrg = "1" + SPACE(5) + SPACE(1) + SPACE(5) + SPACE(7) + SPACE(1) + ;
1987:                      "0" + lcCnv + lcAge + lcBco + ;
1988:                      PADR(lcNtt, 25) + "   " + "2" + "0200" + ;
1989:                      lcNossoNum + lcDV + "0000000000" + ;
1990:                      lcBol + " " + SPACE(10) + " " + "2" + "  " + ;
1991:                      "01" + PADR(lcNtt, 10) + lcVenc + lcVal + ;
1992:                      "000" + "00000" + "01" + "N" + lcDat + ;
1993:                      lcPri + lcPrt + lcMor + "000000" + ;
1994:                      "0000000000000" + "0000000000000" + "0000000000000" + ;
1995:                      lcTpC + lcCpf + lcNom + lcEnd + ;
1996:                      SPACE(12) + lcCep + SPACE(60) + lcSeq + CHR(13) + CHR(10)
1997: 
1998:             lcStrg = fLimpaTexto(lcStrg)
1999:             STRTOFILE(lcStrg, lcArq, 1)
2000: 
2001:             loc_cCidChave = LEFT(SYS(2015) + SYS(2015), 20)
2002:             loc_oBO.InserirRegistroCNAB(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.emps, ;
2003:                 cursor_4c_Filtro2.dopes, cursor_4c_Filtro2.numes, ;
2004:                 gc_4c_UsuarioLogado, loc_cCidChave, ;
2005:                 cursor_4c_Filtro2.titulos, VAL(lcSeqNum), "CNAB", lcStrg)
2006: 
2007:             lnSeq = lnSeq + 1
2008:         ENDSCAN
2009: 
2010:         *-- Trailer
2011:         lcSeq  = TRANSFORM(lnSeq, "@L 999999")
2012:         lcStrg = "9" + SPACE(393) + lcSeq + CHR(13) + CHR(10)
2013:         STRTOFILE(lcStrg, lcArq, 1)
2014: 
2015:         IF FILE(lcArq)
2016:             lok = .T.
2017:             IF !loc_oBO.CommitAlteracoes()
2018:                 loc_oBO.RollbackAlteracoes()
2019:                 lok = .F.
2020:             ENDIF
2021: 
2022:             IF lok
2023:                 SELECT cursor_4c_Filtro2
2024:                 SCAN
2025:                     llAtu = .T.
2026:                     lcTitBanAtual = THIS.ObterTituloBancoAtual(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers)
2027:                     IF !EMPTY(ALLTRIM(lcTitBanAtual))
2028:                         llAtu = MsgConfirma("T" + CHR(237) + "tulo " + CHR(34) + lcTitBanAtual + CHR(34) + ;
2029:                                             " j" + CHR(225) + " possui T" + CHR(237) + "tulo do Banco. Sobrescrever?")
2030:                     ENDIF
2031:                     IF llAtu
2032:                         loc_oBO.MarcarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers, lcTit)
2033:                     ENDIF
2034:                 ENDSCAN
2035:             ENDIF
2036: 
2037:             IF lok
2038:                 MsgInfo("Arquivo " + CHR(34) + ALLTRIM(lcArq) + CHR(34) + " gerado com sucesso!")
2039:             ENDIF
2040:         ENDIF
2041:     ENDPROC
2042: 
2043:     *==========================================================================
2044:     * CnabSantander240 - Gera arquivo CNAB 240 para Santander (033/353)
2045:     *==========================================================================
2046:     PROTECTED PROCEDURE CnabSantander240()
2047:         LOCAL loc_oBO, loc_oP2

*-- Linhas 2057 a 2076:
2057:         loc_oBO = THIS.this_oBusinessObject
2058:         loc_oP2 = THIS.pgf_4c_Principal.Page2
2059: 
2060:         SELECT cursor_4c_Convenio
2061:         SELECT cursor_4c_Empresa
2062: 
2063:         lcTit    = PADR(THIS.pgf_4c_Principal.Page1.txt_4c_TitBan.Value, 13)
2064:         lcCnv    = PADL(ALLTRIM(cursor_4c_Convenio.convenios), 11, "0")
2065:         lcAge    = PADL(ALLTRIM(cursor_4c_Convenio.nagencias), 4, "0")
2066:         lcDigA   = ALLTRIM(cursor_4c_Convenio.digiagen)
2067:         lcCtaC   = ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", ""))
2068:         lcDigC   = RIGHT(lcCtaC, 1)
2069:         lcCta    = PADL(LEFT(lcCtaC, LEN(lcCtaC) - 1), 9, "0")
2070:         lcRaz    = PADR(ALLTRIM(cursor_4c_Empresa.razsocs), 30)
2071:         lcCgc    = PADL(ALLTRIM(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Empresa.cgcs, "/", ""), ".", ""), "-", "")), 15, "0")
2072:         lctpcgc  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Empresa.cgcs, "/.-", ""))) = 11, "1", "2")
2073:         lcrazbco = PADR(ALLTRIM(cursor_4c_Convenio.bancos), 30)
2074:         lcDat    = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 7, 4)
2075:         lcprot   = IIF(loc_oP2.spn_4c_Dias.Value = 0, 5, loc_oP2.spn_4c_Dias.Value)
2076:         lcprot   = PADL(ALLTRIM(STR(lcprot)), 2, "0")

*-- Linhas 2103 a 2160:
2103:                  lcRaz + SPACE(40) + SPACE(40) + lcEnv + lcDat + SPACE(41) + ;
2104:                  CHR(13) + CHR(10)
2105:         lcStrg = fLimpaTexto(lcStrg)
2106:         STRTOFILE(lcStrg, lcArq, 1)
2107: 
2108:         IF USED("cursor_4c_Filtro2")
2109:             USE IN cursor_4c_Filtro2
2110:         ENDIF
2111:         SELECT *, SPACE(5) AS SeqNums FROM cursor_4c_Filtro WHERE marca ;
2112:             INTO CURSOR cursor_4c_Filtro2 READWRITE
2113: 
2114:         lnSeqL = 0
2115:         SELECT cursor_4c_Filtro2
2116:         SCAN
2117:             lcnumes    = TRANSFORM(cursor_4c_Filtro2.numes, "@L 9999999999")
2118:             lcVenc     = SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 1, 2) + ;
2119:                          SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 4, 2) + ;
2120:                          SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 7, 4)
2121:             lcValor    = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 11, 2), ",.", "")), 15, "0")
2122:             lccgccli   = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-,", "")), 15, "0")
2123:             lctpcgcCli = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-", ""))) = 11, "1", "2")
2124:             lcnome     = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 40)
2125:             lnMora     = IIF(cursor_4c_Convenio.moras = 0, 0.33, cursor_4c_Convenio.moras)
2126:             lnMora     = ROUND((cursor_4c_Filtro2.valos * lnMora) / 100, 2)
2127:             lcMora     = PADL(ALLTRIM(CHRTRAN(STR(lnMora, 11, 2), ",.", "")), 15, "0")
2128:             IF EMPTY(cursor_4c_Filtro2.endcobs) OR EMPTY(cursor_4c_Filtro2.cepcobs) OR ;
2129:                EMPTY(cursor_4c_Filtro2.estcobs) OR EMPTY(cursor_4c_Filtro2.baicobs) OR ;
2130:                EMPTY(cursor_4c_Filtro2.cidcobs)
2131:                 lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endes) + "," + cursor_4c_Filtro2.nums, 40)
2132:                 lcbair = PADR(cursor_4c_Filtro2.bairs, 15)
2133:                 lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.ceps, ".-", "")), 8, "0")
2134:                 lccida = PADR(cursor_4c_Filtro2.cidas, 15)
2135:                 lcesta = PADR(cursor_4c_Filtro2.estas, 2)
2136:             ELSE
2137:                 lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endcobs), 40)
2138:                 lcbair = PADR(cursor_4c_Filtro2.baicobs, 15)
2139:                 lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cepcobs, ".-", "")), 8, "0")
2140:                 lccida = PADR(cursor_4c_Filtro2.cidcobs, 15)
2141:                 lcesta = PADR(cursor_4c_Filtro2.estcobs, 2)
2142:             ENDIF
2143: 
2144:             lcnumtit = PADL(ALLTRIM(STRTRAN(cursor_4c_Filtro2.titulos, "/", "")), 15, "0")
2145:             lcChave  = PADR(ALLTRIM(STRTRAN(cursor_4c_Filtro2.titulos, "/", "")), 15) + lcnumes
2146: 
2147:             lcSeqNum   = fGerUniqueKey("STNOSSONUM")
2148:             lcDV       = fCalcMod11BB(PADL(lcSeqNum, 7, "0"), cursor_4c_Convenio.nbancos)
2149:             lcNossoNum = PADL(lcSeqNum, 12, "0") + lcDV
2150: 
2151:             *-- Detalhe P
2152:             lnSeqL = lnSeqL + 1
2153:             lcSeqL = TRANSFORM(lnSeqL, "@L 99999")
2154:             lnSeq  = lnSeq + 1
2155: 
2156:             lcStrg = "033" + lcLot + "3" + lcSeqL + "P" + SPACE(1) + "01" + ;
2157:                      lcAge + lcDigA + lcCta + lcDigC + lcCta + lcDigC + ;
2158:                      SPACE(2) + lcNossoNum + "5" + "1" + "1" + SPACE(1) + SPACE(1) + ;
2159:                      lcnumtit + lcVenc + lcValor + ;
2160:                      lcAge + lcDigA + SPACE(1) + "02" + "N" + lcDat + ;

*-- Linhas 2177 a 2203:
2177:                      "000" + "000" + "000" + "000" + SPACE(19) + ;
2178:                      CHR(13) + CHR(10)
2179:             lcStrg = fLimpaTexto(lcStrg)
2180:             STRTOFILE(lcStrg, lcArq, 1)
2181: 
2182:             REPLACE SeqNums WITH PADL(lcSeqNum, 5, "0") IN cursor_4c_Filtro2
2183: 
2184:             loc_cCidChave = LEFT(SYS(2015) + SYS(2015), 20)
2185:             loc_oBO.InserirRegistroCNAB(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.emps, ;
2186:                 cursor_4c_Filtro2.dopes, cursor_4c_Filtro2.numes, ;
2187:                 gc_4c_UsuarioLogado, loc_cCidChave, ;
2188:                 cursor_4c_Filtro2.titulos, VAL(lcSeqNum), "CNAB", lcStrg)
2189:         ENDSCAN
2190: 
2191:         *-- Trailer do lote
2192:         lnSeq  = lnSeq + 1
2193:         lnSeqL = lnSeqL + 1
2194:         lcSeqL = TRANSFORM(lnSeqL, "@L 999999")
2195:         lcStrg = "033" + lcLot + "5" + SPACE(9) + lcSeqL + SPACE(217) + CHR(13) + CHR(10)
2196:         lcStrg = fLimpaTexto(lcStrg)
2197:         STRTOFILE(lcStrg, lcArq, 1)
2198: 
2199:         *-- Trailer do arquivo
2200:         lnSeq = lnSeq + 1
2201:         lcSeq = TRANSFORM(lnSeq, "@L 999999")
2202:         lcStrg = "033" + "9999" + "9" + SPACE(9) + "000001" + lcSeq + SPACE(211) + CHR(13) + CHR(10)
2203:         lcStrg = fLimpaTexto(lcStrg)

*-- Linhas 2209 a 2503:
2209:                 loc_oBO.RollbackAlteracoes()
2210:                 lok = .F.
2211:             ENDIF
2212: 
2213:             IF lok
2214:                 SELECT cursor_4c_Filtro2
2215:                 SCAN
2216:                     llAtu = .T.
2217:                     lcTitBanAtual = THIS.ObterTituloBancoAtual(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers)
2218:                     IF !EMPTY(ALLTRIM(lcTitBanAtual))
2219:                         llAtu = MsgConfirma("T" + CHR(237) + "tulo " + CHR(34) + lcTitBanAtual + CHR(34) + ;
2220:                                             " j" + CHR(225) + " possui T" + CHR(237) + "tulo do Banco. Sobrescrever?")
2221:                     ENDIF
2222:                     IF llAtu
2223:                         loc_oBO.MarcarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers, lcTit)
2224:                     ENDIF
2225:                 ENDSCAN
2226:             ENDIF
2227: 
2228:             IF lok
2229:                 MsgInfo("Arquivo " + CHR(34) + ALLTRIM(lcArq) + CHR(34) + " gerado com sucesso!")
2230:             ENDIF
2231:         ENDIF
2232:     ENDPROC
2233: 
2234:     *==========================================================================
2235:     * ObterTituloBancoAtual - Retorna titbans atual via BuscarTituloBanco do BO
2236:     * Substitui o antigo VerificarTituloBanco (que nao existe no novo BO)
2237:     *==========================================================================
2238:     PROTECTED PROCEDURE ObterTituloBancoAtual(par_cEmpDopNums, par_nNopers)
2239:         LOCAL loc_oBO, loc_cTitBan
2240:         loc_oBO    = THIS.this_oBusinessObject
2241:         loc_cTitBan = ""
2242: 
2243:         IF loc_oBO.BuscarTituloBanco(par_cEmpDopNums, par_nNopers)
2244:             IF USED("cursor_4c_TitBan") AND RECCOUNT("cursor_4c_TitBan") > 0
2245:                 SELECT cursor_4c_TitBan
2246:                 loc_cTitBan = ALLTRIM(NVL(cursor_4c_TitBan.titbans, ""))
2247:             ENDIF
2248:         ENDIF
2249: 
2250:         RETURN loc_cTitBan
2251:     ENDPROC
2252: 
2253:     *==========================================================================
2254:     * ImpBoleto - Imprime boletos dos registros marcados em cursor_4c_Filtro2
2255:     * par_lReimp: .T. = busca SeqNums do SigPcOol (reimprimir), .F. = usa atual
2256:     *==========================================================================
2257:     PROCEDURE ImpBoleto(par_lReimp)
2258:         LOCAL loc_oBO, loc_lSucesso, loc_oErro
2259:         LOCAL lcRaz, lcAge, lcbco, lcCdC, lcTpCtArq, lcTpCtBol
2260:         LOCAL lcNossoNum, lcDV, lcFator, lcValor, lcBarra, lcArqBMP
2261:         LOCAL lcCampo1, lcCampo2, lcCampo3, lcDv1, lcDv2, lcDv3, lcNrDigit
2262:         LOCAL lcAg, lcCar, lcCta, lcDig, lcLivre
2263:         LOCAL lcPri, lcprot, lnMor, lcMora, lcInt1, lcInt2, lcInt7
2264:         LOCAL loc_nNumeDs, loc_cRaz, loc_cTpCtBol, loc_cTpCtArq
2265:         LOCAL loc_cBancoNr, loc_cSQL
2266:         loc_lSucesso = .F.
2267: 
2268:         TRY
2269:             IF !USED("cursor_4c_Filtro2") OR RECCOUNT("cursor_4c_Filtro2") = 0
2270:                 MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para impress" + CHR(227) + "o de boleto")
2271:             ELSE
2272: 
2273:             loc_oBO = THIS.this_oBusinessObject
2274: 
2275:             SELECT cursor_4c_Convenio
2276:             SELECT cursor_4c_Empresa
2277: 
2278:             loc_cBancoNr = ALLTRIM(cursor_4c_Convenio.nbancos)
2279:             lcRaz       = PADR(ALLTRIM(cursor_4c_Empresa.razsocs), 30)
2280:             lcAge       = LEFT(ALLTRIM(cursor_4c_Convenio.nagencias), 4)
2281:             lcbco       = PADL(ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")), 8, "0")
2282:             lcCdC       = PADL(ALLTRIM(cursor_4c_Convenio.convenios), 7, "0")
2283:             lcTpCtArq   = ALLTRIM(cursor_4c_Convenio.tpctarqs)
2284:             lcTpCtBol   = ALLTRIM(cursor_4c_Convenio.tpctbols)
2285:             loc_cRaz     = lcRaz
2286:             loc_cTpCtBol = lcTpCtBol
2287:             loc_cTpCtArq = lcTpCtArq
2288: 
2289:             *-- Cria cursor extendido com campos de boleto
2290:             SELECT a.*, SPACE(44) AS nBarras, SPACE(30) AS ImgBarra, ;
2291:                     loc_cRaz AS Cedente, SPACE(50) AS NomeCli, ;
2292:                     SPACE(50) AS Instr1, SPACE(50) AS Instr2, SPACE(50) AS Instr3, ;
2293:                     SPACE(50) AS Instr4, SPACE(50) AS Instr5, SPACE(50) AS Instr6, ;
2294:                     SPACE(70) AS Instr7, SPACE(50) AS NrDigit, SPACE(17) AS NossoNum, ;
2295:                     SPACE(15) AS AgCodCed, SPACE(10) AS cTitulos, ;
2296:                     b.Ceps AS CepEmp, b.Endes AS EndEmp, b.Numeros AS NumEmp, ;
2297:                     b.Bairs AS BaiEmp, b.Cidas AS CidEmp, b.Estas AS EstaEmp, ;
2298:                     b.Cgcs AS CpfEmp, b.compls AS compEmp, ;
2299:                     loc_cTpCtBol AS TpCtBols, loc_cTpCtArq AS TpCtArqs, ;
2300:                     SPACE(2) AS carteira ;
2301:                 FROM cursor_4c_Filtro2 a, cursor_4c_Empresa b ;
2302:                 INTO CURSOR cursor_4c_Filtro2 READWRITE
2303: 
2304:             SELECT cursor_4c_Filtro2
2305:             GO TOP
2306: 
2307:             lcPri  = PADL(IIF(EMPTY(ALLTRIM(cursor_4c_Convenio.instrus)), "00", cursor_4c_Convenio.instrus), 2, "0")
2308:             lcprot = IIF(THIS.pgf_4c_Principal.Page2.spn_4c_Dias.Value = 0, 5, ;
2309:                          THIS.pgf_4c_Principal.Page2.spn_4c_Dias.Value)
2310:             lcprot = IIF(lcPri = "00", "00", PADL(ALLTRIM(STR(lcprot)), 2, "0"))
2311:             lnMor  = IIF(EMPTY(cursor_4c_Convenio.moras), 0.23, cursor_4c_Convenio.moras)
2312: 
2313:             SCAN
2314:                 loc_nNumeDs = 0
2315:                 IF par_lReimp
2316:                     *-- Busca numeds atual do SigPcOoL para reimpressao
2317:                     loc_cSQL = "SELECT TOP 1 numeds FROM SigPcOoL " + ;
2318:                                "WHERE processos = 'CNAB' " + ;
2319:                                "AND dopeds = " + EscaparSQL(ALLTRIM(cursor_4c_Filtro2.titulos)) + ;
2320:                                " ORDER BY datas DESC"
2321:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NumeDs") > 0 AND ;
2322:                        USED("cursor_4c_NumeDs") AND RECCOUNT("cursor_4c_NumeDs") > 0
2323:                         SELECT cursor_4c_NumeDs
2324:                         loc_nNumeDs = NVL(cursor_4c_NumeDs.numeds, 0)
2325:                         IF USED("cursor_4c_NumeDs")
2326:                             USE IN cursor_4c_NumeDs
2327:                         ENDIF
2328:                     ENDIF
2329:                     SELECT cursor_4c_Filtro2
2330:                     REPLACE SeqNums WITH PADL(ALLTRIM(STR(loc_nNumeDs)), 5, "0") IN cursor_4c_Filtro2
2331:                 ENDIF
2332: 
2333:                 IF loc_cBancoNr = "001"
2334:                     lcNossoNum = lcCdC + PADL(cursor_4c_Filtro2.SeqNums, 10, "0")
2335:                     lcFator    = PADL(ALLTRIM(STR(1000 + (TTOD(cursor_4c_Filtro2.vencs) - CTOD("03/07/2000")))), 4, "0")
2336:                     lcValor    = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 8, 2), ",.", "")), 10, "0")
2337:                     lcBarra    = "0019" + lcFator + lcValor + "000000" + lcNossoNum + "17"
2338:                     lcDV       = fCalcMod11BB(lcBarra, loc_cBancoNr)
2339: 
2340:                     lcNossoNum = lcCdC + PADL(cursor_4c_Filtro2.SeqNums, 10, "0")
2341:                     lcBarra    = "0019" + lcDV + lcFator + lcValor + "000000" + lcNossoNum + "17"
2342:                     REPLACE nBarras WITH lcBarra IN cursor_4c_Filtro2
2343: 
2344:                     lcArqBMP = "img_barra_" + PADL(cursor_4c_Filtro2.SeqNums, 10, "0") + ".bmp"
2345:                     fGerBar2de5(SYS(2023) + "\" + lcArqBMP, lcBarra)
2346:                     REPLACE ImgBarra WITH lcArqBMP IN cursor_4c_Filtro2
2347: 
2348:                     lcCampo1  = "001900000"
2349:                     lcDv1     = fCalcMod10(lcCampo1)
2350:                     lcCampo2  = SUBSTR(lcBarra, 25, 10)
2351:                     lcDv2     = fCalcMod10(lcCampo2)
2352:                     lcCampo3  = SUBSTR(lcBarra, 35, 10)
2353:                     lcDv3     = fCalcMod10(lcCampo3)
2354:                     lcNrDigit = lcCampo1 + lcDv1 + lcCampo2 + lcDv2 + lcCampo3 + lcDv3 + lcDV + lcFator + lcValor
2355:                     REPLACE NrDigit WITH lcNrDigit IN cursor_4c_Filtro2
2356:                     REPLACE AgCodCed WITH LEFT(ALLTRIM(cursor_4c_Convenio.nagencias), 4) + "-" + ;
2357:                             RIGHT(ALLTRIM(cursor_4c_Convenio.nagencias), 1) + "/" + ;
2358:                             ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")) + "-" + ;
2359:                             PADL(cursor_4c_Convenio.digiagen, 1, "0") IN cursor_4c_Filtro2
2360: 
2361:                     IF cursor_4c_Convenio.bcoimprime = 1
2362:                         REPLACE Instr3 WITH "COBRAR MULTA DE 2% AO M" + CHR(202) + "S AP" + CHR(211) + ;
2363:                                 "S 1 DIA DE VENCIMENTO " IN cursor_4c_Filtro2
2364:                     ENDIF
2365:                 ENDIF
2366: 
2367:                 IF loc_cBancoNr = "033"
2368:                     lcNossoNum = PADL(cursor_4c_Filtro2.SeqNums, 12, "0")
2369:                     lcDV       = fCalcMod11BB(lcNossoNum, loc_cBancoNr)
2370:                     lcNossoNum = lcNossoNum + lcDV
2371: 
2372:                     lcFator = PADL(ALLTRIM(STR((TTOD(cursor_4c_Filtro2.vencs) - CTOD("07/10/1997")))), 4, "0")
2373:                     lcValor = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 8, 2), ",.", "")), 10, "0")
2374:                     lcBarra = "0339" + lcFator + lcValor + "9" + lcCdC + lcNossoNum + "0" + "101"
2375:                     lcDV    = fCalcMod11BB(lcBarra, loc_cBancoNr, "DVB")
2376: 
2377:                     lcBarra = "0339" + lcDV + lcFator + lcValor + "9" + lcCdC + lcNossoNum + "0" + "101"
2378:                     REPLACE nBarras WITH lcBarra IN cursor_4c_Filtro2
2379: 
2380:                     lcArqBMP = "img_barra_" + PADL(cursor_4c_Filtro2.SeqNums, 12, "0") + ".bmp"
2381:                     fGerBar2de5(SYS(2023) + "\" + lcArqBMP, lcBarra)
2382:                     REPLACE ImgBarra WITH lcArqBMP IN cursor_4c_Filtro2
2383: 
2384:                     lcCampo1  = "03399" + SUBSTR(lcCdC, 1, 4)
2385:                     lcDv1     = fCalcMod10(lcCampo1)
2386:                     lcCampo2  = SUBSTR(lcBarra, 25, 10)
2387:                     lcDv2     = fCalcMod10(lcCampo2)
2388:                     lcCampo3  = SUBSTR(lcBarra, 35, 10)
2389:                     lcDv3     = fCalcMod10(lcCampo3)
2390:                     lcNrDigit = lcCampo1 + lcDv1 + lcCampo2 + lcDv2 + lcCampo3 + lcDv3 + lcDV + lcFator + lcValor
2391:                     REPLACE NrDigit WITH ALLTRIM(lcNrDigit) IN cursor_4c_Filtro2
2392:                     REPLACE AgCodCed WITH ALLTRIM(cursor_4c_Convenio.nagencias) + "/" + lcCdC IN cursor_4c_Filtro2
2393:                     REPLACE Instr3 WITH "COBRAR 1% DE MULTA A PARTIR DE " + ;
2394:                             DTOC(TTOD(cursor_4c_Filtro2.vencs) + 6) IN cursor_4c_Filtro2
2395:                 ENDIF
2396: 
2397:                 IF loc_cBancoNr = "237"
2398:                     IF par_lReimp
2399:                         REPLACE SeqNums WITH PADL(ALLTRIM(TRANSFORM(loc_nNumeDs, "@R 99999999999")), 11, "0") ;
2400:                             IN cursor_4c_Filtro2
2401:                     ENDIF
2402:                     lcFator = PADL(ALLTRIM(STR((TTOD(cursor_4c_Filtro2.vencs) - CTOD("07/10/1997")))), 4, "0")
2403:                     lcValor = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 8, 2), ",.", "")), 10, "0")
2404:                     lcAg    = PADL(LEFT(ALLTRIM(cursor_4c_Convenio.nagencias), 4), 4, "0")
2405:                     lcCar   = PADL(ALLTRIM(cursor_4c_Convenio.tpctbols), 2, "0")
2406:                     lcCta   = PADL(ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")), 7, "0")
2407:                     lcDig   = ALLTRIM(cursor_4c_Convenio.digiagen)
2408:                     lcNossoNum = PADL(cursor_4c_Filtro2.SeqNums, 11, "0")
2409:                     lcDV       = fCalcMod11B7(lcCar + lcNossoNum)
2410:                     lcNossoNum = lcNossoNum + lcDV
2411: 
2412:                     lcLivre = lcAg + lcCar + SUBSTR(lcNossoNum, 1, 11) + lcCta + "0"
2413:                     lcBarra = "2379" + lcFator + lcValor + lcLivre
2414:                     lcDV    = fCalcMod11BB(lcBarra, loc_cBancoNr, "DVB")
2415: 
2416:                     lcBarra = "2379" + lcDV + lcFator + lcValor + lcLivre
2417:                     REPLACE nBarras WITH lcBarra IN cursor_4c_Filtro2
2418: 
2419:                     lcArqBMP = "img_barra_" + PADL(cursor_4c_Filtro2.SeqNums, 11, "0") + ".bmp"
2420:                     fGerBar2de5(SYS(2023) + "\" + lcArqBMP, lcBarra)
2421:                     REPLACE ImgBarra WITH lcArqBMP IN cursor_4c_Filtro2
2422: 
2423:                     lcCampo1  = "2379" + SUBSTR(lcLivre, 1, 5)
2424:                     lcDv1     = fCalcMod10(lcCampo1)
2425:                     lcCampo2  = SUBSTR(lcLivre, 6, 10)
2426:                     lcDv2     = fCalcMod10(lcCampo2)
2427:                     lcCampo3  = SUBSTR(lcLivre, 16, 10)
2428:                     lcDv3     = fCalcMod10(lcCampo3)
2429:                     lcNrDigit = lcCampo1 + lcDv1 + lcCampo2 + lcDv2 + lcCampo3 + lcDv3 + lcDV + lcFator + lcValor
2430:                     REPLACE NrDigit WITH lcNrDigit IN cursor_4c_Filtro2
2431:                     REPLACE AgCodCed WITH ALLTRIM(cursor_4c_Convenio.nagencias) + "/" + lcCta + "-" + lcDig ;
2432:                         IN cursor_4c_Filtro2
2433:                     REPLACE carteira WITH lcCar IN cursor_4c_Filtro2
2434:                 ENDIF
2435: 
2436:                 REPLACE NossoNum   WITH lcNossoNum, ;
2437:                         cTitulos   WITH PADL(CHRTRAN(cursor_4c_Filtro2.titulos, "/", ""), 8, "0") ;
2438:                     IN cursor_4c_Filtro2
2439: 
2440:                 lcMora = STR(ROUND((cursor_4c_Filtro2.valos * lnMor) / 100, 2), 8, 2)
2441:                 lcInt1 = "AP" + CHR(211) + "S VENCIMENTO, COBRAR JUROS DE R$" + ALLTRIM(lcMora) + " AO DIA."
2442:                 lcInt2 = "PROTESTAR NO " + lcprot + CHR(186) + " DIA " + CHR(218) + "TIL AP" + CHR(211) + "S O VENCIMENTO."
2443:                 lcInt7 = IIF(loc_cBancoNr = "237", ;
2444:                              "Pag" + CHR(225) + "vel preferencialmente na Rede Bradesco ou Bradesco Expresso", ;
2445:                              "PAG" + CHR(193) + "VEL EM QUALQUER BANCO AT" + CHR(201) + " O VENCIMENTO")
2446: 
2447:                 IF cursor_4c_Convenio.bcoimprime = 1
2448:                     lcInt2 = ""
2449:                 ENDIF
2450: 
2451:                 LOCAL lcNomeCliTmp
2452:                 lcNomeCliTmp = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 37)
2453:                 lcNomeCliTmp = PADR(CHRTRAN(lcNomeCliTmp, "/.-,", ""), 37)
2454:                 REPLACE NomeCli WITH lcNomeCliTmp IN cursor_4c_Filtro2
2455: 
2456:                 IF !EMPTY(cursor_4c_Filtro2.endcobs) AND !EMPTY(cursor_4c_Filtro2.cepcobs) AND ;
2457:                    !EMPTY(cursor_4c_Filtro2.estcobs) AND !EMPTY(cursor_4c_Filtro2.baicobs) AND ;
2458:                    !EMPTY(cursor_4c_Filtro2.cidcobs)
2459:                     REPLACE endes WITH ALLTRIM(cursor_4c_Filtro2.endcobs), ;
2460:                             bairs WITH cursor_4c_Filtro2.baicobs, ;
2461:                             ceps  WITH cursor_4c_Filtro2.cepcobs, ;
2462:                             cidas WITH cursor_4c_Filtro2.cidcobs, ;
2463:                             estas WITH cursor_4c_Filtro2.estcobs ;
2464:                         IN cursor_4c_Filtro2
2465:                 ENDIF
2466: 
2467:                 REPLACE Instr1 WITH lcInt1, Instr2 WITH lcInt2, Instr7 WITH lcInt7 ;
2468:                     IN cursor_4c_Filtro2
2469:             ENDSCAN
2470: 
2471:             SELECT cursor_4c_Filtro2
2472:             GO TOP
2473: 
2474:             DO CASE
2475:                 CASE loc_cBancoNr = "001"
2476:                     THIS.ExecutarReportForm("BloquetoBB2", "PREVIEW", "cursor_4c_Filtro2")
2477: 
2478:                 CASE loc_cBancoNr = "033"
2479:                     THIS.ExecutarReportForm("BloquetoSt", "PREVIEW", "cursor_4c_Filtro2")
2480: 
2481:                 CASE loc_cBancoNr = "237"
2482:                     THIS.ExecutarReportForm("BloquetoBra", "PREVIEW", "cursor_4c_Filtro2")
2483:             ENDCASE
2484: 
2485:             *-- Limpa imagens de barra geradas
2486:             SELECT cursor_4c_Filtro2
2487:             SCAN
2488:                 lcArqBMP = SYS(2023) + "\img_barra_" + PADL(cursor_4c_Filtro2.SeqNums, 10, "0") + ".bmp"
2489:                 IF FILE(lcArqBMP)
2490:                     ERASE &lcArqBMP
2491:                 ENDIF
2492:             ENDSCAN
2493: 
2494:             loc_lSucesso = .T.
2495:             ENDIF
2496:         CATCH TO loc_oErro
2497:             MsgErro(loc_oErro.Message, "Erro ImpBoleto")
2498:         ENDTRY
2499: 
2500:         RETURN loc_lSucesso
2501:     ENDPROC
2502: 
2503:     *==========================================================================

*-- Linhas 2528 a 2565:
2528:     * BtnVisualizarClick - Visualiza relatorio dos titulos selecionados
2529:     *==========================================================================
2530:     PROCEDURE BtnVisualizarClick()
2531:         LOCAL loc_oErro
2532:         TRY
2533:             IF !USED("cursor_4c_Filtro") OR RECCOUNT("cursor_4c_Filtro") = 0
2534:                 MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o dispon" + CHR(237) + ;
2535:                          "vel. Execute o processamento primeiro.")
2536:             ELSE
2537:                 THIS.ClickRelatorio()
2538:             ENDIF
2539:         CATCH TO loc_oErro
2540:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
2541:         ENDTRY
2542:     ENDPROC
2543: 
2544:     *==========================================================================
2545:     * BtnExcluirClick - Desmarca todos os titulos
2546:     *==========================================================================
2547:     PROCEDURE BtnExcluirClick()
2548:         LOCAL loc_oErro
2549:         TRY
2550:             IF !USED("cursor_4c_Filtro") OR RECCOUNT("cursor_4c_Filtro") = 0
2551:                 MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o para desmarcar.")
2552:             ELSE
2553:                 IF MsgConfirma("Desmarcar todos os t" + CHR(237) + "tulos selecionados?")
2554:                     THIS.ClickDesmarcarTitulos()
2555:                 ENDIF
2556:             ENDIF
2557:         CATCH TO loc_oErro
2558:             MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
2559:         ENDTRY
2560:     ENDPROC
2561: 
2562:     *==========================================================================
2563:     * CarregarLista - Carrega dados iniciais (operacoes SigCdOpe)
2564:     *==========================================================================
2565:     PROCEDURE CarregarLista()

*-- Linhas 2653 a 2686:
2653:         loc_oP1.txt_4c_TitBan.Value       = ""
2654: 
2655:         IF USED("cursor_4c_Operacoes")
2656:             SELECT cursor_4c_Operacoes
2657:             REPLACE ALL marca WITH .F.
2658:             GO TOP
2659:             loc_oP1.grd_4c_Operacoes.Refresh()
2660:         ENDIF
2661: 
2662:         loc_oP1.txt_4c_CdEmpresa.SetFocus()
2663:     ENDPROC
2664: 
2665:     *==========================================================================
2666:     * AjustarBotoesPorModo - Habilita/desabilita botoes de acordo com dados
2667:     *==========================================================================
2668:     PROCEDURE AjustarBotoesPorModo()
2669:         LOCAL loc_oP1, loc_oP2, loc_lTemDados, loc_oErro
2670:         TRY
2671:             loc_lTemDados = USED("cursor_4c_Filtro") AND RECCOUNT("cursor_4c_Filtro") > 0
2672:             loc_oP1 = THIS.pgf_4c_Principal.Page1
2673:             loc_oP2 = THIS.pgf_4c_Principal.Page2
2674: 
2675:             loc_oP1.cgp_4c_Filtro.Command1.Enabled = .T.
2676:             loc_oP1.cgp_4c_Filtro.Command2.Enabled = .T.
2677: 
2678:             loc_oP2.cgp_4c_Acoes.Command1.Enabled = loc_lTemDados
2679:             loc_oP2.cgp_4c_Acoes.Command2.Enabled = loc_lTemDados
2680:             loc_oP2.cgp_4c_MarcaDados.Enabled     = loc_lTemDados
2681:         CATCH TO loc_oErro
2682:             MsgErro(loc_oErro.Message, "Erro AjustarBotoesPorModo")
2683:         ENDTRY
2684:     ENDPROC
2685: 
2686:     *==========================================================================

*-- Linhas 2786 a 2810:
2786:             USE IN cursor_4c_Operacoes
2787:         ENDIF
2788:         IF USED("cursor_4c_FormaPagto")
2789:             USE IN cursor_4c_FormaPagto
2790:         ENDIF
2791:         IF USED("cursor_4c_Filtro")
2792:             USE IN cursor_4c_Filtro
2793:         ENDIF
2794:         IF USED("cursor_4c_Filtro2")
2795:             USE IN cursor_4c_Filtro2
2796:         ENDIF
2797:         IF USED("cursor_4c_Empresa")
2798:             USE IN cursor_4c_Empresa
2799:         ENDIF
2800:         IF USED("cursor_4c_Convenio")
2801:             USE IN cursor_4c_Convenio
2802:         ENDIF
2803:         IF USED("cursor_4c_ClienteConta")
2804:             USE IN cursor_4c_ClienteConta
2805:         ENDIF
2806:         IF USED("cursor_4c_TitBan")
2807:             USE IN cursor_4c_TitBan
2808:         ENDIF
2809:         THIS.this_oBusinessObject = .NULL.
2810:         DODEFAULT()


### BO (C:\4c\projeto\app\classes\SIGPRCNBBO.prg):
*==============================================================================
* SIGPRCNBBO.prg - Business Object para Geracao de Arquivos CNAB
* Herda de: BusinessBase
* Tabela principal: SigPcOoL
* Chave primaria: cidchaves
*==============================================================================

DEFINE CLASS SIGPRCNBBO AS BusinessBase

    *-- Configuracao da tabela principal
    this_cTabela          = "SigPcOoL"
    this_cCampoChave      = "cidchaves"

    *--------------------------------------------------------------------------
    * Filtros da pagina pgfiltro
    *--------------------------------------------------------------------------
    this_cEmps            = ""    && Empresa selecionada char(3)
    this_cDsEmpresa       = ""    && Razao social da empresa char(40)
    this_dDatIni          = {}    && Data inicial do periodo
    this_dDatFim          = {}    && Data final do periodo
    this_cCdCarConta      = ""    && Codigo da conta bancaria char(10)
    this_cDsCarConta      = ""    && Descricao da conta bancaria char(40)
    this_cTitBan          = ""    && Titulo banco char(12)
    this_lNaoProcessadas  = .T.   && .T.=Nao processadas, .F.=Ja processadas
    this_nPeriodo         = 1     && 1=Vencimento, 2=Emissao
    this_nDiasProt        = 5     && Dias para protesto (spinner spndias)

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigPcOoL (schema confirmado)
    *--------------------------------------------------------------------------
    this_cTipos           = ""    && char(10) - tipo do processo ex: SIGPRCNB
    this_cDopes           = ""    && char(20) - codigo da operacao
    this_nNumes           = 0     && numeric(6,0) - numero do titulo
    this_cEmpDs           = ""    && char(3) - empresa destino
    this_cDopeDs          = ""    && char(20) - titulo/nosso numero (dopeds)
    this_nNumeDs          = 0     && numeric(11,0) - nosso numero sequencial (numeds)
    this_dDatas           = {}    && datetime NULL - data/hora do processamento
    this_cUsuars          = ""    && char(10) - usuario que processou
    this_cProdutos        = ""    && text NULL - conteudo do arquivo CNAB gerado
    this_cCidChaves       = ""    && char(20) PK - chave unica do registro
    this_cEdnDests        = ""    && char(29) - endereco destino
    this_cEmpDopNums      = ""    && char(29) - emps+dopes+numes (chave composta)
    this_cProcessos       = ""    && char(20) - tipo de arquivo ex: CNAB
    this_nNopers          = 0     && numeric(9,0) - numero da operacao

    *--------------------------------------------------------------------------
    * INIT - Configura tabela e chave; delega ao BusinessBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigPcOoL"
        THIS.this_cCampoChave = "cidchaves"
        RETURN DODEFAULT("SigPcOoL")
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK do registro corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor de dados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cTipos      = NVL(tipos,      "")
                THIS.this_cEmps       = NVL(emps,       "")
                THIS.this_cDopes      = NVL(dopes,      "")
                THIS.this_nNumes      = NVL(numes,      0)
                THIS.this_cEmpDs      = NVL(empds,      "")
                THIS.this_cDopeDs     = NVL(dopeds,     "")
                THIS.this_nNumeDs     = NVL(numeds,     0)
                THIS.this_dDatas      = NVL(datas,      {})
                THIS.this_cUsuars     = NVL(usuars,     "")
                THIS.this_cProdutos   = NVL(produtos,   "")
                THIS.this_cCidChaves  = NVL(cidchaves,  "")
                THIS.this_cEdnDests   = NVL(edndests,   "")
                THIS.this_cEmpDopNums = NVL(empdopnums, "")
                THIS.this_cProcessos  = NVL(processos,  "")
                THIS.this_nNopers     = NVL(nopers,     0)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.
        IF EMPTY(THIS.this_cEmps)
            MsgAviso("Empresa obrigat" + CHR(243) + "ria.")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND EMPTY(THIS.this_cDopes)
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria.")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND EMPTY(THIS.this_cEmpDopNums)
            MsgAviso("C" + CHR(243) + "digo do t" + CHR(237) + "tulo obrigat" + CHR(243) + "rio.")
            loc_lValido = .F.
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere registro de processamento na tabela SigPcOoL
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF THIS.ValidarDados()
                IF EMPTY(THIS.this_cCidChaves)
                    THIS.this_cCidChaves = fUniqueIds()
                ENDIF
                loc_cSQL = "INSERT INTO SigPcOoL "
                loc_cSQL = loc_cSQL + "(tipos, emps, dopes, numes, empds, dopeds, numeds, datas, usuars, "
                loc_cSQL = loc_cSQL + "produtos, cidchaves, edndests, empdopnums, processos, nopers) "
                loc_cSQL = loc_cSQL + "VALUES ("
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cTipos)         + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cEmps)          + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cDopes)         + ", "
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes)  + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cEmpDs)         + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cDopeDs)        + ", "
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumeDs) + ", "
                loc_cSQL = loc_cSQL + "GETDATE(), "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cUsuars)        + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cProdutos)      + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cCidChaves)     + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cEdnDests)      + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cEmpDopNums)    + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cProcessos)     + ", "
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopers) + ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro de processamento na tabela SigPcOoL
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "UPDATE SigPcOoL SET "
                loc_cSQL = loc_cSQL + "tipos = "      + EscaparSQL(THIS.this_cTipos)          + ", "
                loc_cSQL = loc_cSQL + "emps = "       + EscaparSQL(THIS.this_cEmps)           + ", "
                loc_cSQL = loc_cSQL + "dopes = "      + EscaparSQL(THIS.this_cDopes)          + ", "
                loc_cSQL = loc_cSQL + "numes = "      + FormatarNumeroSQL(THIS.this_nNumes)   + ", "
                loc_cSQL = loc_cSQL + "empds = "      + EscaparSQL(THIS.this_cEmpDs)          + ", "
                loc_cSQL = loc_cSQL + "dopeds = "     + EscaparSQL(THIS.this_cDopeDs)         + ", "
                loc_cSQL = loc_cSQL + "numeds = "     + FormatarNumeroSQL(THIS.this_nNumeDs)  + ", "
                loc_cSQL = loc_cSQL + "datas = GETDATE(), "
                loc_cSQL = loc_cSQL + "usuars = "     + EscaparSQL(THIS.this_cUsuars)         + ", "
                loc_cSQL = loc_cSQL + "produtos = "   + EscaparSQL(THIS.this_cProdutos)       + ", "
                loc_cSQL = loc_cSQL + "edndests = "   + EscaparSQL(THIS.this_cEdnDests)       + ", "
                loc_cSQL = loc_cSQL + "empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)     + ", "
                loc_cSQL = loc_cSQL + "processos = "  + EscaparSQL(THIS.this_cProcessos)      + ", "
                loc_cSQL = loc_cSQL + "nopers = "     + FormatarNumeroSQL(THIS.this_nNopers)
                loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigPcOoL (chamado por Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigPcOoL WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Carrega operacoes bancarias para grid de filtro
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF
            loc_cSQL = "SELECT dopes, CAST(0 AS bit) AS marca "
            loc_cSQL = loc_cSQL + "FROM SigCdOpe "
            loc_cSQL = loc_cSQL + "WHERE parcontas = 1 AND valpends = 1 "
            loc_cSQL = loc_cSQL + "ORDER BY dopes"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFormasPagto - Carrega formas de pagamento bancarias (SigOpFp)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarFormasPagto()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_FormaPagto")
                USE IN cursor_4c_FormaPagto
            ENDIF
            loc_cSQL = "SELECT fpags, descrs, infos, situas, nbancos "
            loc_cSQL = loc_cSQL + "FROM SigOpFp "
            loc_cSQL = loc_cSQL + "WHERE situas IN ('R','A') AND infos = 'K' "
            loc_cSQL = loc_cSQL + "ORDER BY fpags"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FormaPagto") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTitulos - Busca titulos a cobrar para geracao do arquivo CNAB
    * par_cOpCodes: codigos de operacao p/ IN clause ex: "'OP1','OP2'"
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTitulos(par_cOpCodes)
        LOCAL loc_lResultado, loc_cSQL, loc_cPeriodo, loc_cMarca
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Filtro")
                USE IN cursor_4c_Filtro
            ENDIF
            IF THIS.this_nPeriodo = 1
                loc_cPeriodo = "SigMvPar.vencs BETWEEN " + ;
                    FormatarDataSQL(THIS.this_dDatIni) + " AND " + ;
                    FormatarDataSQL(THIS.this_dDatFim)
            ELSE
                loc_cPeriodo = "SigMvCcr.dtemis BETWEEN " + ;
                    FormatarDataSQL(THIS.this_dDatIni) + " AND " + ;
                    FormatarDataSQL(THIS.this_dDatFim)
            ENDIF
            IF THIS.this_lNaoProcessadas
                loc_cMarca = "NOT EXISTS (SELECT 1 FROM SigPcOoL "
                loc_cMarca = loc_cMarca + "WHERE SigPcOoL.empdopnums = SigMvPar.empdopnums "
                loc_cMarca = loc_cMarca + "AND SigPcOoL.nopers = SigMvPar.nopers "
                loc_cMarca = loc_cMarca + "AND SigPcOoL.processos = 'CNAB')"
            ELSE
                loc_cMarca = "EXISTS (SELECT 1 FROM SigPcOoL "
                loc_cMarca = loc_cMarca + "WHERE SigPcOoL.empdopnums = SigMvPar.empdopnums "
                loc_cMarca = loc_cMarca + "AND SigPcOoL.nopers = SigMvPar.nopers "
                loc_cMarca = loc_cMarca + "AND SigPcOoL.processos = 'CNAB')"
            ENDIF
            loc_cSQL = "SELECT SigMvPar.empdopnums, SigMvPar.emps, SigMvPar.dopes, "
            loc_cSQL = loc_cSQL + "SigMvPar.numes, SigMvPar.vencs, SigMvPar.valos, "
            loc_cSQL = loc_cSQL + "SigMvPar.fpags, SigMvPar.nopers, "
            loc_cSQL = loc_cSQL + "SigMvCcr.titulos, SigMvCcr.titbans, SigMvCcr.dtemis, SigMvCcr.opers, "
            loc_cSQL = loc_cSQL + "SigMvCab.contads, "
            loc_cSQL = loc_cSQL + "SigCdCli.iclis, SigCdCli.rclis, SigCdCli.razaos, SigCdCli.grupos, "
            loc_cSQL = loc_cSQL + "SigCdCli.endes, SigCdCli.cidas, SigCdCli.estas, SigCdCli.nums, "
            loc_cSQL = loc_cSQL + "SigCdCli.compls, SigCdCli.bairs, SigCdCli.ceps, SigCdCli.cpfs, "
            loc_cSQL = loc_cSQL + "SigCdCli.endcobs, SigCdCli.cepcobs, SigCdCli.estcobs, "
            loc_cSQL = loc_cSQL + "SigCdCli.baicobs, SigCdCli.cidcobs, "
            loc_cSQL = loc_cSQL + "CAST(0 AS bit) AS marca, CAST(0 AS bit) AS EnvErro "
            loc_cSQL = loc_cSQL + "FROM SigMvPar "
            loc_cSQL = loc_cSQL + "INNER JOIN SigOpFp ON SigOpFp.fpags = SigMvPar.fpags "
            loc_cSQL = loc_cSQL + "INNER JOIN SigMvCab ON SigMvCab.empdopnums = SigMvPar.empdopnums "
            loc_cSQL = loc_cSQL + "INNER JOIN SigCdCli ON SigCdCli.iclis = SigMvCab.contads "
            loc_cSQL = loc_cSQL + "LEFT JOIN SigMvCcr ON SigMvCcr.empdopnums = SigMvPar.empdopnums "
            loc_cSQL = loc_cSQL + "AND SigMvCcr.nopers = SigMvPar.nopers "
            loc_cSQL = loc_cSQL + "WHERE SigMvPar.emps = " + EscaparSQL(THIS.this_cEmps)
            loc_cSQL = loc_cSQL + " AND SigMvPar.dopes IN (" + par_cOpCodes + ")"
            loc_cSQL = loc_cSQL + " AND SigOpFp.infos = 'K'"
            loc_cSQL = loc_cSQL + " AND " + loc_cPeriodo
            loc_cSQL = loc_cSQL + " AND " + loc_cMarca
            loc_cSQL = loc_cSQL + " ORDER BY SigMvPar.vencs, SigCdCli.rclis"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Filtro") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarEmpresa - Carrega dados da empresa para cabecalho do arquivo CNAB
    *--------------------------------------------------------------------------
    PROCEDURE BuscarEmpresa(par_cEmps)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Empresa")
                USE IN cursor_4c_Empresa
            ENDIF
            loc_cSQL = "SELECT cemps, razsocs, cgcs, tel1s, ceps, endes, "
            loc_cSQL = loc_cSQL + "numeros, bairs, cidas, estas, compls "
            loc_cSQL = loc_cSQL + "FROM SigCdEmp "
            loc_cSQL = loc_cSQL + "WHERE cemps = " + EscaparSQL(par_cEmps)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresa") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarClientePorConta - Retorna dados do cliente pela conta (iclis)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarClientePorConta(par_cConta)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_ClienteConta")
                USE IN cursor_4c_ClienteConta
            ENDIF
            loc_cSQL = "SELECT iclis, grupos, rclis "
            loc_cSQL = loc_cSQL + "FROM SigCdCli "
            loc_cSQL = loc_cSQL + "WHERE iclis = " + EscaparSQL(par_cConta)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClienteConta") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarConvenio - Carrega convenio bancario da conta selecionada no filtro
    * par_cGrupo: SigCdCli.grupos do cliente
    * par_cConta: codigo da conta bancaria selecionada
    *--------------------------------------------------------------------------
    PROCEDURE BuscarConvenio(par_cGrupo, par_cConta)
        LOCAL loc_lResultado, loc_cSQL, loc_cGruContas
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Convenio")
                USE IN cursor_4c_Convenio
            ENDIF
            loc_cGruContas = par_cGrupo + par_cConta
            loc_cSQL = "SELECT agencias, bancos, nagencias, nbancos, digiagen, "
            loc_cSQL = loc_cSQL + "contas, convenios, grucontas, diasprots, instrus, "
            loc_cSQL = loc_cSQL + "moras, bcoimprime, tpctarqs, tpctbols, arqcnabs "
            loc_cSQL = loc_cSQL + "FROM SIGCDCEB "
            loc_cSQL = loc_cSQL + "WHERE grucontas = " + EscaparSQL(loc_cGruContas)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Convenio") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTituloBanco - Retorna titulo e nosso numero do titulo no banco
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTituloBanco(par_cEmpDopNums, par_nNopers)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_TitBan")
                USE IN cursor_4c_TitBan
            ENDIF
            loc_cSQL = "SELECT titulos, titbans "
            loc_cSQL = loc_cSQL + "FROM SigMvCcr "
            loc_cSQL = loc_cSQL + "WHERE empdopnums = " + EscaparSQL(par_cEmpDopNums)
            loc_cSQL = loc_cSQL + " AND nopers = " + FormatarNumeroSQL(par_nNopers)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TitBan") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTituloBanco - Grava nosso numero do titulo no banco (titbans)
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTituloBanco(par_cEmpDopNums, par_nNopers, par_cTitBan)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE SigMvCcr SET titbans = " + EscaparSQL(par_cTitBan)
            loc_cSQL = loc_cSQL + " WHERE empdopnums = " + EscaparSQL(par_cEmpDopNums)
            loc_cSQL = loc_cSQL + " AND nopers = " + FormatarNumeroSQL(par_nNopers)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirRegistroCNAB - Insere registro de processamento CNAB em SigPcOoL
    *--------------------------------------------------------------------------
    PROCEDURE InserirRegistroCNAB
        LPARAMETERS par_cEmpDopNums, par_cEmps, par_cDopes, par_nNumes, ;
                    par_cUsuars, par_cCidChaves, par_cDopeDs, par_nNumeDs, ;
                    par_cProcessos, par_cProdutos
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "INSERT INTO SigPcOoL "
            loc_cSQL = loc_cSQL + "(empdopnums, emps, dopes, numes, usuars, tipos, "
            loc_cSQL = loc_cSQL + "processos, produtos, datas, cidchaves, dopeds, numeds) "
            loc_cSQL = loc_cSQL + "VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(par_cEmpDopNums)         + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cEmps)               + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cDopes)              + ", "
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(par_nNumes)       + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cUsuars)             + ", "
            loc_cSQL = loc_cSQL + "'SIGPRCNB', "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cProcessos)          + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cProdutos)           + ", "
            loc_cSQL = loc_cSQL + "GETDATE(), "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cCidChaves)          + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cDopeDs)             + ", "
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(par_nNumeDs)      + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CommitAlteracoes - Confirma transacao no SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE CommitAlteracoes()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF SQLCOMMIT(gnConnHandle) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * RollbackAlteracoes - Desfaz transacao no SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE RollbackAlteracoes()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF SQLROLLBACK(gnConnHandle) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE


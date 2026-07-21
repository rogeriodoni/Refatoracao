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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCNB.prg) - TRECHOS RELEVANTES PARA PASS SQL (2815 linhas total):

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

*-- Linhas 1473 a 1491:
1473: 
1474:         IF loc_oBO.BuscarClientePorConta(par_cCdConta)
1475:             IF USED("cursor_4c_ClienteConta") AND RECCOUNT("cursor_4c_ClienteConta") > 0
1476:                 SELECT cursor_4c_ClienteConta
1477:                 par_cGrupo = ALLTRIM(cursor_4c_ClienteConta.grupos)
1478:                 loc_lResultado = loc_oBO.BuscarConvenio(par_cGrupo, par_cCdConta)
1479:             ENDIF
1480:         ENDIF
1481: 
1482:         RETURN loc_lResultado
1483:     ENDPROC
1484: 
1485:     *==========================================================================
1486:     * GerarCNAB - Despacha geracao de arquivo CNAB por banco ou cria preview
1487:     * par_cTipo: "A"=Gerar arquivo, "V"=Preview relatorio, "I"=Prep boleto
1488:     *==========================================================================
1489:     PROCEDURE GerarCNAB(par_cTipo)
1490:         LOCAL loc_oBO, loc_oP1, loc_oP2
1491:         LOCAL loc_cCdEmp, loc_cCdConta, loc_cTitBan

*-- Linhas 1514 a 1545:
1514:                      "CNPJ da Empresa [" + loc_cCdEmp + "].")
1515:             RETURN
1516:         ENDIF
1517:         SELECT cursor_4c_Empresa
1518:         IF EMPTY(ALLTRIM(cursor_4c_Empresa.razsocs)) OR EMPTY(ALLTRIM(cursor_4c_Empresa.cgcs))
1519:             MsgAviso("N" + CHR(227) + "o foi encontrada a Raz" + CHR(227) + "o Social e/ou o " + ;
1520:                      "CNPJ da Empresa [" + loc_cCdEmp + "].")
1521:             RETURN
1522:         ENDIF
1523: 
1524:         IF par_cTipo = "A"
1525:             *-- Valida selecao de registros
1526:             loc_nCont = 0
1527:             IF USED("cursor_4c_Filtro")
1528:                 SELECT cursor_4c_Filtro
1529:                 SCAN
1530:                     IF cursor_4c_Filtro.marca
1531:                         loc_nCont = loc_nCont + 1
1532:                     ENDIF
1533:                 ENDSCAN
1534:             ENDIF
1535:             IF loc_nCont = 0
1536:                 MsgAviso("Nenhum registro foi selecionado")
1537:                 RETURN
1538:             ENDIF
1539: 
1540:             *-- Confirma geracao
1541:             IF !EMPTY(ALLTRIM(loc_cTitBan))
1542:                 IF !MsgConfirma("Confirma gera" + CHR(231) + CHR(227) + "o do arquivo de remessa?")
1543:                     RETURN
1544:                 ENDIF
1545:             ELSE

*-- Linhas 1558 a 1576:
1558:             ENDIF
1559: 
1560:             *-- Atualiza spinner dias do convenio
1561:             SELECT cursor_4c_Convenio
1562:             IF cursor_4c_Convenio.diasprots > 0
1563:                 loc_oP2.spn_4c_Dias.Value = cursor_4c_Convenio.diasprots
1564:             ELSE
1565:                 loc_oP2.spn_4c_Dias.Value = 5
1566:             ENDIF
1567: 
1568:             SET SAFETY OFF
1569: 
1570:             loc_cBancoNr = ALLTRIM(cursor_4c_Convenio.nbancos)
1571: 
1572:             *-- Despacha por banco
1573:             DO CASE
1574:                 CASE loc_cBancoNr = "001"
1575:                     THIS.CnabBrasil()
1576: 

*-- Linhas 1593 a 1652:
1593:                     MsgAviso("Banco " + CHR(34) + loc_cBancoNr + CHR(34) + ;
1594:                              " n" + CHR(227) + "o suportado para gera" + CHR(231) + CHR(227) + "o CNAB.")
1595:             ENDCASE
1596: 
1597:         ELSE
1598:             *-- "V" ou "I": carrega convenio e cria cursor_4c_Filtro2 para relatorio/boleto
1599:             IF !THIS.CarregarConvenioLocal(loc_cCdConta, loc_cGrupo)
1600:                 MsgAviso("Conv" + CHR(234) + "nio n" + CHR(227) + "o encontrado para a conta [" + ;
1601:                          loc_cCdConta + "].")
1602:                 RETURN
1603:             ENDIF
1604: 
1605:             IF USED("cursor_4c_Filtro2")
1606:                 USE IN cursor_4c_Filtro2
1607:             ENDIF
1608: 
1609:             SELECT *, SPACE(15) AS SeqNums FROM cursor_4c_Filtro WHERE marca ;
1610:                 INTO CURSOR cursor_4c_Filtro2 READWRITE
1611: 
1612:             SELECT cursor_4c_Filtro2
1613:             GO TOP
1614: 
1615:             IF par_cTipo = "V"
1616:                 THIS.ExecutarReportForm("sigrecnb", "PREVIEW", "cursor_4c_Filtro2")
1617:             ENDIF
1618:         ENDIF
1619:     ENDPROC
1620: 
1621:     *==========================================================================
1622:     * CnabBrasil - Gera arquivo CNAB 400 para Banco do Brasil (001)
1623:     *==========================================================================
1624:     PROTECTED PROCEDURE CnabBrasil()
1625:         LOCAL loc_oBO, loc_oP2
1626:         LOCAL lcTit, lcBanco, lcCnv, lcAge, lcbco, lcRaz, lcCgc, lctpcgc, lcrazbco
1627:         LOCAL lcDat, lnMor, lcPri, lcprot, lcCdC, lcTpCtArq, lcTpCtBol, lcEnv, lcArq
1628:         LOCAL lcStrg, lnSeq, lcSeq, lcSeqNum, lcVenc, lcValor, lnMora, lcMora
1629:         LOCAL lccgccli, lctpcgccli, lcnome, lcende, lcbair, lccep, lccida, lcesta, lcnumtit
1630:         LOCAL lnCont, lok, llAtu, lcTitBanAtual, loc_oErro
1631:         LOCAL lcArqCnabs, loc_cCidChave
1632: 
1633:         loc_oBO = THIS.this_oBusinessObject
1634:         loc_oP2 = THIS.pgf_4c_Principal.Page2
1635: 
1636:         SELECT cursor_4c_Convenio
1637:         SELECT cursor_4c_Empresa
1638: 
1639:         lcArqCnabs = ALLTRIM(cursor_4c_Convenio.arqcnabs)
1640: 
1641:         lcTit     = PADR(THIS.pgf_4c_Principal.Page1.txt_4c_TitBan.Value, 12)
1642:         lcBanco   = PADL(ALLTRIM(cursor_4c_Convenio.nbancos), 3, "0")
1643:         lcCnv     = PADL(ALLTRIM(cursor_4c_Convenio.convenios), 3, "0")
1644:         lcAge     = PADL(ALLTRIM(cursor_4c_Convenio.nagencias), 5, "0")
1645:         lcbco     = PADL(ALLTRIM(CHRTRAN(ALLTRIM(cursor_4c_Convenio.contas) + ;
1646:                           PADL(cursor_4c_Convenio.digiagen, 1, "0"), ".-", "")), 9, "0")
1647:         lcRaz     = PADR(ALLTRIM(cursor_4c_Empresa.razsocs), 30)
1648:         lcCgc     = PADL(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Empresa.cgcs, "/", ""), ".", ""), "-", ""), 14, "0")
1649:         lctpcgc   = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Empresa.cgcs, "/.-", ""))) = 11, "01", "02")
1650:         lcrazbco  = PADR(ALLTRIM(cursor_4c_Convenio.bancos), 15)
1651:         lcDat     = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 9, 2)
1652:         lnMor     = IIF(EMPTY(cursor_4c_Convenio.moras), 0.23, cursor_4c_Convenio.moras)

*-- Linhas 1665 a 1772:
1665:                  "001BANCO DO BRASIL" + lcDat + lcEnv + SPACE(22) + lcCdC + ;
1666:                  SPACE(258) + "000001" + CHR(13) + CHR(10)
1667:         lcStrg = fLimpaTexto(lcStrg)
1668:         STRTOFILE(lcStrg, lcArq, 0)
1669: 
1670:         IF USED("cursor_4c_Filtro2")
1671:             USE IN cursor_4c_Filtro2
1672:         ENDIF
1673:         SELECT *, SPACE(5) AS SeqNums FROM cursor_4c_Filtro WHERE marca ;
1674:             INTO CURSOR cursor_4c_Filtro2 READWRITE
1675: 
1676:         lnSeq = 2
1677:         SELECT cursor_4c_Filtro2
1678:         SCAN
1679:             lcSeqNum   = fGerUniqueKey("BBNOSSONUM")
1680:             lcSeq      = TRANSFORM(lnSeq, "@L 999999")
1681:             lcVenc     = SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 1, 2) + ;
1682:                          SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 4, 2) + ;
1683:                          SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 9, 2)
1684:             lcValor    = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 11, 2), ",.", "")), 13, "0")
1685:             lnMora     = ROUND((cursor_4c_Filtro2.valos * 0.23) / 100, 2)
1686:             lcMora     = PADL(ALLTRIM(CHRTRAN(STR(lnMora, 11, 2), ",.", "")), 13, "0")
1687:             lccgccli   = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-,", "")), 14, "0")
1688:             lctpcgccli = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-", ""))) = 11, "01", "02")
1689:             lcnome     = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 37)
1690:             lcnome     = PADR(CHRTRAN(lcnome, "/.-,", ""), 37)
1691:             IF EMPTY(cursor_4c_Filtro2.endcobs) OR EMPTY(cursor_4c_Filtro2.cepcobs) OR ;
1692:                EMPTY(cursor_4c_Filtro2.estcobs) OR EMPTY(cursor_4c_Filtro2.baicobs) OR ;
1693:                EMPTY(cursor_4c_Filtro2.cidcobs)
1694:                 lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endes) + " " + ;
1695:                               ALLTRIM(cursor_4c_Filtro2.nums) + " " + ;
1696:                               ALLTRIM(cursor_4c_Filtro2.compls), 40)
1697:                 lcbair = PADR(cursor_4c_Filtro2.bairs, 12)
1698:                 lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.ceps, ".-", "")), 8, "0")
1699:                 lccida = PADR(cursor_4c_Filtro2.cidas, 15)
1700:                 lcesta = PADR(cursor_4c_Filtro2.estas, 2)
1701:             ELSE
1702:                 lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endcobs), 40)
1703:                 lcbair = PADR(cursor_4c_Filtro2.baicobs, 12)
1704:                 lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cepcobs, ".-", "")), 8, "0")
1705:                 lccida = PADR(cursor_4c_Filtro2.cidcobs, 15)
1706:                 lcesta = PADR(cursor_4c_Filtro2.estcobs, 2)
1707:             ENDIF
1708:             lcende   = PADR(CHRTRAN(lcende, "/.-,", ""), 40)
1709:             lcnumtit = PADL(CHRTRAN(cursor_4c_Filtro2.titulos, "/", ""), 8, "0")
1710: 
1711:             lcStrg = "7" + lctpcgc + lcCgc + lcAge + lcbco + lcCdC + ;
1712:                      PADR(lcnumtit, 25) + lcCdC + PADL(lcSeqNum, 10, "0") + ;
1713:                      "00" + "00" + "   " + " " + "   " + lcTpCtBol + "0" + "000000" + "     " + ;
1714:                      lcTpCtArq + "01" + PADR(lcnumtit, 10) + lcVenc + lcValor + "001" + ;
1715:                      "0000" + " " + "01" + "N" + lcDat + lcPri + "00" + lcMora + ;
1716:                      "000000" + "0000000000000" + "0000000000000" + "0000000000000" + ;
1717:                      lctpcgccli + lccgccli + UPPER(lcnome) + "   " + UPPER(lcende) + ;
1718:                      UPPER(lcbair) + lccep + UPPER(lccida) + UPPER(lcesta) + ;
1719:                      SPACE(40) + "  " + " " + lcSeq + CHR(13) + CHR(10)
1720: 
1721:             lcStrg = fLimpaTexto(lcStrg)
1722:             STRTOFILE(lcStrg, lcArq, 1)
1723: 
1724:             REPLACE SeqNums WITH PADL(lcSeqNum, 5, "0") IN cursor_4c_Filtro2
1725: 
1726:             loc_cCidChave = LEFT(SYS(2015) + SYS(2015), 20)
1727:             loc_oBO.InserirRegistroCNAB(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.emps, ;
1728:                 cursor_4c_Filtro2.dopes, cursor_4c_Filtro2.numes, ;
1729:                 gc_4c_UsuarioLogado, loc_cCidChave, ;
1730:                 cursor_4c_Filtro2.titulos, VAL(lcSeqNum), "CNAB", lcStrg)
1731: 
1732:             lnSeq = lnSeq + 1
1733:         ENDSCAN
1734: 
1735:         *-- Trailer
1736:         lcSeq  = TRANSFORM(lnSeq, "@L 999999")
1737:         lcStrg = "9" + SPACE(393) + lcSeq + CHR(13) + CHR(10)
1738:         STRTOFILE(lcStrg, lcArq, 1)
1739: 
1740:         IF FILE(lcArq)
1741:             lok = .T.
1742:             IF !loc_oBO.CommitAlteracoes()
1743:                 loc_oBO.RollbackAlteracoes()
1744:                 lok = .F.
1745:             ENDIF
1746: 
1747:             IF lok
1748:                 SELECT cursor_4c_Filtro2
1749:                 SCAN
1750:                     llAtu = .T.
1751:                     lcTitBanAtual = THIS.ObterTituloBancoAtual(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers)
1752:                     IF !EMPTY(ALLTRIM(lcTitBanAtual))
1753:                         llAtu = MsgConfirma("T" + CHR(237) + "tulo " + CHR(34) + lcTitBanAtual + CHR(34) + ;
1754:                                             " j" + CHR(225) + " possui T" + CHR(237) + "tulo do Banco preenchido. Sobrescrever?")
1755:                     ENDIF
1756:                     IF llAtu
1757:                         loc_oBO.MarcarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers, lcTit)
1758:                     ENDIF
1759:                 ENDSCAN
1760:             ENDIF
1761: 
1762:             IF lok
1763:                 MsgInfo("Arquivo " + CHR(34) + ALLTRIM(lcArq) + CHR(34) + " gerado com sucesso!")
1764:             ENDIF
1765: 
1766:             *-- BB auto-imprime boleto apos geracao
1767:             THIS.pgf_4c_Principal.Page2.cgp_4c_Acoes.Command3.Enabled = .T.
1768:             THIS.ImpBoleto(.F.)
1769:         ENDIF
1770:     ENDPROC
1771: 
1772:     *==========================================================================

*-- Linhas 1786 a 1905:
1786:         loc_oP2 = THIS.pgf_4c_Principal.Page2
1787:         lcarq   = THIS.this_cArqCNAB
1788: 
1789:         SELECT cursor_4c_Convenio
1790:         SELECT cursor_4c_Empresa
1791: 
1792:         lcTit    = PADR(THIS.pgf_4c_Principal.Page1.txt_4c_TitBan.Value, 12)
1793:         lcCnv    = PADL(ALLTRIM(cursor_4c_Convenio.convenios), 8, "0")
1794:         lcAge    = PADL(ALLTRIM(cursor_4c_Convenio.nagencias), 4, "0")
1795:         lcbco    = PADL(ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")), 5, "0") + cursor_4c_Convenio.digiagen
1796:         lcRaz    = PADR(ALLTRIM(cursor_4c_Empresa.razsocs), 30)
1797:         lcCgc    = PADL(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Empresa.cgcs, "/", ""), ".", ""), "-", ""), 14, "0")
1798:         lctpcgc  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Empresa.cgcs, "/.-", ""))) = 11, "01", "02")
1799:         lcrazbco = PADR(ALLTRIM(cursor_4c_Convenio.bancos), 15)
1800:         lcDat    = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 9, 2)
1801:         lcprot   = IIF(loc_oP2.spn_4c_Dias.Value = 0, 5, loc_oP2.spn_4c_Dias.Value)
1802:         lcprot   = PADL(ALLTRIM(STR(lcprot)), 2, "0")
1803: 
1804:         *-- Header
1805:         lcStrg = "0" + "1" + "REMESSA" + "01" + "COBRANCA       " + ;
1806:                  lcAge + "00" + lcbco + SPACE(8) + lcRaz + "341" + ;
1807:                  lcrazbco + lcDat + SPACE(294) + "000001" + CHR(13) + CHR(10)
1808:         lcStrg = fLimpaTexto(lcStrg)
1809:         STRTOFILE(lcStrg, lcarq, 0)
1810: 
1811:         IF USED("cursor_4c_Filtro2")
1812:             USE IN cursor_4c_Filtro2
1813:         ENDIF
1814:         SELECT * FROM cursor_4c_Filtro WHERE marca INTO CURSOR cursor_4c_Filtro2 READWRITE
1815: 
1816:         lnSeq = 2
1817:         SELECT cursor_4c_Filtro2
1818:         SCAN
1819:             lcSeq      = TRANSFORM(lnSeq, "@L 999999")
1820:             lcnumes    = TRANSFORM(cursor_4c_Filtro2.numes, "@L 9999999999")
1821:             lcVenc     = SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 1, 2) + ;
1822:                          SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 4, 2) + ;
1823:                          SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 9, 2)
1824:             lcValor    = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 11, 2), ",.", "")), 13, "0")
1825:             lccgccli   = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-,", "")), 14, "0")
1826:             lctpcgcCli = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-", ""))) = 11, "01", "02")
1827:             lcnome     = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 30)
1828:             IF EMPTY(cursor_4c_Filtro2.endcobs) OR EMPTY(cursor_4c_Filtro2.cepcobs) OR ;
1829:                EMPTY(cursor_4c_Filtro2.estcobs) OR EMPTY(cursor_4c_Filtro2.baicobs) OR ;
1830:                EMPTY(cursor_4c_Filtro2.cidcobs)
1831:                 lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endes) + "," + cursor_4c_Filtro2.nums, 40)
1832:                 lcbair = PADR(cursor_4c_Filtro2.bairs, 12)
1833:                 lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.ceps, ".-", "")), 8, "0")
1834:                 lccida = PADR(cursor_4c_Filtro2.cidas, 15)
1835:                 lcesta = PADR(cursor_4c_Filtro2.estas, 2)
1836:             ELSE
1837:                 lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endcobs), 40)
1838:                 lcbair = PADR(cursor_4c_Filtro2.baicobs, 12)
1839:                 lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cepcobs, ".-", "")), 8, "0")
1840:                 lccida = PADR(cursor_4c_Filtro2.cidcobs, 15)
1841:                 lcesta = PADR(cursor_4c_Filtro2.estcobs, 2)
1842:             ENDIF
1843:             lcnumtit = PADL(STRTRAN(cursor_4c_Filtro2.titulos, "/", ""), 8, "0")
1844: 
1845:             lcStrg = "1" + lctpcgcCli + lcCgc + lcAge + "00" + lcbco + SPACE(4) + ;
1846:                      "0000" + PADR(lcnumtit, 25) + lcnumtit + ;
1847:                      "0000000000000" + "112" + SPACE(21) + "I" + "01" + ;
1848:                      PADR(lcnumtit, 10) + lcVenc + lcValor + "341" + "00000" + ;
1849:                      "01" + "A" + lcDat + "81" + "19" + "0000000000000" + ;
1850:                      "000000" + "0000000000000" + "0000000000000" + "0000000000000" + ;
1851:                      lctpcgcCli + lccgccli + lcnome + SPACE(10) + ;
1852:                      lcende + lcbair + lccep + lccida + lcesta + ;
1853:                      SPACE(30) + SPACE(4) + "000000" + lcprot + SPACE(1) + ;
1854:                      lcSeq + CHR(13) + CHR(10)
1855: 
1856:             lcStrg = fLimpaTexto(lcStrg)
1857:             STRTOFILE(lcStrg, lcarq, 1)
1858: 
1859:             loc_cCidChave = LEFT(SYS(2015) + SYS(2015), 20)
1860:             loc_oBO.InserirRegistroCNAB(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.emps, ;
1861:                 cursor_4c_Filtro2.dopes, cursor_4c_Filtro2.numes, ;
1862:                 gc_4c_UsuarioLogado, loc_cCidChave, ;
1863:                 cursor_4c_Filtro2.titulos, 0, "CNAB", lcStrg)
1864: 
1865:             lnSeq = lnSeq + 1
1866:         ENDSCAN
1867: 
1868:         *-- Trailer
1869:         lcSeq  = TRANSFORM(lnSeq, "@L 999999")
1870:         lcStrg = "9" + SPACE(393) + lcSeq + CHR(13) + CHR(10)
1871:         STRTOFILE(lcStrg, lcarq, 1)
1872: 
1873:         IF FILE(lcarq)
1874:             lok = .T.
1875:             IF !loc_oBO.CommitAlteracoes()
1876:                 loc_oBO.RollbackAlteracoes()
1877:                 lok = .F.
1878:             ENDIF
1879: 
1880:             IF lok
1881:                 SELECT cursor_4c_Filtro2
1882:                 SCAN
1883:                     llAtu = .T.
1884:                     lcTitBanAtual = THIS.ObterTituloBancoAtual(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers)
1885:                     IF !EMPTY(ALLTRIM(lcTitBanAtual))
1886:                         llAtu = MsgConfirma("T" + CHR(237) + "tulo " + CHR(34) + lcTitBanAtual + CHR(34) + ;
1887:                                             " j" + CHR(225) + " possui T" + CHR(237) + "tulo do Banco. Sobrescrever?")
1888:                     ENDIF
1889:                     IF llAtu
1890:                         loc_oBO.MarcarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers, lcTit)
1891:                     ENDIF
1892:                 ENDSCAN
1893:             ENDIF
1894: 
1895:             IF lok
1896:                 MsgInfo("Arquivo " + CHR(34) + ALLTRIM(lcarq) + CHR(34) + " gerado com sucesso!")
1897:             ENDIF
1898:         ENDIF
1899:     ENDPROC
1900: 
1901:     *==========================================================================
1902:     * CnabBradesco - Gera arquivo CNAB 400 para Bradesco (237)
1903:     *==========================================================================
1904:     PROTECTED PROCEDURE CnabBradesco()
1905:         LOCAL loc_oBO, loc_oP2

*-- Linhas 1912 a 1931:
1912:         loc_oBO = THIS.this_oBusinessObject
1913:         loc_oP2 = THIS.pgf_4c_Principal.Page2
1914: 
1915:         SELECT cursor_4c_Convenio
1916:         SELECT cursor_4c_Empresa
1917: 
1918:         lcTit  = PADR(THIS.pgf_4c_Principal.Page1.txt_4c_TitBan.Value, 12)
1919:         lcBcn  = PADL(ALLTRIM(cursor_4c_Convenio.nbancos), 3, "0")
1920:         lcCnv  = "009"
1921:         lcAge  = PADL(ALLTRIM(cursor_4c_Convenio.nagencias), 5, "0")
1922:         lcBco  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")), 7, "0") + ;
1923:                  PADL(cursor_4c_Convenio.digiagen, 1, "0")
1924:         lcRaz  = PADR(ALLTRIM(cursor_4c_Empresa.razsocs), 30)
1925:         lcCgc  = PADL(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Empresa.cgcs, "/", ""), ".", ""), "-", ""), 14, "0")
1926:         lcTpC  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Empresa.cgcs, "/.-", ""))) = 11, "01", "02")
1927:         lcRbc  = PADR(ALLTRIM(cursor_4c_Convenio.bancos), 15)
1928:         lcDat  = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 9, 2)
1929:         lcEnv  = PADL(fGerUniqueKey("BRADESCOENV"), 7, "0")
1930:         lnMor  = IIF(EMPTY(cursor_4c_Convenio.moras), 0.17, cursor_4c_Convenio.moras)
1931:         lcPri  = PADL(IIF(EMPTY(ALLTRIM(cursor_4c_Convenio.instrus)), "00", cursor_4c_Convenio.instrus), 2, "0")

*-- Linhas 1944 a 2049:
1944:                  lcRaz + lcBcn + lcRbc + lcDat + SPACE(8) + "MX" + ;
1945:                  lcEnv + SPACE(277) + "000001" + CHR(13) + CHR(10)
1946:         lcStrg = fLimpaTexto(lcStrg)
1947:         STRTOFILE(lcStrg, lcArq, 0)
1948: 
1949:         IF USED("cursor_4c_Filtro2")
1950:             USE IN cursor_4c_Filtro2
1951:         ENDIF
1952:         SELECT *, SPACE(11) AS SeqNums FROM cursor_4c_Filtro WHERE marca ;
1953:             INTO CURSOR cursor_4c_Filtro2 READWRITE
1954: 
1955:         lnSeq = 2
1956:         SELECT cursor_4c_Filtro2
1957:         SCAN
1958:             lcSeqNum  = fGerUniqueKey("BRNOSSONUM")
1959:             REPLACE SeqNums WITH PADL(lcSeqNum, 11, "0") IN cursor_4c_Filtro2
1960: 
1961:             lcSeq  = TRANSFORM(lnSeq, "@L 999999")
1962:             lcVenc = SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 1, 2) + ;
1963:                      SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 4, 2) + ;
1964:                      SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 9, 2)
1965:             lcVal  = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 11, 2), ",.", "")), 13, "0")
1966:             lcMor  = PADL(ALLTRIM(CHRTRAN(STR(ROUND((cursor_4c_Filtro2.valos * lnMor) / 100, 2), 11, 2), ",.", "")), 13, "0")
1967:             lcCpf  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-,", "")), 14, "0")
1968:             lcTpC  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-", ""))) = 11, "01", "02")
1969:             lcNom  = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 40)
1970:             lcNom  = PADR(CHRTRAN(lcNom, "/.-,", ""), 40)
1971:             IF EMPTY(cursor_4c_Filtro2.EndCobs) OR EMPTY(cursor_4c_Filtro2.CepCobs)
1972:                 lcEnd = PADR(ALLTRIM(cursor_4c_Filtro2.endes) + " " + cursor_4c_Filtro2.nums, 40)
1973:                 lcCep = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.ceps, ".-", "")), 8, "0")
1974:             ELSE
1975:                 lcEnd = PADR(ALLTRIM(cursor_4c_Filtro2.EndCobs), 40)
1976:                 lcCep = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.CepCobs, ".-", "")), 8, "0")
1977:             ENDIF
1978:             lcEnd = PADR(CHRTRAN(lcEnd, "/.-,", ""), 40)
1979:             lcNtt = PADL(STRTRAN(cursor_4c_Filtro2.titulos, "/", ""), 8, "0")
1980: 
1981:             lcNossoNum = "00000000000"
1982:             lcDV = "0"
1983:             IF lcBol = "2"
1984:                 lcNossoNum = PADL(cursor_4c_Filtro2.SeqNums, 11, "0")
1985:                 lcDV = fCalcMod11B7(lcCar + lcNossoNum)
1986:             ENDIF
1987: 
1988:             lcStrg = "1" + SPACE(5) + SPACE(1) + SPACE(5) + SPACE(7) + SPACE(1) + ;
1989:                      "0" + lcCnv + lcAge + lcBco + ;
1990:                      PADR(lcNtt, 25) + "   " + "2" + "0200" + ;
1991:                      lcNossoNum + lcDV + "0000000000" + ;
1992:                      lcBol + " " + SPACE(10) + " " + "2" + "  " + ;
1993:                      "01" + PADR(lcNtt, 10) + lcVenc + lcVal + ;
1994:                      "000" + "00000" + "01" + "N" + lcDat + ;
1995:                      lcPri + lcPrt + lcMor + "000000" + ;
1996:                      "0000000000000" + "0000000000000" + "0000000000000" + ;
1997:                      lcTpC + lcCpf + lcNom + lcEnd + ;
1998:                      SPACE(12) + lcCep + SPACE(60) + lcSeq + CHR(13) + CHR(10)
1999: 
2000:             lcStrg = fLimpaTexto(lcStrg)
2001:             STRTOFILE(lcStrg, lcArq, 1)
2002: 
2003:             loc_cCidChave = LEFT(SYS(2015) + SYS(2015), 20)
2004:             loc_oBO.InserirRegistroCNAB(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.emps, ;
2005:                 cursor_4c_Filtro2.dopes, cursor_4c_Filtro2.numes, ;
2006:                 gc_4c_UsuarioLogado, loc_cCidChave, ;
2007:                 cursor_4c_Filtro2.titulos, VAL(lcSeqNum), "CNAB", lcStrg)
2008: 
2009:             lnSeq = lnSeq + 1
2010:         ENDSCAN
2011: 
2012:         *-- Trailer
2013:         lcSeq  = TRANSFORM(lnSeq, "@L 999999")
2014:         lcStrg = "9" + SPACE(393) + lcSeq + CHR(13) + CHR(10)
2015:         STRTOFILE(lcStrg, lcArq, 1)
2016: 
2017:         IF FILE(lcArq)
2018:             lok = .T.
2019:             IF !loc_oBO.CommitAlteracoes()
2020:                 loc_oBO.RollbackAlteracoes()
2021:                 lok = .F.
2022:             ENDIF
2023: 
2024:             IF lok
2025:                 SELECT cursor_4c_Filtro2
2026:                 SCAN
2027:                     llAtu = .T.
2028:                     lcTitBanAtual = THIS.ObterTituloBancoAtual(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers)
2029:                     IF !EMPTY(ALLTRIM(lcTitBanAtual))
2030:                         llAtu = MsgConfirma("T" + CHR(237) + "tulo " + CHR(34) + lcTitBanAtual + CHR(34) + ;
2031:                                             " j" + CHR(225) + " possui T" + CHR(237) + "tulo do Banco. Sobrescrever?")
2032:                     ENDIF
2033:                     IF llAtu
2034:                         loc_oBO.MarcarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers, lcTit)
2035:                     ENDIF
2036:                 ENDSCAN
2037:             ENDIF
2038: 
2039:             IF lok
2040:                 MsgInfo("Arquivo " + CHR(34) + ALLTRIM(lcArq) + CHR(34) + " gerado com sucesso!")
2041:             ENDIF
2042:         ENDIF
2043:     ENDPROC
2044: 
2045:     *==========================================================================
2046:     * CnabSantander240 - Gera arquivo CNAB 240 para Santander (033/353)
2047:     *==========================================================================
2048:     PROTECTED PROCEDURE CnabSantander240()
2049:         LOCAL loc_oBO, loc_oP2

*-- Linhas 2059 a 2078:
2059:         loc_oBO = THIS.this_oBusinessObject
2060:         loc_oP2 = THIS.pgf_4c_Principal.Page2
2061: 
2062:         SELECT cursor_4c_Convenio
2063:         SELECT cursor_4c_Empresa
2064: 
2065:         lcTit    = PADR(THIS.pgf_4c_Principal.Page1.txt_4c_TitBan.Value, 13)
2066:         lcCnv    = PADL(ALLTRIM(cursor_4c_Convenio.convenios), 11, "0")
2067:         lcAge    = PADL(ALLTRIM(cursor_4c_Convenio.nagencias), 4, "0")
2068:         lcDigA   = ALLTRIM(cursor_4c_Convenio.digiagen)
2069:         lcCtaC   = ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", ""))
2070:         lcDigC   = RIGHT(lcCtaC, 1)
2071:         lcCta    = PADL(LEFT(lcCtaC, LEN(lcCtaC) - 1), 9, "0")
2072:         lcRaz    = PADR(ALLTRIM(cursor_4c_Empresa.razsocs), 30)
2073:         lcCgc    = PADL(ALLTRIM(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Empresa.cgcs, "/", ""), ".", ""), "-", "")), 15, "0")
2074:         lctpcgc  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Empresa.cgcs, "/.-", ""))) = 11, "1", "2")
2075:         lcrazbco = PADR(ALLTRIM(cursor_4c_Convenio.bancos), 30)
2076:         lcDat    = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 7, 4)
2077:         lcprot   = IIF(loc_oP2.spn_4c_Dias.Value = 0, 5, loc_oP2.spn_4c_Dias.Value)
2078:         lcprot   = PADL(ALLTRIM(STR(lcprot)), 2, "0")

*-- Linhas 2105 a 2162:
2105:                  lcRaz + SPACE(40) + SPACE(40) + lcEnv + lcDat + SPACE(41) + ;
2106:                  CHR(13) + CHR(10)
2107:         lcStrg = fLimpaTexto(lcStrg)
2108:         STRTOFILE(lcStrg, lcArq, 1)
2109: 
2110:         IF USED("cursor_4c_Filtro2")
2111:             USE IN cursor_4c_Filtro2
2112:         ENDIF
2113:         SELECT *, SPACE(5) AS SeqNums FROM cursor_4c_Filtro WHERE marca ;
2114:             INTO CURSOR cursor_4c_Filtro2 READWRITE
2115: 
2116:         lnSeqL = 0
2117:         SELECT cursor_4c_Filtro2
2118:         SCAN
2119:             lcnumes    = TRANSFORM(cursor_4c_Filtro2.numes, "@L 9999999999")
2120:             lcVenc     = SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 1, 2) + ;
2121:                          SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 4, 2) + ;
2122:                          SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 7, 4)
2123:             lcValor    = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 11, 2), ",.", "")), 15, "0")
2124:             lccgccli   = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-,", "")), 15, "0")
2125:             lctpcgcCli = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-", ""))) = 11, "1", "2")
2126:             lcnome     = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 40)
2127:             lnMora     = IIF(cursor_4c_Convenio.moras = 0, 0.33, cursor_4c_Convenio.moras)
2128:             lnMora     = ROUND((cursor_4c_Filtro2.valos * lnMora) / 100, 2)
2129:             lcMora     = PADL(ALLTRIM(CHRTRAN(STR(lnMora, 11, 2), ",.", "")), 15, "0")
2130:             IF EMPTY(cursor_4c_Filtro2.endcobs) OR EMPTY(cursor_4c_Filtro2.cepcobs) OR ;
2131:                EMPTY(cursor_4c_Filtro2.estcobs) OR EMPTY(cursor_4c_Filtro2.baicobs) OR ;
2132:                EMPTY(cursor_4c_Filtro2.cidcobs)
2133:                 lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endes) + "," + cursor_4c_Filtro2.nums, 40)
2134:                 lcbair = PADR(cursor_4c_Filtro2.bairs, 15)
2135:                 lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.ceps, ".-", "")), 8, "0")
2136:                 lccida = PADR(cursor_4c_Filtro2.cidas, 15)
2137:                 lcesta = PADR(cursor_4c_Filtro2.estas, 2)
2138:             ELSE
2139:                 lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endcobs), 40)
2140:                 lcbair = PADR(cursor_4c_Filtro2.baicobs, 15)
2141:                 lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cepcobs, ".-", "")), 8, "0")
2142:                 lccida = PADR(cursor_4c_Filtro2.cidcobs, 15)
2143:                 lcesta = PADR(cursor_4c_Filtro2.estcobs, 2)
2144:             ENDIF
2145: 
2146:             lcnumtit = PADL(ALLTRIM(STRTRAN(cursor_4c_Filtro2.titulos, "/", "")), 15, "0")
2147:             lcChave  = PADR(ALLTRIM(STRTRAN(cursor_4c_Filtro2.titulos, "/", "")), 15) + lcnumes
2148: 
2149:             lcSeqNum   = fGerUniqueKey("STNOSSONUM")
2150:             lcDV       = fCalcMod11BB(PADL(lcSeqNum, 7, "0"), cursor_4c_Convenio.nbancos)
2151:             lcNossoNum = PADL(lcSeqNum, 12, "0") + lcDV
2152: 
2153:             *-- Detalhe P
2154:             lnSeqL = lnSeqL + 1
2155:             lcSeqL = TRANSFORM(lnSeqL, "@L 99999")
2156:             lnSeq  = lnSeq + 1
2157: 
2158:             lcStrg = "033" + lcLot + "3" + lcSeqL + "P" + SPACE(1) + "01" + ;
2159:                      lcAge + lcDigA + lcCta + lcDigC + lcCta + lcDigC + ;
2160:                      SPACE(2) + lcNossoNum + "5" + "1" + "1" + SPACE(1) + SPACE(1) + ;
2161:                      lcnumtit + lcVenc + lcValor + ;
2162:                      lcAge + lcDigA + SPACE(1) + "02" + "N" + lcDat + ;

*-- Linhas 2179 a 2205:
2179:                      "000" + "000" + "000" + "000" + SPACE(19) + ;
2180:                      CHR(13) + CHR(10)
2181:             lcStrg = fLimpaTexto(lcStrg)
2182:             STRTOFILE(lcStrg, lcArq, 1)
2183: 
2184:             REPLACE SeqNums WITH PADL(lcSeqNum, 5, "0") IN cursor_4c_Filtro2
2185: 
2186:             loc_cCidChave = LEFT(SYS(2015) + SYS(2015), 20)
2187:             loc_oBO.InserirRegistroCNAB(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.emps, ;
2188:                 cursor_4c_Filtro2.dopes, cursor_4c_Filtro2.numes, ;
2189:                 gc_4c_UsuarioLogado, loc_cCidChave, ;
2190:                 cursor_4c_Filtro2.titulos, VAL(lcSeqNum), "CNAB", lcStrg)
2191:         ENDSCAN
2192: 
2193:         *-- Trailer do lote
2194:         lnSeq  = lnSeq + 1
2195:         lnSeqL = lnSeqL + 1
2196:         lcSeqL = TRANSFORM(lnSeqL, "@L 999999")
2197:         lcStrg = "033" + lcLot + "5" + SPACE(9) + lcSeqL + SPACE(217) + CHR(13) + CHR(10)
2198:         lcStrg = fLimpaTexto(lcStrg)
2199:         STRTOFILE(lcStrg, lcArq, 1)
2200: 
2201:         *-- Trailer do arquivo
2202:         lnSeq = lnSeq + 1
2203:         lcSeq = TRANSFORM(lnSeq, "@L 999999")
2204:         lcStrg = "033" + "9999" + "9" + SPACE(9) + "000001" + lcSeq + SPACE(211) + CHR(13) + CHR(10)
2205:         lcStrg = fLimpaTexto(lcStrg)

*-- Linhas 2211 a 2505:
2211:                 loc_oBO.RollbackAlteracoes()
2212:                 lok = .F.
2213:             ENDIF
2214: 
2215:             IF lok
2216:                 SELECT cursor_4c_Filtro2
2217:                 SCAN
2218:                     llAtu = .T.
2219:                     lcTitBanAtual = THIS.ObterTituloBancoAtual(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers)
2220:                     IF !EMPTY(ALLTRIM(lcTitBanAtual))
2221:                         llAtu = MsgConfirma("T" + CHR(237) + "tulo " + CHR(34) + lcTitBanAtual + CHR(34) + ;
2222:                                             " j" + CHR(225) + " possui T" + CHR(237) + "tulo do Banco. Sobrescrever?")
2223:                     ENDIF
2224:                     IF llAtu
2225:                         loc_oBO.MarcarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers, lcTit)
2226:                     ENDIF
2227:                 ENDSCAN
2228:             ENDIF
2229: 
2230:             IF lok
2231:                 MsgInfo("Arquivo " + CHR(34) + ALLTRIM(lcArq) + CHR(34) + " gerado com sucesso!")
2232:             ENDIF
2233:         ENDIF
2234:     ENDPROC
2235: 
2236:     *==========================================================================
2237:     * ObterTituloBancoAtual - Retorna titbans atual via BuscarTituloBanco do BO
2238:     * Substitui o antigo VerificarTituloBanco (que nao existe no novo BO)
2239:     *==========================================================================
2240:     PROTECTED PROCEDURE ObterTituloBancoAtual(par_cEmpDopNums, par_nNopers)
2241:         LOCAL loc_oBO, loc_cTitBan
2242:         loc_oBO    = THIS.this_oBusinessObject
2243:         loc_cTitBan = ""
2244: 
2245:         IF loc_oBO.BuscarTituloBanco(par_cEmpDopNums, par_nNopers)
2246:             IF USED("cursor_4c_TitBan") AND RECCOUNT("cursor_4c_TitBan") > 0
2247:                 SELECT cursor_4c_TitBan
2248:                 loc_cTitBan = ALLTRIM(NVL(cursor_4c_TitBan.titbans, ""))
2249:             ENDIF
2250:         ENDIF
2251: 
2252:         RETURN loc_cTitBan
2253:     ENDPROC
2254: 
2255:     *==========================================================================
2256:     * ImpBoleto - Imprime boletos dos registros marcados em cursor_4c_Filtro2
2257:     * par_lReimp: .T. = busca SeqNums do SigPcOol (reimprimir), .F. = usa atual
2258:     *==========================================================================
2259:     PROCEDURE ImpBoleto(par_lReimp)
2260:         LOCAL loc_oBO, loc_lSucesso, loc_oErro
2261:         LOCAL lcRaz, lcAge, lcbco, lcCdC, lcTpCtArq, lcTpCtBol
2262:         LOCAL lcNossoNum, lcDV, lcFator, lcValor, lcBarra, lcArqBMP
2263:         LOCAL lcCampo1, lcCampo2, lcCampo3, lcDv1, lcDv2, lcDv3, lcNrDigit
2264:         LOCAL lcAg, lcCar, lcCta, lcDig, lcLivre
2265:         LOCAL lcPri, lcprot, lnMor, lcMora, lcInt1, lcInt2, lcInt7
2266:         LOCAL loc_nNumeDs, loc_cRaz, loc_cTpCtBol, loc_cTpCtArq
2267:         LOCAL loc_cBancoNr, loc_cSQL
2268:         loc_lSucesso = .F.
2269: 
2270:         TRY
2271:             IF !USED("cursor_4c_Filtro2") OR RECCOUNT("cursor_4c_Filtro2") = 0
2272:                 MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para impress" + CHR(227) + "o de boleto")
2273:             ELSE
2274: 
2275:             loc_oBO = THIS.this_oBusinessObject
2276: 
2277:             SELECT cursor_4c_Convenio
2278:             SELECT cursor_4c_Empresa
2279: 
2280:             loc_cBancoNr = ALLTRIM(cursor_4c_Convenio.nbancos)
2281:             lcRaz       = PADR(ALLTRIM(cursor_4c_Empresa.razsocs), 30)
2282:             lcAge       = LEFT(ALLTRIM(cursor_4c_Convenio.nagencias), 4)
2283:             lcbco       = PADL(ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")), 8, "0")
2284:             lcCdC       = PADL(ALLTRIM(cursor_4c_Convenio.convenios), 7, "0")
2285:             lcTpCtArq   = ALLTRIM(cursor_4c_Convenio.tpctarqs)
2286:             lcTpCtBol   = ALLTRIM(cursor_4c_Convenio.tpctbols)
2287:             loc_cRaz     = lcRaz
2288:             loc_cTpCtBol = lcTpCtBol
2289:             loc_cTpCtArq = lcTpCtArq
2290: 
2291:             *-- Cria cursor extendido com campos de boleto
2292:             SELECT a.*, SPACE(44) AS nBarras, SPACE(30) AS ImgBarra, ;
2293:                     loc_cRaz AS Cedente, SPACE(50) AS NomeCli, ;
2294:                     SPACE(50) AS Instr1, SPACE(50) AS Instr2, SPACE(50) AS Instr3, ;
2295:                     SPACE(50) AS Instr4, SPACE(50) AS Instr5, SPACE(50) AS Instr6, ;
2296:                     SPACE(70) AS Instr7, SPACE(50) AS NrDigit, SPACE(17) AS NossoNum, ;
2297:                     SPACE(15) AS AgCodCed, SPACE(10) AS cTitulos, ;
2298:                     b.Ceps AS CepEmp, b.Endes AS EndEmp, b.Numeros AS NumEmp, ;
2299:                     b.Bairs AS BaiEmp, b.Cidas AS CidEmp, b.Estas AS EstaEmp, ;
2300:                     b.Cgcs AS CpfEmp, b.compls AS compEmp, ;
2301:                     loc_cTpCtBol AS TpCtBols, loc_cTpCtArq AS TpCtArqs, ;
2302:                     SPACE(2) AS carteira ;
2303:                 FROM cursor_4c_Filtro2 a, cursor_4c_Empresa b ;
2304:                 INTO CURSOR cursor_4c_Filtro2 READWRITE
2305: 
2306:             SELECT cursor_4c_Filtro2
2307:             GO TOP
2308: 
2309:             lcPri  = PADL(IIF(EMPTY(ALLTRIM(cursor_4c_Convenio.instrus)), "00", cursor_4c_Convenio.instrus), 2, "0")
2310:             lcprot = IIF(THIS.pgf_4c_Principal.Page2.spn_4c_Dias.Value = 0, 5, ;
2311:                          THIS.pgf_4c_Principal.Page2.spn_4c_Dias.Value)
2312:             lcprot = IIF(lcPri = "00", "00", PADL(ALLTRIM(STR(lcprot)), 2, "0"))
2313:             lnMor  = IIF(EMPTY(cursor_4c_Convenio.moras), 0.23, cursor_4c_Convenio.moras)
2314: 
2315:             SCAN
2316:                 loc_nNumeDs = 0
2317:                 IF par_lReimp
2318:                     *-- Busca numeds atual do SigPcOoL para reimpressao
2319:                     loc_cSQL = "SELECT TOP 1 numeds FROM SigPcOoL " + ;
2320:                                "WHERE processos = 'CNAB' " + ;
2321:                                "AND dopeds = " + EscaparSQL(ALLTRIM(cursor_4c_Filtro2.titulos)) + ;
2322:                                " ORDER BY datas DESC"
2323:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NumeDs") > 0 AND ;
2324:                        USED("cursor_4c_NumeDs") AND RECCOUNT("cursor_4c_NumeDs") > 0
2325:                         SELECT cursor_4c_NumeDs
2326:                         loc_nNumeDs = NVL(cursor_4c_NumeDs.numeds, 0)
2327:                         IF USED("cursor_4c_NumeDs")
2328:                             USE IN cursor_4c_NumeDs
2329:                         ENDIF
2330:                     ENDIF
2331:                     SELECT cursor_4c_Filtro2
2332:                     REPLACE SeqNums WITH PADL(ALLTRIM(STR(loc_nNumeDs)), 5, "0") IN cursor_4c_Filtro2
2333:                 ENDIF
2334: 
2335:                 IF loc_cBancoNr = "001"
2336:                     lcNossoNum = lcCdC + PADL(cursor_4c_Filtro2.SeqNums, 10, "0")
2337:                     lcFator    = PADL(ALLTRIM(STR(1000 + (TTOD(cursor_4c_Filtro2.vencs) - CTOD("03/07/2000")))), 4, "0")
2338:                     lcValor    = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 8, 2), ",.", "")), 10, "0")
2339:                     lcBarra    = "0019" + lcFator + lcValor + "000000" + lcNossoNum + "17"
2340:                     lcDV       = fCalcMod11BB(lcBarra, loc_cBancoNr)
2341: 
2342:                     lcNossoNum = lcCdC + PADL(cursor_4c_Filtro2.SeqNums, 10, "0")
2343:                     lcBarra    = "0019" + lcDV + lcFator + lcValor + "000000" + lcNossoNum + "17"
2344:                     REPLACE nBarras WITH lcBarra IN cursor_4c_Filtro2
2345: 
2346:                     lcArqBMP = "img_barra_" + PADL(cursor_4c_Filtro2.SeqNums, 10, "0") + ".bmp"
2347:                     fGerBar2de5(SYS(2023) + "\" + lcArqBMP, lcBarra)
2348:                     REPLACE ImgBarra WITH lcArqBMP IN cursor_4c_Filtro2
2349: 
2350:                     lcCampo1  = "001900000"
2351:                     lcDv1     = fCalcMod10(lcCampo1)
2352:                     lcCampo2  = SUBSTR(lcBarra, 25, 10)
2353:                     lcDv2     = fCalcMod10(lcCampo2)
2354:                     lcCampo3  = SUBSTR(lcBarra, 35, 10)
2355:                     lcDv3     = fCalcMod10(lcCampo3)
2356:                     lcNrDigit = lcCampo1 + lcDv1 + lcCampo2 + lcDv2 + lcCampo3 + lcDv3 + lcDV + lcFator + lcValor
2357:                     REPLACE NrDigit WITH lcNrDigit IN cursor_4c_Filtro2
2358:                     REPLACE AgCodCed WITH LEFT(ALLTRIM(cursor_4c_Convenio.nagencias), 4) + "-" + ;
2359:                             RIGHT(ALLTRIM(cursor_4c_Convenio.nagencias), 1) + "/" + ;
2360:                             ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")) + "-" + ;
2361:                             PADL(cursor_4c_Convenio.digiagen, 1, "0") IN cursor_4c_Filtro2
2362: 
2363:                     IF cursor_4c_Convenio.bcoimprime = 1
2364:                         REPLACE Instr3 WITH "COBRAR MULTA DE 2% AO M" + CHR(202) + "S AP" + CHR(211) + ;
2365:                                 "S 1 DIA DE VENCIMENTO " IN cursor_4c_Filtro2
2366:                     ENDIF
2367:                 ENDIF
2368: 
2369:                 IF loc_cBancoNr = "033"
2370:                     lcNossoNum = PADL(cursor_4c_Filtro2.SeqNums, 12, "0")
2371:                     lcDV       = fCalcMod11BB(lcNossoNum, loc_cBancoNr)
2372:                     lcNossoNum = lcNossoNum + lcDV
2373: 
2374:                     lcFator = PADL(ALLTRIM(STR((TTOD(cursor_4c_Filtro2.vencs) - CTOD("07/10/1997")))), 4, "0")
2375:                     lcValor = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 8, 2), ",.", "")), 10, "0")
2376:                     lcBarra = "0339" + lcFator + lcValor + "9" + lcCdC + lcNossoNum + "0" + "101"
2377:                     lcDV    = fCalcMod11BB(lcBarra, loc_cBancoNr, "DVB")
2378: 
2379:                     lcBarra = "0339" + lcDV + lcFator + lcValor + "9" + lcCdC + lcNossoNum + "0" + "101"
2380:                     REPLACE nBarras WITH lcBarra IN cursor_4c_Filtro2
2381: 
2382:                     lcArqBMP = "img_barra_" + PADL(cursor_4c_Filtro2.SeqNums, 12, "0") + ".bmp"
2383:                     fGerBar2de5(SYS(2023) + "\" + lcArqBMP, lcBarra)
2384:                     REPLACE ImgBarra WITH lcArqBMP IN cursor_4c_Filtro2
2385: 
2386:                     lcCampo1  = "03399" + SUBSTR(lcCdC, 1, 4)
2387:                     lcDv1     = fCalcMod10(lcCampo1)
2388:                     lcCampo2  = SUBSTR(lcBarra, 25, 10)
2389:                     lcDv2     = fCalcMod10(lcCampo2)
2390:                     lcCampo3  = SUBSTR(lcBarra, 35, 10)
2391:                     lcDv3     = fCalcMod10(lcCampo3)
2392:                     lcNrDigit = lcCampo1 + lcDv1 + lcCampo2 + lcDv2 + lcCampo3 + lcDv3 + lcDV + lcFator + lcValor
2393:                     REPLACE NrDigit WITH ALLTRIM(lcNrDigit) IN cursor_4c_Filtro2
2394:                     REPLACE AgCodCed WITH ALLTRIM(cursor_4c_Convenio.nagencias) + "/" + lcCdC IN cursor_4c_Filtro2
2395:                     REPLACE Instr3 WITH "COBRAR 1% DE MULTA A PARTIR DE " + ;
2396:                             DTOC(TTOD(cursor_4c_Filtro2.vencs) + 6) IN cursor_4c_Filtro2
2397:                 ENDIF
2398: 
2399:                 IF loc_cBancoNr = "237"
2400:                     IF par_lReimp
2401:                         REPLACE SeqNums WITH PADL(ALLTRIM(TRANSFORM(loc_nNumeDs, "@R 99999999999")), 11, "0") ;
2402:                             IN cursor_4c_Filtro2
2403:                     ENDIF
2404:                     lcFator = PADL(ALLTRIM(STR((TTOD(cursor_4c_Filtro2.vencs) - CTOD("07/10/1997")))), 4, "0")
2405:                     lcValor = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 8, 2), ",.", "")), 10, "0")
2406:                     lcAg    = PADL(LEFT(ALLTRIM(cursor_4c_Convenio.nagencias), 4), 4, "0")
2407:                     lcCar   = PADL(ALLTRIM(cursor_4c_Convenio.tpctbols), 2, "0")
2408:                     lcCta   = PADL(ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")), 7, "0")
2409:                     lcDig   = ALLTRIM(cursor_4c_Convenio.digiagen)
2410:                     lcNossoNum = PADL(cursor_4c_Filtro2.SeqNums, 11, "0")
2411:                     lcDV       = fCalcMod11B7(lcCar + lcNossoNum)
2412:                     lcNossoNum = lcNossoNum + lcDV
2413: 
2414:                     lcLivre = lcAg + lcCar + SUBSTR(lcNossoNum, 1, 11) + lcCta + "0"
2415:                     lcBarra = "2379" + lcFator + lcValor + lcLivre
2416:                     lcDV    = fCalcMod11BB(lcBarra, loc_cBancoNr, "DVB")
2417: 
2418:                     lcBarra = "2379" + lcDV + lcFator + lcValor + lcLivre
2419:                     REPLACE nBarras WITH lcBarra IN cursor_4c_Filtro2
2420: 
2421:                     lcArqBMP = "img_barra_" + PADL(cursor_4c_Filtro2.SeqNums, 11, "0") + ".bmp"
2422:                     fGerBar2de5(SYS(2023) + "\" + lcArqBMP, lcBarra)
2423:                     REPLACE ImgBarra WITH lcArqBMP IN cursor_4c_Filtro2
2424: 
2425:                     lcCampo1  = "2379" + SUBSTR(lcLivre, 1, 5)
2426:                     lcDv1     = fCalcMod10(lcCampo1)
2427:                     lcCampo2  = SUBSTR(lcLivre, 6, 10)
2428:                     lcDv2     = fCalcMod10(lcCampo2)
2429:                     lcCampo3  = SUBSTR(lcLivre, 16, 10)
2430:                     lcDv3     = fCalcMod10(lcCampo3)
2431:                     lcNrDigit = lcCampo1 + lcDv1 + lcCampo2 + lcDv2 + lcCampo3 + lcDv3 + lcDV + lcFator + lcValor
2432:                     REPLACE NrDigit WITH lcNrDigit IN cursor_4c_Filtro2
2433:                     REPLACE AgCodCed WITH ALLTRIM(cursor_4c_Convenio.nagencias) + "/" + lcCta + "-" + lcDig ;
2434:                         IN cursor_4c_Filtro2
2435:                     REPLACE carteira WITH lcCar IN cursor_4c_Filtro2
2436:                 ENDIF
2437: 
2438:                 REPLACE NossoNum   WITH lcNossoNum, ;
2439:                         cTitulos   WITH PADL(CHRTRAN(cursor_4c_Filtro2.titulos, "/", ""), 8, "0") ;
2440:                     IN cursor_4c_Filtro2
2441: 
2442:                 lcMora = STR(ROUND((cursor_4c_Filtro2.valos * lnMor) / 100, 2), 8, 2)
2443:                 lcInt1 = "AP" + CHR(211) + "S VENCIMENTO, COBRAR JUROS DE R$" + ALLTRIM(lcMora) + " AO DIA."
2444:                 lcInt2 = "PROTESTAR NO " + lcprot + CHR(186) + " DIA " + CHR(218) + "TIL AP" + CHR(211) + "S O VENCIMENTO."
2445:                 lcInt7 = IIF(loc_cBancoNr = "237", ;
2446:                              "Pag" + CHR(225) + "vel preferencialmente na Rede Bradesco ou Bradesco Expresso", ;
2447:                              "PAG" + CHR(193) + "VEL EM QUALQUER BANCO AT" + CHR(201) + " O VENCIMENTO")
2448: 
2449:                 IF cursor_4c_Convenio.bcoimprime = 1
2450:                     lcInt2 = ""
2451:                 ENDIF
2452: 
2453:                 LOCAL lcNomeCliTmp
2454:                 lcNomeCliTmp = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 37)
2455:                 lcNomeCliTmp = PADR(CHRTRAN(lcNomeCliTmp, "/.-,", ""), 37)
2456:                 REPLACE NomeCli WITH lcNomeCliTmp IN cursor_4c_Filtro2
2457: 
2458:                 IF !EMPTY(cursor_4c_Filtro2.endcobs) AND !EMPTY(cursor_4c_Filtro2.cepcobs) AND ;
2459:                    !EMPTY(cursor_4c_Filtro2.estcobs) AND !EMPTY(cursor_4c_Filtro2.baicobs) AND ;
2460:                    !EMPTY(cursor_4c_Filtro2.cidcobs)
2461:                     REPLACE endes WITH ALLTRIM(cursor_4c_Filtro2.endcobs), ;
2462:                             bairs WITH cursor_4c_Filtro2.baicobs, ;
2463:                             ceps  WITH cursor_4c_Filtro2.cepcobs, ;
2464:                             cidas WITH cursor_4c_Filtro2.cidcobs, ;
2465:                             estas WITH cursor_4c_Filtro2.estcobs ;
2466:                         IN cursor_4c_Filtro2
2467:                 ENDIF
2468: 
2469:                 REPLACE Instr1 WITH lcInt1, Instr2 WITH lcInt2, Instr7 WITH lcInt7 ;
2470:                     IN cursor_4c_Filtro2
2471:             ENDSCAN
2472: 
2473:             SELECT cursor_4c_Filtro2
2474:             GO TOP
2475: 
2476:             DO CASE
2477:                 CASE loc_cBancoNr = "001"
2478:                     THIS.ExecutarReportForm("BloquetoBB2", "PREVIEW", "cursor_4c_Filtro2")
2479: 
2480:                 CASE loc_cBancoNr = "033"
2481:                     THIS.ExecutarReportForm("BloquetoSt", "PREVIEW", "cursor_4c_Filtro2")
2482: 
2483:                 CASE loc_cBancoNr = "237"
2484:                     THIS.ExecutarReportForm("BloquetoBra", "PREVIEW", "cursor_4c_Filtro2")
2485:             ENDCASE
2486: 
2487:             *-- Limpa imagens de barra geradas
2488:             SELECT cursor_4c_Filtro2
2489:             SCAN
2490:                 lcArqBMP = SYS(2023) + "\img_barra_" + PADL(cursor_4c_Filtro2.SeqNums, 10, "0") + ".bmp"
2491:                 IF FILE(lcArqBMP)
2492:                     ERASE &lcArqBMP
2493:                 ENDIF
2494:             ENDSCAN
2495: 
2496:             loc_lSucesso = .T.
2497:             ENDIF
2498:         CATCH TO loc_oErro
2499:             MsgErro(loc_oErro.Message, "Erro ImpBoleto")
2500:         ENDTRY
2501: 
2502:         RETURN loc_lSucesso
2503:     ENDPROC
2504: 
2505:     *==========================================================================

*-- Linhas 2530 a 2567:
2530:     * BtnVisualizarClick - Visualiza relatorio dos titulos selecionados
2531:     *==========================================================================
2532:     PROCEDURE BtnVisualizarClick()
2533:         LOCAL loc_oErro
2534:         TRY
2535:             IF !USED("cursor_4c_Filtro") OR RECCOUNT("cursor_4c_Filtro") = 0
2536:                 MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o dispon" + CHR(237) + ;
2537:                          "vel. Execute o processamento primeiro.")
2538:             ELSE
2539:                 THIS.ClickRelatorio()
2540:             ENDIF
2541:         CATCH TO loc_oErro
2542:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
2543:         ENDTRY
2544:     ENDPROC
2545: 
2546:     *==========================================================================
2547:     * BtnExcluirClick - Desmarca todos os titulos
2548:     *==========================================================================
2549:     PROCEDURE BtnExcluirClick()
2550:         LOCAL loc_oErro
2551:         TRY
2552:             IF !USED("cursor_4c_Filtro") OR RECCOUNT("cursor_4c_Filtro") = 0
2553:                 MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o para desmarcar.")
2554:             ELSE
2555:                 IF MsgConfirma("Desmarcar todos os t" + CHR(237) + "tulos selecionados?")
2556:                     THIS.ClickDesmarcarTitulos()
2557:                 ENDIF
2558:             ENDIF
2559:         CATCH TO loc_oErro
2560:             MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
2561:         ENDTRY
2562:     ENDPROC
2563: 
2564:     *==========================================================================
2565:     * CarregarLista - Carrega dados iniciais (operacoes SigCdOpe)
2566:     *==========================================================================
2567:     PROCEDURE CarregarLista()

*-- Linhas 2655 a 2688:
2655:         loc_oP1.txt_4c_TitBan.Value       = ""
2656: 
2657:         IF USED("cursor_4c_Operacoes")
2658:             SELECT cursor_4c_Operacoes
2659:             REPLACE ALL marca WITH .F.
2660:             GO TOP
2661:             loc_oP1.grd_4c_Operacoes.Refresh()
2662:         ENDIF
2663: 
2664:         loc_oP1.txt_4c_CdEmpresa.SetFocus()
2665:     ENDPROC
2666: 
2667:     *==========================================================================
2668:     * AjustarBotoesPorModo - Habilita/desabilita botoes de acordo com dados
2669:     *==========================================================================
2670:     PROCEDURE AjustarBotoesPorModo()
2671:         LOCAL loc_oP1, loc_oP2, loc_lTemDados, loc_oErro
2672:         TRY
2673:             loc_lTemDados = USED("cursor_4c_Filtro") AND RECCOUNT("cursor_4c_Filtro") > 0
2674:             loc_oP1 = THIS.pgf_4c_Principal.Page1
2675:             loc_oP2 = THIS.pgf_4c_Principal.Page2
2676: 
2677:             loc_oP1.cgp_4c_Filtro.Command1.Enabled = .T.
2678:             loc_oP1.cgp_4c_Filtro.Command2.Enabled = .T.
2679: 
2680:             loc_oP2.cgp_4c_Acoes.Command1.Enabled = loc_lTemDados
2681:             loc_oP2.cgp_4c_Acoes.Command2.Enabled = loc_lTemDados
2682:             loc_oP2.cgp_4c_MarcaDados.Enabled     = loc_lTemDados
2683:         CATCH TO loc_oErro
2684:             MsgErro(loc_oErro.Message, "Erro AjustarBotoesPorModo")
2685:         ENDTRY
2686:     ENDPROC
2687: 
2688:     *==========================================================================

*-- Linhas 2788 a 2812:
2788:             USE IN cursor_4c_Operacoes
2789:         ENDIF
2790:         IF USED("cursor_4c_FormaPagto")
2791:             USE IN cursor_4c_FormaPagto
2792:         ENDIF
2793:         IF USED("cursor_4c_Filtro")
2794:             USE IN cursor_4c_Filtro
2795:         ENDIF
2796:         IF USED("cursor_4c_Filtro2")
2797:             USE IN cursor_4c_Filtro2
2798:         ENDIF
2799:         IF USED("cursor_4c_Empresa")
2800:             USE IN cursor_4c_Empresa
2801:         ENDIF
2802:         IF USED("cursor_4c_Convenio")
2803:             USE IN cursor_4c_Convenio
2804:         ENDIF
2805:         IF USED("cursor_4c_ClienteConta")
2806:             USE IN cursor_4c_ClienteConta
2807:         ENDIF
2808:         IF USED("cursor_4c_TitBan")
2809:             USE IN cursor_4c_TitBan
2810:         ENDIF
2811:         THIS.this_oBusinessObject = .NULL.
2812:         DODEFAULT()


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


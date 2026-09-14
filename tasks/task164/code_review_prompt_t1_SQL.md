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
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPERS, INFOS, VPAGS, TIPOS, ENDERRO, GRUCONTAS, EMPDOPNUMS, LCT085A087, PROCESSOS, DOPEDS, MSGMULTA, LCBARRA, LCT079A081, LCT140A142, LCQ019A033, LCQ034A073, LCQ074A113, LCQ114A128, LCQ129A136, LCQ137A151, LCQ152A153, LCQ154A154, LCB019A032, LCB033A062, SITUAS, PARCONTAS, VALPENDS, OPERS, EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPERS, INFOS, VPAGS, TIPOS, ENDERRO, GRUCONTAS, EMPDOPNUMS, LCT085A087, PROCESSOS, DOPEDS, MSGMULTA, LCBARRA, LCT079A081, LCT140A142, LCQ019A033, LCQ034A073, LCQ074A113, LCQ114A128, LCQ129A136, LCQ137A151, LCQ152A153, LCQ154A154, LCB019A032, LCB033A062, SITUAS, PARCONTAS, VALPENDS, OPERS, EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NAGENCIAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPERS, INFOS, VPAGS, TIPOS, ENDERRO, GRUCONTAS, EMPDOPNUMS, LCT085A087, PROCESSOS, DOPEDS, MSGMULTA, LCBARRA, LCT079A081, LCT140A142, LCQ019A033, LCQ034A073, LCQ074A113, LCQ114A128, LCQ129A136, LCQ137A151, LCQ152A153, LCQ154A154, LCB019A032, LCB033A062, SITUAS, PARCONTAS, VALPENDS, OPERS, EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONVENIOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPERS, INFOS, VPAGS, TIPOS, ENDERRO, GRUCONTAS, EMPDOPNUMS, LCT085A087, PROCESSOS, DOPEDS, MSGMULTA, LCBARRA, LCT079A081, LCT140A142, LCQ019A033, LCQ034A073, LCQ074A113, LCQ114A128, LCQ129A136, LCQ137A151, LCQ152A153, LCQ154A154, LCB019A032, LCB033A062, SITUAS, PARCONTAS, VALPENDS, OPERS, EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZSOCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPERS, INFOS, VPAGS, TIPOS, ENDERRO, GRUCONTAS, EMPDOPNUMS, LCT085A087, PROCESSOS, DOPEDS, MSGMULTA, LCBARRA, LCT079A081, LCT140A142, LCQ019A033, LCQ034A073, LCQ074A113, LCQ114A128, LCQ129A136, LCQ137A151, LCQ152A153, LCQ154A154, LCB019A032, LCB033A062, SITUAS, PARCONTAS, VALPENDS, OPERS, EMPS
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCNB.prg) - TRECHOS RELEVANTES PARA PASS SQL (2654 linhas total):

*-- Linhas 519 a 537:
519:             .FontName          = "Tahoma"
520:             .AllowHeaderSizing = .F.
521:             .AllowRowSizing    = .F.
522:             .DeleteMark        = .F.
523:             .GridLines         = 3
524:             .Height            = 344
525:             .Left              = 350
526:             .Panel             = 1
527:             .ScrollBars        = 2
528:             .SplitBar          = .F.
529:             .TabIndex          = 10
530:             .Top               = 232
531:             .Width             = 202
532:             .GridLineColor     = RGB(238,238,238)
533:             .Themes            = .F.
534:             .Column1.Width     = 18
535:             .Column1.Movable   = .F.
536:             .Column1.Resizable = .F.
537:             .Column1.Sparse    = .F.

*-- Linhas 685 a 703:
685:             .FontName          = "Tahoma"
686:             .AllowHeaderSizing = .F.
687:             .AllowRowSizing    = .F.
688:             .DeleteMark        = .F.
689:             .Height            = 401
690:             .Left              = 7
691:             .Panel             = 1
692:             .RecordMark        = .F.
693:             .ScrollBars        = 2
694:             .SplitBar          = .F.
695:             .TabIndex          = 1
696:             .Top               = 134
697:             .Width             = 981
698:             .GridLineColor     = RGB(238,238,238)
699:             .Themes            = .F.
700:             .Column1.Width     = 18
701:             .Column1.Movable   = .F.
702:             .Column1.Resizable = .F.
703:             .Column1.Sparse    = .F.

*-- Linhas 982 a 1001:
982:             loc_oGrd = THIS.pgf_4c_Principal.Page1.grd_4c_Operacoes
983:             loc_oGrd.ColumnCount = 2
984:             loc_oGrd.RecordSource          = "cursor_4c_Operacoes"
985:             loc_oGrd.Column1.ControlSource = "cursor_4c_Operacoes.marca"
986:             loc_oGrd.Column2.ControlSource = "cursor_4c_Operacoes.Dopes"
987:             loc_oGrd.Column1.Header1.Caption = ""
988:             loc_oGrd.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
989:             loc_oGrd.Column2.Header1.Alignment = 2
990:             loc_oGrd.Refresh()
991:         ENDIF
992: 
993:         *-- Pre-carrega formas de pagamento para lookup do Titulo Banco
994:         THIS.this_oBusinessObject.BuscarFormaPagamento()
995: 
996:         THIS.pgf_4c_Principal.Page1.txt_4c_CdEmpresa.SetFocus()
997:     ENDPROC
998: 
999:     *==========================================================================
1000:     * VALIDADORES DOS CAMPOS
1001:     *==========================================================================

*-- Linhas 1010 a 1053:
1010:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1011:             RETURN
1012:         ENDIF
1013:         loc_cSQL = "SELECT TOP 1 RazSocs FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCod)
1014:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmpV") >= 1 AND RECCOUNT("cursor_4c_EmpTmpV") > 0
1015:             SELECT cursor_4c_EmpTmpV
1016:             THIS.pgf_4c_Principal.Page1.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpTmpV.RazSocs)
1017:         ELSE
1018:             THIS.pgf_4c_Principal.Page1.txt_4c_CdEmpresa.Value = ""
1019:             THIS.pgf_4c_Principal.Page1.txt_4c_DsEmpresa.Value = ""
1020:             MsgAviso("Empresa inv" + CHR(225) + "lida.")
1021:         ENDIF
1022:         IF USED("cursor_4c_EmpTmpV")
1023:             USE IN cursor_4c_EmpTmpV
1024:         ENDIF
1025:     ENDPROC
1026: 
1027:     PROCEDURE ValidarDsEmpresa()
1028:         LOCAL loc_cDs, loc_cSQL
1029:         loc_cDs = ALLTRIM(THIS.pgf_4c_Principal.Page1.txt_4c_DsEmpresa.Value)
1030:         IF EMPTY(loc_cDs)
1031:             RETURN
1032:         ENDIF
1033:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1034:             RETURN
1035:         ENDIF
1036:         loc_cSQL = "SELECT TOP 1 Cemps, RazSocs FROM SigCdEmp WHERE RazSocs LIKE " + EscaparSQL(loc_cDs + "%")
1037:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmpV") >= 1 AND RECCOUNT("cursor_4c_EmpTmpV") > 0
1038:             SELECT cursor_4c_EmpTmpV
1039:             THIS.pgf_4c_Principal.Page1.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpTmpV.Cemps)
1040:             THIS.pgf_4c_Principal.Page1.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpTmpV.RazSocs)
1041:         ELSE
1042:             THIS.pgf_4c_Principal.Page1.txt_4c_CdEmpresa.Value = ""
1043:             THIS.pgf_4c_Principal.Page1.txt_4c_DsEmpresa.Value = ""
1044:         ENDIF
1045:         IF USED("cursor_4c_EmpTmpV")
1046:             USE IN cursor_4c_EmpTmpV
1047:         ENDIF
1048:     ENDPROC
1049: 
1050:     PROCEDURE ValidarCdConta()
1051:         LOCAL loc_cCod, loc_cGrupo, loc_llRet
1052:         loc_cCod = ALLTRIM(THIS.pgf_4c_Principal.Page1.txt_4c_CdConta.Value)
1053:         IF EMPTY(loc_cCod)

*-- Linhas 1097 a 1115:
1097:             RETURN
1098:         ENDIF
1099:         IF USED("cursor_4c_FormaPagto")
1100:             SELECT cursor_4c_FormaPagto
1101:             SEEK PADR(loc_cCod, 12) TAG FpagSgru
1102:             IF !FOUND("cursor_4c_FormaPagto")
1103:                 MsgAviso("T" + CHR(237) + "tulo Banco inv" + CHR(225) + "lido.")
1104:                 THIS.pgf_4c_Principal.Page1.txt_4c_TitBan.Value = ""
1105:             ENDIF
1106:         ENDIF
1107:     ENDPROC
1108: 
1109:     PROCEDURE ValidarDataf()
1110:         LOCAL loc_dDatf, loc_dDati
1111:         loc_dDatf = THIS.pgf_4c_Principal.Page1.txt_4c_Dataf.Value
1112:         loc_dDati = THIS.pgf_4c_Principal.Page1.txt_4c_Datai.Value
1113:         IF !EMPTY(loc_dDati) AND !EMPTY(loc_dDatf) AND loc_dDatf < loc_dDati
1114:             MsgAviso("Data Final Deve Ser Maior Que a Inicial!!!")
1115:             THIS.pgf_4c_Principal.Page1.txt_4c_Dataf.Value = {}

*-- Linhas 1183 a 1224:
1183:         loc_oBusca.mAddColuna("Cgcs",    "", "CNPJ")
1184:         loc_oBusca.Show()
1185:         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
1186:             SELECT cursor_4c_BuscaEmpresa
1187:             loc_oP1.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
1188:             loc_oP1.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.RazSocs)
1189:         ENDIF
1190:         IF USED("cursor_4c_BuscaEmpresa")
1191:             USE IN cursor_4c_BuscaEmpresa
1192:         ENDIF
1193:         loc_oBusca.Release()
1194:     ENDPROC
1195: 
1196:     PROCEDURE AbrirLookupConta()
1197:         LOCAL loc_oBusca, loc_oP1
1198:         loc_oP1 = THIS.pgf_4c_Principal.Page1
1199:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1200:             RETURN
1201:         ENDIF
1202:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1203:             "SigCdCli", "cursor_4c_BuscaConta", "IClis", ;
1204:             ALLTRIM(loc_oP1.txt_4c_CdConta.Value), "Buscar Conta Banc" + CHR(225) + "ria")
1205:         loc_oBusca.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
1206:         loc_oBusca.mAddColuna("Rclis",  "", "Descri" + CHR(231) + CHR(227) + "o")
1207:         loc_oBusca.Show()
1208:         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1209:             SELECT cursor_4c_BuscaConta
1210:             loc_oP1.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.IClis)
1211:             loc_oP1.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
1212:         ENDIF
1213:         IF USED("cursor_4c_BuscaConta")
1214:             USE IN cursor_4c_BuscaConta
1215:         ENDIF
1216:         loc_oBusca.Release()
1217:     ENDPROC
1218: 
1219:     PROCEDURE AbrirLookupTitBan()
1220:         LOCAL loc_oBusca, loc_oP1
1221:         loc_oP1 = THIS.pgf_4c_Principal.Page1
1222:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1223:             RETURN
1224:         ENDIF

*-- Linhas 1230 a 1248:
1230:         loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
1231:         loc_oBusca.Show()
1232:         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTitBan")
1233:             SELECT cursor_4c_BuscaTitBan
1234:             loc_oP1.txt_4c_TitBan.Value = PADR(ALLTRIM(cursor_4c_BuscaTitBan.Fpags), 12)
1235:         ENDIF
1236:         IF USED("cursor_4c_BuscaTitBan")
1237:             USE IN cursor_4c_BuscaTitBan
1238:         ENDIF
1239:         loc_oBusca.Release()
1240:     ENDPROC
1241: 
1242:     *==========================================================================
1243:     * HANDLERS DOS BOTOES
1244:     *==========================================================================
1245: 
1246:     PROCEDURE ClickProcessar()
1247:         LOCAL loc_cCdEmp, loc_dDati, loc_dDatf, loc_cCdConta, loc_nCont
1248: 

*-- Linhas 1269 a 1287:
1269: 
1270:         loc_nCont = 0
1271:         IF USED("cursor_4c_Operacoes")
1272:             SELECT cursor_4c_Operacoes
1273:             SCAN
1274:                 IF cursor_4c_Operacoes.marca
1275:                     loc_nCont = loc_nCont + 1
1276:                 ENDIF
1277:             ENDSCAN
1278:         ENDIF
1279:         IF loc_nCont = 0
1280:             MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o foi selecionada")
1281:             RETURN
1282:         ENDIF
1283: 
1284:         THIS.Processamento()
1285:     ENDPROC
1286: 
1287:     PROCEDURE ClickEncerrarFiltro()

*-- Linhas 1307 a 1352:
1307: 
1308:     PROCEDURE ClickMarcarOpe()
1309:         IF USED("cursor_4c_Operacoes")
1310:             SELECT cursor_4c_Operacoes
1311:             REPLACE ALL marca WITH .T.
1312:             GO TOP
1313:             THIS.pgf_4c_Principal.Page1.grd_4c_Operacoes.Refresh()
1314:         ENDIF
1315:     ENDPROC
1316: 
1317:     PROCEDURE ClickDesmarcarOpe()
1318:         IF USED("cursor_4c_Operacoes")
1319:             SELECT cursor_4c_Operacoes
1320:             REPLACE ALL marca WITH .F.
1321:             GO TOP
1322:             THIS.pgf_4c_Principal.Page1.grd_4c_Operacoes.Refresh()
1323:         ENDIF
1324:     ENDPROC
1325: 
1326:     PROCEDURE ClickMarcarTitulos()
1327:         IF USED("cursor_4c_Filtro")
1328:             SELECT cursor_4c_Filtro
1329:             REPLACE ALL marca WITH .T.
1330:             GO TOP
1331:             THIS.pgf_4c_Principal.Page2.grd_4c_Dados.Refresh()
1332:         ENDIF
1333:     ENDPROC
1334: 
1335:     PROCEDURE ClickDesmarcarTitulos()
1336:         IF USED("cursor_4c_Filtro")
1337:             SELECT cursor_4c_Filtro
1338:             REPLACE ALL marca WITH .F.
1339:             GO TOP
1340:             THIS.pgf_4c_Principal.Page2.grd_4c_Dados.Refresh()
1341:         ENDIF
1342:     ENDPROC
1343: 
1344:     *==========================================================================
1345:     * Processamento - Executa busca de titulos e muda para page2
1346:     *==========================================================================
1347:     PROCEDURE Processamento()
1348:         LOCAL loc_oP1, loc_oP2, loc_oGrd, loc_oBO
1349:         LOCAL loc_cCdEmp, loc_cCdConta, loc_dDati, loc_dDatf
1350:         LOCAL loc_lNaoProc, loc_nPeriodo, loc_cOpeIN
1351: 
1352:         loc_oP1  = THIS.pgf_4c_Principal.Page1

*-- Linhas 1364 a 1425:
1364:         *-- Monta clausula IN das operacoes marcadas
1365:         loc_cOpeIN = "("
1366:         IF USED("cursor_4c_Operacoes")
1367:             SELECT cursor_4c_Operacoes
1368:             SCAN
1369:                 IF cursor_4c_Operacoes.marca
1370:                     loc_cOpeIN = loc_cOpeIN + IIF(loc_cOpeIN == "(", "", ",") + ;
1371:                                  "'" + ALLTRIM(cursor_4c_Operacoes.Dopes) + "'"
1372:                 ENDIF
1373:             ENDSCAN
1374:         ENDIF
1375:         loc_cOpeIN = loc_cOpeIN + ")"
1376: 
1377:         *-- Limpa grid
1378:         loc_oGrd.RecordSource = ""
1379:         loc_oGrd.Refresh()
1380: 
1381:         IF !loc_oBO.BuscarTitulos(loc_cCdEmp, loc_dDati, loc_dDatf, ;
1382:                 IIF(loc_lNaoProc, 1, 2), loc_nPeriodo, loc_cOpeIN)
1383:             RETURN
1384:         ENDIF
1385: 
1386:         IF RECCOUNT("cursor_4c_Filtro") = 0
1387:             MsgAviso("Nenhum dado foi encontrado")
1388:             RETURN
1389:         ENDIF
1390: 
1391:         *-- Liga grid ao cursor
1392:         loc_oGrd.ColumnCount = 8
1393:         loc_oGrd.RecordSource          = "cursor_4c_Filtro"
1394:         loc_oGrd.Column1.ControlSource = "cursor_4c_Filtro.marca"
1395:         loc_oGrd.Column2.ControlSource = "cursor_4c_Filtro.dopes"
1396:         loc_oGrd.Column3.ControlSource = "cursor_4c_Filtro.numes"
1397:         loc_oGrd.Column4.ControlSource = "cursor_4c_Filtro.rclis"
1398:         loc_oGrd.Column5.ControlSource = "cursor_4c_Filtro.vencs"
1399:         loc_oGrd.Column6.ControlSource = "cursor_4c_Filtro.fpags"
1400:         loc_oGrd.Column7.ControlSource = "cursor_4c_Filtro.valos"
1401:         loc_oGrd.Column8.ControlSource = "cursor_4c_Filtro.titulos"
1402:         loc_oGrd.Column1.Header1.Caption = ""
1403:         loc_oGrd.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1404:         loc_oGrd.Column3.Header1.Caption = "C" + CHR(243) + "digo"
1405:         loc_oGrd.Column4.Header1.Caption = "Cliente"
1406:         loc_oGrd.Column5.Header1.Caption = "Vencimento"
1407:         loc_oGrd.Column6.Header1.Caption = "Forma Pagto"
1408:         loc_oGrd.Column7.Header1.Caption = "Valor"
1409:         loc_oGrd.Column8.Header1.Caption = "T" + CHR(237) + "tulo"
1410:         loc_oGrd.SetAll("DynamicForeColor", "IIF(cursor_4c_Filtro.EndErro=1,RGB(255,0,0),RGB(0,0,0))", "Column")
1411:         loc_oGrd.Refresh()
1412: 
1413:         *-- Habilita boleto apenas quando mostrando "Ja Processados"
1414:         loc_oP2.cgp_4c_Acoes.Command3.Enabled = !loc_lNaoProc
1415: 
1416:         *-- Ativa protestar dias
1417:         loc_oP2.lbl_4c_Protestar.Enabled = .T.
1418:         loc_oP2.spn_4c_Dias.Enabled = .T.
1419:         loc_oP2.lbl_4c_Dias.Enabled = .T.
1420: 
1421:         *-- Muda para page2
1422:         loc_oP1.Enabled = .F.
1423:         loc_oP2.Enabled = .T.
1424:         THIS.pgf_4c_Principal.ActivePage = 2
1425:     ENDPROC

*-- Linhas 1476 a 1499:
1476:         ENDIF
1477: 
1478:         IF par_cTipo = "A"
1479:             *-- Valida selecao de registros
1480:             loc_nCont = 0
1481:             IF USED("cursor_4c_Filtro")
1482:                 SELECT cursor_4c_Filtro
1483:                 SCAN
1484:                     IF cursor_4c_Filtro.marca
1485:                         loc_nCont = loc_nCont + 1
1486:                     ENDIF
1487:                 ENDSCAN
1488:             ENDIF
1489:             IF loc_nCont = 0
1490:                 MsgAviso("Nenhum registro foi selecionado")
1491:                 RETURN
1492:             ENDIF
1493: 
1494:             *-- Confirma geracao
1495:             IF !EMPTY(ALLTRIM(loc_cTitBan))
1496:                 IF !MsgConfirma("Confirma gera" + CHR(231) + CHR(227) + "o do arquivo de remessa?")
1497:                     RETURN
1498:                 ENDIF
1499:             ELSE

*-- Linhas 1545 a 1579:
1545:                     MsgAviso("Banco " + CHR(34) + ALLTRIM(loc_oBO.this_cBancoNr) + CHR(34) + ;
1546:                              " n" + CHR(227) + "o suportado para gera" + CHR(231) + CHR(227) + "o CNAB.")
1547:             ENDCASE
1548: 
1549:         ELSE
1550:             *-- "V" ou "I": carrega convenio e cria cursor_4c_Filtro2 para relatorio/boleto
1551:             IF !loc_oBO.CarregarConvenio(loc_cCdConta)
1552:                 MsgAviso("Conv" + CHR(234) + "nio n" + CHR(227) + "o encontrado para a conta [" + ;
1553:                          loc_cCdConta + "].")
1554:                 RETURN
1555:             ENDIF
1556: 
1557:             IF USED("cursor_4c_Filtro2")
1558:                 USE IN cursor_4c_Filtro2
1559:             ENDIF
1560: 
1561:             SELECT *, SPACE(15) AS SeqNums FROM cursor_4c_Filtro WHERE marca ;
1562:                 INTO CURSOR cursor_4c_Filtro2 READWRITE
1563: 
1564:             SELECT cursor_4c_Filtro2
1565:             GO TOP
1566: 
1567:             IF par_cTipo = "V"
1568:                 REPORT FORM sigrecnb PREVIEW
1569:             ENDIF
1570:         ENDIF
1571:     ENDPROC
1572: 
1573:     *==========================================================================
1574:     * CnabBrasil - Gera arquivo CNAB 400 para Banco do Brasil (001)
1575:     *==========================================================================
1576:     PROTECTED PROCEDURE CnabBrasil()
1577:         LOCAL loc_oBO, loc_oP2
1578:         LOCAL lcTit, lcBanco, lcCnv, lcAge, lcbco, lcRaz, lcCgc, lctpcgc, lcrazbco
1579:         LOCAL lcDat, lnMor, lcPri, lcprot, lcCdC, lcTpCtArq, lcTpCtBol, lcEnv, lcArq

*-- Linhas 1611 a 1716:
1611:                  "001BANCO DO BRASIL" + lcDat + lcEnv + SPACE(22) + lcCdC + ;
1612:                  SPACE(258) + "000001" + CHR(13) + CHR(10)
1613:         lcStrg = fLimpaTexto(lcStrg)
1614:         STRTOFILE(lcStrg, lcArq, 0)
1615: 
1616:         IF USED("cursor_4c_Filtro2")
1617:             USE IN cursor_4c_Filtro2
1618:         ENDIF
1619:         SELECT *, SPACE(5) AS SeqNums FROM cursor_4c_Filtro WHERE marca ;
1620:             INTO CURSOR cursor_4c_Filtro2 READWRITE
1621: 
1622:         lnSeq = 2
1623:         SELECT cursor_4c_Filtro2
1624:         SCAN
1625:             lcSeqNum   = fGerUniqueKey("BBNOSSONUM")
1626:             lcSeq      = TRANSFORM(lnSeq, "@L 999999")
1627:             lcVenc     = SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 1, 2) + ;
1628:                          SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 4, 2) + ;
1629:                          SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 9, 2)
1630:             lcValor    = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 11, 2), ",.", "")), 13, "0")
1631:             lnMora     = ROUND((cursor_4c_Filtro2.valos * 0.23) / 100, 2)
1632:             lcMora     = PADL(ALLTRIM(CHRTRAN(STR(lnMora, 11, 2), ",.", "")), 13, "0")
1633:             lccgccli   = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-,", "")), 14, "0")
1634:             lctpcgccli = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-", ""))) = 11, "01", "02")
1635:             lcnome     = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 37)
1636:             lcnome     = PADR(CHRTRAN(lcnome, "/.-,", ""), 37)
1637:             IF EMPTY(cursor_4c_Filtro2.endcobs) OR EMPTY(cursor_4c_Filtro2.cepcobs) OR ;
1638:                EMPTY(cursor_4c_Filtro2.estcobs) OR EMPTY(cursor_4c_Filtro2.baicobs) OR ;
1639:                EMPTY(cursor_4c_Filtro2.cidcobs)
1640:                 lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endes) + " " + ;
1641:                               ALLTRIM(cursor_4c_Filtro2.nums) + " " + ;
1642:                               ALLTRIM(cursor_4c_Filtro2.compls), 40)
1643:                 lcbair = PADR(cursor_4c_Filtro2.bairs, 12)
1644:                 lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.ceps, ".-", "")), 8, "0")
1645:                 lccida = PADR(cursor_4c_Filtro2.cidas, 15)
1646:                 lcesta = PADR(cursor_4c_Filtro2.estas, 2)
1647:             ELSE
1648:                 lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endcobs), 40)
1649:                 lcbair = PADR(cursor_4c_Filtro2.baicobs, 12)
1650:                 lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cepcobs, ".-", "")), 8, "0")
1651:                 lccida = PADR(cursor_4c_Filtro2.cidcobs, 15)
1652:                 lcesta = PADR(cursor_4c_Filtro2.estcobs, 2)
1653:             ENDIF
1654:             lcende   = PADR(CHRTRAN(lcende, "/.-,", ""), 40)
1655:             lcnumtit = PADL(CHRTRAN(cursor_4c_Filtro2.titulos, "/", ""), 8, "0")
1656: 
1657:             lcStrg = "7" + lctpcgc + lcCgc + lcAge + lcbco + lcCdC + ;
1658:                      PADR(lcnumtit, 25) + lcCdC + PADL(lcSeqNum, 10, "0") + ;
1659:                      "00" + "00" + "   " + " " + "   " + lcTpCtBol + "0" + "000000" + "     " + ;
1660:                      lcTpCtArq + "01" + PADR(lcnumtit, 10) + lcVenc + lcValor + "001" + ;
1661:                      "0000" + " " + "01" + "N" + lcDat + lcPri + "00" + lcMora + ;
1662:                      "000000" + "0000000000000" + "0000000000000" + "0000000000000" + ;
1663:                      lctpcgccli + lccgccli + UPPER(lcnome) + "   " + UPPER(lcende) + ;
1664:                      UPPER(lcbair) + lccep + UPPER(lccida) + UPPER(lcesta) + ;
1665:                      SPACE(40) + "  " + " " + lcSeq + CHR(13) + CHR(10)
1666: 
1667:             lcStrg = fLimpaTexto(lcStrg)
1668:             STRTOFILE(lcStrg, lcArq, 1)
1669: 
1670:             REPLACE SeqNums WITH PADL(lcSeqNum, 5, "0") IN cursor_4c_Filtro2
1671: 
1672:             loc_oBO.InserirLinhaCNAB(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.emps, ;
1673:                 cursor_4c_Filtro2.dopes, cursor_4c_Filtro2.numes, ;
1674:                 lcStrg, cursor_4c_Filtro2.titulos, VAL(lcSeqNum))
1675: 
1676:             lnSeq = lnSeq + 1
1677:         ENDSCAN
1678: 
1679:         *-- Trailer
1680:         lcSeq  = TRANSFORM(lnSeq, "@L 999999")
1681:         lcStrg = "9" + SPACE(393) + lcSeq + CHR(13) + CHR(10)
1682:         STRTOFILE(lcStrg, lcArq, 1)
1683: 
1684:         IF FILE(lcArq)
1685:             lok = .T.
1686:             IF !loc_oBO.ConfirmarTransacao()
1687:                 loc_oBO.CancelarTransacao()
1688:                 lok = .F.
1689:             ENDIF
1690: 
1691:             IF lok
1692:                 SELECT cursor_4c_Filtro2
1693:                 SCAN
1694:                     llAtu = .T.
1695:                     lcTitBanAtual = loc_oBO.VerificarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers)
1696:                     IF !EMPTY(ALLTRIM(lcTitBanAtual))
1697:                         llAtu = MsgConfirma("T" + CHR(237) + "tulo " + CHR(34) + lcTitBanAtual + CHR(34) + ;
1698:                                             " j" + CHR(225) + " possui T" + CHR(237) + "tulo do Banco preenchido. Sobrescrever?")
1699:                     ENDIF
1700:                     IF llAtu
1701:                         loc_oBO.AtualizarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers, lcTit)
1702:                     ENDIF
1703:                 ENDSCAN
1704:             ENDIF
1705: 
1706:             IF lok
1707:                 MsgInfo("Arquivo " + CHR(34) + ALLTRIM(lcArq) + CHR(34) + " gerado com sucesso!")
1708:             ENDIF
1709: 
1710:             *-- BB auto-imprime boleto apos geracao
1711:             THIS.pgf_4c_Principal.Page2.cgp_4c_Acoes.Command3.Enabled = .T.
1712:             THIS.ImpBoleto(.F.)
1713:         ENDIF
1714:     ENDPROC
1715: 
1716:     *==========================================================================

*-- Linhas 1747 a 1845:
1747:                  lcAge + "00" + lcbco + SPACE(8) + lcRaz + "341" + ;
1748:                  lcrazbco + lcDat + SPACE(294) + "000001" + CHR(13) + CHR(10)
1749:         lcStrg = fLimpaTexto(lcStrg)
1750:         STRTOFILE(lcStrg, lcarq, 0)
1751: 
1752:         IF USED("cursor_4c_Filtro2")
1753:             USE IN cursor_4c_Filtro2
1754:         ENDIF
1755:         SELECT * FROM cursor_4c_Filtro WHERE marca INTO CURSOR cursor_4c_Filtro2 READWRITE
1756: 
1757:         lnSeq = 2
1758:         SELECT cursor_4c_Filtro2
1759:         SCAN
1760:             lcSeq      = TRANSFORM(lnSeq, "@L 999999")
1761:             lcnumes    = TRANSFORM(cursor_4c_Filtro2.numes, "@L 9999999999")
1762:             lcVenc     = SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 1, 2) + ;
1763:                          SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 4, 2) + ;
1764:                          SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 9, 2)
1765:             lcValor    = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 11, 2), ",.", "")), 13, "0")
1766:             lccgccli   = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-,", "")), 14, "0")
1767:             lctpcgcCli = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-", ""))) = 11, "01", "02")
1768:             lcnome     = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 30)
1769:             IF EMPTY(cursor_4c_Filtro2.endcobs) OR EMPTY(cursor_4c_Filtro2.cepcobs) OR ;
1770:                EMPTY(cursor_4c_Filtro2.estcobs) OR EMPTY(cursor_4c_Filtro2.baicobs) OR ;
1771:                EMPTY(cursor_4c_Filtro2.cidcobs)
1772:                 lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endes) + "," + cursor_4c_Filtro2.nums, 40)
1773:                 lcbair = PADR(cursor_4c_Filtro2.bairs, 12)
1774:                 lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.ceps, ".-", "")), 8, "0")
1775:                 lccida = PADR(cursor_4c_Filtro2.cidas, 15)
1776:                 lcesta = PADR(cursor_4c_Filtro2.estas, 2)
1777:             ELSE
1778:                 lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endcobs), 40)
1779:                 lcbair = PADR(cursor_4c_Filtro2.baicobs, 12)
1780:                 lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cepcobs, ".-", "")), 8, "0")
1781:                 lccida = PADR(cursor_4c_Filtro2.cidcobs, 15)
1782:                 lcesta = PADR(cursor_4c_Filtro2.estcobs, 2)
1783:             ENDIF
1784:             lcnumtit = PADL(STRTRAN(cursor_4c_Filtro2.titulos, "/", ""), 8, "0")
1785: 
1786:             lcStrg = "1" + lctpcgcCli + lcCgc + lcAge + "00" + lcbco + SPACE(4) + ;
1787:                      "0000" + PADR(lcnumtit, 25) + lcnumtit + ;
1788:                      "0000000000000" + "112" + SPACE(21) + "I" + "01" + ;
1789:                      PADR(lcnumtit, 10) + lcVenc + lcValor + "341" + "00000" + ;
1790:                      "01" + "A" + lcDat + "81" + "19" + "0000000000000" + ;
1791:                      "000000" + "0000000000000" + "0000000000000" + "0000000000000" + ;
1792:                      lctpcgcCli + lccgccli + lcnome + SPACE(10) + ;
1793:                      lcende + lcbair + lccep + lccida + lcesta + ;
1794:                      SPACE(30) + SPACE(4) + "000000" + lcprot + SPACE(1) + ;
1795:                      lcSeq + CHR(13) + CHR(10)
1796: 
1797:             lcStrg = fLimpaTexto(lcStrg)
1798:             STRTOFILE(lcStrg, lcarq, 1)
1799: 
1800:             *-- Itau nao usa numeds (par_nNumeDs=0)
1801:             loc_oBO.InserirLinhaCNAB(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.emps, ;
1802:                 cursor_4c_Filtro2.dopes, cursor_4c_Filtro2.numes, ;
1803:                 lcStrg, cursor_4c_Filtro2.titulos, 0)
1804: 
1805:             lnSeq = lnSeq + 1
1806:         ENDSCAN
1807: 
1808:         *-- Trailer
1809:         lcSeq  = TRANSFORM(lnSeq, "@L 999999")
1810:         lcStrg = "9" + SPACE(393) + lcSeq + CHR(13) + CHR(10)
1811:         STRTOFILE(lcStrg, lcarq, 1)
1812: 
1813:         IF FILE(lcarq)
1814:             lok = .T.
1815:             IF !loc_oBO.ConfirmarTransacao()
1816:                 loc_oBO.CancelarTransacao()
1817:                 lok = .F.
1818:             ENDIF
1819: 
1820:             IF lok
1821:                 SELECT cursor_4c_Filtro2
1822:                 SCAN
1823:                     llAtu = .T.
1824:                     lcTitBanAtual = loc_oBO.VerificarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers)
1825:                     IF !EMPTY(ALLTRIM(lcTitBanAtual))
1826:                         llAtu = MsgConfirma("T" + CHR(237) + "tulo " + CHR(34) + lcTitBanAtual + CHR(34) + ;
1827:                                             " j" + CHR(225) + " possui T" + CHR(237) + "tulo do Banco. Sobrescrever?")
1828:                     ENDIF
1829:                     IF llAtu
1830:                         loc_oBO.AtualizarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers, lcTit)
1831:                     ENDIF
1832:                 ENDSCAN
1833:             ENDIF
1834: 
1835:             IF lok
1836:                 MsgInfo("Arquivo " + CHR(34) + ALLTRIM(lcarq) + CHR(34) + " gerado com sucesso!")
1837:             ENDIF
1838:         ENDIF
1839:     ENDPROC
1840: 
1841:     *==========================================================================
1842:     * CnabBradesco - Gera arquivo CNAB 400 para Bradesco (237)
1843:     *==========================================================================
1844:     PROTECTED PROCEDURE CnabBradesco()
1845:         LOCAL loc_oBO, loc_oP2

*-- Linhas 1881 a 1984:
1881:                  lcRaz + lcBcn + lcRbc + lcDat + SPACE(8) + "MX" + ;
1882:                  lcEnv + SPACE(277) + "000001" + CHR(13) + CHR(10)
1883:         lcStrg = fLimpaTexto(lcStrg)
1884:         STRTOFILE(lcStrg, lcArq, 0)
1885: 
1886:         IF USED("cursor_4c_Filtro2")
1887:             USE IN cursor_4c_Filtro2
1888:         ENDIF
1889:         SELECT *, SPACE(11) AS SeqNums FROM cursor_4c_Filtro WHERE marca ;
1890:             INTO CURSOR cursor_4c_Filtro2 READWRITE
1891: 
1892:         lnSeq = 2
1893:         SELECT cursor_4c_Filtro2
1894:         SCAN
1895:             lcSeqNum  = fGerUniqueKey("BRNOSSONUM")
1896:             REPLACE SeqNums WITH PADL(lcSeqNum, 11, "0") IN cursor_4c_Filtro2
1897: 
1898:             lcSeq  = TRANSFORM(lnSeq, "@L 999999")
1899:             lcVenc = SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 1, 2) + ;
1900:                      SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 4, 2) + ;
1901:                      SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 9, 2)
1902:             lcVal  = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 11, 2), ",.", "")), 13, "0")
1903:             lcMor  = PADL(ALLTRIM(CHRTRAN(STR(ROUND((cursor_4c_Filtro2.valos * lnMor) / 100, 2), 11, 2), ",.", "")), 13, "0")
1904:             lcCpf  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-,", "")), 14, "0")
1905:             lcTpC  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-", ""))) = 11, "01", "02")
1906:             lcNom  = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 40)
1907:             lcNom  = PADR(CHRTRAN(lcNom, "/.-,", ""), 40)
1908:             IF EMPTY(cursor_4c_Filtro2.EndCobs) OR EMPTY(cursor_4c_Filtro2.CepCobs)
1909:                 lcEnd = PADR(ALLTRIM(cursor_4c_Filtro2.endes) + " " + cursor_4c_Filtro2.nums, 40)
1910:                 lcCep = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.ceps, ".-", "")), 8, "0")
1911:             ELSE
1912:                 lcEnd = PADR(ALLTRIM(cursor_4c_Filtro2.EndCobs), 40)
1913:                 lcCep = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.CepCobs, ".-", "")), 8, "0")
1914:             ENDIF
1915:             lcEnd = PADR(CHRTRAN(lcEnd, "/.-,", ""), 40)
1916:             lcNtt = PADL(STRTRAN(cursor_4c_Filtro2.titulos, "/", ""), 8, "0")
1917: 
1918:             lcNossoNum = "00000000000"
1919:             lcDV = "0"
1920:             IF lcBol = "2"
1921:                 lcNossoNum = PADL(cursor_4c_Filtro2.SeqNums, 11, "0")
1922:                 lcDV = fCalcMod11B7(lcCar + lcNossoNum)
1923:             ENDIF
1924: 
1925:             lcStrg = "1" + SPACE(5) + SPACE(1) + SPACE(5) + SPACE(7) + SPACE(1) + ;
1926:                      "0" + lcCnv + lcAge + lcBco + ;
1927:                      PADR(lcNtt, 25) + "   " + "2" + "0200" + ;
1928:                      lcNossoNum + lcDV + "0000000000" + ;
1929:                      lcBol + " " + SPACE(10) + " " + "2" + "  " + ;
1930:                      "01" + PADR(lcNtt, 10) + lcVenc + lcVal + ;
1931:                      "000" + "00000" + "01" + "N" + lcDat + ;
1932:                      lcPri + lcPrt + lcMor + "000000" + ;
1933:                      "0000000000000" + "0000000000000" + "0000000000000" + ;
1934:                      lcTpC + lcCpf + lcNom + lcEnd + ;
1935:                      SPACE(12) + lcCep + SPACE(60) + lcSeq + CHR(13) + CHR(10)
1936: 
1937:             lcStrg = fLimpaTexto(lcStrg)
1938:             STRTOFILE(lcStrg, lcArq, 1)
1939: 
1940:             loc_oBO.InserirLinhaCNAB(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.emps, ;
1941:                 cursor_4c_Filtro2.dopes, cursor_4c_Filtro2.numes, ;
1942:                 lcStrg, cursor_4c_Filtro2.titulos, VAL(lcSeqNum))
1943: 
1944:             lnSeq = lnSeq + 1
1945:         ENDSCAN
1946: 
1947:         *-- Trailer
1948:         lcSeq  = TRANSFORM(lnSeq, "@L 999999")
1949:         lcStrg = "9" + SPACE(393) + lcSeq + CHR(13) + CHR(10)
1950:         STRTOFILE(lcStrg, lcArq, 1)
1951: 
1952:         IF FILE(lcArq)
1953:             lok = .T.
1954:             IF !loc_oBO.ConfirmarTransacao()
1955:                 loc_oBO.CancelarTransacao()
1956:                 lok = .F.
1957:             ENDIF
1958: 
1959:             IF lok
1960:                 SELECT cursor_4c_Filtro2
1961:                 SCAN
1962:                     llAtu = .T.
1963:                     lcTitBanAtual = loc_oBO.VerificarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers)
1964:                     IF !EMPTY(ALLTRIM(lcTitBanAtual))
1965:                         llAtu = MsgConfirma("T" + CHR(237) + "tulo " + CHR(34) + lcTitBanAtual + CHR(34) + ;
1966:                                             " j" + CHR(225) + " possui T" + CHR(237) + "tulo do Banco. Sobrescrever?")
1967:                     ENDIF
1968:                     IF llAtu
1969:                         loc_oBO.AtualizarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers, lcTit)
1970:                     ENDIF
1971:                 ENDSCAN
1972:             ENDIF
1973: 
1974:             IF lok
1975:                 MsgInfo("Arquivo " + CHR(34) + ALLTRIM(lcArq) + CHR(34) + " gerado com sucesso!")
1976:             ENDIF
1977:         ENDIF
1978:     ENDPROC
1979: 
1980:     *==========================================================================
1981:     * CnabSantander240 - Gera arquivo CNAB 240 para Santander (033/353)
1982:     *==========================================================================
1983:     PROTECTED PROCEDURE CnabSantander240()
1984:         LOCAL loc_oBO, loc_oP2

*-- Linhas 2038 a 2095:
2038:                  lcRaz + SPACE(40) + SPACE(40) + lcEnv + lcDat + SPACE(41) + ;
2039:                  CHR(13) + CHR(10)
2040:         lcStrg = fLimpaTexto(lcStrg)
2041:         STRTOFILE(lcStrg, lcArq, 1)
2042: 
2043:         IF USED("cursor_4c_Filtro2")
2044:             USE IN cursor_4c_Filtro2
2045:         ENDIF
2046:         SELECT *, SPACE(5) AS SeqNums FROM cursor_4c_Filtro WHERE marca ;
2047:             INTO CURSOR cursor_4c_Filtro2 READWRITE
2048: 
2049:         lnSeqL = 0
2050:         SELECT cursor_4c_Filtro2
2051:         SCAN
2052:             lcnumes    = TRANSFORM(cursor_4c_Filtro2.numes, "@L 9999999999")
2053:             lcVenc     = SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 1, 2) + ;
2054:                          SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 4, 2) + ;
2055:                          SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 7, 4)
2056:             lcValor    = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 11, 2), ",.", "")), 15, "0")
2057:             lccgccli   = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-,", "")), 15, "0")
2058:             lctpcgcCli = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-", ""))) = 11, "1", "2")
2059:             lcnome     = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 40)
2060:             lnMora     = IIF(loc_oBO.this_nMoras = 0, 0.33, loc_oBO.this_nMoras)
2061:             lnMora     = ROUND((cursor_4c_Filtro2.valos * lnMora) / 100, 2)
2062:             lcMora     = PADL(ALLTRIM(CHRTRAN(STR(lnMora, 11, 2), ",.", "")), 15, "0")
2063:             IF EMPTY(cursor_4c_Filtro2.endcobs) OR EMPTY(cursor_4c_Filtro2.cepcobs) OR ;
2064:                EMPTY(cursor_4c_Filtro2.estcobs) OR EMPTY(cursor_4c_Filtro2.baicobs) OR ;
2065:                EMPTY(cursor_4c_Filtro2.cidcobs)
2066:                 lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endes) + "," + cursor_4c_Filtro2.nums, 40)
2067:                 lcbair = PADR(cursor_4c_Filtro2.bairs, 15)
2068:                 lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.ceps, ".-", "")), 8, "0")
2069:                 lccida = PADR(cursor_4c_Filtro2.cidas, 15)
2070:                 lcesta = PADR(cursor_4c_Filtro2.estas, 2)
2071:             ELSE
2072:                 lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endcobs), 40)
2073:                 lcbair = PADR(cursor_4c_Filtro2.baicobs, 15)
2074:                 lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cepcobs, ".-", "")), 8, "0")
2075:                 lccida = PADR(cursor_4c_Filtro2.cidcobs, 15)
2076:                 lcesta = PADR(cursor_4c_Filtro2.estcobs, 2)
2077:             ENDIF
2078: 
2079:             lcnumtit = PADL(ALLTRIM(STRTRAN(cursor_4c_Filtro2.titulos, "/", "")), 15, "0")
2080:             lcChave  = PADR(ALLTRIM(STRTRAN(cursor_4c_Filtro2.titulos, "/", "")), 15) + lcnumes
2081: 
2082:             lcSeqNum   = fGerUniqueKey("STNOSSONUM")
2083:             lcDV       = fCalcMod11BB(PADL(lcSeqNum, 7, "0"), loc_oBO.this_cBancoNr)
2084:             lcNossoNum = PADL(lcSeqNum, 12, "0") + lcDV
2085: 
2086:             *-- Detalhe P
2087:             lnSeqL = lnSeqL + 1
2088:             lcSeqL = TRANSFORM(lnSeqL, "@L 99999")
2089:             lnSeq  = lnSeq + 1
2090: 
2091:             lcStrg = "033" + lcLot + "3" + lcSeqL + "P" + SPACE(1) + "01" + ;
2092:                      lcAge + lcDigA + lcCta + lcDigC + lcCta + lcDigC + ;
2093:                      SPACE(2) + lcNossoNum + "5" + "1" + "1" + SPACE(1) + SPACE(1) + ;
2094:                      lcnumtit + lcVenc + lcValor + ;
2095:                      lcAge + lcDigA + SPACE(1) + "02" + "N" + lcDat + ;

*-- Linhas 2112 a 2136:
2112:                      "000" + "000" + "000" + "000" + SPACE(19) + ;
2113:                      CHR(13) + CHR(10)
2114:             lcStrg = fLimpaTexto(lcStrg)
2115:             STRTOFILE(lcStrg, lcArq, 1)
2116: 
2117:             REPLACE SeqNums WITH PADL(lcSeqNum, 5, "0") IN cursor_4c_Filtro2
2118: 
2119:             loc_oBO.InserirLinhaCNAB(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.emps, ;
2120:                 cursor_4c_Filtro2.dopes, cursor_4c_Filtro2.numes, ;
2121:                 lcStrg, cursor_4c_Filtro2.titulos, VAL(lcSeqNum))
2122:         ENDSCAN
2123: 
2124:         *-- Trailer do lote
2125:         lnSeq  = lnSeq + 1
2126:         lnSeqL = lnSeqL + 1
2127:         lcSeqL = TRANSFORM(lnSeqL, "@L 999999")
2128:         lcStrg = "033" + lcLot + "5" + SPACE(9) + lcSeqL + SPACE(217) + CHR(13) + CHR(10)
2129:         lcStrg = fLimpaTexto(lcStrg)
2130:         STRTOFILE(lcStrg, lcArq, 1)
2131: 
2132:         *-- Trailer do arquivo
2133:         lnSeq = lnSeq + 1
2134:         lcSeq = TRANSFORM(lnSeq, "@L 999999")
2135:         lcStrg = "033" + "9999" + "9" + SPACE(9) + "000001" + lcSeq + SPACE(211) + CHR(13) + CHR(10)
2136:         lcStrg = fLimpaTexto(lcStrg)

*-- Linhas 2142 a 2399:
2142:                 loc_oBO.CancelarTransacao()
2143:                 lok = .F.
2144:             ENDIF
2145: 
2146:             IF lok
2147:                 SELECT cursor_4c_Filtro2
2148:                 SCAN
2149:                     llAtu = .T.
2150:                     lcTitBanAtual = loc_oBO.VerificarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers)
2151:                     IF !EMPTY(ALLTRIM(lcTitBanAtual))
2152:                         llAtu = MsgConfirma("T" + CHR(237) + "tulo " + CHR(34) + lcTitBanAtual + CHR(34) + ;
2153:                                             " j" + CHR(225) + " possui T" + CHR(237) + "tulo do Banco. Sobrescrever?")
2154:                     ENDIF
2155:                     IF llAtu
2156:                         loc_oBO.AtualizarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers, lcTit)
2157:                     ENDIF
2158:                 ENDSCAN
2159:             ENDIF
2160: 
2161:             IF lok
2162:                 MsgInfo("Arquivo " + CHR(34) + ALLTRIM(lcArq) + CHR(34) + " gerado com sucesso!")
2163:             ENDIF
2164:         ENDIF
2165:     ENDPROC
2166: 
2167:     *==========================================================================
2168:     * ImpBoleto - Imprime boletos dos registros marcados em cursor_4c_Filtro2
2169:     * par_lReimp: .T. = busca SeqNums do SigPcOol (reimprimir), .F. = usa atual
2170:     *==========================================================================
2171:     PROCEDURE ImpBoleto(par_lReimp)
2172:         LOCAL loc_oBO, loc_lSucesso, loc_oErro
2173:         LOCAL lcRaz, lcAge, lcbco, lcCdC, lcTpCtArq, lcTpCtBol
2174:         LOCAL lcNossoNum, lcDV, lcFator, lcValor, lcBarra, lcArqBMP
2175:         LOCAL lcCampo1, lcCampo2, lcCampo3, lcDv1, lcDv2, lcDv3, lcNrDigit
2176:         LOCAL lcAg, lcCar, lcCta, lcDig, lcLivre
2177:         LOCAL lcPri, lcprot, lnMor, lcMora, lcInt1, lcInt2, lcInt7
2178:         LOCAL loc_nNumeDs, loc_cRaz, loc_cTpCtBol, loc_cTpCtArq
2179:         loc_lSucesso = .F.
2180: 
2181:         TRY
2182:             IF !USED("cursor_4c_Filtro2") OR RECCOUNT("cursor_4c_Filtro2") = 0
2183:                 MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para impress" + CHR(227) + "o de boleto")
2184:                 RETURN
2185:             ENDIF
2186: 
2187:             loc_oBO     = THIS.this_oBusinessObject
2188:             lcRaz       = PADR(ALLTRIM(loc_oBO.this_cRazSocs), 30)
2189:             lcAge       = LEFT(ALLTRIM(loc_oBO.this_cAgencia), 4)
2190:             lcbco       = PADL(ALLTRIM(CHRTRAN(loc_oBO.this_cContaConv, ".-", "")), 8, "0")
2191:             lcCdC       = PADL(ALLTRIM(loc_oBO.this_cConvenio), 7, "0")
2192:             lcTpCtArq   = ALLTRIM(loc_oBO.this_cTpCtArq)
2193:             lcTpCtBol   = ALLTRIM(loc_oBO.this_cTpCtBol)
2194:             loc_cRaz     = lcRaz
2195:             loc_cTpCtBol = lcTpCtBol
2196:             loc_cTpCtArq = lcTpCtArq
2197: 
2198:             *-- Cria cursor extendido com campos de boleto
2199:             SELECT a.*, SPACE(44) AS nBarras, SPACE(30) AS ImgBarra, ;
2200:                     loc_cRaz AS Cedente, SPACE(50) AS NomeCli, ;
2201:                     SPACE(50) AS Instr1, SPACE(50) AS Instr2, SPACE(50) AS Instr3, ;
2202:                     SPACE(50) AS Instr4, SPACE(50) AS Instr5, SPACE(50) AS Instr6, ;
2203:                     SPACE(70) AS Instr7, SPACE(50) AS NrDigit, SPACE(17) AS NossoNum, ;
2204:                     SPACE(15) AS AgCodCed, SPACE(10) AS cTitulos, ;
2205:                     b.Ceps AS CepEmp, b.Endes AS EndEmp, b.Numeros AS NumEmp, ;
2206:                     b.Bairs AS BaiEmp, b.Cidas AS CidEmp, b.Estas AS EstaEmp, ;
2207:                     b.Cgcs AS CpfEmp, b.compls AS compEmp, ;
2208:                     loc_cTpCtBol AS TpCtBols, loc_cTpCtArq AS TpCtArqs, ;
2209:                     SPACE(2) AS carteira ;
2210:                 FROM cursor_4c_Filtro2 a, cursor_4c_Empresa b ;
2211:                 INTO CURSOR cursor_4c_Filtro2 READWRITE
2212: 
2213:             SELECT cursor_4c_Filtro2
2214:             GO TOP
2215: 
2216:             lcPri  = PADL(IIF(EMPTY(ALLTRIM(loc_oBO.this_cInstrus)), "00", loc_oBO.this_cInstrus), 2, "0")
2217:             lcprot = IIF(THIS.pgf_4c_Principal.Page2.spn_4c_Dias.Value = 0, 5, ;
2218:                          THIS.pgf_4c_Principal.Page2.spn_4c_Dias.Value)
2219:             lcprot = IIF(lcPri = "00", "00", PADL(ALLTRIM(STR(lcprot)), 2, "0"))
2220:             lnMor  = IIF(EMPTY(loc_oBO.this_nMoras), 0.23, loc_oBO.this_nMoras)
2221: 
2222:             SCAN
2223:                 loc_nNumeDs = 0
2224:                 IF par_lReimp
2225:                     loc_nNumeDs = loc_oBO.BuscarUltimoNumeDs(ALLTRIM(cursor_4c_Filtro2.titulos))
2226:                     REPLACE SeqNums WITH PADL(ALLTRIM(STR(loc_nNumeDs)), 5, "0") IN cursor_4c_Filtro2
2227:                 ENDIF
2228: 
2229:                 IF ALLTRIM(loc_oBO.this_cBancoNr) = "001"
2230:                     lcNossoNum = lcCdC + PADL(cursor_4c_Filtro2.SeqNums, 10, "0")
2231:                     lcFator    = PADL(ALLTRIM(STR(1000 + (TTOD(cursor_4c_Filtro2.vencs) - CTOD("03/07/2000")))), 4, "0")
2232:                     lcValor    = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 8, 2), ",.", "")), 10, "0")
2233:                     lcBarra    = "0019" + lcFator + lcValor + "000000" + lcNossoNum + "17"
2234:                     lcDV       = fCalcMod11BB(lcBarra, loc_oBO.this_cBancoNr)
2235: 
2236:                     lcNossoNum = lcCdC + PADL(cursor_4c_Filtro2.SeqNums, 10, "0")
2237:                     lcBarra    = "0019" + lcDV + lcFator + lcValor + "000000" + lcNossoNum + "17"
2238:                     REPLACE nBarras WITH lcBarra IN cursor_4c_Filtro2
2239: 
2240:                     lcArqBMP = "img_barra_" + PADL(cursor_4c_Filtro2.SeqNums, 10, "0") + ".bmp"
2241:                     fGerBar2de5(SYS(2023) + "\" + lcArqBMP, lcBarra)
2242:                     REPLACE ImgBarra WITH lcArqBMP IN cursor_4c_Filtro2
2243: 
2244:                     lcCampo1  = "001900000"
2245:                     lcDv1     = fCalcMod10(lcCampo1)
2246:                     lcCampo2  = SUBSTR(lcBarra, 25, 10)
2247:                     lcDv2     = fCalcMod10(lcCampo2)
2248:                     lcCampo3  = SUBSTR(lcBarra, 35, 10)
2249:                     lcDv3     = fCalcMod10(lcCampo3)
2250:                     lcNrDigit = lcCampo1 + lcDv1 + lcCampo2 + lcDv2 + lcCampo3 + lcDv3 + lcDV + lcFator + lcValor
2251:                     REPLACE NrDigit WITH lcNrDigit IN cursor_4c_Filtro2
2252:                     REPLACE AgCodCed WITH LEFT(ALLTRIM(loc_oBO.this_cAgencia), 4) + "-" + ;
2253:                             RIGHT(ALLTRIM(loc_oBO.this_cAgencia), 1) + "/" + ;
2254:                             ALLTRIM(CHRTRAN(loc_oBO.this_cContaConv, ".-", "")) + "-" + ;
2255:                             PADL(loc_oBO.this_cDigitoAgencia, 1, "0") IN cursor_4c_Filtro2
2256: 
2257:                     IF TYPE("loc_oBO.this_nMsgMulta") = "N" AND loc_oBO.this_nMsgMulta = 1
2258:                         REPLACE Instr3 WITH "COBRAR MULTA DE 2% AO M" + CHR(202) + "S AP" + CHR(211) + ;
2259:                                 "S 1 DIA DE VENCIMENTO " IN cursor_4c_Filtro2
2260:                     ENDIF
2261:                 ENDIF
2262: 
2263:                 IF ALLTRIM(loc_oBO.this_cBancoNr) = "033"
2264:                     lcNossoNum = PADL(cursor_4c_Filtro2.SeqNums, 12, "0")
2265:                     lcDV       = fCalcMod11BB(lcNossoNum, loc_oBO.this_cBancoNr)
2266:                     lcNossoNum = lcNossoNum + lcDV
2267: 
2268:                     lcFator = PADL(ALLTRIM(STR((TTOD(cursor_4c_Filtro2.vencs) - CTOD("07/10/1997")))), 4, "0")
2269:                     lcValor = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 8, 2), ",.", "")), 10, "0")
2270:                     lcBarra = "0339" + lcFator + lcValor + "9" + lcCdC + lcNossoNum + "0" + "101"
2271:                     lcDV    = fCalcMod11BB(lcBarra, loc_oBO.this_cBancoNr, "DVB")
2272: 
2273:                     lcBarra = "0339" + lcDV + lcFator + lcValor + "9" + lcCdC + lcNossoNum + "0" + "101"
2274:                     REPLACE nBarras WITH lcBarra IN cursor_4c_Filtro2
2275: 
2276:                     lcArqBMP = "img_barra_" + PADL(cursor_4c_Filtro2.SeqNums, 12, "0") + ".bmp"
2277:                     fGerBar2de5(SYS(2023) + "\" + lcArqBMP, lcBarra)
2278:                     REPLACE ImgBarra WITH lcArqBMP IN cursor_4c_Filtro2
2279: 
2280:                     lcCampo1  = "03399" + SUBSTR(lcCdC, 1, 4)
2281:                     lcDv1     = fCalcMod10(lcCampo1)
2282:                     lcCampo2  = SUBSTR(lcBarra, 25, 10)
2283:                     lcDv2     = fCalcMod10(lcCampo2)
2284:                     lcCampo3  = SUBSTR(lcBarra, 35, 10)
2285:                     lcDv3     = fCalcMod10(lcCampo3)
2286:                     lcNrDigit = lcCampo1 + lcDv1 + lcCampo2 + lcDv2 + lcCampo3 + lcDv3 + lcDV + lcFator + lcValor
2287:                     REPLACE NrDigit WITH ALLTRIM(lcNrDigit) IN cursor_4c_Filtro2
2288:                     REPLACE AgCodCed WITH ALLTRIM(loc_oBO.this_cAgencia) + "/" + lcCdC IN cursor_4c_Filtro2
2289:                     REPLACE Instr3 WITH "COBRAR 1% DE MULTA A PARTIR DE " + ;
2290:                             DTOC(TTOD(cursor_4c_Filtro2.vencs) + 6) IN cursor_4c_Filtro2
2291:                 ENDIF
2292: 
2293:                 IF ALLTRIM(loc_oBO.this_cBancoNr) = "237"
2294:                     IF par_lReimp
2295:                         REPLACE SeqNums WITH PADL(ALLTRIM(TRANSFORM(loc_nNumeDs, "@R 99999999999")), 11, "0") ;
2296:                             IN cursor_4c_Filtro2
2297:                     ENDIF
2298:                     lcFator = PADL(ALLTRIM(STR((TTOD(cursor_4c_Filtro2.vencs) - CTOD("07/10/1997")))), 4, "0")
2299:                     lcValor = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 8, 2), ",.", "")), 10, "0")
2300:                     lcAg    = PADL(LEFT(ALLTRIM(loc_oBO.this_cAgencia), 4), 4, "0")
2301:                     lcCar   = PADL(ALLTRIM(loc_oBO.this_cTpCtBol), 2, "0")
2302:                     lcCta   = PADL(ALLTRIM(CHRTRAN(loc_oBO.this_cContaConv, ".-", "")), 7, "0")
2303:                     lcDig   = ALLTRIM(loc_oBO.this_cDigitoAgencia)
2304:                     lcNossoNum = PADL(cursor_4c_Filtro2.SeqNums, 11, "0")
2305:                     lcDV       = fCalcMod11B7(lcCar + lcNossoNum)
2306:                     lcNossoNum = lcNossoNum + lcDV
2307: 
2308:                     lcLivre = lcAg + lcCar + SUBSTR(lcNossoNum, 1, 11) + lcCta + "0"
2309:                     lcBarra = "2379" + lcFator + lcValor + lcLivre
2310:                     lcDV    = fCalcMod11BB(lcBarra, loc_oBO.this_cBancoNr, "DVB")
2311: 
2312:                     lcBarra = "2379" + lcDV + lcFator + lcValor + lcLivre
2313:                     REPLACE nBarras WITH lcBarra IN cursor_4c_Filtro2
2314: 
2315:                     lcArqBMP = "img_barra_" + PADL(cursor_4c_Filtro2.SeqNums, 11, "0") + ".bmp"
2316:                     fGerBar2de5(SYS(2023) + "\" + lcArqBMP, lcBarra)
2317:                     REPLACE ImgBarra WITH lcArqBMP IN cursor_4c_Filtro2
2318: 
2319:                     lcCampo1  = "2379" + SUBSTR(lcLivre, 1, 5)
2320:                     lcDv1     = fCalcMod10(lcCampo1)
2321:                     lcCampo2  = SUBSTR(lcLivre, 6, 10)
2322:                     lcDv2     = fCalcMod10(lcCampo2)
2323:                     lcCampo3  = SUBSTR(lcLivre, 16, 10)
2324:                     lcDv3     = fCalcMod10(lcCampo3)
2325:                     lcNrDigit = lcCampo1 + lcDv1 + lcCampo2 + lcDv2 + lcCampo3 + lcDv3 + lcDV + lcFator + lcValor
2326:                     REPLACE NrDigit WITH lcNrDigit IN cursor_4c_Filtro2
2327:                     REPLACE AgCodCed WITH ALLTRIM(loc_oBO.this_cAgencia) + "/" + lcCta + "-" + lcDig ;
2328:                         IN cursor_4c_Filtro2
2329:                     REPLACE carteira WITH lcCar IN cursor_4c_Filtro2
2330:                 ENDIF
2331: 
2332:                 REPLACE NossoNum   WITH lcNossoNum, ;
2333:                         cTitulos   WITH PADL(CHRTRAN(cursor_4c_Filtro2.titulos, "/", ""), 8, "0") ;
2334:                     IN cursor_4c_Filtro2
2335: 
2336:                 lcMora = STR(ROUND((cursor_4c_Filtro2.valos * lnMor) / 100, 2), 8, 2)
2337:                 lcInt1 = "AP" + CHR(211) + "S VENCIMENTO, COBRAR JUROS DE R$" + ALLTRIM(lcMora) + " AO DIA."
2338:                 lcInt2 = "PROTESTAR NO " + lcprot + CHR(186) + " DIA " + CHR(218) + "TIL AP" + CHR(211) + "S O VENCIMENTO."
2339:                 lcInt7 = IIF(ALLTRIM(loc_oBO.this_cBancoNr) = "237", ;
2340:                              "Pag" + CHR(225) + "vel preferencialmente na Rede Bradesco ou Bradesco Expresso", ;
2341:                              "PAG" + CHR(193) + "VEL EM QUALQUER BANCO AT" + CHR(201) + " O VENCIMENTO")
2342: 
2343:                 IF TYPE("loc_oBO.this_nMsgMulta") = "N" AND loc_oBO.this_nMsgMulta = 1
2344:                     lcInt2 = ""
2345:                 ENDIF
2346: 
2347:                 LOCAL lcNomeCliTmp
2348:                 lcNomeCliTmp = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 37)
2349:                 lcNomeCliTmp = PADR(CHRTRAN(lcNomeCliTmp, "/.-,", ""), 37)
2350:                 REPLACE NomeCli WITH lcNomeCliTmp IN cursor_4c_Filtro2
2351: 
2352:                 IF !EMPTY(cursor_4c_Filtro2.endcobs) AND !EMPTY(cursor_4c_Filtro2.cepcobs) AND ;
2353:                    !EMPTY(cursor_4c_Filtro2.estcobs) AND !EMPTY(cursor_4c_Filtro2.baicobs) AND ;
2354:                    !EMPTY(cursor_4c_Filtro2.cidcobs)
2355:                     REPLACE endes WITH ALLTRIM(cursor_4c_Filtro2.endcobs), ;
2356:                             bairs WITH cursor_4c_Filtro2.baicobs, ;
2357:                             ceps  WITH cursor_4c_Filtro2.cepcobs, ;
2358:                             cidas WITH cursor_4c_Filtro2.cidcobs, ;
2359:                             estas WITH cursor_4c_Filtro2.estcobs ;
2360:                         IN cursor_4c_Filtro2
2361:                 ENDIF
2362: 
2363:                 REPLACE Instr1 WITH lcInt1, Instr2 WITH lcInt2, Instr7 WITH lcInt7 ;
2364:                     IN cursor_4c_Filtro2
2365:             ENDSCAN
2366: 
2367:             SELECT cursor_4c_Filtro2
2368:             GO TOP
2369: 
2370:             DO CASE
2371:                 CASE ALLTRIM(loc_oBO.this_cBancoNr) = "001"
2372:                     REPORT FORM BloquetoBB2 PREVIEW
2373: 
2374:                 CASE ALLTRIM(loc_oBO.this_cBancoNr) = "033"
2375:                     REPORT FORM BloquetoSt PREVIEW
2376: 
2377:                 CASE ALLTRIM(loc_oBO.this_cBancoNr) = "237"
2378:                     REPORT FORM BloquetoBra PREVIEW
2379:             ENDCASE
2380: 
2381:             *-- Limpa imagens de barra geradas
2382:             SELECT cursor_4c_Filtro2
2383:             SCAN
2384:                 lcArqBMP = SYS(2023) + "\img_barra_" + PADL(cursor_4c_Filtro2.SeqNums, 10, "0") + ".bmp"
2385:                 IF FILE(lcArqBMP)
2386:                     ERASE &lcArqBMP
2387:                 ENDIF
2388:             ENDSCAN
2389: 
2390:             loc_lSucesso = .T.
2391:         CATCH TO loc_oErro
2392:             MsgErro(loc_oErro.Message, "Erro ImpBoleto")
2393:         ENDTRY
2394: 
2395:         RETURN loc_lSucesso
2396:     ENDPROC
2397: 
2398:     *==========================================================================
2399:     * BtnIncluirClick - Voltar para pagina de filtros (nova selecao)

*-- Linhas 2423 a 2460:
2423:     * BtnVisualizarClick - Visualiza relatorio dos titulos selecionados
2424:     *==========================================================================
2425:     PROCEDURE BtnVisualizarClick()
2426:         LOCAL loc_oErro
2427:         TRY
2428:             IF !USED("cursor_4c_Filtro") OR RECCOUNT("cursor_4c_Filtro") = 0
2429:                 MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o dispon" + CHR(237) + ;
2430:                          "vel. Execute o processamento primeiro.")
2431:                 RETURN
2432:             ENDIF
2433:             THIS.ClickRelatorio()
2434:         CATCH TO loc_oErro
2435:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
2436:         ENDTRY
2437:     ENDPROC
2438: 
2439:     *==========================================================================
2440:     * BtnExcluirClick - Desmarca todos os titulos
2441:     *==========================================================================
2442:     PROCEDURE BtnExcluirClick()
2443:         LOCAL loc_oErro
2444:         TRY
2445:             IF !USED("cursor_4c_Filtro") OR RECCOUNT("cursor_4c_Filtro") = 0
2446:                 MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o para desmarcar.")
2447:                 RETURN
2448:             ENDIF
2449:             IF MsgConfirma("Desmarcar todos os t" + CHR(237) + "tulos selecionados?")
2450:                 THIS.ClickDesmarcarTitulos()
2451:             ENDIF
2452:         CATCH TO loc_oErro
2453:             MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
2454:         ENDTRY
2455:     ENDPROC
2456: 
2457:     *==========================================================================
2458:     * CarregarLista - Carrega dados iniciais (operacoes SigCdOpe)
2459:     *==========================================================================
2460:     PROCEDURE CarregarLista()

*-- Linhas 2548 a 2581:
2548:         loc_oP1.txt_4c_TitBan.Value       = ""
2549: 
2550:         IF USED("cursor_4c_Operacoes")
2551:             SELECT cursor_4c_Operacoes
2552:             REPLACE ALL marca WITH .F.
2553:             GO TOP
2554:             loc_oP1.grd_4c_Operacoes.Refresh()
2555:         ENDIF
2556: 
2557:         loc_oP1.txt_4c_CdEmpresa.SetFocus()
2558:     ENDPROC
2559: 
2560:     *==========================================================================
2561:     * AjustarBotoesPorModo - Habilita/desabilita botoes de acordo com dados
2562:     *==========================================================================
2563:     PROCEDURE AjustarBotoesPorModo()
2564:         LOCAL loc_oP1, loc_oP2, loc_lTemDados, loc_oErro
2565:         TRY
2566:             loc_lTemDados = USED("cursor_4c_Filtro") AND RECCOUNT("cursor_4c_Filtro") > 0
2567:             loc_oP1 = THIS.pgf_4c_Principal.Page1
2568:             loc_oP2 = THIS.pgf_4c_Principal.Page2
2569: 
2570:             loc_oP1.cgp_4c_Filtro.Command1.Enabled = .T.
2571:             loc_oP1.cgp_4c_Filtro.Command2.Enabled = .T.
2572: 
2573:             loc_oP2.cgp_4c_Acoes.Command1.Enabled = loc_lTemDados
2574:             loc_oP2.cgp_4c_Acoes.Command2.Enabled = loc_lTemDados
2575:             loc_oP2.cgp_4c_MarcaDados.Enabled     = loc_lTemDados
2576:         CATCH TO loc_oErro
2577:             MsgErro(loc_oErro.Message, "Erro AjustarBotoesPorModo")
2578:         ENDTRY
2579:     ENDPROC
2580: 
2581:     *==========================================================================

*-- Linhas 2633 a 2654:
2633:             USE IN cursor_4c_Operacoes
2634:         ENDIF
2635:         IF USED("cursor_4c_FormaPagto")
2636:             USE IN cursor_4c_FormaPagto
2637:         ENDIF
2638:         IF USED("cursor_4c_Filtro")
2639:             USE IN cursor_4c_Filtro
2640:         ENDIF
2641:         IF USED("cursor_4c_Filtro2")
2642:             USE IN cursor_4c_Filtro2
2643:         ENDIF
2644:         IF USED("cursor_4c_Empresa")
2645:             USE IN cursor_4c_Empresa
2646:         ENDIF
2647:         IF USED("cursor_4c_Convenio")
2648:             USE IN cursor_4c_Convenio
2649:         ENDIF
2650:         THIS.this_oBusinessObject = .NULL.
2651:         DODEFAULT()
2652:     ENDPROC
2653: 
2654: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRCNBBO.prg):
*==============================================================================
* SIGPRCNBBO.prg - Business Object para Geracao de Arquivos CNAB - Cobranca
* Data: 2026-07-02
* Tabela principal: SigPcOol | PK: cidchaves
* Tabela de titulos: SigMvPar (via SigMvCab + SigCdCli + SigMvCcr)
* Tabela de operacoes: SigCdOpe (grid filtro com marca)
* Tabela de formas pgto: SigOpFp (lookup get_titban)
* Tabela de convenios: SigCdCeb (dados bancarios)
*==============================================================================

DEFINE CLASS SIGPRCNBBO AS BusinessBase

    *-- -----------------------------------------------------------------------
    *-- FILTROS DE TELA (pgfiltro - Page 1)
    *-- -----------------------------------------------------------------------

    *-- Empresa (get_cd_empresa / get_ds_empresa)
    this_cCdEmpresa        = ""    && emps      CHAR(3)  - Codigo empresa
    this_cDsEmpresa        = ""    && RazSocs   CHAR(40) - Razao social

    *-- Periodo (Get_Datai / Get_Dataf)
    this_dDatai            = {}    && Periodo inicial
    this_dDataf            = {}    && Periodo final

    *-- Opcao processados (optProcessados: 1=Nao Processados, 2=Ja Processados)
    this_nProcessados      = 1

    *-- Opcao periodo (optPeriodo: 1=Vencimento, 2=Emissao)
    this_nPeriodo          = 1

    *-- Conta bancaria (get_cd_car_conta / get_ds_car_conta)
    this_cCdConta          = ""    && IClis / GruContas CHAR(10) - Codigo conta
    this_cDsConta          = ""    && Descricao da conta CHAR(40)

    *-- Titulo banco (Get_titban) - codigo do titulo no banco
    this_cTitBan           = ""    && Fpags CHAR(12) - Titulo banco (FPagsGru)

    *-- -----------------------------------------------------------------------
    *-- ESTADO DO PROCESSAMENTO (pgdados - Page 2)
    *-- -----------------------------------------------------------------------

    *-- Spinner dias protesto (spndias, default=5)
    this_nDiasProt         = 5     && DiasProts NUMERIC - Dias para protesto

    *-- Caminho do arquivo CNAB gerado (montado em geracnab por banco)
    this_cArquivoCNAB      = ""    && Drive + ArqCnabs + seq + .REM

    *-- Codigo do banco do convenio ativo (ex: "001", "341", "237", "033")
    this_cBancoNr          = ""    && nbancos CHAR(3) - Codigo banco FEBRABAN

    *-- -----------------------------------------------------------------------
    *-- REGISTRO DE PROCESSAMENTO (SigPcOol)
    *-- -----------------------------------------------------------------------

    *-- Campos da tabela SigPcOol (usados em INSERT durante geracao CNAB)
    this_cCidChaves        = ""    && cidchaves   CHAR(20)      - Chave unica PK
    this_cTipos            = ""    && tipos       CHAR(10)      - Identificador ('SIGPRCNB')
    this_cEmps             = ""    && emps        CHAR(3)       - Empresa origem do titulo
    this_cDopes            = ""    && dopes       CHAR(20)      - Tipo operacao
    this_nNumes            = 0     && numes       NUMERIC(6,0)  - Numero operacao
    this_cEmpDs            = ""    && empds       CHAR(3)       - Empresa destino
    this_cDopeds           = ""    && dopeds      CHAR(20)      - Referencia titulo (SigMvCcr.Titulos)
    this_nNumeds           = 0     && numeds      NUMERIC(11,0) - Numero sequencial CNAB
    this_dDataS            = {}    && datas       DATETIME      - Data/hora geracao
    this_cUsuars           = ""    && usuars      CHAR(10)      - Usuario que gerou
    this_cProdutos         = ""    && produtos    TEXT          - Conteudo linha CNAB gerada
    this_cEdndests         = ""    && ednests     CHAR(29)      - EmpDopNums origem
    this_cEmpDopNums       = ""    && empdopnums  CHAR(29)      - Chave EmpDopNums titulo
    this_cProcessos        = ""    && processos   CHAR(20)      - Processo ('CNAB')
    this_nNopers           = 0     && nopers      NUMERIC(9,0)  - Numero operacao SigMvCcr

    *-- -----------------------------------------------------------------------
    *-- DADOS DO CONVENIO BANCARIO (SigCdCeb - carregado em geracnab/impboleto)
    *-- -----------------------------------------------------------------------
    this_cConvenio         = ""    && Convenios   CHAR - Codigo convenio
    this_cAgencia          = ""    && NAgencias   CHAR - Agencia empresa
    this_cDigitoAgencia    = ""    && DigiAgen    CHAR - Digito agencia
    this_cContaConv        = ""    && contas      CHAR - Conta do convenio
    this_cArqCnabs         = ""    && ArqCnabs    CHAR - Nome base do arquivo .REM
    this_cDrive            = ""    && Drive       CHAR - Drive de destino do arquivo
    this_cTpCtArq          = ""    && TpCtArqs    CHAR - Tipo conta arquivo
    this_cTpCtBol          = ""    && TpCtBols    CHAR - Tipo conta boleto
    this_cBancos           = ""    && bancos      CHAR - Razao social banco
    this_nMoras            = 0     && Moras       NUMERIC - Indice de mora/dia
    this_cInstrus          = ""    && Instrus     CHAR - Primeira instrucao
    this_nDiasProtConvenio = 0     && DiasProts   NUMERIC - Dias para protesto (config convenio)
    this_nBcoImprime       = 0     && bcoimprime  NUMERIC - 1=Banco emite boleto
    this_cGruposConv       = ""    && Grupos      CHAR - Grupo da conta no convenio
    this_nMsgMulta         = 0     && MsgMulta    NUMERIC - 1=Gerar mensagem de multa

    *-- -----------------------------------------------------------------------
    *-- DADOS DA EMPRESA (SigCdEmp - carregado em geracnab)
    *-- -----------------------------------------------------------------------
    this_cRazSocs          = ""    && RazSocs     CHAR - Razao social empresa
    this_cCgcs             = ""    && Cgcs        CHAR - CNPJ/CPF empresa
    this_cTel1s            = ""    && Tel1s       CHAR - Telefone
    this_cCepsEmp          = ""    && Ceps        CHAR - CEP empresa
    this_cEndesEmp         = ""    && Endes       CHAR - Endereco empresa
    this_cNumerosEmp       = ""    && Numeros     CHAR - Numero endereco
    this_cBairsEmp         = ""    && Bairs       CHAR - Bairro
    this_cCidasEmp         = ""    && Cidas       CHAR - Cidade
    this_cEstasEmp         = ""    && Estas       CHAR - Estado (UF)
    this_cComplsEmp        = ""    && Compls      CHAR - Complemento

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPcOol"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do cursor para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves    = TratarNulo(cidchaves,    "C")
                THIS.this_cTipos        = TratarNulo(tipos,        "C")
                THIS.this_cEmps         = TratarNulo(emps,         "C")
                THIS.this_cDopes        = TratarNulo(dopes,        "C")
                THIS.this_nNumes        = TratarNulo(numes,        "N")
                THIS.this_cEmpDs        = TratarNulo(empds,        "C")
                THIS.this_cDopeds       = TratarNulo(dopeds,       "C")
                THIS.this_nNumeds       = TratarNulo(numeds,       "N")
                THIS.this_dDataS        = TratarNulo(datas,        "D")
                THIS.this_cUsuars       = TratarNulo(usuars,       "C")
                THIS.this_cProdutos     = TratarNulo(produtos,     "C")
                THIS.this_cEdndests     = TratarNulo(ednests,      "C")
                THIS.this_cEmpDopNums   = TratarNulo(empdopnums,   "C")
                THIS.this_cProcessos    = TratarNulo(processos,    "C")
                THIS.this_nNopers       = TratarNulo(nopers,       "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados obrigatorios antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cEmps))
            MsgAviso("Empresa " + CHR(233) + " obrigat" + CHR(243) + "ria.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cProcessos))
            MsgAviso("Processo " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigPcOol
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = PADR(LOWER(SYS(2015)) + LOWER(SYS(2015)), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigPcOol " + ;
                "(cidchaves, tipos, emps, dopes, numes, empds, dopeds, numeds, " + ;
                " datas, usuars, produtos, ednests, empdopnums, processos, nopers) " + ;
                "VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves)    + ", " + ;
                EscaparSQL(THIS.this_cTipos)        + ", " + ;
                EscaparSQL(THIS.this_cEmps)         + ", " + ;
                EscaparSQL(THIS.this_cDopes)        + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;
                EscaparSQL(THIS.this_cEmpDs)        + ", " + ;
                EscaparSQL(THIS.this_cDopeds)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumeds) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(gc_4c_UsuarioLogado)     + ", " + ;
                EscaparSQL(THIS.this_cProdutos)     + ", " + ;
                EscaparSQL(THIS.this_cEdndests)     + ", " + ;
                EscaparSQL(THIS.this_cEmpDopNums)   + ", " + ;
                EscaparSQL(THIS.this_cProcessos)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nNopers) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro em SigPcOol.", "Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro em SigPcOol pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigPcOol SET " + ;
                "tipos = "        + EscaparSQL(THIS.this_cTipos)         + ", " + ;
                "emps = "         + EscaparSQL(THIS.this_cEmps)          + ", " + ;
                "dopes = "        + EscaparSQL(THIS.this_cDopes)         + ", " + ;
                "numes = "        + FormatarNumeroSQL(THIS.this_nNumes)   + ", " + ;
                "empds = "        + EscaparSQL(THIS.this_cEmpDs)         + ", " + ;
                "dopeds = "       + EscaparSQL(THIS.this_cDopeds)        + ", " + ;
                "numeds = "       + FormatarNumeroSQL(THIS.this_nNumeds)  + ", " + ;
                "usuars = "       + EscaparSQL(gc_4c_UsuarioLogado)      + ", " + ;
                "produtos = "     + EscaparSQL(THIS.this_cProdutos)      + ", " + ;
                "ednests = "      + EscaparSQL(THIS.this_cEdndests)      + ", " + ;
                "empdopnums = "   + EscaparSQL(THIS.this_cEmpDopNums)    + ", " + ;
                "processos = "    + EscaparSQL(THIS.this_cProcessos)     + ", " + ;
                "nopers = "       + FormatarNumeroSQL(THIS.this_nNopers) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro em SigPcOol.", "Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOperacoes - Carrega SigCdOpe no cursor_4c_Operacoes com campo marca
    * Equivalente ao Init: select dopes, .F. as marca from SigCdOpe where Parcontas=1 And ValPends=1
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOperacoes()
        LOCAL loc_lSucesso, loc_cSQL, loc_lFalso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Operacoes")
                TABLEREVERT(.T., "cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_lFalso = .F.
            loc_cSQL = "SELECT Dopes, ?loc_lFalso AS marca FROM SigCdOpe " + ;
                "WHERE Parcontas = 1 AND ValPends = 1 ORDER BY Dopes"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes") > 0
                SELECT cursor_4c_Operacoes
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es.", "BuscarOperacoes")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao BuscarOperacoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarFormaPagamento - Carrega SigOpFp em cursor_4c_FormaPagto para lookup titban
    * Equivalente ao Init: Select * From SigOpFp Where Situas in ('R','A') And Infos='K'
    *--------------------------------------------------------------------------
    PROCEDURE BuscarFormaPagamento()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_FormaPagto")
                USE IN cursor_4c_FormaPagto
            ENDIF

            IF SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigOpFp WHERE Situas IN ('R','A') AND Infos = 'K'", ;
                "cursor_4c_FormaPagto") > 0
                SELECT cursor_4c_FormaPagto
                INDEX ON Fpags TAG FpagSgru
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar formas de pagamento.", "BuscarFormaPagamento")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao BuscarFormaPagamento")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresa - Carrega dados da empresa; popula this_c* e cursor_4c_Empresa
    * par_cCodEmp: codigo da empresa (Cemps em SigCdEmp)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresa(par_cCodEmp)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Empresa")
                USE IN cursor_4c_Empresa
            ENDIF

            loc_cSQL = "SELECT RazSocs, Cgcs, Tel1s, Ceps, Endes, Numeros, " + ;
                "Bairs, Cidas, Estas, Compls " + ;
                "FROM SigCdEmp WHERE Cemps = " + EscaparSQL(par_cCodEmp)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresa") > 0
                SELECT cursor_4c_Empresa
                GO TOP
                IF !EOF("cursor_4c_Empresa")
                    THIS.this_cRazSocs      = TratarNulo(cursor_4c_Empresa.RazSocs,    "C")
                    THIS.this_cCgcs         = TratarNulo(cursor_4c_Empresa.Cgcs,       "C")
                    THIS.this_cTel1s        = TratarNulo(cursor_4c_Empresa.Tel1s,      "C")
                    THIS.this_cCepsEmp      = TratarNulo(cursor_4c_Empresa.Ceps,       "C")
                    THIS.this_cEndesEmp     = TratarNulo(cursor_4c_Empresa.Endes,      "C")
                    THIS.this_cNumerosEmp   = TratarNulo(cursor_4c_Empresa.Numeros,    "C")
                    THIS.this_cBairsEmp     = TratarNulo(cursor_4c_Empresa.Bairs,      "C")
                    THIS.this_cCidasEmp     = TratarNulo(cursor_4c_Empresa.Cidas,      "C")
                    THIS.this_cEstasEmp     = TratarNulo(cursor_4c_Empresa.Estas,      "C")
                    THIS.this_cComplsEmp    = TratarNulo(cursor_4c_Empresa.Compls,     "C")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao carregar empresa.", "CarregarEmpresa")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao CarregarEmpresa")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarConvenio - Carrega convenio bancario; popula this_c* e cursor_4c_Convenio
    * par_cConta: codigo da conta bancaria (IClis em SigCdCli)
    * Busca Grupos em SigCdCli, depois SigCdCeb WHERE GruContas = Grupos+Conta
    *--------------------------------------------------------------------------
    PROCEDURE CarregarConvenio(par_cConta)
        LOCAL loc_lSucesso, loc_cGrupos, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- 1. Busca grupo da conta em SigCdCli
            loc_cGrupos = ""
            IF SQLEXEC(gnConnHandle, ;
                "SELECT Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(par_cConta), ;
                "cursor_4c_BancoGrupo") > 0
                SELECT cursor_4c_BancoGrupo
                GO TOP
                IF !EOF("cursor_4c_BancoGrupo")
                    loc_cGrupos = TratarNulo(cursor_4c_BancoGrupo.Grupos, "C")
                ENDIF
                USE IN cursor_4c_BancoGrupo
            ENDIF

            *-- 2. Busca convenio em SigCdCeb
            IF USED("cursor_4c_Convenio")
                USE IN cursor_4c_Convenio
            ENDIF

            loc_cSQL = "SELECT * FROM SigCdCeb " + ;
                "WHERE GruContas = " + ;
                EscaparSQL(ALLTRIM(loc_cGrupos) + ALLTRIM(par_cConta)) + ;
                " AND NAgencias <> SPACE(6) AND Convenios <> SPACE(9) " + ;
                "ORDER BY NAgencias, Convenios"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Convenio") > 0
                SELECT cursor_4c_Convenio
                GO TOP
                IF !EOF("cursor_4c_Convenio")
                    THIS.this_cConvenio         = TratarNulo(cursor_4c_Convenio.Convenios,  "C")
                    THIS.this_cAgencia          = TratarNulo(cursor_4c_Convenio.NAgencias,  "C")
                    THIS.this_cDigitoAgencia    = TratarNulo(cursor_4c_Convenio.DigiAgen,   "C")
                    THIS.this_cContaConv        = TratarNulo(cursor_4c_Convenio.contas,     "C")
                    THIS.this_cArqCnabs         = TratarNulo(cursor_4c_Convenio.ArqCnabs,   "C")
                    THIS.this_cDrive            = TratarNulo(cursor_4c_Convenio.Drive,      "C")
                    THIS.this_cTpCtArq          = TratarNulo(cursor_4c_Convenio.TpCtArqs,   "C")
                    THIS.this_cTpCtBol          = TratarNulo(cursor_4c_Convenio.TpCtBols,   "C")
                    THIS.this_cBancos           = TratarNulo(cursor_4c_Convenio.bancos,     "C")
                    THIS.this_nMoras            = TratarNulo(cursor_4c_Convenio.Moras,      "N")
                    THIS.this_cInstrus          = TratarNulo(cursor_4c_Convenio.Instrus,    "C")
                    THIS.this_nDiasProtConvenio = TratarNulo(cursor_4c_Convenio.DiasProts,  "N")
                    THIS.this_nBcoImprime       = TratarNulo(cursor_4c_Convenio.bcoimprime, "N")
                    THIS.this_cGruposConv       = TratarNulo(cursor_4c_Convenio.Grupos,     "C")
                    THIS.this_nMsgMulta         = TratarNulo(cursor_4c_Convenio.MsgMulta,   "N")
                    THIS.this_cBancoNr          = TratarNulo(cursor_4c_Convenio.nbancos,    "C")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao carregar conv" + CHR(234) + "nio.", "CarregarConvenio")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao CarregarConvenio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTitulos - Executa query de processamento e carrega cursor_4c_Filtro
    * Equivalente ao PROCEDURE processamento do legado
    * par_cEmp: codigo da empresa
    * par_dDatai / par_dDataf: periodo
    * par_nProcessados: 1=Nao processados, 2=Ja processados
    * par_nPeriodo: 1=Vencimento, 2=Emissao
    * par_cOpeIN: clausula IN formatada ex: ('VENDA','COBRANCA')
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTitulos(par_cEmp, par_dDatai, par_dDataf, par_nProcessados, par_nPeriodo, par_cOpeIN)
        LOCAL loc_lSucesso, loc_cSQL, loc_lMarca, loc_dDatai, loc_dDataf, loc_cEmpParam, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Filtro")
                TABLEREVERT(.T., "cursor_4c_Filtro")
                USE IN cursor_4c_Filtro
            ENDIF

            *-- Variaveis para parametros SQLEXEC (?var resolve na scope local)
            loc_lMarca    = .T.
            loc_dDatai    = par_dDatai
            loc_dDataf    = par_dDataf
            loc_cEmpParam = par_cEmp

            loc_cSQL = "SELECT ?loc_lMarca AS marca, e.titulos, a.dopes, a.numes, d.rclis, " + ;
                "a.vencs, b.fpags, a.valos, a.datas, a.vpags, " + ;
                "d.iclis, d.endes, d.cidas, d.estas, d.nums, d.compls, " + ;
                "d.bairs, d.ceps, d.cpfs, a.emps, a.empdopnums, a.nopers, d.Razaos, " + ;
                "d.endcobs, d.cepcobs, d.estcobs, d.baicobs, d.cidcobs, " + ;
                "CASE WHEN d.EndCobs <> '' AND LEN(RTRIM(d.EndCobs)) > 40 THEN 1 " + ;
                "ELSE CASE WHEN d.Endes <> '' AND " + ;
                "LEN(RTRIM(d.Endes) + ' ' + RTRIM(d.Nums) + ' ' + RTRIM(d.compls)) > 40 " + ;
                "THEN 1 ELSE 0 END END AS EndErro " + ;
                "FROM SigMvPar a " + ;
                "INNER JOIN SigOpFp b ON a.fpags = b.fpags " + ;
                "LEFT JOIN SigMvCab c ON a.empdopnums = c.empdopnums " + ;
                "LEFT JOIN SigCdCli d ON c.contads = d.iclis " + ;
                "LEFT JOIN SigMvCcr e ON a.empdopnums = e.empdopnums AND a.nopers = e.nopers " + ;
                "WHERE b.infos = 'B' AND a.vpags = 0 " + ;
                "AND " + IIF(par_nPeriodo = 1, "a.Vencs", "e.DtEmis") + ;
                " BETWEEN ?loc_dDatai AND ?loc_dDataf " + ;
                "AND e.opers = 'C' " + ;
                "AND c.emps = ?loc_cEmpParam " + ;
                "AND a.dopes IN " + par_cOpeIN + ;
                " AND a.EmpDopNums + e.titulos " + ;
                IIF(par_nProcessados = 1, "NOT ", "") + ;
                "IN (SELECT e2.EmpDopNums + SUBSTRING(e2.dopeds, 1, 10) " + ;
                "    FROM SigPcOol e2 WHERE e2.Tipos = 'SIGPRCNB') " + ;
                "ORDER BY a.dopes, a.numes"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Filtro") > 0
                SELECT cursor_4c_Filtro
                GO TOP
                IF !EOF("cursor_4c_Filtro")
                    REPLACE ALL marca WITH .F. FOR EndErro = 1
                    GO TOP
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar t" + CHR(237) + "tulos para processamento.", "BuscarTitulos")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao BuscarTitulos")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinhaCNAB - Insere linha CNAB em SigPcOol diretamente via SQLEXEC
    * par_cEmpDopNums: chave EmpDopNums do titulo
    * par_cEmps: codigo empresa
    * par_cDopes: codigo operacao
    * par_nNumes: numero da operacao
    * par_cConteudo: conteudo da linha CNAB (texto do arquivo .REM)
    * par_cDopeDs: referencia do titulo (SigMvCcr.Titulos)
    * par_nNumeDs: numero sequencial CNAB gerado (SeqNums)
    * Retorna: cidchaves gerado ou "" se falhou
    *--------------------------------------------------------------------------
    PROCEDURE InserirLinhaCNAB(par_cEmpDopNums, par_cEmps, par_cDopes, par_nNumes, par_cConteudo, par_cDopeDs, par_nNumeDs)
        LOCAL loc_cCidChaves, loc_cSQL, loc_oErro
        loc_cCidChaves = ""
        TRY
            loc_cCidChaves = PADR(LOWER(SYS(2015)) + LOWER(SYS(2015)), 20)

            loc_cSQL = "INSERT INTO SigPcOol " + ;
                "(empdopnums, emps, dopes, numes, usuars, tipos, processos, " + ;
                " produtos, DataS, cidchaves, dopeds, numeds) VALUES (" + ;
                EscaparSQL(par_cEmpDopNums)         + ", " + ;
                EscaparSQL(par_cEmps)               + ", " + ;
                EscaparSQL(par_cDopes)              + ", " + ;
                FormatarNumeroSQL(par_nNumes)       + ", " + ;
                EscaparSQL(gc_4c_UsuarioLogado)     + ", " + ;
                "'SIGPRCNB', " + ;
                "'CNAB', " + ;
                EscaparSQL(par_cConteudo)           + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(loc_cCidChaves)          + ", " + ;
                EscaparSQL(par_cDopeDs)             + ", " + ;
                FormatarNumeroSQL(par_nNumeDs) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                loc_cCidChaves = ""
                MsgErro("Erro ao inserir linha CNAB em SigPcOol.", "InserirLinhaCNAB")
            ENDIF
        CATCH TO loc_oErro
            loc_cCidChaves = ""
            MsgErro(loc_oErro.Message, "Erro ao InserirLinhaCNAB")
        ENDTRY
        RETURN loc_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarTituloBanco - Verifica TitBans atual em SigMvCcr
    * Retorna "" se nao preenchido, ou valor atual se ja preenchido
    *--------------------------------------------------------------------------
    PROCEDURE VerificarTituloBanco(par_cEmpDopNums, par_nNopers)
        LOCAL loc_cTitBanAtual, loc_cSQL, loc_oErro
        loc_cTitBanAtual = ""
        TRY
            loc_cSQL = "SELECT Titulos, TitBans FROM SigMvCcr " + ;
                "WHERE EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + ;
                " AND Nopers = " + FormatarNumeroSQL(par_nNopers)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvCcr") > 0
                SELECT cursor_4c_SigMvCcr
                GO TOP
                IF !EOF("cursor_4c_SigMvCcr")
                    loc_cTitBanAtual = TratarNulo(cursor_4c_SigMvCcr.TitBans, "C")
                ENDIF
                USE IN cursor_4c_SigMvCcr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao VerificarTituloBanco")
        ENDTRY
        RETURN loc_cTitBanAtual
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTituloBanco - Atualiza TitBans em SigMvCcr
    * par_cEmpDopNums: chave do movimento de conta corrente
    * par_nNopers: numero da operacao
    * par_cTitBan: novo valor do titulo banco (12 chars)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTituloBanco(par_cEmpDopNums, par_nNopers, par_cTitBan)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigMvCcr SET TitBans = " + EscaparSQL(par_cTitBan) + ;
                " WHERE EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + ;
                " AND Nopers = " + FormatarNumeroSQL(par_nNopers)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar T" + CHR(237) + "tulo Banco.", "AtualizarTituloBanco")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao AtualizarTituloBanco")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarUltimoNumeDs - Busca ultimo NumeDs gerado para um titulo (reimprimir)
    * par_cDopeDs: referencia do titulo (campo titulos em SigMvCcr)
    * Retorna: numeds como N ou 0 se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarUltimoNumeDs(par_cDopeDs)
        LOCAL loc_nNumeDs, loc_cSQL, loc_oErro
        loc_nNumeDs = 0
        TRY
            loc_cSQL = "SELECT TOP 1 NumeDs FROM SigPcOol " + ;
                "WHERE Processos = 'CNAB' AND DopeDs = " + EscaparSQL(par_cDopeDs) + ;
                " ORDER BY Datas DESC"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PcOolUlt") > 0
                SELECT cursor_4c_PcOolUlt
                GO TOP
                IF !EOF("cursor_4c_PcOolUlt")
                    loc_nNumeDs = TratarNulo(cursor_4c_PcOolUlt.NumeDs, "N")
                ENDIF
                USE IN cursor_4c_PcOolUlt
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao BuscarUltimoNumeDs")
        ENDTRY
        RETURN loc_nNumeDs
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfirmarTransacao - Confirma todos os INSERTs CNAB (SQLCOMMIT)
    *--------------------------------------------------------------------------
    PROCEDURE ConfirmarTransacao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF SQLCOMMIT(gnConnHandle) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao confirmar transa" + CHR(231) + CHR(227) + "o CNAB.", "ConfirmarTransacao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao ConfirmarTransacao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CancelarTransacao - Desfaz INSERTs CNAB em caso de falha (SQLROLLBACK)
    *--------------------------------------------------------------------------
    PROCEDURE CancelarTransacao()
        LOCAL loc_oErro
        TRY
            SQLROLLBACK(gnConnHandle)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao CancelarTransacao")
        ENDTRY
    ENDPROC

ENDDEFINE


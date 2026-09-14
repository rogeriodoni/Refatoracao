# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PAGOS, CONTAPGS, OPERS, NOPERS, EMPS, CIDCHAVES, GRUPOS, CONTAS, TIPOS, DOPES, GRUCONTAS, FKCHAVES, CCB_TIPO, 1, LCJ021A035, LCJ036A075, LCJ076A076, LCJ133A147, LCJ148A187, LCJ188A240, LCB230A230, LCBCO, NBANCOS, BARRAS, TIPOCHV, 0, PADPGRECS, NAGENCIAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PAGOS, CONTAPGS, OPERS, NOPERS, EMPS, CIDCHAVES, GRUPOS, CONTAS, TIPOS, DOPES, GRUCONTAS, FKCHAVES, CCB_TIPO, 1, LCJ021A035, LCJ036A075, LCJ076A076, LCJ133A147, LCJ148A187, LCJ188A240, LCB230A230, LCBCO, NBANCOS, BARRAS, TIPOCHV, 0, PADPGRECS, NAGENCIAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZSOCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PAGOS, CONTAPGS, OPERS, NOPERS, EMPS, CIDCHAVES, GRUPOS, CONTAS, TIPOS, DOPES, GRUCONTAS, FKCHAVES, CCB_TIPO, 1, LCJ021A035, LCJ036A075, LCJ076A076, LCJ133A147, LCJ148A187, LCJ188A240, LCB230A230, LCBCO, NBANCOS, BARRAS, TIPOCHV, 0, PADPGRECS, NAGENCIAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COLUMNCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PAGOS, CONTAPGS, OPERS, NOPERS, EMPS, CIDCHAVES, GRUPOS, CONTAS, TIPOS, DOPES, GRUCONTAS, FKCHAVES, CCB_TIPO, 1, LCJ021A035, LCJ036A075, LCJ076A076, LCJ133A147, LCJ148A187, LCJ188A240, LCB230A230, LCBCO, NBANCOS, BARRAS, TIPOCHV, 0, PADPGRECS, NAGENCIAS

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  DeleteMark = .F.
Select crSigCdGcr
lcquery = 	[select ?ltru as marca, a.emps, a.datas, a.vencs, a.Valors, a.moedas, a.Hists + a.Titulos + a.Nfs as histo, b.rclis, b.iclis, a.Grupos, a.contas, a.Nopers, a.Tipos, ] +;
			[From SigMvCcr a, sigcdcli b ] + ;
			[And a.cidchaves in(select cidchaves From SigMvCcr ] + ; 
			[And a.nopers ] + Iif(llNPr, [Not ], []) + [In (Select e.nopers From SigPcOol e Where e.Tipos = 'SIGPGCNB' and e.dopes = 'C') ] + ;
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
Select *, Space(10) As nossoNum, Space(50) As barras From crfiltro Where marca Into Cursor crFiltro2 Readwrite
	Select * From crFiltroTr Into Cursor crFiltro2 Readwrite
	Select crFiltro2
		lcQuery = [Select * From SigMvCcb Where fkchaves = '] + pFks + [' ]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crMvCcb') < 1)
		lcQuery = [Select * From SigCdCeb where 1=0]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConta') < 1)
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
	Select crFiltro2
		lcQuery = [Select * ] + ;
		[From SigCdCeb ] + ;
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConta') < 1)
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
	Select * From crFiltro4 Into Cursor crFiltro2 Readwrite
	Select crFiltro2
		lcQuery = [Select * ] + ;
		[From SigCdCeb ] + ;
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConta') < 1)
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
	Select crFiltro3
		lcQuery = [Select * From SigCdCeb Where GruContas = '] + crFiltro3.Grupos + crFiltro3.contas + [' Order By NAgencias]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConta') < 1)
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
	Select * From crFiltro5 Into Cursor crFiltro3 Readwrite
	Select crFiltro3
		lcQuery = [Select * From SigCdCeb Where GruContas = '] + crFiltro3.Grupos + crFiltro3.contas + [' Order By NAgencias]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConta') < 1)
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
Select * From crFiltro6 Where Inlist(Substr(barras,2,1),'1','5','7') Into Cursor crFiltro7	&& tributos
Select * From crFiltro6 Where !Inlist(Substr(barras,2,1),'1','5','7') Into Cursor crFiltro6	&& contas de consumo
	Select * From crFiltro6 Into Cursor crFiltro3 Readwrite
	Select crFiltro3
		lcQuery = [Select * From SigCdCeb Where GruContas = '] + crFiltro3.Grupos + crFiltro3.contas + [' Order By NAgencias]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConta') < 1)
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
	Select * From crFiltro7 Into Cursor crFiltro3 Readwrite
	Select crFiltro3
		lcQuery = [Select * From SigCdCeb Where GruContas = '] + crFiltro3.Grupos + crFiltro3.contas + [' Order By NAgencias]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConta') < 1)
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
	If ! Thisform.poDataMgr.Update('crSigPcOol')
		Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
		Select crFiltro20
			Thisform.poDataMgr.SqlExecute("select titulos, titbans from SigMvCcr where opers = 'C' and nopers = ?crFiltro20.nopers",'crSigMvCcr')
			Select crSigMvCcr
				lcQuery = "Update SigMvCcr set titbans = 'TIT ITAU' where opers = 'C' and nopers = ?crFiltro20.nopers"
				&&lcquery = "Update SigMvCcr set titbans = convert(char, nopers) where opers = 'C' and nopers = ?crFiltro2.nopers"
				If Thisform.poDataMgr.SqlExecute(lcQuery) < 1
					Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
			Select crFiltro20
Select *, Space(10) As nossoNum, Space(50) As barras From crfiltro Where marca Into Cursor crFiltro2 Readwrite
	Select crFiltro2
		lcQuery = [Select * ] + ;
					[From SigCdCeb ] + ;
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConta') < 1)
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
	SELECT * from crFiltro4 into cursor crFiltro2 readwrite
	Select crFiltro2
		lcQuery = [Select * ] + ;
					[From SigCdCeb ] + ;
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConta') < 1)
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
	Select crFiltro3
		lcQuery = [Select * From SigCdCeb Where GruContas = '] + crFiltro3.Grupos + crFiltro3.contas + [' Order By NAgencias]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConta') < 1)
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
	SELECT * from crFiltro5 into cursor crFiltro3 readwrite
	Select crFiltro3
		lcQuery = [Select * From SigCdCeb Where GruContas = '] + crFiltro3.Grupos + crFiltro3.contas + [' Order By NAgencias]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConta') < 1)
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
	SELECT * from crFiltro6 into cursor crFiltro3 readwrite
	Select crFiltro3
		lcQuery = [Select * From SigCdCeb Where GruContas = '] + crFiltro3.Grupos + crFiltro3.contas + [' Order By NAgencias]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConta') < 1)
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
	If ! Thisform.podatamgr.Update('crSigPcOol')
		Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
		Select crFiltro20
			Thisform.podatamgr.Sqlexecute("select titulos, titbans from SigMvCcr where opers = 'C' and nopers = ?crFiltro20.nopers",'crSigMvCcr')
			Select crSigMvCcr
				lcquery = "Update SigMvCcr set titbans = 'TIT ITAU' where opers = 'C' and nopers = ?crFiltro20.nopers"
				&&lcquery = "Update SigMvCcr set titbans = convert(char, nopers) where opers = 'C' and nopers = ?crFiltro2.nopers"
				If Thisform.podatamgr.Sqlexecute(lcquery) < 1
					Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
			Select crFiltro20
Select *, Space(10) As nossoNum, Space(50) As barras From crfiltro Where marca Into Cursor crFiltro2 Readwrite
	Select crFiltro2
		lcQuery = [Select * ] + ;
			[From SigCdCeb ] + ;
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConta') < 1)
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
	SELECT * from crFiltro4 into cursor crFiltro2 readwrite
	Select crFiltro2
		lcQuery = [Select * ] + ;
			[From SigCdCeb ] + ;
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConta') < 1)
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
	Select crFiltro3
		lcQuery = [Select * From SigCdCeb Where GruContas = '] + crFiltro3.Grupos + crFiltro3.contas + [' Order By NAgencias]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConta') < 1)
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
	SELECT * from crFiltro5 into cursor crFiltro3 readwrite
	Select crFiltro3
		lcQuery = [Select * From SigCdCeb Where GruContas = '] + crFiltro3.Grupos + crFiltro3.contas + [' Order By NAgencias]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConta') < 1)
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
	SELECT * from crFiltro6 into cursor crFiltro3 readwrite
	Select crFiltro3
		lcQuery = [Select * From SigCdCeb Where GruContas = '] + crFiltro3.Grupos + crFiltro3.contas + [' Order By NAgencias]
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConta') < 1)
		Insert Into crSigPcOol(dopes, nopers,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,edndests) Values ;
	If ! Thisform.poDataMgr.Update('crSigPcOol')
		Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
		Select crFiltro20
			Thisform.poDataMgr.SqlExecute("select titulos, titbans from SigMvCcr where opers = 'C' and nopers = ?crFiltro20.nopers",'crSigMvCcr')
			Select crSigMvCcr
				lcQuery = "Update SigMvCcr set titbans = 'TIT BRADESC' where opers = 'C' and nopers = ?crFiltro20.nopers"
&&lcquery = "Update SigMvCcr set titbans = convert(char, nopers) where opers = 'C' and nopers = ?crFiltro2.nopers"
				If Thisform.poDataMgr.SqlExecute(lcQuery) < 1
					Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
			Select crFiltro20
lcQuery = [Select * From SigCdCeb Where nbancos = ]+lcBco
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crBanco') < 1)
lcQuery = [Select * From SigCdCeb Where nbancos != ]+lcBco
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crBancoD') < 1)
SELECT crFiltro2
	lcquery = 	[select ccb_bars From sigmvccb Where fkchaves = '] + lcFkchaves  + [' ]
	Thisform.podatamgr.sqlexecute(lcquery,[crBarra])
	SELECT crBarra
	SELECT crFiltro2
SELECT * from crFiltro2 into cursor crFiltro20	&& salva para marcar os registros gerados
SELECT * from crFiltro2 where barras != SPACE(50) into cursor crFiltro3 Readwrite	&& boleto
SELECT * from crFiltro2 where barras = SPACE(50) into cursor crFiltroTr Readwrite	&& Transferencia
SELECT * from crFiltroTr where Grupos + contas in (select GruContas from crBancoD) into cursor crFiltro4 Readwrite 		&& Doc  
SELECT * from crFiltroTr where Grupos + contas in (select GruContas from crBanco) into cursor crFiltro2 Readwrite 		&& credito em conta 
SELECT * from crFiltro3 where LEN(ALLTRIM(barras)) = 48 into cursor crFiltro6 Readwrite				 							&& tributos  
SELECT * from crFiltro3 where LEN(ALLTRIM(barras)) != 48 and SUBSTR(barras, 1, 3) != lcBco into cursor crFiltro5 Readwrite 		&& boleto de outro banco  
SELECT * from crFiltro3 where LEN(ALLTRIM(barras)) != 48 and SUBSTR(barras, 1, 3) = lcBco into cursor crFiltro3 Readwrite		&& boleto mesmo banco
SELECT * from crFiltroTr where tipochv != '  ' into cursor crFiltroTr Readwrite 		&& credito em conta PIX 
	SELECT * from crFiltro2 where 0 = 1 into cursor crFiltro2 Readwrite
	SELECT * from crFiltro3 where 0 = 1 into cursor crFiltro3 Readwrite
	SELECT * from crFiltro4 where 0 = 1 into cursor crFiltro4 Readwrite
	SELECT * from crFiltro5 where 0 = 1 into cursor crFiltro5 Readwrite
	SELECT * from crFiltro6 where 0 = 1 into cursor crFiltro6 Readwrite
SELECT * from crFiltro20 where Grupos + contas not in (select Grupos + contas from crFiltro2 )  ;
							and  Grupos + contas not in (select Grupos + contas from crFiltro3 ) ;
							and  Grupos + contas not in (select Grupos + contas from crFiltro4 ) ;
							and  Grupos + contas not in (select Grupos + contas from crFiltro5 ) ;
							and  Grupos + contas not in (select Grupos + contas from crFiltroTr ) ;
							and  Grupos + contas not in (select Grupos + contas from crFiltro6 ) into cursor crErro
SELECT crErro
SELECT * from crFiltro20 where Grupos + contas not in (select Grupos + contas from crErro ) into cursor crFiltro20 readwrite	&& salva para marcar os registros gerados
	Thisform.poDataMgr.SqlExecute([select Codigos, Descrs, ?lltru as marca from SigCdGcr where PadPgRecs in (4,2) order by Codigos],[crSigCdGcr])
	Select crSigCdGcr
	Thisform.pgfprincipal.pgfiltro.grdgrupos.column1.ControlSource = [crSigCdGcr.marca]
	Thisform.pgfprincipal.pgfiltro.grdgrupos.column2.ControlSource = [crSigCdGcr.Descrs]
Select crSigCdGcr
Select crSigCdGcr
Update crSigCdGcr Set marca = .T.
Select crSigCdGcr
Update crSigCdGcr Set marca = .F.
SELECT crFiltro
SELECT crFiltro
SELECT crFiltro
SELECT crFiltro
SELECT crfiltro
Update crfiltro set marca = .t.
SELECT crfiltro
Update crfiltro set marca = .f.

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPGCNB.prg) - TRECHOS RELEVANTES PARA PASS SQL (3830 linhas total):

*-- Linhas 540 a 558:
540:             .FontName         = "Tahoma"
541:             .AllowHeaderSizing = .F.
542:             .AllowRowSizing   = .F.
543:             .DeleteMark       = .F.
544:             .GridLines        = 3
545:             .Height           = 344
546:             .Left             = 372
547:             .Panel            = 1
548:             .ScrollBars       = 2
549:             .SplitBar         = .F.
550:             .TabIndex         = 11
551:             .Top              = 236
552:             .Width            = 202
553:             .GridLineColor    = RGB(238,238,238)
554:             .Themes           = .F.
555:             .Column1.Width    = 18
556:             .Column1.Movable  = .F.
557:             .Column1.Resizable = .F.
558:             .Column1.Sparse   = .F.

*-- Linhas 629 a 647:
629:             .FontName          = "Tahoma"
630:             .AllowHeaderSizing = .F.
631:             .AllowRowSizing    = .F.
632:             .DeleteMark        = .F.
633:             .Height            = 382
634:             .Left              = 9
635:             .Panel             = 1
636:             .RecordMark        = .F.
637:             .ScrollBars        = 2
638:             .SplitBar          = .F.
639:             .TabIndex          = 1
640:             .Top               = 152
641:             .Width             = 981
642:             .GridLineColor     = RGB(238,238,238)
643:             .Themes            = .F.
644:             .Column1.Width     = 16
645:             .Column1.Movable   = .F.
646:             .Column1.Resizable = .F.
647:             .Column1.Sparse    = .F.

*-- Linhas 987 a 1006:
987:             loc_oGrd = THIS.pgf_4c_Principal.pgfiltro.grd_4c_Grupos
988:             loc_oGrd.ColumnCount = 2
989:             loc_oGrd.RecordSource      = "cursor_4c_Grupos"
990:             loc_oGrd.Column1.ControlSource = "cursor_4c_Grupos.marca"
991:             loc_oGrd.Column2.ControlSource = "cursor_4c_Grupos.descrs"
992:             loc_oGrd.Column1.Header1.Caption = ""
993:             loc_oGrd.Column2.Header1.Caption = "Grupos"
994:             loc_oGrd.Column2.Header1.Alignment = 2
995:             loc_oGrd.Refresh()
996:         ENDIF
997: 
998:         THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpresa.SetFocus()
999:     ENDPROC
1000: 
1001:     *==========================================================================
1002:     * HANDLERS DE VALIDACAO DOS CAMPOS DE FILTRO
1003:     *==========================================================================
1004: 
1005:     PROCEDURE ValidarCdEmpresa()
1006:         LOCAL loc_cCod, loc_cSQL

*-- Linhas 1012 a 1055:
1012:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1013:             RETURN
1014:         ENDIF
1015:         loc_cSQL = "SELECT TOP 1 RazSocs FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCod)
1016:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmpV") >= 1 AND RECCOUNT("cursor_4c_EmpTmpV") > 0
1017:             SELECT cursor_4c_EmpTmpV
1018:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpTmpV.RazSocs)
1019:         ELSE
1020:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpresa.Value = ""
1021:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpresa.Value = ""
1022:             MsgAviso("Empresa inv" + CHR(225) + "lida.")
1023:         ENDIF
1024:         IF USED("cursor_4c_EmpTmpV")
1025:             USE IN cursor_4c_EmpTmpV
1026:         ENDIF
1027:     ENDPROC
1028: 
1029:     PROCEDURE ValidarDsEmpresa()
1030:         LOCAL loc_cDs, loc_cSQL
1031:         loc_cDs = ALLTRIM(THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpresa.Value)
1032:         IF EMPTY(loc_cDs)
1033:             RETURN
1034:         ENDIF
1035:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1036:             RETURN
1037:         ENDIF
1038:         loc_cSQL = "SELECT TOP 1 Cemps, RazSocs FROM SigCdEmp WHERE RazSocs LIKE " + EscaparSQL(loc_cDs + "%")
1039:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmpV") >= 1 AND RECCOUNT("cursor_4c_EmpTmpV") > 0
1040:             SELECT cursor_4c_EmpTmpV
1041:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpTmpV.Cemps)
1042:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpTmpV.RazSocs)
1043:         ELSE
1044:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpresa.Value = ""
1045:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpresa.Value = ""
1046:         ENDIF
1047:         IF USED("cursor_4c_EmpTmpV")
1048:             USE IN cursor_4c_EmpTmpV
1049:         ENDIF
1050:     ENDPROC
1051: 
1052:     PROCEDURE ValidarCdConta()
1053:         LOCAL loc_cCod, loc_cGrupo, loc_llRet
1054:         loc_cCod = ALLTRIM(THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdConta.Value)
1055:         IF EMPTY(loc_cCod)

*-- Linhas 1099 a 1142:
1099:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1100:             RETURN
1101:         ENDIF
1102:         loc_cSQL = "SELECT TOP 1 RazSocs FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCod)
1103:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpConvV") >= 1 AND RECCOUNT("cursor_4c_EmpConvV") > 0
1104:             SELECT cursor_4c_EmpConvV
1105:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpConv.Value = ALLTRIM(cursor_4c_EmpConvV.RazSocs)
1106:         ELSE
1107:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpConv.Value = ""
1108:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpConv.Value = ""
1109:             MsgAviso("Empresa do conv" + CHR(234) + "nio inv" + CHR(225) + "lida.")
1110:         ENDIF
1111:         IF USED("cursor_4c_EmpConvV")
1112:             USE IN cursor_4c_EmpConvV
1113:         ENDIF
1114:     ENDPROC
1115: 
1116:     PROCEDURE ValidarDsEmpConv()
1117:         LOCAL loc_cDs, loc_cSQL
1118:         loc_cDs = ALLTRIM(THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpConv.Value)
1119:         IF EMPTY(loc_cDs)
1120:             RETURN
1121:         ENDIF
1122:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1123:             RETURN
1124:         ENDIF
1125:         loc_cSQL = "SELECT TOP 1 Cemps, RazSocs FROM SigCdEmp WHERE RazSocs LIKE " + EscaparSQL(loc_cDs + "%")
1126:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpConvV") >= 1 AND RECCOUNT("cursor_4c_EmpConvV") > 0
1127:             SELECT cursor_4c_EmpConvV
1128:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpConv.Value = ALLTRIM(cursor_4c_EmpConvV.Cemps)
1129:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpConv.Value = ALLTRIM(cursor_4c_EmpConvV.RazSocs)
1130:         ELSE
1131:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpConv.Value = ""
1132:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpConv.Value = ""
1133:         ENDIF
1134:         IF USED("cursor_4c_EmpConvV")
1135:             USE IN cursor_4c_EmpConvV
1136:         ENDIF
1137:     ENDPROC
1138: 
1139:     PROCEDURE ValidarDataf()
1140:         LOCAL loc_dDatf, loc_dDati
1141:         loc_dDatf = THIS.pgf_4c_Principal.pgfiltro.txt_4c_Dataf.Value
1142:         loc_dDati = THIS.pgf_4c_Principal.pgfiltro.txt_4c_Datai.Value

*-- Linhas 1227 a 1245:
1227: 
1228:         IF loc_oBusca.this_lSelecionou
1229:             IF USED("cursor_4c_BuscaEmpresa")
1230:                 SELECT cursor_4c_BuscaEmpresa
1231:                 loc_oP1.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
1232:                 loc_oP1.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.RazSocs)
1233:             ENDIF
1234:         ENDIF
1235: 
1236:         IF USED("cursor_4c_BuscaEmpresa")
1237:             USE IN cursor_4c_BuscaEmpresa
1238:         ENDIF
1239:         loc_oBusca.Release()
1240:     ENDPROC
1241: 
1242:     PROCEDURE AbrirLookupConta()
1243:         LOCAL loc_oBusca, loc_oP1
1244:         loc_oP1 = THIS.pgf_4c_Principal.pgfiltro
1245: 

*-- Linhas 1261 a 1279:
1261: 
1262:         IF loc_oBusca.this_lSelecionou
1263:             IF USED("cursor_4c_BuscaConta")
1264:                 SELECT cursor_4c_BuscaConta
1265:                 loc_oP1.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.GruContas)
1266:                 loc_oP1.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.bancos) + ;
1267:                                                " - Ag" + CHR(234) + " " + ;
1268:                                                ALLTRIM(cursor_4c_BuscaConta.NAgencias)
1269:             ENDIF
1270:         ENDIF
1271: 
1272:         IF USED("cursor_4c_BuscaConta")
1273:             USE IN cursor_4c_BuscaConta
1274:         ENDIF
1275:         loc_oBusca.Release()
1276:     ENDPROC
1277: 
1278:     PROCEDURE AbrirLookupEmpConv()
1279:         LOCAL loc_oBusca, loc_oP1

*-- Linhas 1297 a 1315:
1297: 
1298:         IF loc_oBusca.this_lSelecionou
1299:             IF USED("cursor_4c_BuscaEmpConv")
1300:                 SELECT cursor_4c_BuscaEmpConv
1301:                 loc_oP1.txt_4c_CdEmpConv.Value = ALLTRIM(cursor_4c_BuscaEmpConv.Cemps)
1302:                 loc_oP1.txt_4c_DsEmpConv.Value = ALLTRIM(cursor_4c_BuscaEmpConv.RazSocs)
1303:             ENDIF
1304:         ENDIF
1305: 
1306:         IF USED("cursor_4c_BuscaEmpConv")
1307:             USE IN cursor_4c_BuscaEmpConv
1308:         ENDIF
1309:         loc_oBusca.Release()
1310:     ENDPROC
1311: 
1312:     *==========================================================================
1313:     * HANDLERS DOS BOTOES
1314:     *==========================================================================
1315: 

*-- Linhas 1345 a 1363:
1345:         ENDIF
1346: 
1347:         IF USED("cursor_4c_Grupos")
1348:             SELECT cursor_4c_Grupos
1349:             loc_nCont = 0
1350:             SCAN
1351:                 IF cursor_4c_Grupos.marca
1352:                     loc_nCont = loc_nCont + 1
1353:                 ENDIF
1354:             ENDSCAN
1355:             IF loc_nCont = 0
1356:                 MsgAviso("Nenhum grupo foi selecionado")
1357:                 RETURN
1358:             ENDIF
1359:         ENDIF
1360: 
1361:         THIS.Processamento()
1362:     ENDPROC
1363: 

*-- Linhas 1397 a 1497:
1397:                 RETURN
1398:             ENDIF
1399: 
1400:             SELECT cursor_4c_Filtro2Rel
1401:             GO TOP
1402: 
1403:             IF par_lImprimir
1404:                 REPORT FORM sigrecnb PREVIEW NOCONSOLE
1405:             ELSE
1406:                 REPORT FORM sigrecnb PREVIEW
1407:             ENDIF
1408: 
1409:             loc_lSucesso = .T.
1410:         CATCH TO loc_oErro
1411:             MsgErro(loc_oErro.Message, "Erro ImpBoleto")
1412:         ENDTRY
1413: 
1414:         RETURN loc_lSucesso
1415:     ENDPROC
1416: 
1417:     PROCEDURE ClickMarcarGrupos()
1418:         IF USED("cursor_4c_Grupos")
1419:             SELECT cursor_4c_Grupos
1420:             REPLACE ALL marca WITH .T.
1421:             GO TOP
1422:             THIS.pgf_4c_Principal.pgfiltro.grd_4c_Grupos.Refresh()
1423:         ENDIF
1424:     ENDPROC
1425: 
1426:     PROCEDURE ClickDesmarcarGrupos()
1427:         IF USED("cursor_4c_Grupos")
1428:             SELECT cursor_4c_Grupos
1429:             REPLACE ALL marca WITH .F.
1430:             GO TOP
1431:             THIS.pgf_4c_Principal.pgfiltro.grd_4c_Grupos.Refresh()
1432:         ENDIF
1433:     ENDPROC
1434: 
1435:     PROCEDURE ClickMarcarOper()
1436:         IF USED("cursor_4c_Filtro")
1437:             SELECT cursor_4c_Filtro
1438:             REPLACE ALL marca WITH .T.
1439:             GO TOP
1440:             THIS.pgf_4c_Principal.pgdados.grd_4c_Dados.Refresh()
1441:         ENDIF
1442:     ENDPROC
1443: 
1444:     PROCEDURE ClickDesmarcarOper()
1445:         IF USED("cursor_4c_Filtro")
1446:             SELECT cursor_4c_Filtro
1447:             REPLACE ALL marca WITH .F.
1448:             GO TOP
1449:             THIS.pgf_4c_Principal.pgdados.grd_4c_Dados.Refresh()
1450:         ENDIF
1451:     ENDPROC
1452: 
1453:     PROCEDURE ClickHeaderVencs()
1454:         IF USED("cursor_4c_Filtro")
1455:             SELECT cursor_4c_Filtro
1456:             INDEX ON vencs TAG vencs
1457:             SET ORDER TO vencs
1458:             THIS.OrdenarGrade()
1459:         ENDIF
1460:     ENDPROC
1461: 
1462:     PROCEDURE ClickHeaderValors()
1463:         IF USED("cursor_4c_Filtro")
1464:             SELECT cursor_4c_Filtro
1465:             INDEX ON Valors TAG valors
1466:             SET ORDER TO valors
1467:             THIS.OrdenarGrade()
1468:         ENDIF
1469:     ENDPROC
1470: 
1471:     PROCEDURE ClickHeaderHisto()
1472:         IF USED("cursor_4c_Filtro")
1473:             SELECT cursor_4c_Filtro
1474:             INDEX ON histo TAG histo
1475:             SET ORDER TO histo
1476:             THIS.OrdenarGrade()
1477:         ENDIF
1478:     ENDPROC
1479: 
1480:     PROCEDURE ClickHeaderRclis()
1481:         IF USED("cursor_4c_Filtro")
1482:             SELECT cursor_4c_Filtro
1483:             INDEX ON rclis TAG rclis
1484:             SET ORDER TO rclis
1485:             THIS.OrdenarGrade()
1486:         ENDIF
1487:     ENDPROC
1488: 
1489:     *==========================================================================
1490:     * BtnIncluirClick - Inicia novo processamento (volta para pagina de filtros)
1491:     * Form OPERACIONAL: "Incluir" = preparar novo lote CNAB a partir da pag. filtro
1492:     * Limpa o grid de dados e habilita filtros para nova selecao de operacoes
1493:     *==========================================================================
1494:     PROCEDURE BtnIncluirClick()
1495:         LOCAL loc_oErro
1496: 
1497:         TRY

*-- Linhas 1582 a 1607:
1582:                 loc_oGrd = loc_oP2.grd_4c_Dados
1583:                 loc_oGrd.ColumnCount = 8
1584:                 loc_oGrd.RecordSource = "cursor_4c_Filtro"
1585:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Filtro.marca"
1586:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Filtro.datas"
1587:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Filtro.vencs"
1588:                 loc_oGrd.Column4.ControlSource = "cursor_4c_Filtro.Valors"
1589:                 loc_oGrd.Column5.ControlSource = "cursor_4c_Filtro.moedas"
1590:                 loc_oGrd.Column6.ControlSource = "cursor_4c_Filtro.histo"
1591:                 loc_oGrd.Column7.ControlSource = "cursor_4c_Filtro.rclis"
1592:                 loc_oGrd.Column8.ControlSource = "cursor_4c_Filtro.emps"
1593:                 loc_oGrd.Column1.Header1.Caption = ""
1594:                 loc_oGrd.Column2.Header1.Caption = "Data"
1595:                 loc_oGrd.Column3.Header1.Caption = "Vencimento"
1596:                 loc_oGrd.Column4.Header1.Caption = "Valor"
1597:                 loc_oGrd.Column5.Header1.Caption = "Moeda"
1598:                 loc_oGrd.Column6.Header1.Caption = "Historico"
1599:                 loc_oGrd.Column7.Header1.Caption = "Fornecedor"
1600:                 loc_oGrd.Column8.Header1.Caption = "Empresa"
1601:                 loc_oGrd.SetAll("DynamicForeColor", "RGB(0,0,0)", "Column")
1602:                 loc_oGrd.Refresh()
1603:             ENDIF
1604:             THIS.pgf_4c_Principal.ActivePage = 2
1605:         ENDIF
1606:     ENDPROC
1607: 

*-- Linhas 1617 a 1642:
1617:         loc_oGrd.Refresh()
1618:         loc_oGrd.ColumnCount = 8
1619:         loc_oGrd.RecordSource = "cursor_4c_Filtro"
1620:         loc_oGrd.Column1.ControlSource = "cursor_4c_Filtro.marca"
1621:         loc_oGrd.Column2.ControlSource = "cursor_4c_Filtro.datas"
1622:         loc_oGrd.Column3.ControlSource = "cursor_4c_Filtro.vencs"
1623:         loc_oGrd.Column4.ControlSource = "cursor_4c_Filtro.Valors"
1624:         loc_oGrd.Column5.ControlSource = "cursor_4c_Filtro.moedas"
1625:         loc_oGrd.Column6.ControlSource = "cursor_4c_Filtro.histo"
1626:         loc_oGrd.Column7.ControlSource = "cursor_4c_Filtro.rclis"
1627:         loc_oGrd.Column8.ControlSource = "cursor_4c_Filtro.emps"
1628:         loc_oGrd.Column1.Header1.Caption = ""
1629:         loc_oGrd.Column2.Header1.Caption = "Data"
1630:         loc_oGrd.Column3.Header1.Caption = "Vencimento"
1631:         loc_oGrd.Column4.Header1.Caption = "Valor"
1632:         loc_oGrd.Column5.Header1.Caption = "Moeda"
1633:         loc_oGrd.Column6.Header1.Caption = "Historico"
1634:         loc_oGrd.Column7.Header1.Caption = "Fornecedor"
1635:         loc_oGrd.Column8.Header1.Caption = "Empresa"
1636:         loc_oGrd.SetAll("DynamicForeColor", "RGB(0,0,0)", "Column")
1637:         loc_oGrd.Refresh()
1638:     ENDPROC
1639: 
1640:     *==========================================================================
1641:     * Processamento - Executa busca com filtros e muda para pagina de dados
1642:     *==========================================================================

*-- Linhas 1661 a 1679:
1661:         *-- Monta lista de grupos marcados
1662:         loc_cGrupos = "("
1663:         IF USED("cursor_4c_Grupos")
1664:             SELECT cursor_4c_Grupos
1665:             SCAN
1666:                 IF cursor_4c_Grupos.marca
1667:                     loc_cGrupos = loc_cGrupos + IIF(loc_cGrupos == "(", "", ",") + ;
1668:                                   "'" + ALLTRIM(cursor_4c_Grupos.codigos) + "'"
1669:                 ENDIF
1670:             ENDSCAN
1671:         ENDIF
1672:         loc_cGrupos = loc_cGrupos + ")"
1673: 
1674:         *-- Limpa grid antes da busca
1675:         loc_oGrd.RecordSource = ""
1676:         loc_oGrd.Refresh()
1677: 
1678:         IF !loc_oBO.BuscarOperacoes(loc_cCdEmp, loc_cCdConta, loc_dDati, loc_dDatf, ;
1679:                                      loc_lNaoProc, loc_nPeriodo, loc_cGrupos)

*-- Linhas 1688 a 1713:
1688:         *-- Liga grid ao cursor
1689:         loc_oGrd.ColumnCount = 8
1690:         loc_oGrd.RecordSource = "cursor_4c_Filtro"
1691:         loc_oGrd.Column1.ControlSource = "cursor_4c_Filtro.marca"
1692:         loc_oGrd.Column2.ControlSource = "cursor_4c_Filtro.datas"
1693:         loc_oGrd.Column3.ControlSource = "cursor_4c_Filtro.vencs"
1694:         loc_oGrd.Column4.ControlSource = "cursor_4c_Filtro.Valors"
1695:         loc_oGrd.Column5.ControlSource = "cursor_4c_Filtro.moedas"
1696:         loc_oGrd.Column6.ControlSource = "cursor_4c_Filtro.histo"
1697:         loc_oGrd.Column7.ControlSource = "cursor_4c_Filtro.rclis"
1698:         loc_oGrd.Column8.ControlSource = "cursor_4c_Filtro.emps"
1699: 
1700:         loc_oGrd.Column1.Header1.Caption = ""
1701:         loc_oGrd.Column2.Header1.Caption = "Data"
1702:         loc_oGrd.Column3.Header1.Caption = "Vencimento"
1703:         loc_oGrd.Column4.Header1.Caption = "Valor"
1704:         loc_oGrd.Column5.Header1.Caption = "Moeda"
1705:         loc_oGrd.Column6.Header1.Caption = "Historico"
1706:         loc_oGrd.Column7.Header1.Caption = "Fornecedor"
1707:         loc_oGrd.Column8.Header1.Caption = "Empresa"
1708: 
1709:         loc_oGrd.SetAll("DynamicForeColor", "RGB(0,0,0)", "Column")
1710:         loc_oGrd.Refresh()
1711: 
1712:         *-- Muda para pagina de dados
1713:         THIS.AlternarPagina(2)

*-- Linhas 1756 a 1774:
1756:             LOCAL loc_nCont
1757:             loc_nCont = 0
1758:             IF USED("cursor_4c_Filtro")
1759:                 SELECT cursor_4c_Filtro
1760:                 SCAN
1761:                     IF cursor_4c_Filtro.marca
1762:                         loc_nCont = loc_nCont + 1
1763:                     ENDIF
1764:                 ENDSCAN
1765:             ENDIF
1766:             IF loc_nCont = 0
1767:                 MsgAviso("Nenhum registro foi selecionado")
1768:                 RETURN
1769:             ENDIF
1770: 
1771:             *-- Busca grupos da conta bancaria para montar GruContas
1772:             loc_cGruposConta = loc_oBO.BuscarGruposContaCli(loc_cCdConta)
1773:             IF EMPTY(loc_cGruposConta)
1774:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel determinar o grupo da conta banc" + CHR(225) + "ria.")

*-- Linhas 1788 a 1806:
1788:                 RETURN
1789:             ENDIF
1790: 
1791:             SELECT cursor_4c_Convenio
1792:             GO TOP
1793: 
1794:             *-- Define dias protesto do convenio
1795:             loc_oP2.spn_4c_Dias.Value = IIF(EMPTY(NVL(cursor_4c_Convenio.DiasProts, 0)), 5, cursor_4c_Convenio.DiasProts)
1796: 
1797:             *-- Despacha para o metodo CNAB correto
1798:             loc_cBanco = ALLTRIM(cursor_4c_Convenio.nbancos)
1799:             DO CASE
1800:                 CASE loc_cBanco = "001"
1801:                     THIS.CnabBrasil()
1802:                 CASE loc_cBanco = "341"
1803:                     THIS.CnabItau240()
1804:                 CASE loc_cBanco = "237"
1805:                     THIS.CnabBrades240()
1806:                 CASE INLIST(loc_cBanco, "033", "353")

*-- Linhas 1826 a 1854:
1826:                 USE IN cursor_4c_CabRel
1827:             ENDIF
1828:             SET NULL ON
1829:             CREATE CURSOR cursor_4c_CabRel (titulo C(100), periodo C(100), empresa C(100))
1830:             SET NULL OFF
1831:             INSERT INTO cursor_4c_CabRel (titulo, periodo, empresa) ;
1832:                 VALUES ("Dados para gera" + CHR(231) + CHR(227) + "o do CNAB", ;
1833:                         loc_cDataRel, ;
1834:                         loc_cCdEmp + " - " + ALLTRIM(NVL(cursor_4c_Empresa.RazSocs, "")))
1835: 
1836:             IF USED("cursor_4c_Filtro2Rel")
1837:                 USE IN cursor_4c_Filtro2Rel
1838:             ENDIF
1839:             SELECT *, SPACE(11) AS SeqNums FROM cursor_4c_Filtro WHERE marca INTO CURSOR cursor_4c_Filtro2Rel
1840: 
1841:             IF par_cTipo = "V"
1842:                 REPORT FORM sigrecnb PREVIEW
1843:             ENDIF
1844:         ENDIF
1845:     ENDPROC
1846: 
1847:     *==========================================================================
1848:     * BuscarBoleto - Classifica registros de cursor_4c_Filtro por tipo pagamento
1849:     * par_cBco: codigo banco FEBRABAN (ex: '341', '237', '033')
1850:     * Cria cursores: crFiltro2 (cc), crFiltroTr (transfer/pix), crFiltro3 (boleto),
1851:     *                crFiltro4 (doc), crFiltro5 (boleto outro banco),
1852:     *                crFiltro6 (tributos), crFiltro20 (todos processados)
1853:     *==========================================================================
1854:     PROCEDURE BuscarBoleto(par_cBco)

*-- Linhas 1861 a 1968:
1861:         ENDIF
1862: 
1863:         *-- Preenche campo barras em crFiltro2 a partir de SigMvCcb
1864:         SELECT crFiltro2
1865:         GO TOP
1866:         SCAN
1867:             loc_cFkChaves = ALLTRIM(crFiltro2.Emps) + STR(crFiltro2.Nopers, 10) + ALLTRIM(crFiltro2.Opers)
1868:             loc_cBarras   = THIS.this_oBusinessObject.BuscarBarrasCcb(loc_cFkChaves)
1869:             IF !EMPTY(loc_cBarras)
1870:                 REPLACE barras WITH loc_cBarras IN crFiltro2
1871:             ENDIF
1872:             SELECT crFiltro2
1873:         ENDSCAN
1874: 
1875:         *-- Salva snapshot de tudo (para update titbans depois)
1876:         IF USED("crFiltro20")
1877:             USE IN crFiltro20
1878:         ENDIF
1879:         SELECT * FROM crFiltro2 INTO CURSOR crFiltro20
1880: 
1881:         *-- Separa boletos (com barras) de transferencias (sem barras)
1882:         IF USED("crFiltro3")
1883:             USE IN crFiltro3
1884:         ENDIF
1885:         IF USED("crFiltroTr")
1886:             USE IN crFiltroTr
1887:         ENDIF
1888:         SELECT * FROM crFiltro2 WHERE ALLTRIM(barras) != SPACE(50) AND !EMPTY(ALLTRIM(barras)) INTO CURSOR crFiltro3 READWRITE
1889:         SELECT * FROM crFiltro2 WHERE ALLTRIM(barras) = SPACE(50) OR EMPTY(ALLTRIM(barras)) INTO CURSOR crFiltroTr READWRITE
1890: 
1891:         *-- Classifica transferencias: DOC (outro banco) vs credito em conta (mesmo banco)
1892:         IF USED("crFiltro4")
1893:             USE IN crFiltro4
1894:         ENDIF
1895:         IF USED("crFiltro2")
1896:             USE IN crFiltro2
1897:         ENDIF
1898:         SELECT * FROM crFiltroTr WHERE Grupos + contas IN (SELECT GruContas FROM cursor_4c_BancoDif) INTO CURSOR crFiltro4 READWRITE
1899:         SELECT * FROM crFiltroTr WHERE Grupos + contas IN (SELECT GruContas FROM cursor_4c_BancoIgual) INTO CURSOR crFiltro2 READWRITE
1900: 
1901:         *-- Classifica boletos: tributos (len=48), mesmo banco, outro banco
1902:         IF USED("crFiltro6")
1903:             USE IN crFiltro6
1904:         ENDIF
1905:         IF USED("crFiltro5")
1906:             USE IN crFiltro5
1907:         ENDIF
1908:         SELECT * FROM crFiltro3 WHERE LEN(ALLTRIM(barras)) = 48 INTO CURSOR crFiltro6 READWRITE
1909:         SELECT * FROM crFiltro3 WHERE LEN(ALLTRIM(barras)) != 48 AND SUBSTR(barras, 1, 3) != par_cBco INTO CURSOR crFiltro5 READWRITE
1910:         SELECT * FROM crFiltro3 WHERE LEN(ALLTRIM(barras)) != 48 AND SUBSTR(barras, 1, 3) = par_cBco INTO CURSOR crFiltro3 READWRITE
1911: 
1912:         *-- Identifica PIX (tipochv preenchido em crFiltroTr)
1913:         SELECT * FROM crFiltroTr WHERE !EMPTY(ALLTRIM(tipochv)) INTO CURSOR crFiltroTr READWRITE
1914: 
1915:         *-- Se ha PIX, esvazia os outros cursores (processa apenas PIX)
1916:         LOCAL loc_cMsg
1917:         loc_cMsg = ""
1918:         IF RECCOUNT("crFiltroTr") > 0
1919:             SELECT * FROM crFiltro2  WHERE 0 = 1 INTO CURSOR crFiltro2  READWRITE
1920:             SELECT * FROM crFiltro3  WHERE 0 = 1 INTO CURSOR crFiltro3  READWRITE
1921:             SELECT * FROM crFiltro4  WHERE 0 = 1 INTO CURSOR crFiltro4  READWRITE
1922:             SELECT * FROM crFiltro5  WHERE 0 = 1 INTO CURSOR crFiltro5  READWRITE
1923:             SELECT * FROM crFiltro6  WHERE 0 = 1 INTO CURSOR crFiltro6  READWRITE
1924:             loc_cMsg = "Ser" + CHR(225) + " gerado remessa apenas de PIX." + CHR(13) + CHR(10)
1925:         ENDIF
1926: 
1927:         *-- Titulos sem dados bancarios (para aviso)
1928:         LOCAL loc_cSemDados
1929:         loc_cSemDados = ""
1930:         IF USED("crErro")
1931:             USE IN crErro
1932:         ENDIF
1933:         SELECT * FROM crFiltro20 ;
1934:             WHERE Grupos + contas NOT IN (SELECT Grupos + contas FROM crFiltro2) ;
1935:             AND   Grupos + contas NOT IN (SELECT Grupos + contas FROM crFiltro3) ;
1936:             AND   Grupos + contas NOT IN (SELECT Grupos + contas FROM crFiltro4) ;
1937:             AND   Grupos + contas NOT IN (SELECT Grupos + contas FROM crFiltro5) ;
1938:             AND   Grupos + contas NOT IN (SELECT Grupos + contas FROM crFiltroTr) ;
1939:             AND   Grupos + contas NOT IN (SELECT Grupos + contas FROM crFiltro6) ;
1940:             INTO CURSOR crErro
1941: 
1942:         SELECT crErro
1943:         GO TOP
1944:         SCAN
1945:             loc_cMsg = loc_cMsg + ALLTRIM(crErro.contas) + "-" + ALLTRIM(crErro.rclis) + CHR(13) + CHR(10)
1946:         ENDSCAN
1947: 
1948:         IF !EMPTY(loc_cMsg)
1949:             MsgAviso(loc_cMsg + CHR(13) + "N" + CHR(227) + "o entraram no CNAB")
1950:         ENDIF
1951: 
1952:         *-- Atualiza crFiltro20 removendo os que nao entraram
1953:         SELECT * FROM crFiltro20 WHERE Grupos + contas NOT IN (SELECT Grupos + contas FROM crErro) INTO CURSOR crFiltro20 READWRITE
1954:     ENDPROC
1955: 
1956:     *==========================================================================
1957:     * CnabItau240 - Gera arquivo CNAB 240 posicoes para Itau (banco 341)
1958:     *==========================================================================
1959:     PROCEDURE CnabItau240()
1960:         LOCAL loc_oBO, loc_oP2
1961:         LOCAL lcCnv, lcAgeE, lcDigAE, lcCtaCE, lcDigCE, lcCtaE
1962:         LOCAL lcRaz, lcCgc, lctpcgc, lcrazbco
1963:         LOCAL lcDat, lcHora, lcprot, lcEnv, lcArq, lcTpCtArq, lcTpCtBol
1964:         LOCAL lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco
1965:         LOCAL lnLot, lcLot, lnSeq, lcSeq, lcFin, lnQlote, lcQlote
1966:         LOCAL lcstrg, lok, lnPix
1967:         LOCAL loc_cSQL
1968: 

*-- Linhas 1974 a 2008:
1974:         IF USED("crFiltro2")
1975:             USE IN crFiltro2
1976:         ENDIF
1977:         SELECT *, SPACE(10) AS nossoNum, SPACE(50) AS barras FROM cursor_4c_Filtro WHERE marca INTO CURSOR crFiltro2 READWRITE
1978: 
1979:         *-- Classifica registros por tipo de pagamento
1980:         THIS.BuscarBoleto("341")
1981: 
1982:         *-- Variaveis do convenio e empresa (de cursor_4c_Convenio e cursor_4c_Empresa)
1983:         SELECT cursor_4c_Convenio
1984:         GO TOP
1985: 
1986:         lcCnv  = PADR(ALLTRIM(cursor_4c_Convenio.Convenios), 20, " ")
1987:         lcAgeE = PADL(ALLTRIM(cursor_4c_Convenio.NAgencias), 5, "0")
1988:         lcDigAE= ALLTRIM(cursor_4c_Convenio.DigiAgen)
1989:         lcCtaCE= PADL(ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")), 13, "0")
1990:         lcDigCE= SUBSTR(lcCtaCE, 13, 1)
1991:         lcCtaE = SUBSTR(lcCtaCE, 1, 12)
1992: 
1993:         SELECT cursor_4c_Empresa
1994:         GO TOP
1995: 
1996:         lcRaz    = PADR(ALLTRIM(cursor_4c_Empresa.RazSocs), 30)
1997:         lcCgc    = PADL(ALLTRIM(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Empresa.Cgcs, "/", ""), ".", ""), "-", "")), 14, "0")
1998:         lctpcgc  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Empresa.Cgcs, "/.-", ""))) = 11, "1", "2")
1999:         lcrazbco = PADR(ALLTRIM(cursor_4c_Convenio.bancos), 30)
2000: 
2001:         lcDat     = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 7, 4)
2002:         lcHora    = TTOC(DATETIME())
2003:         lcHora    = SUBSTR(lcHora, 12, 2) + SUBSTR(lcHora, 15, 2) + SUBSTR(lcHora, 18, 2)
2004:         lcprot    = IIF(loc_oP2.spn_4c_Dias.Value = 0, 5, loc_oP2.spn_4c_Dias.Value)
2005:         lcprot    = PADL(ALLTRIM(STR(lcprot)), 2, "0")
2006:         lcEnv     = PADL(fGerUniqueKey("ITAUENV"), 7, "0")
2007:         lcArq     = ALLTRIM(cursor_4c_Convenio.Drive) + IIF(EMPTY(ALLTRIM(cursor_4c_Convenio.Drive)), "", "\")
2008:         lcArq     = STRTRAN(lcArq + ALLTRIM(cursor_4c_Convenio.ArqCnabs) + lcEnv + ".REM", "\\", "\")

*-- Linhas 2092 a 2110:
2092: 
2093:         *-- Boleto outro banco (crFiltro5)
2094:         IF RECCOUNT("crFiltro5") > 0 AND RECCOUNT("crFiltroTr") = 0
2095:             SELECT * FROM crFiltro5 INTO CURSOR crFiltro3 READWRITE
2096:             THIS.CnabItau240LoteBoleto(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, ;
2097:                 lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
2098:                 lcArq, lcprot, "31", "crFiltro3", "341")
2099:         ENDIF
2100: 
2101:         *-- Trailer do arquivo
2102:         IF FILE(lcArq)
2103:             LOCAL lcT001a003, lcT004a007, lcT008a008, lcT009a017, lcT018a023, lcT024a029, lcT030a035, lcT036a240
2104:             lcT001a003 = "341"
2105:             lcT004a007 = "9999"
2106:             lcT008a008 = "9"
2107:             lcT009a017 = SPACE(9)
2108:             lcT018a023 = "00" + PADL(ALLTRIM(STR(THIS.this_nCnabLot)), 4, "0")
2109:             lcT024a029 = PADL(ALLTRIM(STR(INT(FSIZE(lcArq)/242)+1)), 6, "0")
2110:             lcT030a035 = "000000"

*-- Linhas 2116 a 2146:
2116:             *-- Atualiza titbans em SigMvCcr
2117:             lok = .T.
2118:             IF lok
2119:                 SELECT crFiltro20
2120:                 SCAN
2121:                     LOCAL loc_cTitBans, loc_cTitulos, loc_lAtua
2122:                     loc_cTitBans = loc_oBO.BuscarTituloBanco(crFiltro20.nopers)
2123:                     loc_cTitulos = ALLTRIM(NVL(crFiltro20.titulos, ""))
2124:                     loc_lAtua = .T.
2125:                     IF !EMPTY(loc_cTitBans)
2126:                         loc_lAtua = MsgConfirma('T' + CHR(237) + 'tulo "' + loc_cTitulos + '" j' + CHR(225) + ' possui T' + CHR(237) + 'tulo do Banco preenchido. Sobrescrever?')
2127:                     ENDIF
2128:                     IF loc_lAtua
2129:                         loc_oBO.AtualizarTituloBanco(crFiltro20.nopers, "TIT ITAU")
2130:                     ENDIF
2131:                     SELECT crFiltro20
2132:                 ENDSCAN
2133:             ENDIF
2134: 
2135:             MsgAviso("Arquivo '" + lcArq + "' gerado com sucesso.")
2136:             THIS.pgf_4c_Principal.pgdados.cgp_4c_Acoes.Command3.Enabled = .F.
2137:         ENDIF
2138:     ENDPROC
2139: 
2140:     *==========================================================================
2141:     * CnabItau240LoteCC - Gera lote de credito em conta / DOC para Itau 240
2142:     *==========================================================================
2143:     PROTECTED PROCEDURE CnabItau240LoteCC(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, ;
2144:         lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
2145:         lcArq, lcprot, par_cFormaPgto, par_cCursor, par_cBanco)
2146: 

*-- Linhas 2204 a 2233:
2204:         lnValtot = 0
2205:         lnMoetot = 0
2206: 
2207:         SELECT (par_cCursor)
2208:         SCAN
2209:             *-- Busca conta do favorecido
2210:             loc_cSQL = "SELECT * FROM SigCdCeb WHERE GruContas = " + ;
2211:                        EscaparSQL(Grupos + contas) + ;
2212:                        " AND NAgencias != '' AND contas != '' AND nbancos != 0 ORDER BY NAgencias"
2213:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Conta") < 1
2214:                 MsgAviso("Falha na conex" + CHR(227) + "o ao buscar conta do favorecido.")
2215:                 LOOP
2216:             ENDIF
2217:             GO TOP IN cursor_4c_Conta
2218:             SELECT (par_cCursor)
2219:             IF RECCOUNT("cursor_4c_Conta") = 0
2220:                 lcSemCC = lcSemCC + contas + " "
2221:                 LOOP
2222:             ENDIF
2223: 
2224:             LOCAL lcnopers, lcvenc, lccgccli, lctpcgcCli, lcnome
2225:             LOCAL lcValpag, lcValmoe, lcende, lcbair, lcCep, lcCida, lcEsta
2226:             LOCAL lcnumero, lcCompl, lcCep1, lcCep2
2227:             LOCAL lcBco, lcAge, lcDigA, lcCtaC, lcDigC, lcDigAC, lcCta, lcAgCta, lcTpcta
2228:             LOCAL lcOutCgc, lcnumtit, lcChave, lcNossoNum, lcTptrans
2229:             LOCAL lcA001a003, lcA004a007, lcA008a008, lcA009a013, lcA014a014
2230:             LOCAL lcA015a017, lcA018a020, lcA021a023, lcA024a043, lcA044a073
2231:             LOCAL lcA074a093, lcA094a101, lcA102a104, lcA105a112, lcA113a114
2232:             LOCAL lcA115a119, lcA120a134, lcA135a149, lcA150a154, lcA155a162
2233:             LOCAL lcA163a177, lcA178a195, lcA196a197, lcA198a203, lcA204a217

*-- Linhas 2253 a 2285:
2253:             lcCep1  = SUBSTR(lcCep, 1, 5)
2254:             lcCep2  = SUBSTR(lcCep, 6, 3)
2255: 
2256:             SELECT cursor_4c_Conta
2257:             GO TOP
2258:             lcBco  = PADL(ALLTRIM(cursor_4c_Conta.nbancos), 3, "0")
2259:             lcAge  = PADL(ALLTRIM(cursor_4c_Conta.NAgencias), 5, "0")
2260:             lcDigA = ALLTRIM(cursor_4c_Conta.DigiAgen)
2261:             lcCtaC = PADL(ALLTRIM(CHRTRAN(cursor_4c_Conta.contas, ".-", "")), 13, "0")
2262:             lcDigC = SUBSTR(lcCtaC, 13, 1)
2263:             lcDigAC = " "
2264:             lcCta  = SUBSTR(lcCtaC, 1, 12)
2265:             lcAgCta = lcAge + " " + lcCta + " " + lcDigC
2266:             lcTpcta = IIF(cursor_4c_Conta.tpCtas = "02", "02", "01")
2267:             lcOutCgc = ALLTRIM(CHRTRAN(cursor_4c_Conta.Convenios, "/.-,", ""))
2268:             lccgccli = IIF(LEN(lcOutCgc) != 11 AND LEN(lcOutCgc) != 14, lccgccli, PADL(lcOutCgc, 14, "0"))
2269: 
2270:             SELECT (par_cCursor)
2271:             lcnumtit = PADL(ALLTRIM(STRTRAN(titulos, "/", "")), 15, "0")
2272:             lcChave  = PADR(ALLTRIM(titulos), 10) + lcnopers
2273: 
2274:             lcNossoNum = ALLTRIM(STR(fGerUniqueKey("BRNOSSONUM")))
2275:             REPLACE nossoNum WITH PADL(lcNossoNum, 10, "0") IN (par_cCursor)
2276:             lcNossoNum = PADR(lcNossoNum, 20)
2277: 
2278:             lnSeql = lnSeql + 1
2279:             lcSeql = TRANSFORM(lnSeql, "@L 99999")
2280:             lnQlote = lnQlote + 1
2281:             lnSeq = lnSeq + 1
2282: 
2283:             lcA001a003 = par_cBanco
2284:             lcA004a007 = lcLot
2285:             lcA008a008 = "3"

*-- Linhas 2323 a 2341:
2323: 
2324:             loc_oBO.RegistrarLinhaArquivo("C", nopers, lcstrg, titulos, lcChave)
2325: 
2326:             SELECT (par_cCursor)
2327:         ENDSCAN
2328: 
2329:         *-- Trailer do lote
2330:         lnSeq = lnSeq + 1
2331:         lnSeql = lnSeql + 1
2332:         lcSeql = TRANSFORM(lnSeql, "@L 999999")
2333:         lnQlote = lnQlote + 1
2334:         lcQlote = TRANSFORM(lnQlote, "@L 999999")
2335:         LOCAL lcValtotStr, lcMoetotStr
2336:         lcValtotStr = TRANSFORM(lnValtot * 100, "@L 999999999999999999")
2337:         lcMoetotStr = TRANSFORM(lnMoetot * 100000, "@L 999999999999999999")
2338: 
2339:         LOCAL lcTL001a003, lcTL004a007, lcTL008a008, lcTL009a017, lcTL018a023
2340:         LOCAL lcTL024a041, lcTL042a059, lcTL060a230, lcTL231a240
2341:         lcTL001a003 = par_cBanco

*-- Linhas 2417 a 2435:
2417:         lnValtot = 0
2418:         lnMoetot = 0
2419: 
2420:         SELECT (par_cCursor)
2421:         SCAN
2422:             lnQlote = lnQlote + 1
2423: 
2424:             LOCAL lcnopers, lcvenc, lccgccli, lctpcgcCli, lcnome, lcValpag, lcValmoe
2425:             LOCAL lcBarra, lcChave, lcNossoNum
2426:             LOCAL lcJ001a003, lcJ004a007, lcJ008a008, lcJ009a013, lcJ014a014
2427:             LOCAL lcJ015a017, lcJ018a061, lcJ062a091, lcJ092a099, lcJ100a114
2428:             LOCAL lcJ115a129, lcJ130a144, lcJ145a152, lcJ153a167, lcJ168a182
2429:             LOCAL lcJ183a202, lcJ203a215, lcJ216a230, lcJ231a240
2430: 
2431:             lcnopers   = TRANSFORM(nopers, "@L 9999999999")
2432:             lcvenc     = SUBSTR(DTOC(vencs), 1, 2) + SUBSTR(DTOC(vencs), 4, 2) + SUBSTR(DTOC(vencs), 7, 4)
2433:             lccgccli   = PADL(ALLTRIM(CHRTRAN(cpfs, "/.-,", "")), 14, "0")
2434:             lctpcgcCli = IIF(LEN(ALLTRIM(CHRTRAN(cpfs, "/.-", ""))) = 11, "1", "2")
2435:             lcnome     = PADR(ALLTRIM(IIF(EMPTY(Razaos), rclis, Razaos)), 30)

*-- Linhas 2512 a 2530:
2512: 
2513:             loc_oBO.RegistrarLinhaArquivo("C", nopers, lcstrg, titulos, lcChave)
2514: 
2515:             SELECT (par_cCursor)
2516:         ENDSCAN
2517: 
2518:         *-- Trailer do lote
2519:         lnSeq = lnSeq + 1
2520:         lnSeql = lnSeql + 1
2521:         lcSeql = TRANSFORM(lnSeql, "@L 999999")
2522:         lnQlote = lnQlote + 1
2523:         lcQlote = TRANSFORM(lnQlote, "@L 999999")
2524:         LOCAL lcValtotStr, lcMoetotStr
2525:         lcValtotStr = TRANSFORM(lnValtot * 100, "@L 999999999999999999")
2526:         lcMoetotStr = "000000000000000000"
2527: 
2528:         LOCAL lcTL001a003, lcTL004a007, lcTL008a008, lcTL009a017, lcTL018a023
2529:         LOCAL lcTL024a041, lcTL042a059, lcTL060a065, lcTL066a230, lcTL231a240
2530:         lcTL001a003 = par_cBanco

*-- Linhas 2562 a 2585:
2562:         IF USED("crFiltro2")
2563:             USE IN crFiltro2
2564:         ENDIF
2565:         SELECT *, SPACE(10) AS nossoNum, SPACE(50) AS barras FROM cursor_4c_Filtro WHERE marca INTO CURSOR crFiltro2 READWRITE
2566:         THIS.BuscarBoleto("237")
2567: 
2568:         SELECT cursor_4c_Convenio
2569:         GO TOP
2570:         SELECT cursor_4c_Empresa
2571:         GO TOP
2572: 
2573:         lcCnv  = PADR(ALLTRIM(cursor_4c_Convenio.Convenios), 20, " ")
2574:         lcAgeE = PADL(ALLTRIM(cursor_4c_Convenio.NAgencias), 5, "0")
2575:         lcDigAE= PADR(ALLTRIM(cursor_4c_Convenio.DigiAgen), 1)
2576:         lcCtaCE= PADL(ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")), 13, "0")
2577:         lcDigCE= SUBSTR(lcCtaCE, 13, 1)
2578:         lcDigACE = " "
2579:         lcCtaE = SUBSTR(lcCtaCE, 1, 12)
2580:         lcRaz    = PADR(ALLTRIM(cursor_4c_Empresa.RazSocs), 30)
2581:         lcCgc    = PADL(ALLTRIM(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Empresa.Cgcs, "/", ""), ".", ""), "-", "")), 14, "0")
2582:         lctpcgc  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Empresa.Cgcs, "/.-", ""))) = 11, "1", "2")
2583:         lcrazbco = PADR(ALLTRIM(cursor_4c_Convenio.bancos), 30)
2584:         lcDat    = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 7, 4)
2585:         lcprot   = IIF(loc_oP2.spn_4c_Dias.Value = 0, 5, loc_oP2.spn_4c_Dias.Value)

*-- Linhas 2660 a 2713:
2660:         ENDIF
2661: 
2662:         IF RECCOUNT("crFiltro5") > 0
2663:             SELECT * FROM crFiltro5 INTO CURSOR crFiltro3 READWRITE
2664:             THIS.CnabBrades240LoteBoleto(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
2665:                 lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
2666:                 lcArq, lcprot, "crFiltro3", "237")
2667:         ENDIF
2668: 
2669:         *-- Trailer do arquivo
2670:         IF FILE(lcArq)
2671:             LOCAL lcT001a003, lcT004a007, lcT008a008, lcT009a017, lcT018a023, lcT024a029, lcT030a035, lcT036a240
2672:             lcT001a003 = "237"
2673:             lcT004a007 = "9999"
2674:             lcT008a008 = "9"
2675:             lcT009a017 = SPACE(9)
2676:             lcT018a023 = "00" + PADL(ALLTRIM(STR(THIS.this_nCnabLot)), 4, "0")
2677:             lcT024a029 = PADL(ALLTRIM(STR(INT(FSIZE(lcArq)/242)+1)), 6, "0")
2678:             lcT030a035 = "000000"
2679:             lcT036a240 = SPACE(205)
2680:             lcstrg = lcT001a003+lcT004a007+lcT008a008+lcT009a017+lcT018a023+lcT024a029+lcT030a035+lcT036a240+CHR(13)+CHR(10)
2681:             lcstrg = fLimpaTexto(lcstrg)
2682:             STRTOFILE(lcstrg, lcArq, 1)
2683: 
2684:             lok = .T.
2685:             IF lok
2686:                 SELECT crFiltro20
2687:                 SCAN
2688:                     LOCAL loc_cTitBans, loc_cTitulos, loc_lAtua
2689:                     loc_cTitBans = loc_oBO.BuscarTituloBanco(crFiltro20.nopers)
2690:                     loc_cTitulos = ALLTRIM(NVL(crFiltro20.titulos, ""))
2691:                     loc_lAtua = .T.
2692:                     IF !EMPTY(loc_cTitBans)
2693:                         loc_lAtua = MsgConfirma('T' + CHR(237) + 'tulo "' + loc_cTitulos + '" j' + CHR(225) + ' possui T' + CHR(237) + 'tulo do Banco preenchido. Sobrescrever?')
2694:                     ENDIF
2695:                     IF loc_lAtua
2696:                         loc_oBO.AtualizarTituloBanco(crFiltro20.nopers, "TIT BRADESC")
2697:                     ENDIF
2698:                     SELECT crFiltro20
2699:                 ENDSCAN
2700:             ENDIF
2701: 
2702:             MsgAviso("Arquivo '" + lcArq + "' gerado com sucesso.")
2703:             THIS.pgf_4c_Principal.pgdados.cgp_4c_Acoes.Command3.Enabled = .F.
2704:         ENDIF
2705:     ENDPROC
2706: 
2707:     *==========================================================================
2708:     * CnabBrades240LoteCC - Lote credito em conta para Bradesco
2709:     *==========================================================================
2710:     PROTECTED PROCEDURE CnabBrades240LoteCC(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
2711:         lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
2712:         lcArq, lcprot, par_cFormaPgto, par_cCursor, par_cBanco)
2713: 

*-- Linhas 2768 a 2824:
2768:         lnValtot = 0
2769:         lnMoetot = 0
2770: 
2771:         SELECT (par_cCursor)
2772:         SCAN
2773:             loc_cSQL = "SELECT * FROM SigCdCeb WHERE GruContas = " + ;
2774:                        EscaparSQL(Grupos + contas) + ;
2775:                        " AND NAgencias != '' AND contas != '' AND nbancos != 0 ORDER BY NAgencias"
2776:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Conta") < 1
2777:                 LOOP
2778:             ENDIF
2779:             GO TOP IN cursor_4c_Conta
2780:             SELECT (par_cCursor)
2781:             IF RECCOUNT("cursor_4c_Conta") = 0
2782:                 LOOP
2783:             ENDIF
2784: 
2785:             LOCAL lcnopers, lcvenc, lccgccli, lctpcgcCli, lcnome
2786:             LOCAL lcValpag, lcChave, lcNossoNum, lcTpcta
2787:             LOCAL lcBco, lcAge, lcDigA, lcCtaC, lcDigC, lcCta, lcAgCta, lcOutCgc
2788: 
2789:             lcnopers   = TRANSFORM(nopers, "@L 9999999999")
2790:             lcvenc     = SUBSTR(DTOC(vencs), 1, 2) + SUBSTR(DTOC(vencs), 4, 2) + SUBSTR(DTOC(vencs), 7, 4)
2791:             lccgccli   = PADL(ALLTRIM(CHRTRAN(cpfs, "/.-,", "")), 14, "0")
2792:             lctpcgcCli = IIF(LEN(ALLTRIM(CHRTRAN(cpfs, "/.-", ""))) = 11, "1", "2")
2793:             lcnome     = PADR(ALLTRIM(IIF(EMPTY(Razaos), rclis, Razaos)), 30)
2794:             lcValpag   = TRANSFORM(valors * 100, "@L 999999999999999")
2795:             lnValtot   = lnValtot + valors
2796: 
2797:             SELECT cursor_4c_Conta
2798:             GO TOP
2799:             lcBco  = PADL(ALLTRIM(cursor_4c_Conta.nbancos), 3, "0")
2800:             lcAge  = PADL(ALLTRIM(cursor_4c_Conta.NAgencias), 5, "0")
2801:             lcCtaC = PADL(ALLTRIM(CHRTRAN(cursor_4c_Conta.contas, ".-", "")), 13, "0")
2802:             lcDigC = SUBSTR(lcCtaC, 13, 1)
2803:             lcCta  = SUBSTR(lcCtaC, 1, 12)
2804:             lcAgCta = lcAge + " " + lcCta + " " + lcDigC
2805:             lcTpcta = IIF(cursor_4c_Conta.tpCtas = "02", "PP", "CC")
2806:             lcOutCgc = ALLTRIM(CHRTRAN(cursor_4c_Conta.Convenios, "/.-,", ""))
2807:             lccgccli = IIF(LEN(lcOutCgc) != 11 AND LEN(lcOutCgc) != 14, lccgccli, PADL(lcOutCgc, 14, "0"))
2808: 
2809:             SELECT (par_cCursor)
2810:             lcChave  = PADR(ALLTRIM(titulos), 10) + lcnopers
2811:             lcNossoNum = ALLTRIM(STR(fGerUniqueKey("BRNOSSONUM")))
2812:             REPLACE nossoNum WITH PADL(lcNossoNum, 10, "0") IN (par_cCursor)
2813: 
2814:             lnSeql = lnSeql + 1
2815:             lcSeql = TRANSFORM(lnSeql, "@L 99999")
2816:             lnQlote = lnQlote + 1
2817:             lnSeq = lnSeq + 1
2818: 
2819:             LOCAL lcA001a003, lcA004a007, lcA008a008, lcA009a013, lcA014a014
2820:             LOCAL lcA015a017, lcA018a020, lcA021a023, lcA024a043, lcA044a073
2821:             LOCAL lcA074a093, lcA094a101, lcA102a104, lcA105a112, lcA113a119
2822:             LOCAL lcA120a134, lcA135a149, lcA150a154, lcA155a162, lcA163a177
2823:             LOCAL lcA178a195, lcA196a197, lcA198a203, lcA204a217, lcA218a219
2824:             LOCAL lcA220a224, lcA225a229, lcA230a230, lcA231a240

*-- Linhas 2863 a 2881:
2863:             STRTOFILE(lcstrg, lcArq, 1)
2864: 
2865:             loc_oBO.RegistrarLinhaArquivo("C", nopers, lcstrg, titulos, lcChave)
2866:             SELECT (par_cCursor)
2867:         ENDSCAN
2868: 
2869:         lnSeq = lnSeq + 1
2870:         lnSeql = lnSeql + 1
2871:         lcSeql = TRANSFORM(lnSeql, "@L 999999")
2872:         lnQlote = lnQlote + 1
2873:         lcQlote = TRANSFORM(lnQlote, "@L 999999")
2874:         LOCAL lcValtotStr, lcMoetotStr
2875:         lcValtotStr = TRANSFORM(lnValtot * 100, "@L 999999999999999999")
2876:         lcMoetotStr = "000000000000000000"
2877:         LOCAL lcTL001a003, lcTL004a007, lcTL008a008, lcTL009a017, lcTL018a023
2878:         LOCAL lcTL024a041, lcTL042a059, lcTL060a230, lcTL231a240
2879:         lcTL001a003 = par_cBanco
2880:         lcTL004a007 = lcLot
2881:         lcTL008a008 = "5"

*-- Linhas 2952 a 2979:
2952:         lnSeql = 0
2953:         lnValtot = 0
2954: 
2955:         SELECT (par_cCursor)
2956:         SCAN
2957:             lnQlote = lnQlote + 1
2958:             loc_cSQL = "SELECT * FROM SigCdCeb WHERE GruContas = " + ;
2959:                        EscaparSQL(Grupos + contas) + ;
2960:                        " ORDER BY NAgencias"
2961:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Conta") >= 1
2962:                 GO TOP IN cursor_4c_Conta
2963:             ENDIF
2964:             SELECT (par_cCursor)
2965: 
2966:             LOCAL lcnopers, lcvenc, lccgccli, lcnome, lcValpag, lcBarra, lcChave, lcNossoNum
2967:             LOCAL lcO001a003, lcO004a007, lcO008a008, lcO009a013, lcO014a014
2968:             LOCAL lcO015a015, lcO016a017, lcO018a061, lcO062a091, lcO092a099
2969:             LOCAL lcO100a107, lcO108a122, lcO123a142, lcO143a162, lcO163a230, lcO231a240
2970: 
2971:             lcnopers = TRANSFORM(nopers, "@L 9999999999")
2972:             lcvenc   = SUBSTR(DTOC(vencs), 1, 2) + SUBSTR(DTOC(vencs), 4, 2) + SUBSTR(DTOC(vencs), 7, 4)
2973:             lccgccli = PADL(ALLTRIM(CHRTRAN(cpfs, "/.-,", "")), 14, "0")
2974:             lcnome   = PADR(ALLTRIM(IIF(EMPTY(Razaos), rclis, Razaos)), 30)
2975:             lcValpag = TRANSFORM(valors * 100, "@L 999999999999999")
2976:             lnValtot = lnValtot + valors
2977:             lcBarra  = ALLTRIM(CHRTRAN(barras, "/.-", "")) + REPLICATE("0", 44)
2978:             lcBarra  = SUBSTR(lcBarra, 1, 4) + SUBSTR(lcBarra, 33, 15) + SUBSTR(lcBarra, 5, 5) + SUBSTR(lcBarra, 11, 10) + SUBSTR(lcBarra, 22, 10)
2979:             lcChave  = PADR(ALLTRIM(titulos), 10) + lcnopers

*-- Linhas 3008 a 3026:
3008:             STRTOFILE(lcstrg, lcArq, 1)
3009: 
3010:             loc_oBO.RegistrarLinhaArquivo("C", nopers, lcstrg, titulos, lcChave)
3011:             SELECT (par_cCursor)
3012:         ENDSCAN
3013: 
3014:         lnSeq = lnSeq + 1
3015:         lnSeql = lnSeql + 1
3016:         lcSeql = TRANSFORM(lnSeql, "@L 999999")
3017:         lnQlote = lnQlote + 1
3018:         lcQlote = TRANSFORM(lnQlote, "@L 999999")
3019:         LOCAL lcValtotStr
3020:         lcValtotStr = TRANSFORM(lnValtot * 100, "@L 999999999999999999")
3021:         LOCAL lcTL001a003, lcTL004a007, lcTL008a008, lcTL009a017, lcTL018a023
3022:         LOCAL lcTL024a041, lcTL042a059, lcTL060a065, lcTL066a230, lcTL231a240
3023:         lcTL001a003 = par_cBanco
3024:         lcTL004a007 = lcLot
3025:         lcTL008a008 = "5"
3026:         lcTL009a017 = SPACE(9)

*-- Linhas 3055 a 3078:
3055:         IF USED("crFiltro2")
3056:             USE IN crFiltro2
3057:         ENDIF
3058:         SELECT *, SPACE(10) AS nossoNum, SPACE(50) AS barras FROM cursor_4c_Filtro WHERE marca INTO CURSOR crFiltro2 READWRITE
3059:         THIS.BuscarBoleto("033")
3060: 
3061:         SELECT cursor_4c_Convenio
3062:         GO TOP
3063:         SELECT cursor_4c_Empresa
3064:         GO TOP
3065: 
3066:         lcAgeE = PADL(ALLTRIM(cursor_4c_Convenio.NAgencias), 5, "0")
3067:         lcCnv  = "0033" + SUBSTR(lcAgeE, 2, 4) + PADL(ALLTRIM(cursor_4c_Convenio.Convenios), 12, "0")
3068:         lcDigAE = ALLTRIM(cursor_4c_Convenio.DigiAgen)
3069:         lcCtaCE = PADL(ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")), 13, "0")
3070:         lcDigCE = SUBSTR(lcCtaCE, 13, 1)
3071:         lcDigACE = " "
3072:         lcCtaE = SUBSTR(lcCtaCE, 1, 12)
3073:         lcRaz    = PADR(ALLTRIM(cursor_4c_Empresa.RazSocs), 30)
3074:         lcCgc    = PADL(ALLTRIM(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Empresa.Cgcs, "/", ""), ".", ""), "-", "")), 14, "0")
3075:         lctpcgc  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Empresa.Cgcs, "/.-", ""))) = 11, "1", "2")
3076:         lcrazbco = PADR(ALLTRIM(cursor_4c_Convenio.bancos), 30)
3077:         lcDat    = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 7, 4)
3078:         lcHora   = TTOC(DATETIME())

*-- Linhas 3158 a 3211:
3158:         ENDIF
3159: 
3160:         IF RECCOUNT("crFiltro5") > 0
3161:             SELECT * FROM crFiltro5 INTO CURSOR crFiltro3 READWRITE
3162:             THIS.CnabSant240LoteBoleto(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
3163:                 lcRaz, lcCnv, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
3164:                 lcArq, lcprot, "crFiltro3", "033")
3165:         ENDIF
3166: 
3167:         *-- Trailer do arquivo
3168:         IF FILE(lcArq)
3169:             LOCAL lcT001a003, lcT004a007, lcT008a008, lcT009a017, lcT018a023, lcT024a029, lcT030a035, lcT036a240
3170:             lcT001a003 = "033"
3171:             lcT004a007 = "9999"
3172:             lcT008a008 = "9"
3173:             lcT009a017 = SPACE(9)
3174:             lcT018a023 = "00" + PADL(ALLTRIM(STR(THIS.this_nCnabLot)), 4, "0")
3175:             lcT024a029 = PADL(ALLTRIM(STR(INT(FSIZE(lcArq)/242)+1)), 6, "0")
3176:             lcT030a035 = "000000"
3177:             lcT036a240 = SPACE(205)
3178:             lcstrg = lcT001a003+lcT004a007+lcT008a008+lcT009a017+lcT018a023+lcT024a029+lcT030a035+lcT036a240+CHR(13)+CHR(10)
3179:             lcstrg = fLimpaTexto(lcstrg)
3180:             STRTOFILE(lcstrg, lcArq, 1)
3181: 
3182:             lok = .T.
3183:             IF lok
3184:                 SELECT crFiltro20
3185:                 SCAN
3186:                     LOCAL loc_cTitBans, loc_cTitulos, loc_lAtua
3187:                     loc_cTitBans = loc_oBO.BuscarTituloBanco(crFiltro20.nopers)
3188:                     loc_cTitulos = ALLTRIM(NVL(crFiltro20.titulos, ""))
3189:                     loc_lAtua = .T.
3190:                     IF !EMPTY(loc_cTitBans)
3191:                         loc_lAtua = MsgConfirma('T' + CHR(237) + 'tulo "' + loc_cTitulos + '" j' + CHR(225) + ' possui T' + CHR(237) + 'tulo do Banco preenchido. Sobrescrever?')
3192:                     ENDIF
3193:                     IF loc_lAtua
3194:                         loc_oBO.AtualizarTituloBanco(crFiltro20.nopers, "TIT SANTANDER")
3195:                     ENDIF
3196:                     SELECT crFiltro20
3197:                 ENDSCAN
3198:             ENDIF
3199: 
3200:             MsgAviso("Arquivo '" + lcArq + "' gerado com sucesso.")
3201:         ENDIF
3202:     ENDPROC
3203: 
3204:     *==========================================================================
3205:     * CnabSant240LoteCC - Lote credito em conta para Santander
3206:     *==========================================================================
3207:     PROTECTED PROCEDURE CnabSant240LoteCC(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
3208:         lcRaz, lcCnv, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
3209:         lcArq, lcprot, par_cCursor, par_cBanco)
3210: 
3211:         LOCAL loc_oBO, lcFin, lnQlote, lcQlote, lnSeql, lcSeql, lnValtot, lnMoetot, lcstrg

*-- Linhas 3265 a 3320:
3265:         lnValtot = 0
3266:         lnMoetot = 0
3267: 
3268:         SELECT (par_cCursor)
3269:         SCAN
3270:             loc_cSQL = "SELECT * FROM SigCdCeb WHERE GruContas = " + ;
3271:                        EscaparSQL(Grupos + contas) + ;
3272:                        " AND NAgencias != '' AND contas != '' AND nbancos != 0 ORDER BY NAgencias"
3273:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Conta") < 1
3274:                 LOOP
3275:             ENDIF
3276:             GO TOP IN cursor_4c_Conta
3277:             SELECT (par_cCursor)
3278:             IF RECCOUNT("cursor_4c_Conta") = 0
3279:                 LOOP
3280:             ENDIF
3281: 
3282:             LOCAL lcnopers, lcvenc, lccgccli, lctpcgcCli, lcnome
3283:             LOCAL lcValpag, lcChave, lcNossoNum, lcTpcta
3284:             LOCAL lcBco, lcAge, lcDigA, lcCtaC, lcDigC, lcCta, lcAgCta, lcOutCgc
3285: 
3286:             lcnopers   = TRANSFORM(nopers, "@L 9999999999")
3287:             lcvenc     = SUBSTR(DTOC(vencs), 1, 2) + SUBSTR(DTOC(vencs), 4, 2) + SUBSTR(DTOC(vencs), 7, 4)
3288:             lccgccli   = PADL(ALLTRIM(CHRTRAN(cpfs, "/.-,", "")), 14, "0")
3289:             lctpcgcCli = IIF(LEN(ALLTRIM(CHRTRAN(cpfs, "/.-", ""))) = 11, "1", "2")
3290:             lcnome     = PADR(ALLTRIM(IIF(EMPTY(Razaos), rclis, Razaos)), 30)
3291:             lcValpag   = TRANSFORM(valors * 100, "@L 999999999999999")
3292:             lnValtot   = lnValtot + valors
3293: 
3294:             SELECT cursor_4c_Conta
3295:             GO TOP
3296:             lcBco  = PADL(ALLTRIM(cursor_4c_Conta.nbancos), 3, "0")
3297:             lcAge  = PADL(ALLTRIM(cursor_4c_Conta.NAgencias), 5, "0")
3298:             lcCtaC = PADL(ALLTRIM(CHRTRAN(cursor_4c_Conta.contas, ".-", "")), 13, "0")
3299:             lcDigC = SUBSTR(lcCtaC, 13, 1)
3300:             lcCta  = SUBSTR(lcCtaC, 1, 12)
3301:             lcAgCta = lcAge + " " + lcCta + " " + lcDigC
3302:             lcOutCgc = ALLTRIM(CHRTRAN(cursor_4c_Conta.Convenios, "/.-,", ""))
3303:             lccgccli = IIF(LEN(lcOutCgc) != 11 AND LEN(lcOutCgc) != 14, lccgccli, PADL(lcOutCgc, 14, "0"))
3304: 
3305:             SELECT (par_cCursor)
3306:             lcChave  = PADR(ALLTRIM(titulos), 10) + lcnopers
3307:             lcNossoNum = ALLTRIM(STR(fGerUniqueKey("BRNOSSONUM")))
3308:             REPLACE nossoNum WITH PADL(lcNossoNum, 10, "0") IN (par_cCursor)
3309: 
3310:             lnSeql = lnSeql + 1
3311:             lcSeql = TRANSFORM(lnSeql, "@L 99999")
3312:             lnQlote = lnQlote + 1
3313:             lnSeq = lnSeq + 1
3314: 
3315:             LOCAL lcA001a003, lcA004a007, lcA008a008, lcA009a013, lcA014a014
3316:             LOCAL lcA015a017, lcA018a020, lcA021a023, lcA024a043, lcA044a073
3317:             LOCAL lcA074a093, lcA094a101, lcA102a104, lcA105a112, lcA113a114
3318:             LOCAL lcA115a119, lcA120a134, lcA135a149, lcA150a154, lcA155a162
3319:             LOCAL lcA163a177, lcA178a195, lcA196a197, lcA198a203, lcA204a217
3320:             LOCAL lcA218a219, lcA220a224, lcA225a229, lcA230a230, lcA231a240

*-- Linhas 3360 a 3378:
3360:             STRTOFILE(lcstrg, lcArq, 1)
3361: 
3362:             loc_oBO.RegistrarLinhaArquivo("C", nopers, lcstrg, titulos, lcChave)
3363:             SELECT (par_cCursor)
3364:         ENDSCAN
3365: 
3366:         lnSeq = lnSeq + 1
3367:         lnSeql = lnSeql + 1
3368:         lcSeql = TRANSFORM(lnSeql, "@L 999999")
3369:         lnQlote = lnQlote + 1
3370:         lcQlote = TRANSFORM(lnQlote, "@L 999999")
3371:         LOCAL lcValtotStr, lcMoetotStr
3372:         lcValtotStr = TRANSFORM(lnValtot * 100, "@L 999999999999999999")
3373:         lcMoetotStr = "000000000000000000"
3374:         LOCAL lcTL001a003, lcTL004a007, lcTL008a008, lcTL009a017, lcTL018a023
3375:         LOCAL lcTL024a041, lcTL042a059, lcTL060a230, lcTL231a240
3376:         lcTL001a003 = par_cBanco
3377:         lcTL004a007 = lcLot
3378:         lcTL008a008 = "5"

*-- Linhas 3450 a 3477:
3450:         lnSeql = 0
3451:         lnValtot = 0
3452: 
3453:         SELECT (par_cCursor)
3454:         SCAN
3455:             lnQlote = lnQlote + 1
3456:             loc_cSQL = "SELECT * FROM SigCdCeb WHERE GruContas = " + ;
3457:                        EscaparSQL(Grupos + contas) + ;
3458:                        " ORDER BY NAgencias"
3459:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Conta") >= 1
3460:                 GO TOP IN cursor_4c_Conta
3461:             ENDIF
3462:             SELECT (par_cCursor)
3463: 
3464:             LOCAL lcnopers, lcvenc, lccgccli, lcnome, lcValpag, lcBarra, lcChave, lcNossoNum
3465:             LOCAL lcJ001a003, lcJ004a007, lcJ008a008, lcJ009a013, lcJ014a014
3466:             LOCAL lcJ015a017, lcJ018a061, lcJ062a091, lcJ092a099, lcJ100a114
3467:             LOCAL lcJ115a129, lcJ130a144, lcJ145a152, lcJ153a167, lcJ168a182
3468:             LOCAL lcJ183a202, lcJ203a215, lcJ216a230, lcJ231a240
3469: 
3470:             lcnopers = TRANSFORM(nopers, "@L 9999999999")
3471:             lcvenc   = SUBSTR(DTOC(vencs), 1, 2) + SUBSTR(DTOC(vencs), 4, 2) + SUBSTR(DTOC(vencs), 7, 4)
3472:             lccgccli = PADL(ALLTRIM(CHRTRAN(cpfs, "/.-,", "")), 14, "0")
3473:             lcnome   = PADR(ALLTRIM(IIF(EMPTY(Razaos), rclis, Razaos)), 30)
3474:             lcValpag = TRANSFORM(valors * 100, "@L 999999999999999")
3475:             lnValtot = lnValtot + valors
3476:             lcBarra  = ALLTRIM(CHRTRAN(barras, "/.-", "")) + REPLICATE("0", 44)
3477:             lcBarra  = SUBSTR(lcBarra, 1, 4) + SUBSTR(lcBarra, 33, 15) + SUBSTR(lcBarra, 5, 5) + SUBSTR(lcBarra, 11, 10) + SUBSTR(lcBarra, 22, 10)

*-- Linhas 3510 a 3528:
3510:             STRTOFILE(lcstrg, lcArq, 1)
3511: 
3512:             loc_oBO.RegistrarLinhaArquivo("C", nopers, lcstrg, titulos, lcChave)
3513:             SELECT (par_cCursor)
3514:         ENDSCAN
3515: 
3516:         lnSeq = lnSeq + 1
3517:         lnSeql = lnSeql + 1
3518:         lcSeql = TRANSFORM(lnSeql, "@L 999999")
3519:         lnQlote = lnQlote + 1
3520:         lcQlote = TRANSFORM(lnQlote, "@L 999999")
3521:         LOCAL lcValtotStr
3522:         lcValtotStr = TRANSFORM(lnValtot * 100, "@L 999999999999999999")
3523:         LOCAL lcTL001a003, lcTL004a007, lcTL008a008, lcTL009a017, lcTL018a023
3524:         LOCAL lcTL024a041, lcTL042a059, lcTL060a230, lcTL231a240
3525:         lcTL001a003 = par_cBanco
3526:         lcTL004a007 = lcLot
3527:         lcTL008a008 = "5"
3528:         lcTL009a017 = SPACE(9)

*-- Linhas 3713 a 3731:
3713: 
3714:         *-- Desmarca todos os grupos
3715:         IF USED("cursor_4c_Grupos")
3716:             SELECT cursor_4c_Grupos
3717:             REPLACE ALL marca WITH .F.
3718:             GO TOP
3719:             loc_oP1.grd_4c_Grupos.Refresh()
3720:         ENDIF
3721: 
3722:         *-- Limpa grid de dados
3723:         loc_oP2.grd_4c_Dados.RecordSource = ""
3724:         loc_oP2.grd_4c_Dados.Refresh()
3725: 
3726:         *-- Fecha cursores de resultado anterior
3727:         LOCAL loc_i
3728:         LOCAL loc_aCur(9)
3729:         loc_aCur(1) = "cursor_4c_Filtro"
3730:         loc_aCur(2) = "crFiltro2"
3731:         loc_aCur(3) = "crFiltro3"


### BO (C:\4c\projeto\app\classes\SIGPGCNBBO.prg):
*==============================================================================
* SIGPGCNBBO.prg - Business Object para Geracao de Arquivos CNAB - Pagamentos
* Data: 2026-06-19
* Tabela principal: SigPcOol | PK: cidchaves
* Tabela de operacoes: SigMvCcr (leitura) | SigCdCeb (convenios)
*==============================================================================

DEFINE CLASS SIGPGCNBBO AS BusinessBase

    *-- -----------------------------------------------------------------------
    *-- FILTROS DE TELA (pgfiltro)
    *-- -----------------------------------------------------------------------

    *-- Empresa (get_cd_empresa / get_ds_empresa)
    this_cCdEmpresa        = ""    && Emps     CHAR(3)  - C" + CHR(243) + "digo empresa
    this_cDsEmpresa        = ""    && RazSocs  CHAR(40) - Raz" + CHR(227) + "o social

    *-- Per" + CHR(237) + "odo (Get_Datai / Get_Dataf)
    this_dDatai            = {}    && Per" + CHR(237) + "odo inicial
    this_dDataf            = {}    && Per" + CHR(237) + "odo final

    *-- Op" + CHR(231) + CHR(227) + "o processados (optProcessados: 1=N" + CHR(227) + "o Processados, 2=J" + CHR(225) + " Processados)
    this_nProcessados      = 1

    *-- Op" + CHR(231) + CHR(227) + "o per" + CHR(237) + "odo (optPeriodo: 1=Vencimento, 2=Emiss" + CHR(227) + "o)
    this_nPeriodo          = 1

    *-- Conta banc" + CHR(225) + "ria (get_cd_car_conta / get_ds_car_conta)
    this_cCdConta          = ""    && IClis / GruContas CHAR(10) - C" + CHR(243) + "digo conta
    this_cDsConta          = ""    && Descri" + CHR(231) + CHR(227) + "o da conta CHAR(40)

    *-- Empresa do conv" + CHR(234) + "nio (getCEmpc / getDEmpc)
    this_cCdEmpConvenio    = ""    && Cemps    CHAR(3)  - C" + CHR(243) + "digo empresa conv" + CHR(234) + "nio
    this_cDsEmpConvenio    = ""    && RazSocs  CHAR(40) - Descri" + CHR(231) + CHR(227) + "o empresa conv" + CHR(234) + "nio

    *-- -----------------------------------------------------------------------
    *-- ESTADO DO PROCESSAMENTO (pgdados)
    *-- -----------------------------------------------------------------------

    *-- Spinner dias protesto (spndias, default=5)
    this_nDiasProt         = 5     && DiasProts NUMERIC - Dias para protestos

    *-- Caminho do arquivo CNAB gerado
    this_cArquivoCNAB      = ""    && Drive + ArqCnabs - Caminho completo do .REM

    *-- C" + CHR(243) + "digo do banco do conv" + CHR(234) + "nio ativo (ex: "001", "341", "237", "033")
    this_cBancoNr          = ""    && nbancos CHAR(3) - C" + CHR(243) + "digo banco FEBRABAN

    *-- -----------------------------------------------------------------------
    *-- REGISTRO DE PROCESSAMENTO (SigPcOol)
    *-- -----------------------------------------------------------------------

    *-- Campos da tabela SigPcOol (usados em INSERT)
    this_cDopes            = ""    && dopes     CHAR    - Tipo operacao ('C' = CNAB)
    this_nNopers           = 0     && nopers    NUMERIC - N" + CHR(250) + "mero operacao de SigMvCcr
    this_cUsuars           = ""    && usuars    CHAR    - Usu" + CHR(225) + "rio que gerou
    this_cTipos            = ""    && tipos     CHAR    - Identificador ('SIGPGCNB')
    this_cProcessos        = ""    && processos CHAR    - Processo ('CNAB')
    this_cProdutos         = ""    && produtos  MEMO    - Conte" + CHR(250) + "do do arquivo gerado
    this_dDataS            = {}    && DataS     DATETIME - Data/hora de geracao
    this_cCidChaves        = ""    && cidchaves CHAR    - Chave " + CHR(250) + "nica (PK)
    this_cDopeds           = ""    && dopeds    CHAR    - Referencia doc (titulo)
    this_cEdndests         = ""    && edndests  CHAR    - Chave destino (titulo+nopers)

    *-- -----------------------------------------------------------------------
    *-- DADOS DO CONVENIO BANCARIO (SigCdCeb - carregado em geracnab)
    *-- -----------------------------------------------------------------------
    this_cConvenio         = ""    && Convenios  CHAR - C" + CHR(243) + "digo conv" + CHR(234) + "nio
    this_cAgencia          = ""    && NAgencias  CHAR - Ag" + CHR(234) + "ncia empresa
    this_cDigitoAgencia    = ""    && DigiAgen   CHAR - D" + CHR(237) + "gito ag" + CHR(234) + "ncia
    this_cContaConv        = ""    && contas     CHAR - Conta do conv" + CHR(234) + "nio
    this_cArqCnabs         = ""    && ArqCnabs   CHAR - Nome base do arquivo
    this_cDrive            = ""    && Drive      CHAR - Drive de destino
    this_cTpCtArq          = ""    && TpCtArqs   CHAR - Tipo conta arquivo
    this_cTpCtBol          = ""    && TpCtBols   CHAR - Tipo conta boleto
    this_cBancos           = ""    && bancos     CHAR - Raz" + CHR(227) + "o social banco

    *-- -----------------------------------------------------------------------
    *-- DADOS DA EMPRESA (SigCdEmp - carregado em geracnab)
    *-- -----------------------------------------------------------------------
    this_cRazSocs          = ""    && RazSocs   CHAR - Raz" + CHR(227) + "o social empresa
    this_cCgcs             = ""    && Cgcs      CHAR - CNPJ/CPF empresa
    this_cEndesEmp         = ""    && Endes     CHAR - Endere" + CHR(231) + "o empresa
    this_cNumerosEmp       = ""    && Numeros   CHAR - N" + CHR(250) + "mero endere" + CHR(231) + "o
    this_cComplsEmp        = ""    && Compls    CHAR - Complemento
    this_cBairsEmp         = ""    && Bairs     CHAR - Bairro
    this_cCidasEmp         = ""    && Cidas     CHAR - Cidade
    this_cCepsEmp          = ""    && Ceps      CHAR - CEP
    this_cEstasEmp         = ""    && Estas     CHAR - Estado (UF)

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
    * Usado pelo sistema de auditoria do BusinessBase
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves, "C")
            THIS.this_cDopes      = TratarNulo(dopes, "C")
            THIS.this_nNopers     = TratarNulo(nopers, "N")
            THIS.this_cUsuars     = TratarNulo(usuars, "C")
            THIS.this_cTipos      = TratarNulo(tipos, "C")
            THIS.this_cProcessos  = TratarNulo(processos, "C")
            THIS.this_cProdutos   = TratarNulo(produtos, "C")
            THIS.this_cDopeds     = TratarNulo(dopeds, "C")
            THIS.this_cEdndests   = TratarNulo(edndests, "C")
            IF TYPE("DataS") != "U"
                THIS.this_dDataS  = TratarNulo(DataS, "D")
            ENDIF
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um registro de processamento CNAB em SigPcOol
    * Chamado para cada linha/segmento gerado durante geracao do arquivo CNAB
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cProdutos
        loc_lSucesso = .F.
        TRY
            THIS.this_cCidChaves = ALLTRIM(fUniqueIds())
            THIS.this_cUsuars    = ALLTRIM(gc_4c_UsuarioLogado)
            THIS.this_cTipos     = "SIGPGCNB"
            THIS.this_cProcessos = "CNAB"

            loc_cProdutos = THIS.this_cProdutos

            loc_cSQL = "INSERT INTO SigPcOol " + ;
                       "(dopes, nopers, usuars, tipos, processos, produtos, DataS, cidchaves, dopeds, edndests)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNopers) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       EscaparSQL(THIS.this_cTipos) + ", " + ;
                       EscaparSQL(THIS.this_cProcessos) + ", " + ;
                       "?loc_cProdutos, " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cDopeds) + ", " + ;
                       EscaparSQL(THIS.this_cEdndests) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro em SigPcOol." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir em SigPcOol:" + CHR(13) + ;
                        loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro de processamento CNAB em SigPcOol
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cProdutos
        loc_lSucesso = .F.
        TRY
            loc_cProdutos = THIS.this_cProdutos

            loc_cSQL = "UPDATE SigPcOol" + ;
                       " SET dopes     = " + EscaparSQL(THIS.this_cDopes) + ;
                       ",    nopers    = " + FormatarNumeroSQL(THIS.this_nNopers) + ;
                       ",    usuars    = " + EscaparSQL(THIS.this_cUsuars) + ;
                       ",    tipos     = " + EscaparSQL(THIS.this_cTipos) + ;
                       ",    processos = " + EscaparSQL(THIS.this_cProcessos) + ;
                       ",    produtos  = ?loc_cProdutos" + ;
                       ",    dopeds    = " + EscaparSQL(THIS.this_cDopeds) + ;
                       ",    edndests  = " + EscaparSQL(THIS.this_cEdndests) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro em SigPcOol." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao atualizar em SigPcOol:" + CHR(13) + ;
                        loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Carrega grupos de fornecedores (SigCdGcr) para grid filtro
    * Cria cursor_4c_Grupos com campos: codigos, descrs, marca (bool=.F.)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarGrupos()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_lFalso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_GruposTemp")
                USE IN cursor_4c_GruposTemp
            ENDIF
            loc_lFalso = .F.
            loc_cSQL = "SELECT Codigos, Descrs, ?loc_lFalso AS marca FROM SigCdGcr" + ;
                       " WHERE PadPgRecs IN (4,2) ORDER BY Codigos"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposTemp") >= 1
                IF USED("cursor_4c_Grupos")
                    USE IN cursor_4c_Grupos
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Grupos (codigos C(9) NULL, descrs C(40) NULL, marca L NULL)
                SET NULL OFF
                SELECT cursor_4c_Grupos
                APPEND FROM DBF("cursor_4c_GruposTemp")
                SELECT cursor_4c_Grupos
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar grupos de fornecedores." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_GruposTemp")
                USE IN cursor_4c_GruposTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarGrupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOperacoes - Consulta operacoes de pagamento em SigMvCcr
    * Parametros:
    *   par_cCodEmp        - Codigo da empresa
    *   par_cCodConta      - Codigo da conta bancaria (get_cd_car_conta)
    *   par_dDatai         - Data inicial do periodo
    *   par_dDataf         - Data final do periodo
    *   par_lNaoProc       - .T.=Nao Processados, .F.=Ja Processados
    *   par_nPeriodo       - 1=Vencimento, 2=Emissao
    *   par_cGrupos        - Lista SQL de grupos marcados: ('GR1','GR2',...)
    * Cria cursor_4c_Filtro com registros de SigMvCcr+SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOperacoes(par_cCodEmp, par_cCodConta, par_dDatai, par_dDataf, ;
                               par_lNaoProc, par_nPeriodo, par_cGrupos)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCampoPeriodo, loc_cNaoProc, loc_oErro
        LOCAL loc_dDatai, loc_dDataf, loc_lFalso
        loc_lSucesso = .F.
        TRY
            loc_dDatai = par_dDatai
            loc_dDataf = par_dDataf
            loc_lFalso = .F.

            IF par_nPeriodo = 1
                loc_cCampoPeriodo = "a.Vencs"
            ELSE
                loc_cCampoPeriodo = "a.Datas"
            ENDIF

            IF par_lNaoProc
                loc_cNaoProc = "NOT "
            ELSE
                loc_cNaoProc = ""
            ENDIF

            IF USED("cursor_4c_FiltroTemp")
                USE IN cursor_4c_FiltroTemp
            ENDIF

            loc_cSQL = "SELECT ?loc_lFalso AS marca, a.emps, a.datas, a.vencs, a.Valors, " + ;
                       "a.moedas, a.Hists + a.Titulos + a.Nfs AS histo, b.rclis, b.iclis, " + ;
                       "a.Grupos, a.contas, a.Nopers, a.Tipos, " + ;
                       "a.Contapgs, a.Dopes, a.ValPags, a.GruConMoes, a.Opers, " + ;
                       "a.cotacaos, a.cotusus, a.GrupEms, " + ;
                       "a.ContEms, a.GrupAges, a.ContAges, a.EmpDopNcs, a.Pagos, a.Titulos, a.Nfs, " + ;
                       "b.razaos, b.cpfs, b.endes, b.nums, b.bairs, b.cidas, b.ceps, b.estas, " + ;
                       "b.compls, b.tipochv, b.chvpix " + ;
                       "FROM SigMvCcr a, SigCdCli b " + ;
                       "WHERE a.pagos = 1 " + ;
                       "AND a.ContaPgs != 2 " + ;
                       "AND a.opers = 'C' " + ;
                       "AND " + loc_cCampoPeriodo + " BETWEEN ?loc_dDatai AND ?loc_dDataf " + ;
                       "AND a.Nopers <> 0 " + ;
                       "AND a.emps = " + EscaparSQL(par_cCodEmp) + " " + ;
                       "AND a.cidchaves IN (" + ;
                           "SELECT cidchaves FROM SigMvCcr " + ;
                           "WHERE grupos IN " + par_cGrupos + " " + ;
                           "AND " + loc_cCampoPeriodo + " BETWEEN ?loc_dDatai AND ?loc_dDataf" + ;
                       ") " + ;
                       "AND a.grupos = b.grupos " + ;
                       "AND a.contas = b.iclis " + ;
                       "AND a.nopers " + loc_cNaoProc + ;
                       "IN (SELECT e.nopers FROM SigPcOol e WHERE e.Tipos = 'SIGPGCNB' AND e.dopes = 'C') " + ;
                       "ORDER BY a.emps, " + loc_cCampoPeriodo

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FiltroTemp") >= 1
                IF USED("cursor_4c_Filtro")
                    IF USED("cursor_4c_Filtro")
                        TABLEREVERT(.T., "cursor_4c_Filtro")
                        USE IN cursor_4c_Filtro
                    ENDIF
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Filtro (marca L NULL, emps C(3) NULL, ;
                    datas D NULL, vencs D NULL, Valors N(14,2) NULL, moedas C(6) NULL, ;
                    histo C(60) NULL, rclis C(40) NULL, iclis C(10) NULL, ;
                    Grupos C(6) NULL, contas C(10) NULL, Nopers N(10,0) NULL, ;
                    Tipos C(6) NULL, Contapgs N(1,0) NULL, Dopes C(6) NULL, ;
                    ValPags N(14,2) NULL, GruConMoes C(6) NULL, Opers C(6) NULL, ;
                    cotacaos N(14,6) NULL, cotusus C(10) NULL, GrupEms C(6) NULL, ;
                    ContEms C(10) NULL, GrupAges C(6) NULL, ContAges C(10) NULL, ;
                    EmpDopNcs C(9) NULL, Pagos N(1,0) NULL, Titulos C(10) NULL, ;
                    Nfs C(9) NULL, razaos C(40) NULL, cpfs C(20) NULL, ;
                    endes C(40) NULL, nums C(6) NULL, bairs C(20) NULL, ;
                    cidas C(20) NULL, ceps C(9) NULL, estas C(2) NULL, ;
                    compls C(15) NULL, tipochv C(2) NULL, chvpix C(50) NULL)
                SET NULL OFF
                SELECT cursor_4c_Filtro
                APPEND FROM DBF("cursor_4c_FiltroTemp")
                SELECT cursor_4c_Filtro
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_FiltroTemp")
                USE IN cursor_4c_FiltroTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarOperacoes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarEmpresa - Carrega dados da empresa para geracao CNAB (SigCdEmp)
    * Parametro: par_cCodEmpConvenio - Codigo da empresa do convenio (Cemps)
    * Cria cursor_4c_Empresa com: RazSocs, Cgcs, Tel1s, Ceps, Endes, Numeros,
    *                              Bairs, Cidas, Estas, Compls
    *--------------------------------------------------------------------------
    PROCEDURE BuscarEmpresa(par_cCodEmpConvenio)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cCodEmp
        loc_lSucesso = .F.
        TRY
            loc_cCodEmp = ALLTRIM(par_cCodEmpConvenio)
            IF USED("cursor_4c_EmpresaTemp")
                USE IN cursor_4c_EmpresaTemp
            ENDIF
            loc_cSQL = "SELECT RazSocs, Cgcs, Tel1s, Ceps, Endes, Numeros," + ;
                       " Bairs, Cidas, Estas, Compls" + ;
                       " FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCodEmp)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpresaTemp") >= 1
                IF USED("cursor_4c_Empresa")
                    USE IN cursor_4c_Empresa
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Empresa (RazSocs C(40) NULL, Cgcs C(20) NULL, ;
                    Tel1s C(14) NULL, Ceps C(9) NULL, Endes C(40) NULL, ;
                    Numeros C(6) NULL, Bairs C(20) NULL, Cidas C(20) NULL, ;
                    Estas C(2) NULL, Compls C(15) NULL)
                SET NULL OFF
                SELECT cursor_4c_Empresa
                APPEND FROM DBF("cursor_4c_EmpresaTemp")
                SELECT cursor_4c_Empresa
                GO TOP
                loc_lSucesso = !EOF("cursor_4c_Empresa")
            ELSE
                MostrarErro("Erro ao carregar dados da empresa " + loc_cCodEmp + "." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_EmpresaTemp")
                USE IN cursor_4c_EmpresaTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarEmpresa:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarConvenio - Carrega dados do convenio bancario (SigCdCeb)
    * Parametros:
    *   par_cGruContas - Grupos+Contas concatenado (ex: crBancos.Grupos + lcconta)
    * Cria cursor_4c_Convenio com dados do SigCdCeb
    *--------------------------------------------------------------------------
    PROCEDURE BuscarConvenio(par_cGruContas)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cGruContas
        loc_lSucesso = .F.
        TRY
            loc_cGruContas = ALLTRIM(par_cGruContas)
            IF USED("cursor_4c_ConvenioTemp")
                USE IN cursor_4c_ConvenioTemp
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdCeb" + ;
                       " WHERE GruContas = " + EscaparSQL(loc_cGruContas) + ;
                       " AND NAgencias != ''" + ;
                       " ORDER BY NAgencias"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConvenioTemp") >= 1
                IF USED("cursor_4c_Convenio")
                    USE IN cursor_4c_Convenio
                ENDIF
                SELECT cursor_4c_ConvenioTemp
                SELECT *, " " AS placeHolder FROM cursor_4c_ConvenioTemp INTO CURSOR cursor_4c_Convenio READWRITE
                SELECT cursor_4c_Convenio
                GO TOP
                loc_lSucesso = !EOF("cursor_4c_Convenio")
            ELSE
                MostrarErro("Erro ao carregar conv" + CHR(234) + "nio bancario." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_ConvenioTemp")
                USE IN cursor_4c_ConvenioTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarConvenio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarContaBancaria - Carrega dados da conta do favorecido (SigCdCeb)
    * Parametros:
    *   par_cGruContas - Grupos+Contas do favorecido
    * Cria cursor_4c_ContaFav com dados do SigCdCeb
    *--------------------------------------------------------------------------
    PROCEDURE BuscarContaBancaria(par_cGruContas)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cGruContas
        loc_lSucesso = .F.
        TRY
            loc_cGruContas = ALLTRIM(par_cGruContas)
            IF USED("cursor_4c_ContaFavTemp")
                USE IN cursor_4c_ContaFavTemp
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdCeb" + ;
                       " WHERE GruContas = " + EscaparSQL(loc_cGruContas) + ;
                       " AND NAgencias != '' AND contas != '' AND nbancos != 0" + ;
                       " ORDER BY NAgencias"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaFavTemp") >= 1
                IF USED("cursor_4c_ContaFav")
                    USE IN cursor_4c_ContaFav
                ENDIF
                SELECT cursor_4c_ContaFavTemp
                SELECT * FROM cursor_4c_ContaFavTemp INTO CURSOR cursor_4c_ContaFav READWRITE
                SELECT cursor_4c_ContaFav
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar conta do favorecido." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_ContaFavTemp")
                USE IN cursor_4c_ContaFavTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarContaBancaria:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarContasBanco - Carrega contas do banco especificado (SigCdCeb)
    * Para buscaboleto: separa contas do mesmo banco vs outros bancos
    * Parametro: par_cBco - Codigo do banco FEBRABAN (ex: '341', '237', '033')
    * Cria cursor_4c_BancoIgual e cursor_4c_BancoDif
    *--------------------------------------------------------------------------
    PROCEDURE BuscarContasBanco(par_cBco)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_cBco
        loc_lSucesso = .F.
        TRY
            loc_cBco = ALLTRIM(par_cBco)
            IF USED("cursor_4c_BancoIgualTemp")
                USE IN cursor_4c_BancoIgualTemp
            ENDIF
            IF USED("cursor_4c_BancoDifTemp")
                USE IN cursor_4c_BancoDifTemp
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdCeb WHERE nbancos = " + ALLTRIM(loc_cBco)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BancoIgualTemp") < 1
                MostrarErro("Erro ao carregar contas do banco " + loc_cBco + "." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "SELECT * FROM SigCdCeb WHERE nbancos != " + ALLTRIM(loc_cBco)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BancoDifTemp") < 1
                    MostrarErro("Erro ao carregar demais contas." + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("cursor_4c_BancoIgual")
                        USE IN cursor_4c_BancoIgual
                    ENDIF
                    IF USED("cursor_4c_BancoDif")
                        USE IN cursor_4c_BancoDif
                    ENDIF
                    SELECT cursor_4c_BancoIgualTemp
                    SELECT * FROM cursor_4c_BancoIgualTemp INTO CURSOR cursor_4c_BancoIgual READWRITE
                    SELECT cursor_4c_BancoDifTemp
                    SELECT * FROM cursor_4c_BancoDifTemp INTO CURSOR cursor_4c_BancoDif READWRITE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
            IF USED("cursor_4c_BancoIgualTemp")
                USE IN cursor_4c_BancoIgualTemp
            ENDIF
            IF USED("cursor_4c_BancoDifTemp")
                USE IN cursor_4c_BancoDifTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarContasBanco:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarBarrasCcb - Busca codigo de barras de um titulo em SigMvCcb
    * Parametro: par_cFkChaves - chave fk (emps + str(nopers,10) + opers)
    * Retorna a string de barras ou "" se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarBarrasCcb(par_cFkChaves)
        LOCAL loc_cBarras, loc_cSQL, loc_oErro
        LOCAL loc_cFkChaves
        loc_cBarras = ""
        TRY
            loc_cFkChaves = ALLTRIM(par_cFkChaves)
            IF USED("cursor_4c_BarraTemp")
                USE IN cursor_4c_BarraTemp
            ENDIF
            loc_cSQL = "SELECT ccb_bars FROM SigMvCcb WHERE fkchaves = " + ;
                       EscaparSQL(loc_cFkChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BarraTemp") >= 1
                SELECT cursor_4c_BarraTemp
                GO TOP
                IF !EOF("cursor_4c_BarraTemp")
                    loc_cBarras = NVL(cursor_4c_BarraTemp.ccb_bars, "")
                ENDIF
            ENDIF
            IF USED("cursor_4c_BarraTemp")
                USE IN cursor_4c_BarraTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarBarrasCcb:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cBarras
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGruposContaCli - Carrega grupos de uma conta (SigCdCli)
    * Parametro: par_cIClis - Codigo da conta (IClis)
    * Retorna valor do campo Grupos ou ""
    *--------------------------------------------------------------------------
    PROCEDURE BuscarGruposContaCli(par_cIClis)
        LOCAL loc_cGrupos, loc_cSQL, loc_oErro
        LOCAL loc_cIClis
        loc_cGrupos = ""
        TRY
            loc_cIClis = ALLTRIM(par_cIClis)
            IF USED("cursor_4c_CliGrupoTemp")
                USE IN cursor_4c_CliGrupoTemp
            ENDIF
            loc_cSQL = "SELECT Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cIClis)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliGrupoTemp") >= 1
                SELECT cursor_4c_CliGrupoTemp
                GO TOP
                IF !EOF("cursor_4c_CliGrupoTemp")
                    loc_cGrupos = NVL(ALLTRIM(cursor_4c_CliGrupoTemp.Grupos), "")
                ENDIF
            ENDIF
            IF USED("cursor_4c_CliGrupoTemp")
                USE IN cursor_4c_CliGrupoTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarGruposContaCli:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cGrupos
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTituloBanco - Atualiza titbans em SigMvCcr apos geracao CNAB
    * Parametros:
    *   par_nNopers - Numero da operacao
    *   par_cTitulo - Titulo banco para gravar (ex: 'TIT ITAU')
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTituloBanco(par_nNopers, par_cTitulo)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_nNopers
        loc_lSucesso = .F.
        TRY
            loc_nNopers = par_nNopers
            loc_cSQL = "UPDATE SigMvCcr SET titbans = " + EscaparSQL(par_cTitulo) + ;
                       " WHERE opers = 'C' AND nopers = ?loc_nNopers"
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar t" + CHR(237) + "tulo banco." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em AtualizarTituloBanco:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTituloBanco - Verifica titbans existente em SigMvCcr
    * Parametro: par_nNopers - Numero da operacao
    * Retorna o titbans atual ou ""
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTituloBanco(par_nNopers)
        LOCAL loc_cTitulo, loc_cSQL, loc_oErro
        LOCAL loc_nNopers
        loc_cTitulo = ""
        TRY
            loc_nNopers = par_nNopers
            IF USED("cursor_4c_TitBanTemp")
                USE IN cursor_4c_TitBanTemp
            ENDIF
            loc_cSQL = "SELECT titulos, titbans FROM SigMvCcr WHERE opers = 'C' AND nopers = ?loc_nNopers"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TitBanTemp") >= 1
                SELECT cursor_4c_TitBanTemp
                GO TOP
                IF !EOF("cursor_4c_TitBanTemp")
                    loc_cTitulo = NVL(ALLTRIM(cursor_4c_TitBanTemp.titbans), "")
                ENDIF
            ENDIF
            IF USED("cursor_4c_TitBanTemp")
                USE IN cursor_4c_TitBanTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarTituloBanco:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cTitulo
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera chave unica para cidchaves usando fUniqueIds()
    * Retorna a chave gerada como string
    *--------------------------------------------------------------------------
    PROCEDURE GerarChaveUnica()
        RETURN ALLTRIM(fUniqueIds())
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarLinhaArquivo - Insere uma linha do arquivo CNAB em SigPcOol
    * Chamado pelas procedures de geracao CNAB no FormSIGPGCNB
    * Parametros:
    *   par_cDopes    - Tipo operacao ('C')
    *   par_nNopers   - Numero da operacao em SigMvCcr
    *   par_cProdutos - Conteudo da linha CNAB gerada
    *   par_cDopeds   - Referencia do documento (titulo)
    *   par_cEdndests - Chave destino (titulo+nopers)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarLinhaArquivo(par_cDopes, par_nNopers, par_cProdutos, par_cDopeds, par_cEdndests)
        THIS.this_cDopes    = par_cDopes
        THIS.this_nNopers   = par_nNopers
        THIS.this_cProdutos = par_cProdutos
        THIS.this_cDopeds   = par_cDopeds
        THIS.this_cEdndests = par_cEdndests
        RETURN THIS.Inserir()
    ENDPROC

ENDDEFINE


# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PAGOS, CONTAPGS, OPERS, NOPERS, EMPS, CIDCHAVES, GRUPOS, CONTAS, TIPOS, DOPES, GRUCONTAS, FKCHAVES, CCB_TIPO, 1, LCJ021A035, LCJ036A075, LCJ076A076, LCJ133A147, LCJ148A187, LCJ188A240, LCB230A230, LCBCO, NBANCOS, BARRAS, TIPOCHV, 0, PADPGRECS, NAGENCIAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONVENIOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PAGOS, CONTAPGS, OPERS, NOPERS, EMPS, CIDCHAVES, GRUPOS, CONTAS, TIPOS, DOPES, GRUCONTAS, FKCHAVES, CCB_TIPO, 1, LCJ021A035, LCJ036A075, LCJ076A076, LCJ133A147, LCJ148A187, LCJ188A240, LCB230A230, LCBCO, NBANCOS, BARRAS, TIPOCHV, 0, PADPGRECS, NAGENCIAS
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPGCNB.prg) - TRECHOS RELEVANTES PARA PASS SQL (3786 linhas total):

*-- Linhas 538 a 556:
538:             .FontName         = "Tahoma"
539:             .AllowHeaderSizing = .F.
540:             .AllowRowSizing   = .F.
541:             .DeleteMark       = .F.
542:             .GridLines        = 3
543:             .Height           = 344
544:             .Left             = 372
545:             .Panel            = 1
546:             .ScrollBars       = 2
547:             .SplitBar         = .F.
548:             .TabIndex         = 11
549:             .Top              = 236
550:             .Width            = 202
551:             .GridLineColor    = RGB(238,238,238)
552:             .Themes           = .F.
553:             .Column1.Width    = 18
554:             .Column1.Movable  = .F.
555:             .Column1.Resizable = .F.
556:             .Column1.Sparse   = .F.

*-- Linhas 627 a 645:
627:             .FontName          = "Tahoma"
628:             .AllowHeaderSizing = .F.
629:             .AllowRowSizing    = .F.
630:             .DeleteMark        = .F.
631:             .Height            = 382
632:             .Left              = 9
633:             .Panel             = 1
634:             .RecordMark        = .F.
635:             .ScrollBars        = 2
636:             .SplitBar          = .F.
637:             .TabIndex          = 1
638:             .Top               = 152
639:             .Width             = 981
640:             .GridLineColor     = RGB(238,238,238)
641:             .Themes            = .F.
642:             .Column1.Width     = 16
643:             .Column1.Movable   = .F.
644:             .Column1.Resizable = .F.
645:             .Column1.Sparse    = .F.

*-- Linhas 985 a 1004:
985:             loc_oGrd = THIS.pgf_4c_Principal.pgfiltro.grd_4c_Grupos
986:             loc_oGrd.ColumnCount = 2
987:             loc_oGrd.RecordSource      = "cursor_4c_Grupos"
988:             loc_oGrd.Column1.ControlSource = "cursor_4c_Grupos.marca"
989:             loc_oGrd.Column2.ControlSource = "cursor_4c_Grupos.descrs"
990:             loc_oGrd.Column1.Header1.Caption = ""
991:             loc_oGrd.Column2.Header1.Caption = "Grupos"
992:             loc_oGrd.Column2.Header1.Alignment = 2
993:             loc_oGrd.Refresh()
994:         ENDIF
995: 
996:         THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpresa.SetFocus()
997:     ENDPROC
998: 
999:     *==========================================================================
1000:     * HANDLERS DE VALIDACAO DOS CAMPOS DE FILTRO
1001:     *==========================================================================
1002: 
1003:     PROCEDURE ValidarCdEmpresa()
1004:         LOCAL loc_cCod, loc_cSQL

*-- Linhas 1010 a 1053:
1010:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1011:             RETURN
1012:         ENDIF
1013:         loc_cSQL = "SELECT TOP 1 RazSocs FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCod)
1014:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmpV") >= 1 AND RECCOUNT("cursor_4c_EmpTmpV") > 0
1015:             SELECT cursor_4c_EmpTmpV
1016:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpTmpV.RazSocs)
1017:         ELSE
1018:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpresa.Value = ""
1019:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpresa.Value = ""
1020:             MsgAviso("Empresa inv" + CHR(225) + "lida.")
1021:         ENDIF
1022:         IF USED("cursor_4c_EmpTmpV")
1023:             USE IN cursor_4c_EmpTmpV
1024:         ENDIF
1025:     ENDPROC
1026: 
1027:     PROCEDURE ValidarDsEmpresa()
1028:         LOCAL loc_cDs, loc_cSQL
1029:         loc_cDs = ALLTRIM(THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpresa.Value)
1030:         IF EMPTY(loc_cDs)
1031:             RETURN
1032:         ENDIF
1033:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1034:             RETURN
1035:         ENDIF
1036:         loc_cSQL = "SELECT TOP 1 Cemps, RazSocs FROM SigCdEmp WHERE RazSocs LIKE " + EscaparSQL(loc_cDs + "%")
1037:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmpV") >= 1 AND RECCOUNT("cursor_4c_EmpTmpV") > 0
1038:             SELECT cursor_4c_EmpTmpV
1039:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpTmpV.Cemps)
1040:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpTmpV.RazSocs)
1041:         ELSE
1042:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpresa.Value = ""
1043:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpresa.Value = ""
1044:         ENDIF
1045:         IF USED("cursor_4c_EmpTmpV")
1046:             USE IN cursor_4c_EmpTmpV
1047:         ENDIF
1048:     ENDPROC
1049: 
1050:     PROCEDURE ValidarCdConta()
1051:         LOCAL loc_cCod, loc_cGrupo, loc_llRet
1052:         loc_cCod = ALLTRIM(THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdConta.Value)
1053:         IF EMPTY(loc_cCod)

*-- Linhas 1097 a 1140:
1097:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1098:             RETURN
1099:         ENDIF
1100:         loc_cSQL = "SELECT TOP 1 RazSocs FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCod)
1101:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpConvV") >= 1 AND RECCOUNT("cursor_4c_EmpConvV") > 0
1102:             SELECT cursor_4c_EmpConvV
1103:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpConv.Value = ALLTRIM(cursor_4c_EmpConvV.RazSocs)
1104:         ELSE
1105:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpConv.Value = ""
1106:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpConv.Value = ""
1107:             MsgAviso("Empresa do conv" + CHR(234) + "nio inv" + CHR(225) + "lida.")
1108:         ENDIF
1109:         IF USED("cursor_4c_EmpConvV")
1110:             USE IN cursor_4c_EmpConvV
1111:         ENDIF
1112:     ENDPROC
1113: 
1114:     PROCEDURE ValidarDsEmpConv()
1115:         LOCAL loc_cDs, loc_cSQL
1116:         loc_cDs = ALLTRIM(THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpConv.Value)
1117:         IF EMPTY(loc_cDs)
1118:             RETURN
1119:         ENDIF
1120:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1121:             RETURN
1122:         ENDIF
1123:         loc_cSQL = "SELECT TOP 1 Cemps, RazSocs FROM SigCdEmp WHERE RazSocs LIKE " + EscaparSQL(loc_cDs + "%")
1124:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpConvV") >= 1 AND RECCOUNT("cursor_4c_EmpConvV") > 0
1125:             SELECT cursor_4c_EmpConvV
1126:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpConv.Value = ALLTRIM(cursor_4c_EmpConvV.Cemps)
1127:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpConv.Value = ALLTRIM(cursor_4c_EmpConvV.RazSocs)
1128:         ELSE
1129:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_CdEmpConv.Value = ""
1130:             THIS.pgf_4c_Principal.pgfiltro.txt_4c_DsEmpConv.Value = ""
1131:         ENDIF
1132:         IF USED("cursor_4c_EmpConvV")
1133:             USE IN cursor_4c_EmpConvV
1134:         ENDIF
1135:     ENDPROC
1136: 
1137:     PROCEDURE ValidarDataf()
1138:         LOCAL loc_dDatf, loc_dDati
1139:         loc_dDatf = THIS.pgf_4c_Principal.pgfiltro.txt_4c_Dataf.Value
1140:         loc_dDati = THIS.pgf_4c_Principal.pgfiltro.txt_4c_Datai.Value

*-- Linhas 1225 a 1243:
1225: 
1226:         IF loc_oBusca.this_lSelecionou
1227:             IF USED("cursor_4c_BuscaEmpresa")
1228:                 SELECT cursor_4c_BuscaEmpresa
1229:                 loc_oP1.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
1230:                 loc_oP1.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.RazSocs)
1231:             ENDIF
1232:         ENDIF
1233: 
1234:         IF USED("cursor_4c_BuscaEmpresa")
1235:             USE IN cursor_4c_BuscaEmpresa
1236:         ENDIF
1237:         loc_oBusca.Release()
1238:     ENDPROC
1239: 
1240:     PROCEDURE AbrirLookupConta()
1241:         LOCAL loc_oBusca, loc_oP1
1242:         loc_oP1 = THIS.pgf_4c_Principal.pgfiltro
1243: 

*-- Linhas 1259 a 1277:
1259: 
1260:         IF loc_oBusca.this_lSelecionou
1261:             IF USED("cursor_4c_BuscaConta")
1262:                 SELECT cursor_4c_BuscaConta
1263:                 loc_oP1.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.GruContas)
1264:                 loc_oP1.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.bancos) + ;
1265:                                                " - Ag" + CHR(234) + " " + ;
1266:                                                ALLTRIM(cursor_4c_BuscaConta.NAgencias)
1267:             ENDIF
1268:         ENDIF
1269: 
1270:         IF USED("cursor_4c_BuscaConta")
1271:             USE IN cursor_4c_BuscaConta
1272:         ENDIF
1273:         loc_oBusca.Release()
1274:     ENDPROC
1275: 
1276:     PROCEDURE AbrirLookupEmpConv()
1277:         LOCAL loc_oBusca, loc_oP1

*-- Linhas 1295 a 1313:
1295: 
1296:         IF loc_oBusca.this_lSelecionou
1297:             IF USED("cursor_4c_BuscaEmpConv")
1298:                 SELECT cursor_4c_BuscaEmpConv
1299:                 loc_oP1.txt_4c_CdEmpConv.Value = ALLTRIM(cursor_4c_BuscaEmpConv.Cemps)
1300:                 loc_oP1.txt_4c_DsEmpConv.Value = ALLTRIM(cursor_4c_BuscaEmpConv.RazSocs)
1301:             ENDIF
1302:         ENDIF
1303: 
1304:         IF USED("cursor_4c_BuscaEmpConv")
1305:             USE IN cursor_4c_BuscaEmpConv
1306:         ENDIF
1307:         loc_oBusca.Release()
1308:     ENDPROC
1309: 
1310:     *==========================================================================
1311:     * HANDLERS DOS BOTOES
1312:     *==========================================================================
1313: 

*-- Linhas 1343 a 1361:
1343:         ENDIF
1344: 
1345:         IF USED("cursor_4c_Grupos")
1346:             SELECT cursor_4c_Grupos
1347:             loc_nCont = 0
1348:             SCAN
1349:                 IF cursor_4c_Grupos.marca
1350:                     loc_nCont = loc_nCont + 1
1351:                 ENDIF
1352:             ENDSCAN
1353:             IF loc_nCont = 0
1354:                 MsgAviso("Nenhum grupo foi selecionado")
1355:                 RETURN
1356:             ENDIF
1357:         ENDIF
1358: 
1359:         THIS.Processamento()
1360:     ENDPROC
1361: 

*-- Linhas 1395 a 1495:
1395:                 RETURN
1396:             ENDIF
1397: 
1398:             SELECT cursor_4c_Filtro2Rel
1399:             GO TOP
1400: 
1401:             IF par_lImprimir
1402:                 REPORT FORM sigrecnb PREVIEW NOCONSOLE
1403:             ELSE
1404:                 REPORT FORM sigrecnb PREVIEW
1405:             ENDIF
1406: 
1407:             loc_lSucesso = .T.
1408:         CATCH TO loc_oErro
1409:             MsgErro(loc_oErro.Message, "Erro ImpBoleto")
1410:         ENDTRY
1411: 
1412:         RETURN loc_lSucesso
1413:     ENDPROC
1414: 
1415:     PROCEDURE ClickMarcarGrupos()
1416:         IF USED("cursor_4c_Grupos")
1417:             SELECT cursor_4c_Grupos
1418:             REPLACE ALL marca WITH .T.
1419:             GO TOP
1420:             THIS.pgf_4c_Principal.pgfiltro.grd_4c_Grupos.Refresh()
1421:         ENDIF
1422:     ENDPROC
1423: 
1424:     PROCEDURE ClickDesmarcarGrupos()
1425:         IF USED("cursor_4c_Grupos")
1426:             SELECT cursor_4c_Grupos
1427:             REPLACE ALL marca WITH .F.
1428:             GO TOP
1429:             THIS.pgf_4c_Principal.pgfiltro.grd_4c_Grupos.Refresh()
1430:         ENDIF
1431:     ENDPROC
1432: 
1433:     PROCEDURE ClickMarcarOper()
1434:         IF USED("cursor_4c_Filtro")
1435:             SELECT cursor_4c_Filtro
1436:             REPLACE ALL marca WITH .T.
1437:             GO TOP
1438:             THIS.pgf_4c_Principal.pgdados.grd_4c_Dados.Refresh()
1439:         ENDIF
1440:     ENDPROC
1441: 
1442:     PROCEDURE ClickDesmarcarOper()
1443:         IF USED("cursor_4c_Filtro")
1444:             SELECT cursor_4c_Filtro
1445:             REPLACE ALL marca WITH .F.
1446:             GO TOP
1447:             THIS.pgf_4c_Principal.pgdados.grd_4c_Dados.Refresh()
1448:         ENDIF
1449:     ENDPROC
1450: 
1451:     PROCEDURE ClickHeaderVencs()
1452:         IF USED("cursor_4c_Filtro")
1453:             SELECT cursor_4c_Filtro
1454:             INDEX ON vencs TAG vencs
1455:             SET ORDER TO vencs
1456:             THIS.OrdenarGrade()
1457:         ENDIF
1458:     ENDPROC
1459: 
1460:     PROCEDURE ClickHeaderValors()
1461:         IF USED("cursor_4c_Filtro")
1462:             SELECT cursor_4c_Filtro
1463:             INDEX ON Valors TAG valors
1464:             SET ORDER TO valors
1465:             THIS.OrdenarGrade()
1466:         ENDIF
1467:     ENDPROC
1468: 
1469:     PROCEDURE ClickHeaderHisto()
1470:         IF USED("cursor_4c_Filtro")
1471:             SELECT cursor_4c_Filtro
1472:             INDEX ON histo TAG histo
1473:             SET ORDER TO histo
1474:             THIS.OrdenarGrade()
1475:         ENDIF
1476:     ENDPROC
1477: 
1478:     PROCEDURE ClickHeaderRclis()
1479:         IF USED("cursor_4c_Filtro")
1480:             SELECT cursor_4c_Filtro
1481:             INDEX ON rclis TAG rclis
1482:             SET ORDER TO rclis
1483:             THIS.OrdenarGrade()
1484:         ENDIF
1485:     ENDPROC
1486: 
1487:     *==========================================================================
1488:     * BtnIncluirClick - Inicia novo processamento (volta para pagina de filtros)
1489:     * Form OPERACIONAL: "Incluir" = preparar novo lote CNAB a partir da pag. filtro
1490:     * Limpa o grid de dados e habilita filtros para nova selecao de operacoes
1491:     *==========================================================================
1492:     PROCEDURE BtnIncluirClick()
1493:         LOCAL loc_oErro
1494: 
1495:         TRY

*-- Linhas 1619 a 1637:
1619:         *-- Monta lista de grupos marcados
1620:         loc_cGrupos = "("
1621:         IF USED("cursor_4c_Grupos")
1622:             SELECT cursor_4c_Grupos
1623:             SCAN
1624:                 IF cursor_4c_Grupos.marca
1625:                     loc_cGrupos = loc_cGrupos + IIF(loc_cGrupos == "(", "", ",") + ;
1626:                                   "'" + ALLTRIM(cursor_4c_Grupos.codigos) + "'"
1627:                 ENDIF
1628:             ENDSCAN
1629:         ENDIF
1630:         loc_cGrupos = loc_cGrupos + ")"
1631: 
1632:         *-- Limpa grid antes da busca
1633:         loc_oGrd.RecordSource = ""
1634:         loc_oGrd.Refresh()
1635: 
1636:         IF !loc_oBO.BuscarOperacoes(loc_cCdEmp, loc_cCdConta, loc_dDati, loc_dDatf, ;
1637:                                      loc_lNaoProc, loc_nPeriodo, loc_cGrupos)

*-- Linhas 1646 a 1671:
1646:         *-- Liga grid ao cursor
1647:         loc_oGrd.ColumnCount = 8
1648:         loc_oGrd.RecordSource = "cursor_4c_Filtro"
1649:         loc_oGrd.Column1.ControlSource = "cursor_4c_Filtro.marca"
1650:         loc_oGrd.Column2.ControlSource = "cursor_4c_Filtro.datas"
1651:         loc_oGrd.Column3.ControlSource = "cursor_4c_Filtro.vencs"
1652:         loc_oGrd.Column4.ControlSource = "cursor_4c_Filtro.Valors"
1653:         loc_oGrd.Column5.ControlSource = "cursor_4c_Filtro.moedas"
1654:         loc_oGrd.Column6.ControlSource = "cursor_4c_Filtro.histo"
1655:         loc_oGrd.Column7.ControlSource = "cursor_4c_Filtro.rclis"
1656:         loc_oGrd.Column8.ControlSource = "cursor_4c_Filtro.emps"
1657: 
1658:         loc_oGrd.Column1.Header1.Caption = ""
1659:         loc_oGrd.Column2.Header1.Caption = "Data"
1660:         loc_oGrd.Column3.Header1.Caption = "Vencimento"
1661:         loc_oGrd.Column4.Header1.Caption = "Valor"
1662:         loc_oGrd.Column5.Header1.Caption = "Moeda"
1663:         loc_oGrd.Column6.Header1.Caption = "Historico"
1664:         loc_oGrd.Column7.Header1.Caption = "Fornecedor"
1665:         loc_oGrd.Column8.Header1.Caption = "Empresa"
1666: 
1667:         loc_oGrd.SetAll("DynamicForeColor", "RGB(0,0,0)", "Column")
1668:         loc_oGrd.Refresh()
1669: 
1670:         *-- Muda para pagina de dados
1671:         THIS.AlternarPagina(2)

*-- Linhas 1714 a 1732:
1714:             LOCAL loc_nCont
1715:             loc_nCont = 0
1716:             IF USED("cursor_4c_Filtro")
1717:                 SELECT cursor_4c_Filtro
1718:                 SCAN
1719:                     IF cursor_4c_Filtro.marca
1720:                         loc_nCont = loc_nCont + 1
1721:                     ENDIF
1722:                 ENDSCAN
1723:             ENDIF
1724:             IF loc_nCont = 0
1725:                 MsgAviso("Nenhum registro foi selecionado")
1726:                 RETURN
1727:             ENDIF
1728: 
1729:             *-- Busca grupos da conta bancaria para montar GruContas
1730:             loc_cGruposConta = loc_oBO.BuscarGruposContaCli(loc_cCdConta)
1731:             IF EMPTY(loc_cGruposConta)
1732:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel determinar o grupo da conta banc" + CHR(225) + "ria.")

*-- Linhas 1746 a 1764:
1746:                 RETURN
1747:             ENDIF
1748: 
1749:             SELECT cursor_4c_Convenio
1750:             GO TOP
1751: 
1752:             *-- Define dias protesto do convenio
1753:             loc_oP2.spn_4c_Dias.Value = IIF(EMPTY(NVL(cursor_4c_Convenio.DiasProts, 0)), 5, cursor_4c_Convenio.DiasProts)
1754: 
1755:             *-- Despacha para o metodo CNAB correto
1756:             loc_cBanco = ALLTRIM(cursor_4c_Convenio.nbancos)
1757:             DO CASE
1758:                 CASE loc_cBanco = "001"
1759:                     THIS.CnabBrasil()
1760:                 CASE loc_cBanco = "341"
1761:                     THIS.CnabItau240()
1762:                 CASE loc_cBanco = "237"
1763:                     THIS.CnabBrades240()
1764:                 CASE INLIST(loc_cBanco, "033", "353")

*-- Linhas 1783 a 1810:
1783:             IF USED("cursor_4c_CabRel")
1784:                 USE IN cursor_4c_CabRel
1785:             ENDIF
1786:             CREATE CURSOR cursor_4c_CabRel (titulo C(100), periodo C(100), empresa C(100))
1787:             INSERT INTO cursor_4c_CabRel (titulo, periodo, empresa) ;
1788:                 VALUES ("Dados para gera" + CHR(231) + CHR(227) + "o do CNAB", ;
1789:                         loc_cDataRel, ;
1790:                         loc_cCdEmp + " - " + ALLTRIM(NVL(cursor_4c_Empresa.RazSocs, "")))
1791: 
1792:             IF USED("cursor_4c_Filtro2Rel")
1793:                 USE IN cursor_4c_Filtro2Rel
1794:             ENDIF
1795:             SELECT *, SPACE(11) AS SeqNums FROM cursor_4c_Filtro WHERE marca INTO CURSOR cursor_4c_Filtro2Rel
1796: 
1797:             IF par_cTipo = "V"
1798:                 REPORT FORM sigrecnb PREVIEW
1799:             ENDIF
1800:         ENDIF
1801:     ENDPROC
1802: 
1803:     *==========================================================================
1804:     * BuscarBoleto - Classifica registros de cursor_4c_Filtro por tipo pagamento
1805:     * par_cBco: codigo banco FEBRABAN (ex: '341', '237', '033')
1806:     * Cria cursores: crFiltro2 (cc), crFiltroTr (transfer/pix), crFiltro3 (boleto),
1807:     *                crFiltro4 (doc), crFiltro5 (boleto outro banco),
1808:     *                crFiltro6 (tributos), crFiltro20 (todos processados)
1809:     *==========================================================================
1810:     PROCEDURE BuscarBoleto(par_cBco)

*-- Linhas 1817 a 1924:
1817:         ENDIF
1818: 
1819:         *-- Preenche campo barras em crFiltro2 a partir de SigMvCcb
1820:         SELECT crFiltro2
1821:         GO TOP
1822:         SCAN
1823:             loc_cFkChaves = ALLTRIM(crFiltro2.Emps) + STR(crFiltro2.Nopers, 10) + ALLTRIM(crFiltro2.Opers)
1824:             loc_cBarras   = THIS.this_oBusinessObject.BuscarBarrasCcb(loc_cFkChaves)
1825:             IF !EMPTY(loc_cBarras)
1826:                 REPLACE barras WITH loc_cBarras IN crFiltro2
1827:             ENDIF
1828:             SELECT crFiltro2
1829:         ENDSCAN
1830: 
1831:         *-- Salva snapshot de tudo (para update titbans depois)
1832:         IF USED("crFiltro20")
1833:             USE IN crFiltro20
1834:         ENDIF
1835:         SELECT * FROM crFiltro2 INTO CURSOR crFiltro20
1836: 
1837:         *-- Separa boletos (com barras) de transferencias (sem barras)
1838:         IF USED("crFiltro3")
1839:             USE IN crFiltro3
1840:         ENDIF
1841:         IF USED("crFiltroTr")
1842:             USE IN crFiltroTr
1843:         ENDIF
1844:         SELECT * FROM crFiltro2 WHERE ALLTRIM(barras) != SPACE(50) AND !EMPTY(ALLTRIM(barras)) INTO CURSOR crFiltro3 READWRITE
1845:         SELECT * FROM crFiltro2 WHERE ALLTRIM(barras) = SPACE(50) OR EMPTY(ALLTRIM(barras)) INTO CURSOR crFiltroTr READWRITE
1846: 
1847:         *-- Classifica transferencias: DOC (outro banco) vs credito em conta (mesmo banco)
1848:         IF USED("crFiltro4")
1849:             USE IN crFiltro4
1850:         ENDIF
1851:         IF USED("crFiltro2")
1852:             USE IN crFiltro2
1853:         ENDIF
1854:         SELECT * FROM crFiltroTr WHERE Grupos + contas IN (SELECT GruContas FROM cursor_4c_BancoDif) INTO CURSOR crFiltro4 READWRITE
1855:         SELECT * FROM crFiltroTr WHERE Grupos + contas IN (SELECT GruContas FROM cursor_4c_BancoIgual) INTO CURSOR crFiltro2 READWRITE
1856: 
1857:         *-- Classifica boletos: tributos (len=48), mesmo banco, outro banco
1858:         IF USED("crFiltro6")
1859:             USE IN crFiltro6
1860:         ENDIF
1861:         IF USED("crFiltro5")
1862:             USE IN crFiltro5
1863:         ENDIF
1864:         SELECT * FROM crFiltro3 WHERE LEN(ALLTRIM(barras)) = 48 INTO CURSOR crFiltro6 READWRITE
1865:         SELECT * FROM crFiltro3 WHERE LEN(ALLTRIM(barras)) != 48 AND SUBSTR(barras, 1, 3) != par_cBco INTO CURSOR crFiltro5 READWRITE
1866:         SELECT * FROM crFiltro3 WHERE LEN(ALLTRIM(barras)) != 48 AND SUBSTR(barras, 1, 3) = par_cBco INTO CURSOR crFiltro3 READWRITE
1867: 
1868:         *-- Identifica PIX (tipochv preenchido em crFiltroTr)
1869:         SELECT * FROM crFiltroTr WHERE !EMPTY(ALLTRIM(tipochv)) INTO CURSOR crFiltroTr READWRITE
1870: 
1871:         *-- Se ha PIX, esvazia os outros cursores (processa apenas PIX)
1872:         LOCAL loc_cMsg
1873:         loc_cMsg = ""
1874:         IF RECCOUNT("crFiltroTr") > 0
1875:             SELECT * FROM crFiltro2  WHERE 0 = 1 INTO CURSOR crFiltro2  READWRITE
1876:             SELECT * FROM crFiltro3  WHERE 0 = 1 INTO CURSOR crFiltro3  READWRITE
1877:             SELECT * FROM crFiltro4  WHERE 0 = 1 INTO CURSOR crFiltro4  READWRITE
1878:             SELECT * FROM crFiltro5  WHERE 0 = 1 INTO CURSOR crFiltro5  READWRITE
1879:             SELECT * FROM crFiltro6  WHERE 0 = 1 INTO CURSOR crFiltro6  READWRITE
1880:             loc_cMsg = "Ser" + CHR(225) + " gerado remessa apenas de PIX." + CHR(13) + CHR(10)
1881:         ENDIF
1882: 
1883:         *-- Titulos sem dados bancarios (para aviso)
1884:         LOCAL loc_cSemDados
1885:         loc_cSemDados = ""
1886:         IF USED("crErro")
1887:             USE IN crErro
1888:         ENDIF
1889:         SELECT * FROM crFiltro20 ;
1890:             WHERE Grupos + contas NOT IN (SELECT Grupos + contas FROM crFiltro2) ;
1891:             AND   Grupos + contas NOT IN (SELECT Grupos + contas FROM crFiltro3) ;
1892:             AND   Grupos + contas NOT IN (SELECT Grupos + contas FROM crFiltro4) ;
1893:             AND   Grupos + contas NOT IN (SELECT Grupos + contas FROM crFiltro5) ;
1894:             AND   Grupos + contas NOT IN (SELECT Grupos + contas FROM crFiltroTr) ;
1895:             AND   Grupos + contas NOT IN (SELECT Grupos + contas FROM crFiltro6) ;
1896:             INTO CURSOR crErro
1897: 
1898:         SELECT crErro
1899:         GO TOP
1900:         SCAN
1901:             loc_cMsg = loc_cMsg + ALLTRIM(crErro.contas) + "-" + ALLTRIM(crErro.rclis) + CHR(13) + CHR(10)
1902:         ENDSCAN
1903: 
1904:         IF !EMPTY(loc_cMsg)
1905:             MsgAviso(loc_cMsg + CHR(13) + "N" + CHR(227) + "o entraram no CNAB")
1906:         ENDIF
1907: 
1908:         *-- Atualiza crFiltro20 removendo os que nao entraram
1909:         SELECT * FROM crFiltro20 WHERE Grupos + contas NOT IN (SELECT Grupos + contas FROM crErro) INTO CURSOR crFiltro20 READWRITE
1910:     ENDPROC
1911: 
1912:     *==========================================================================
1913:     * CnabItau240 - Gera arquivo CNAB 240 posicoes para Itau (banco 341)
1914:     *==========================================================================
1915:     PROCEDURE CnabItau240()
1916:         LOCAL loc_oBO, loc_oP2
1917:         LOCAL lcCnv, lcAgeE, lcDigAE, lcCtaCE, lcDigCE, lcCtaE
1918:         LOCAL lcRaz, lcCgc, lctpcgc, lcrazbco
1919:         LOCAL lcDat, lcHora, lcprot, lcEnv, lcArq, lcTpCtArq, lcTpCtBol
1920:         LOCAL lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco
1921:         LOCAL lnLot, lcLot, lnSeq, lcSeq, lcFin, lnQlote, lcQlote
1922:         LOCAL lcstrg, lok, lnPix
1923:         LOCAL loc_cSQL
1924: 

*-- Linhas 1930 a 1964:
1930:         IF USED("crFiltro2")
1931:             USE IN crFiltro2
1932:         ENDIF
1933:         SELECT *, SPACE(10) AS nossoNum, SPACE(50) AS barras FROM cursor_4c_Filtro WHERE marca INTO CURSOR crFiltro2 READWRITE
1934: 
1935:         *-- Classifica registros por tipo de pagamento
1936:         THIS.BuscarBoleto("341")
1937: 
1938:         *-- Variaveis do convenio e empresa (de cursor_4c_Convenio e cursor_4c_Empresa)
1939:         SELECT cursor_4c_Convenio
1940:         GO TOP
1941: 
1942:         lcCnv  = PADR(ALLTRIM(cursor_4c_Convenio.Convenios), 20, " ")
1943:         lcAgeE = PADL(ALLTRIM(cursor_4c_Convenio.NAgencias), 5, "0")
1944:         lcDigAE= ALLTRIM(cursor_4c_Convenio.DigiAgen)
1945:         lcCtaCE= PADL(ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")), 13, "0")
1946:         lcDigCE= SUBSTR(lcCtaCE, 13, 1)
1947:         lcCtaE = SUBSTR(lcCtaCE, 1, 12)
1948: 
1949:         SELECT cursor_4c_Empresa
1950:         GO TOP
1951: 
1952:         lcRaz    = PADR(ALLTRIM(cursor_4c_Empresa.RazSocs), 30)
1953:         lcCgc    = PADL(ALLTRIM(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Empresa.Cgcs, "/", ""), ".", ""), "-", "")), 14, "0")
1954:         lctpcgc  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Empresa.Cgcs, "/.-", ""))) = 11, "1", "2")
1955:         lcrazbco = PADR(ALLTRIM(cursor_4c_Convenio.bancos), 30)
1956: 
1957:         lcDat     = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 7, 4)
1958:         lcHora    = TTOC(DATETIME())
1959:         lcHora    = SUBSTR(lcHora, 12, 2) + SUBSTR(lcHora, 15, 2) + SUBSTR(lcHora, 18, 2)
1960:         lcprot    = IIF(loc_oP2.spn_4c_Dias.Value = 0, 5, loc_oP2.spn_4c_Dias.Value)
1961:         lcprot    = PADL(ALLTRIM(STR(lcprot)), 2, "0")
1962:         lcEnv     = PADL(fGerUniqueKey("ITAUENV"), 7, "0")
1963:         lcArq     = ALLTRIM(cursor_4c_Convenio.Drive) + IIF(EMPTY(ALLTRIM(cursor_4c_Convenio.Drive)), "", "\")
1964:         lcArq     = STRTRAN(lcArq + ALLTRIM(cursor_4c_Convenio.ArqCnabs) + lcEnv + ".REM", "\\", "\")

*-- Linhas 2048 a 2066:
2048: 
2049:         *-- Boleto outro banco (crFiltro5)
2050:         IF RECCOUNT("crFiltro5") > 0 AND RECCOUNT("crFiltroTr") = 0
2051:             SELECT * FROM crFiltro5 INTO CURSOR crFiltro3 READWRITE
2052:             THIS.CnabItau240LoteBoleto(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, ;
2053:                 lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
2054:                 lcArq, lcprot, "31", "crFiltro3", "341")
2055:         ENDIF
2056: 
2057:         *-- Trailer do arquivo
2058:         IF FILE(lcArq)
2059:             LOCAL lcT001a003, lcT004a007, lcT008a008, lcT009a017, lcT018a023, lcT024a029, lcT030a035, lcT036a240
2060:             lcT001a003 = "341"
2061:             lcT004a007 = "9999"
2062:             lcT008a008 = "9"
2063:             lcT009a017 = SPACE(9)
2064:             lcT018a023 = "00" + PADL(ALLTRIM(STR(THIS.this_nCnabLot)), 4, "0")
2065:             lcT024a029 = PADL(ALLTRIM(STR(INT(FSIZE(lcArq)/242)+1)), 6, "0")
2066:             lcT030a035 = "000000"

*-- Linhas 2072 a 2102:
2072:             *-- Atualiza titbans em SigMvCcr
2073:             lok = .T.
2074:             IF lok
2075:                 SELECT crFiltro20
2076:                 SCAN
2077:                     LOCAL loc_cTitBans, loc_cTitulos, loc_lAtua
2078:                     loc_cTitBans = loc_oBO.BuscarTituloBanco(crFiltro20.nopers)
2079:                     loc_cTitulos = ALLTRIM(NVL(crFiltro20.titulos, ""))
2080:                     loc_lAtua = .T.
2081:                     IF !EMPTY(loc_cTitBans)
2082:                         loc_lAtua = MsgConfirma('T' + CHR(237) + 'tulo "' + loc_cTitulos + '" j' + CHR(225) + ' possui T' + CHR(237) + 'tulo do Banco preenchido. Sobrescrever?')
2083:                     ENDIF
2084:                     IF loc_lAtua
2085:                         loc_oBO.AtualizarTituloBanco(crFiltro20.nopers, "TIT ITAU")
2086:                     ENDIF
2087:                     SELECT crFiltro20
2088:                 ENDSCAN
2089:             ENDIF
2090: 
2091:             MsgAviso("Arquivo '" + lcArq + "' gerado com sucesso.")
2092:             THIS.pgf_4c_Principal.pgdados.cgp_4c_Acoes.Command3.Enabled = .F.
2093:         ENDIF
2094:     ENDPROC
2095: 
2096:     *==========================================================================
2097:     * CnabItau240LoteCC - Gera lote de credito em conta / DOC para Itau 240
2098:     *==========================================================================
2099:     PROTECTED PROCEDURE CnabItau240LoteCC(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, ;
2100:         lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
2101:         lcArq, lcprot, par_cFormaPgto, par_cCursor, par_cBanco)
2102: 

*-- Linhas 2160 a 2189:
2160:         lnValtot = 0
2161:         lnMoetot = 0
2162: 
2163:         SELECT (par_cCursor)
2164:         SCAN
2165:             *-- Busca conta do favorecido
2166:             loc_cSQL = "SELECT * FROM SigCdCeb WHERE GruContas = " + ;
2167:                        EscaparSQL(Grupos + contas) + ;
2168:                        " AND NAgencias != '' AND contas != '' AND nbancos != 0 ORDER BY NAgencias"
2169:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Conta") < 1
2170:                 MsgAviso("Falha na conex" + CHR(227) + "o ao buscar conta do favorecido.")
2171:                 LOOP
2172:             ENDIF
2173:             GO TOP IN cursor_4c_Conta
2174:             SELECT (par_cCursor)
2175:             IF RECCOUNT("cursor_4c_Conta") = 0
2176:                 lcSemCC = lcSemCC + contas + " "
2177:                 LOOP
2178:             ENDIF
2179: 
2180:             LOCAL lcnopers, lcvenc, lccgccli, lctpcgcCli, lcnome
2181:             LOCAL lcValpag, lcValmoe, lcende, lcbair, lcCep, lcCida, lcEsta
2182:             LOCAL lcnumero, lcCompl, lcCep1, lcCep2
2183:             LOCAL lcBco, lcAge, lcDigA, lcCtaC, lcDigC, lcDigAC, lcCta, lcAgCta, lcTpcta
2184:             LOCAL lcOutCgc, lcnumtit, lcChave, lcNossoNum, lcTptrans
2185:             LOCAL lcA001a003, lcA004a007, lcA008a008, lcA009a013, lcA014a014
2186:             LOCAL lcA015a017, lcA018a020, lcA021a023, lcA024a043, lcA044a073
2187:             LOCAL lcA074a093, lcA094a101, lcA102a104, lcA105a112, lcA113a114
2188:             LOCAL lcA115a119, lcA120a134, lcA135a149, lcA150a154, lcA155a162
2189:             LOCAL lcA163a177, lcA178a195, lcA196a197, lcA198a203, lcA204a217

*-- Linhas 2209 a 2241:
2209:             lcCep1  = SUBSTR(lcCep, 1, 5)
2210:             lcCep2  = SUBSTR(lcCep, 6, 3)
2211: 
2212:             SELECT cursor_4c_Conta
2213:             GO TOP
2214:             lcBco  = PADL(ALLTRIM(cursor_4c_Conta.nbancos), 3, "0")
2215:             lcAge  = PADL(ALLTRIM(cursor_4c_Conta.NAgencias), 5, "0")
2216:             lcDigA = ALLTRIM(cursor_4c_Conta.DigiAgen)
2217:             lcCtaC = PADL(ALLTRIM(CHRTRAN(cursor_4c_Conta.contas, ".-", "")), 13, "0")
2218:             lcDigC = SUBSTR(lcCtaC, 13, 1)
2219:             lcDigAC = " "
2220:             lcCta  = SUBSTR(lcCtaC, 1, 12)
2221:             lcAgCta = lcAge + " " + lcCta + " " + lcDigC
2222:             lcTpcta = IIF(cursor_4c_Conta.tpCtas = "02", "02", "01")
2223:             lcOutCgc = ALLTRIM(CHRTRAN(cursor_4c_Conta.Convenios, "/.-,", ""))
2224:             lccgccli = IIF(LEN(lcOutCgc) != 11 AND LEN(lcOutCgc) != 14, lccgccli, PADL(lcOutCgc, 14, "0"))
2225: 
2226:             SELECT (par_cCursor)
2227:             lcnumtit = PADL(ALLTRIM(STRTRAN(titulos, "/", "")), 15, "0")
2228:             lcChave  = PADR(ALLTRIM(titulos), 10) + lcnopers
2229: 
2230:             lcNossoNum = ALLTRIM(STR(fGerUniqueKey("BRNOSSONUM")))
2231:             REPLACE nossoNum WITH PADL(lcNossoNum, 10, "0") IN (par_cCursor)
2232:             lcNossoNum = PADR(lcNossoNum, 20)
2233: 
2234:             lnSeql = lnSeql + 1
2235:             lcSeql = TRANSFORM(lnSeql, "@L 99999")
2236:             lnQlote = lnQlote + 1
2237:             lnSeq = lnSeq + 1
2238: 
2239:             lcA001a003 = par_cBanco
2240:             lcA004a007 = lcLot
2241:             lcA008a008 = "3"

*-- Linhas 2279 a 2297:
2279: 
2280:             loc_oBO.RegistrarLinhaArquivo("C", nopers, lcstrg, titulos, lcChave)
2281: 
2282:             SELECT (par_cCursor)
2283:         ENDSCAN
2284: 
2285:         *-- Trailer do lote
2286:         lnSeq = lnSeq + 1
2287:         lnSeql = lnSeql + 1
2288:         lcSeql = TRANSFORM(lnSeql, "@L 999999")
2289:         lnQlote = lnQlote + 1
2290:         lcQlote = TRANSFORM(lnQlote, "@L 999999")
2291:         LOCAL lcValtotStr, lcMoetotStr
2292:         lcValtotStr = TRANSFORM(lnValtot * 100, "@L 999999999999999999")
2293:         lcMoetotStr = TRANSFORM(lnMoetot * 100000, "@L 999999999999999999")
2294: 
2295:         LOCAL lcTL001a003, lcTL004a007, lcTL008a008, lcTL009a017, lcTL018a023
2296:         LOCAL lcTL024a041, lcTL042a059, lcTL060a230, lcTL231a240
2297:         lcTL001a003 = par_cBanco

*-- Linhas 2373 a 2391:
2373:         lnValtot = 0
2374:         lnMoetot = 0
2375: 
2376:         SELECT (par_cCursor)
2377:         SCAN
2378:             lnQlote = lnQlote + 1
2379: 
2380:             LOCAL lcnopers, lcvenc, lccgccli, lctpcgcCli, lcnome, lcValpag, lcValmoe
2381:             LOCAL lcBarra, lcChave, lcNossoNum
2382:             LOCAL lcJ001a003, lcJ004a007, lcJ008a008, lcJ009a013, lcJ014a014
2383:             LOCAL lcJ015a017, lcJ018a061, lcJ062a091, lcJ092a099, lcJ100a114
2384:             LOCAL lcJ115a129, lcJ130a144, lcJ145a152, lcJ153a167, lcJ168a182
2385:             LOCAL lcJ183a202, lcJ203a215, lcJ216a230, lcJ231a240
2386: 
2387:             lcnopers   = TRANSFORM(nopers, "@L 9999999999")
2388:             lcvenc     = SUBSTR(DTOC(vencs), 1, 2) + SUBSTR(DTOC(vencs), 4, 2) + SUBSTR(DTOC(vencs), 7, 4)
2389:             lccgccli   = PADL(ALLTRIM(CHRTRAN(cpfs, "/.-,", "")), 14, "0")
2390:             lctpcgcCli = IIF(LEN(ALLTRIM(CHRTRAN(cpfs, "/.-", ""))) = 11, "1", "2")
2391:             lcnome     = PADR(ALLTRIM(IIF(EMPTY(Razaos), rclis, Razaos)), 30)

*-- Linhas 2468 a 2486:
2468: 
2469:             loc_oBO.RegistrarLinhaArquivo("C", nopers, lcstrg, titulos, lcChave)
2470: 
2471:             SELECT (par_cCursor)
2472:         ENDSCAN
2473: 
2474:         *-- Trailer do lote
2475:         lnSeq = lnSeq + 1
2476:         lnSeql = lnSeql + 1
2477:         lcSeql = TRANSFORM(lnSeql, "@L 999999")
2478:         lnQlote = lnQlote + 1
2479:         lcQlote = TRANSFORM(lnQlote, "@L 999999")
2480:         LOCAL lcValtotStr, lcMoetotStr
2481:         lcValtotStr = TRANSFORM(lnValtot * 100, "@L 999999999999999999")
2482:         lcMoetotStr = "000000000000000000"
2483: 
2484:         LOCAL lcTL001a003, lcTL004a007, lcTL008a008, lcTL009a017, lcTL018a023
2485:         LOCAL lcTL024a041, lcTL042a059, lcTL060a065, lcTL066a230, lcTL231a240
2486:         lcTL001a003 = par_cBanco

*-- Linhas 2518 a 2541:
2518:         IF USED("crFiltro2")
2519:             USE IN crFiltro2
2520:         ENDIF
2521:         SELECT *, SPACE(10) AS nossoNum, SPACE(50) AS barras FROM cursor_4c_Filtro WHERE marca INTO CURSOR crFiltro2 READWRITE
2522:         THIS.BuscarBoleto("237")
2523: 
2524:         SELECT cursor_4c_Convenio
2525:         GO TOP
2526:         SELECT cursor_4c_Empresa
2527:         GO TOP
2528: 
2529:         lcCnv  = PADR(ALLTRIM(cursor_4c_Convenio.Convenios), 20, " ")
2530:         lcAgeE = PADL(ALLTRIM(cursor_4c_Convenio.NAgencias), 5, "0")
2531:         lcDigAE= PADR(ALLTRIM(cursor_4c_Convenio.DigiAgen), 1)
2532:         lcCtaCE= PADL(ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")), 13, "0")
2533:         lcDigCE= SUBSTR(lcCtaCE, 13, 1)
2534:         lcDigACE = " "
2535:         lcCtaE = SUBSTR(lcCtaCE, 1, 12)
2536:         lcRaz    = PADR(ALLTRIM(cursor_4c_Empresa.RazSocs), 30)
2537:         lcCgc    = PADL(ALLTRIM(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Empresa.Cgcs, "/", ""), ".", ""), "-", "")), 14, "0")
2538:         lctpcgc  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Empresa.Cgcs, "/.-", ""))) = 11, "1", "2")
2539:         lcrazbco = PADR(ALLTRIM(cursor_4c_Convenio.bancos), 30)
2540:         lcDat    = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 7, 4)
2541:         lcprot   = IIF(loc_oP2.spn_4c_Dias.Value = 0, 5, loc_oP2.spn_4c_Dias.Value)

*-- Linhas 2616 a 2669:
2616:         ENDIF
2617: 
2618:         IF RECCOUNT("crFiltro5") > 0
2619:             SELECT * FROM crFiltro5 INTO CURSOR crFiltro3 READWRITE
2620:             THIS.CnabBrades240LoteBoleto(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
2621:                 lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
2622:                 lcArq, lcprot, "crFiltro3", "237")
2623:         ENDIF
2624: 
2625:         *-- Trailer do arquivo
2626:         IF FILE(lcArq)
2627:             LOCAL lcT001a003, lcT004a007, lcT008a008, lcT009a017, lcT018a023, lcT024a029, lcT030a035, lcT036a240
2628:             lcT001a003 = "237"
2629:             lcT004a007 = "9999"
2630:             lcT008a008 = "9"
2631:             lcT009a017 = SPACE(9)
2632:             lcT018a023 = "00" + PADL(ALLTRIM(STR(THIS.this_nCnabLot)), 4, "0")
2633:             lcT024a029 = PADL(ALLTRIM(STR(INT(FSIZE(lcArq)/242)+1)), 6, "0")
2634:             lcT030a035 = "000000"
2635:             lcT036a240 = SPACE(205)
2636:             lcstrg = lcT001a003+lcT004a007+lcT008a008+lcT009a017+lcT018a023+lcT024a029+lcT030a035+lcT036a240+CHR(13)+CHR(10)
2637:             lcstrg = fLimpaTexto(lcstrg)
2638:             STRTOFILE(lcstrg, lcArq, 1)
2639: 
2640:             lok = .T.
2641:             IF lok
2642:                 SELECT crFiltro20
2643:                 SCAN
2644:                     LOCAL loc_cTitBans, loc_cTitulos, loc_lAtua
2645:                     loc_cTitBans = loc_oBO.BuscarTituloBanco(crFiltro20.nopers)
2646:                     loc_cTitulos = ALLTRIM(NVL(crFiltro20.titulos, ""))
2647:                     loc_lAtua = .T.
2648:                     IF !EMPTY(loc_cTitBans)
2649:                         loc_lAtua = MsgConfirma('T' + CHR(237) + 'tulo "' + loc_cTitulos + '" j' + CHR(225) + ' possui T' + CHR(237) + 'tulo do Banco preenchido. Sobrescrever?')
2650:                     ENDIF
2651:                     IF loc_lAtua
2652:                         loc_oBO.AtualizarTituloBanco(crFiltro20.nopers, "TIT BRADESC")
2653:                     ENDIF
2654:                     SELECT crFiltro20
2655:                 ENDSCAN
2656:             ENDIF
2657: 
2658:             MsgAviso("Arquivo '" + lcArq + "' gerado com sucesso.")
2659:             THIS.pgf_4c_Principal.pgdados.cgp_4c_Acoes.Command3.Enabled = .F.
2660:         ENDIF
2661:     ENDPROC
2662: 
2663:     *==========================================================================
2664:     * CnabBrades240LoteCC - Lote credito em conta para Bradesco
2665:     *==========================================================================
2666:     PROTECTED PROCEDURE CnabBrades240LoteCC(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
2667:         lcRaz, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
2668:         lcArq, lcprot, par_cFormaPgto, par_cCursor, par_cBanco)
2669: 

*-- Linhas 2724 a 2780:
2724:         lnValtot = 0
2725:         lnMoetot = 0
2726: 
2727:         SELECT (par_cCursor)
2728:         SCAN
2729:             loc_cSQL = "SELECT * FROM SigCdCeb WHERE GruContas = " + ;
2730:                        EscaparSQL(Grupos + contas) + ;
2731:                        " AND NAgencias != '' AND contas != '' AND nbancos != 0 ORDER BY NAgencias"
2732:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Conta") < 1
2733:                 LOOP
2734:             ENDIF
2735:             GO TOP IN cursor_4c_Conta
2736:             SELECT (par_cCursor)
2737:             IF RECCOUNT("cursor_4c_Conta") = 0
2738:                 LOOP
2739:             ENDIF
2740: 
2741:             LOCAL lcnopers, lcvenc, lccgccli, lctpcgcCli, lcnome
2742:             LOCAL lcValpag, lcChave, lcNossoNum, lcTpcta
2743:             LOCAL lcBco, lcAge, lcDigA, lcCtaC, lcDigC, lcCta, lcAgCta, lcOutCgc
2744: 
2745:             lcnopers   = TRANSFORM(nopers, "@L 9999999999")
2746:             lcvenc     = SUBSTR(DTOC(vencs), 1, 2) + SUBSTR(DTOC(vencs), 4, 2) + SUBSTR(DTOC(vencs), 7, 4)
2747:             lccgccli   = PADL(ALLTRIM(CHRTRAN(cpfs, "/.-,", "")), 14, "0")
2748:             lctpcgcCli = IIF(LEN(ALLTRIM(CHRTRAN(cpfs, "/.-", ""))) = 11, "1", "2")
2749:             lcnome     = PADR(ALLTRIM(IIF(EMPTY(Razaos), rclis, Razaos)), 30)
2750:             lcValpag   = TRANSFORM(valors * 100, "@L 999999999999999")
2751:             lnValtot   = lnValtot + valors
2752: 
2753:             SELECT cursor_4c_Conta
2754:             GO TOP
2755:             lcBco  = PADL(ALLTRIM(cursor_4c_Conta.nbancos), 3, "0")
2756:             lcAge  = PADL(ALLTRIM(cursor_4c_Conta.NAgencias), 5, "0")
2757:             lcCtaC = PADL(ALLTRIM(CHRTRAN(cursor_4c_Conta.contas, ".-", "")), 13, "0")
2758:             lcDigC = SUBSTR(lcCtaC, 13, 1)
2759:             lcCta  = SUBSTR(lcCtaC, 1, 12)
2760:             lcAgCta = lcAge + " " + lcCta + " " + lcDigC
2761:             lcTpcta = IIF(cursor_4c_Conta.tpCtas = "02", "PP", "CC")
2762:             lcOutCgc = ALLTRIM(CHRTRAN(cursor_4c_Conta.Convenios, "/.-,", ""))
2763:             lccgccli = IIF(LEN(lcOutCgc) != 11 AND LEN(lcOutCgc) != 14, lccgccli, PADL(lcOutCgc, 14, "0"))
2764: 
2765:             SELECT (par_cCursor)
2766:             lcChave  = PADR(ALLTRIM(titulos), 10) + lcnopers
2767:             lcNossoNum = ALLTRIM(STR(fGerUniqueKey("BRNOSSONUM")))
2768:             REPLACE nossoNum WITH PADL(lcNossoNum, 10, "0") IN (par_cCursor)
2769: 
2770:             lnSeql = lnSeql + 1
2771:             lcSeql = TRANSFORM(lnSeql, "@L 99999")
2772:             lnQlote = lnQlote + 1
2773:             lnSeq = lnSeq + 1
2774: 
2775:             LOCAL lcA001a003, lcA004a007, lcA008a008, lcA009a013, lcA014a014
2776:             LOCAL lcA015a017, lcA018a020, lcA021a023, lcA024a043, lcA044a073
2777:             LOCAL lcA074a093, lcA094a101, lcA102a104, lcA105a112, lcA113a119
2778:             LOCAL lcA120a134, lcA135a149, lcA150a154, lcA155a162, lcA163a177
2779:             LOCAL lcA178a195, lcA196a197, lcA198a203, lcA204a217, lcA218a219
2780:             LOCAL lcA220a224, lcA225a229, lcA230a230, lcA231a240

*-- Linhas 2819 a 2837:
2819:             STRTOFILE(lcstrg, lcArq, 1)
2820: 
2821:             loc_oBO.RegistrarLinhaArquivo("C", nopers, lcstrg, titulos, lcChave)
2822:             SELECT (par_cCursor)
2823:         ENDSCAN
2824: 
2825:         lnSeq = lnSeq + 1
2826:         lnSeql = lnSeql + 1
2827:         lcSeql = TRANSFORM(lnSeql, "@L 999999")
2828:         lnQlote = lnQlote + 1
2829:         lcQlote = TRANSFORM(lnQlote, "@L 999999")
2830:         LOCAL lcValtotStr, lcMoetotStr
2831:         lcValtotStr = TRANSFORM(lnValtot * 100, "@L 999999999999999999")
2832:         lcMoetotStr = "000000000000000000"
2833:         LOCAL lcTL001a003, lcTL004a007, lcTL008a008, lcTL009a017, lcTL018a023
2834:         LOCAL lcTL024a041, lcTL042a059, lcTL060a230, lcTL231a240
2835:         lcTL001a003 = par_cBanco
2836:         lcTL004a007 = lcLot
2837:         lcTL008a008 = "5"

*-- Linhas 2908 a 2935:
2908:         lnSeql = 0
2909:         lnValtot = 0
2910: 
2911:         SELECT (par_cCursor)
2912:         SCAN
2913:             lnQlote = lnQlote + 1
2914:             loc_cSQL = "SELECT * FROM SigCdCeb WHERE GruContas = " + ;
2915:                        EscaparSQL(Grupos + contas) + ;
2916:                        " ORDER BY NAgencias"
2917:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Conta") >= 1
2918:                 GO TOP IN cursor_4c_Conta
2919:             ENDIF
2920:             SELECT (par_cCursor)
2921: 
2922:             LOCAL lcnopers, lcvenc, lccgccli, lcnome, lcValpag, lcBarra, lcChave, lcNossoNum
2923:             LOCAL lcO001a003, lcO004a007, lcO008a008, lcO009a013, lcO014a014
2924:             LOCAL lcO015a015, lcO016a017, lcO018a061, lcO062a091, lcO092a099
2925:             LOCAL lcO100a107, lcO108a122, lcO123a142, lcO143a162, lcO163a230, lcO231a240
2926: 
2927:             lcnopers = TRANSFORM(nopers, "@L 9999999999")
2928:             lcvenc   = SUBSTR(DTOC(vencs), 1, 2) + SUBSTR(DTOC(vencs), 4, 2) + SUBSTR(DTOC(vencs), 7, 4)
2929:             lccgccli = PADL(ALLTRIM(CHRTRAN(cpfs, "/.-,", "")), 14, "0")
2930:             lcnome   = PADR(ALLTRIM(IIF(EMPTY(Razaos), rclis, Razaos)), 30)
2931:             lcValpag = TRANSFORM(valors * 100, "@L 999999999999999")
2932:             lnValtot = lnValtot + valors
2933:             lcBarra  = ALLTRIM(CHRTRAN(barras, "/.-", "")) + REPLICATE("0", 44)
2934:             lcBarra  = SUBSTR(lcBarra, 1, 4) + SUBSTR(lcBarra, 33, 15) + SUBSTR(lcBarra, 5, 5) + SUBSTR(lcBarra, 11, 10) + SUBSTR(lcBarra, 22, 10)
2935:             lcChave  = PADR(ALLTRIM(titulos), 10) + lcnopers

*-- Linhas 2964 a 2982:
2964:             STRTOFILE(lcstrg, lcArq, 1)
2965: 
2966:             loc_oBO.RegistrarLinhaArquivo("C", nopers, lcstrg, titulos, lcChave)
2967:             SELECT (par_cCursor)
2968:         ENDSCAN
2969: 
2970:         lnSeq = lnSeq + 1
2971:         lnSeql = lnSeql + 1
2972:         lcSeql = TRANSFORM(lnSeql, "@L 999999")
2973:         lnQlote = lnQlote + 1
2974:         lcQlote = TRANSFORM(lnQlote, "@L 999999")
2975:         LOCAL lcValtotStr
2976:         lcValtotStr = TRANSFORM(lnValtot * 100, "@L 999999999999999999")
2977:         LOCAL lcTL001a003, lcTL004a007, lcTL008a008, lcTL009a017, lcTL018a023
2978:         LOCAL lcTL024a041, lcTL042a059, lcTL060a065, lcTL066a230, lcTL231a240
2979:         lcTL001a003 = par_cBanco
2980:         lcTL004a007 = lcLot
2981:         lcTL008a008 = "5"
2982:         lcTL009a017 = SPACE(9)

*-- Linhas 3011 a 3034:
3011:         IF USED("crFiltro2")
3012:             USE IN crFiltro2
3013:         ENDIF
3014:         SELECT *, SPACE(10) AS nossoNum, SPACE(50) AS barras FROM cursor_4c_Filtro WHERE marca INTO CURSOR crFiltro2 READWRITE
3015:         THIS.BuscarBoleto("033")
3016: 
3017:         SELECT cursor_4c_Convenio
3018:         GO TOP
3019:         SELECT cursor_4c_Empresa
3020:         GO TOP
3021: 
3022:         lcAgeE = PADL(ALLTRIM(cursor_4c_Convenio.NAgencias), 5, "0")
3023:         lcCnv  = "0033" + SUBSTR(lcAgeE, 2, 4) + PADL(ALLTRIM(cursor_4c_Convenio.Convenios), 12, "0")
3024:         lcDigAE = ALLTRIM(cursor_4c_Convenio.DigiAgen)
3025:         lcCtaCE = PADL(ALLTRIM(CHRTRAN(cursor_4c_Convenio.contas, ".-", "")), 13, "0")
3026:         lcDigCE = SUBSTR(lcCtaCE, 13, 1)
3027:         lcDigACE = " "
3028:         lcCtaE = SUBSTR(lcCtaCE, 1, 12)
3029:         lcRaz    = PADR(ALLTRIM(cursor_4c_Empresa.RazSocs), 30)
3030:         lcCgc    = PADL(ALLTRIM(STRTRAN(STRTRAN(STRTRAN(cursor_4c_Empresa.Cgcs, "/", ""), ".", ""), "-", "")), 14, "0")
3031:         lctpcgc  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Empresa.Cgcs, "/.-", ""))) = 11, "1", "2")
3032:         lcrazbco = PADR(ALLTRIM(cursor_4c_Convenio.bancos), 30)
3033:         lcDat    = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 7, 4)
3034:         lcHora   = TTOC(DATETIME())

*-- Linhas 3114 a 3167:
3114:         ENDIF
3115: 
3116:         IF RECCOUNT("crFiltro5") > 0
3117:             SELECT * FROM crFiltro5 INTO CURSOR crFiltro3 READWRITE
3118:             THIS.CnabSant240LoteBoleto(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
3119:                 lcRaz, lcCnv, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
3120:                 lcArq, lcprot, "crFiltro3", "033")
3121:         ENDIF
3122: 
3123:         *-- Trailer do arquivo
3124:         IF FILE(lcArq)
3125:             LOCAL lcT001a003, lcT004a007, lcT008a008, lcT009a017, lcT018a023, lcT024a029, lcT030a035, lcT036a240
3126:             lcT001a003 = "033"
3127:             lcT004a007 = "9999"
3128:             lcT008a008 = "9"
3129:             lcT009a017 = SPACE(9)
3130:             lcT018a023 = "00" + PADL(ALLTRIM(STR(THIS.this_nCnabLot)), 4, "0")
3131:             lcT024a029 = PADL(ALLTRIM(STR(INT(FSIZE(lcArq)/242)+1)), 6, "0")
3132:             lcT030a035 = "000000"
3133:             lcT036a240 = SPACE(205)
3134:             lcstrg = lcT001a003+lcT004a007+lcT008a008+lcT009a017+lcT018a023+lcT024a029+lcT030a035+lcT036a240+CHR(13)+CHR(10)
3135:             lcstrg = fLimpaTexto(lcstrg)
3136:             STRTOFILE(lcstrg, lcArq, 1)
3137: 
3138:             lok = .T.
3139:             IF lok
3140:                 SELECT crFiltro20
3141:                 SCAN
3142:                     LOCAL loc_cTitBans, loc_cTitulos, loc_lAtua
3143:                     loc_cTitBans = loc_oBO.BuscarTituloBanco(crFiltro20.nopers)
3144:                     loc_cTitulos = ALLTRIM(NVL(crFiltro20.titulos, ""))
3145:                     loc_lAtua = .T.
3146:                     IF !EMPTY(loc_cTitBans)
3147:                         loc_lAtua = MsgConfirma('T' + CHR(237) + 'tulo "' + loc_cTitulos + '" j' + CHR(225) + ' possui T' + CHR(237) + 'tulo do Banco preenchido. Sobrescrever?')
3148:                     ENDIF
3149:                     IF loc_lAtua
3150:                         loc_oBO.AtualizarTituloBanco(crFiltro20.nopers, "TIT SANTANDER")
3151:                     ENDIF
3152:                     SELECT crFiltro20
3153:                 ENDSCAN
3154:             ENDIF
3155: 
3156:             MsgAviso("Arquivo '" + lcArq + "' gerado com sucesso.")
3157:         ENDIF
3158:     ENDPROC
3159: 
3160:     *==========================================================================
3161:     * CnabSant240LoteCC - Lote credito em conta para Santander
3162:     *==========================================================================
3163:     PROTECTED PROCEDURE CnabSant240LoteCC(lcLot, lnLot, lnSeq, lcSeq, lctpcgc, lcCgc, lcAgeE, lcCtaE, lcDigCE, lcDigACE, ;
3164:         lcRaz, lcCnv, lcEndesE, lcNumsE, lcComplE, lcCidaE, lcCepE, lcCep1E, lcEstaE, lcOco, ;
3165:         lcArq, lcprot, par_cCursor, par_cBanco)
3166: 
3167:         LOCAL loc_oBO, lcFin, lnQlote, lcQlote, lnSeql, lcSeql, lnValtot, lnMoetot, lcstrg

*-- Linhas 3221 a 3276:
3221:         lnValtot = 0
3222:         lnMoetot = 0
3223: 
3224:         SELECT (par_cCursor)
3225:         SCAN
3226:             loc_cSQL = "SELECT * FROM SigCdCeb WHERE GruContas = " + ;
3227:                        EscaparSQL(Grupos + contas) + ;
3228:                        " AND NAgencias != '' AND contas != '' AND nbancos != 0 ORDER BY NAgencias"
3229:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Conta") < 1
3230:                 LOOP
3231:             ENDIF
3232:             GO TOP IN cursor_4c_Conta
3233:             SELECT (par_cCursor)
3234:             IF RECCOUNT("cursor_4c_Conta") = 0
3235:                 LOOP
3236:             ENDIF
3237: 
3238:             LOCAL lcnopers, lcvenc, lccgccli, lctpcgcCli, lcnome
3239:             LOCAL lcValpag, lcChave, lcNossoNum, lcTpcta
3240:             LOCAL lcBco, lcAge, lcDigA, lcCtaC, lcDigC, lcCta, lcAgCta, lcOutCgc
3241: 
3242:             lcnopers   = TRANSFORM(nopers, "@L 9999999999")
3243:             lcvenc     = SUBSTR(DTOC(vencs), 1, 2) + SUBSTR(DTOC(vencs), 4, 2) + SUBSTR(DTOC(vencs), 7, 4)
3244:             lccgccli   = PADL(ALLTRIM(CHRTRAN(cpfs, "/.-,", "")), 14, "0")
3245:             lctpcgcCli = IIF(LEN(ALLTRIM(CHRTRAN(cpfs, "/.-", ""))) = 11, "1", "2")
3246:             lcnome     = PADR(ALLTRIM(IIF(EMPTY(Razaos), rclis, Razaos)), 30)
3247:             lcValpag   = TRANSFORM(valors * 100, "@L 999999999999999")
3248:             lnValtot   = lnValtot + valors
3249: 
3250:             SELECT cursor_4c_Conta
3251:             GO TOP
3252:             lcBco  = PADL(ALLTRIM(cursor_4c_Conta.nbancos), 3, "0")
3253:             lcAge  = PADL(ALLTRIM(cursor_4c_Conta.NAgencias), 5, "0")
3254:             lcCtaC = PADL(ALLTRIM(CHRTRAN(cursor_4c_Conta.contas, ".-", "")), 13, "0")
3255:             lcDigC = SUBSTR(lcCtaC, 13, 1)
3256:             lcCta  = SUBSTR(lcCtaC, 1, 12)
3257:             lcAgCta = lcAge + " " + lcCta + " " + lcDigC
3258:             lcOutCgc = ALLTRIM(CHRTRAN(cursor_4c_Conta.Convenios, "/.-,", ""))
3259:             lccgccli = IIF(LEN(lcOutCgc) != 11 AND LEN(lcOutCgc) != 14, lccgccli, PADL(lcOutCgc, 14, "0"))
3260: 
3261:             SELECT (par_cCursor)
3262:             lcChave  = PADR(ALLTRIM(titulos), 10) + lcnopers
3263:             lcNossoNum = ALLTRIM(STR(fGerUniqueKey("BRNOSSONUM")))
3264:             REPLACE nossoNum WITH PADL(lcNossoNum, 10, "0") IN (par_cCursor)
3265: 
3266:             lnSeql = lnSeql + 1
3267:             lcSeql = TRANSFORM(lnSeql, "@L 99999")
3268:             lnQlote = lnQlote + 1
3269:             lnSeq = lnSeq + 1
3270: 
3271:             LOCAL lcA001a003, lcA004a007, lcA008a008, lcA009a013, lcA014a014
3272:             LOCAL lcA015a017, lcA018a020, lcA021a023, lcA024a043, lcA044a073
3273:             LOCAL lcA074a093, lcA094a101, lcA102a104, lcA105a112, lcA113a114
3274:             LOCAL lcA115a119, lcA120a134, lcA135a149, lcA150a154, lcA155a162
3275:             LOCAL lcA163a177, lcA178a195, lcA196a197, lcA198a203, lcA204a217
3276:             LOCAL lcA218a219, lcA220a224, lcA225a229, lcA230a230, lcA231a240

*-- Linhas 3316 a 3334:
3316:             STRTOFILE(lcstrg, lcArq, 1)
3317: 
3318:             loc_oBO.RegistrarLinhaArquivo("C", nopers, lcstrg, titulos, lcChave)
3319:             SELECT (par_cCursor)
3320:         ENDSCAN
3321: 
3322:         lnSeq = lnSeq + 1
3323:         lnSeql = lnSeql + 1
3324:         lcSeql = TRANSFORM(lnSeql, "@L 999999")
3325:         lnQlote = lnQlote + 1
3326:         lcQlote = TRANSFORM(lnQlote, "@L 999999")
3327:         LOCAL lcValtotStr, lcMoetotStr
3328:         lcValtotStr = TRANSFORM(lnValtot * 100, "@L 999999999999999999")
3329:         lcMoetotStr = "000000000000000000"
3330:         LOCAL lcTL001a003, lcTL004a007, lcTL008a008, lcTL009a017, lcTL018a023
3331:         LOCAL lcTL024a041, lcTL042a059, lcTL060a230, lcTL231a240
3332:         lcTL001a003 = par_cBanco
3333:         lcTL004a007 = lcLot
3334:         lcTL008a008 = "5"

*-- Linhas 3406 a 3433:
3406:         lnSeql = 0
3407:         lnValtot = 0
3408: 
3409:         SELECT (par_cCursor)
3410:         SCAN
3411:             lnQlote = lnQlote + 1
3412:             loc_cSQL = "SELECT * FROM SigCdCeb WHERE GruContas = " + ;
3413:                        EscaparSQL(Grupos + contas) + ;
3414:                        " ORDER BY NAgencias"
3415:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Conta") >= 1
3416:                 GO TOP IN cursor_4c_Conta
3417:             ENDIF
3418:             SELECT (par_cCursor)
3419: 
3420:             LOCAL lcnopers, lcvenc, lccgccli, lcnome, lcValpag, lcBarra, lcChave, lcNossoNum
3421:             LOCAL lcJ001a003, lcJ004a007, lcJ008a008, lcJ009a013, lcJ014a014
3422:             LOCAL lcJ015a017, lcJ018a061, lcJ062a091, lcJ092a099, lcJ100a114
3423:             LOCAL lcJ115a129, lcJ130a144, lcJ145a152, lcJ153a167, lcJ168a182
3424:             LOCAL lcJ183a202, lcJ203a215, lcJ216a230, lcJ231a240
3425: 
3426:             lcnopers = TRANSFORM(nopers, "@L 9999999999")
3427:             lcvenc   = SUBSTR(DTOC(vencs), 1, 2) + SUBSTR(DTOC(vencs), 4, 2) + SUBSTR(DTOC(vencs), 7, 4)
3428:             lccgccli = PADL(ALLTRIM(CHRTRAN(cpfs, "/.-,", "")), 14, "0")
3429:             lcnome   = PADR(ALLTRIM(IIF(EMPTY(Razaos), rclis, Razaos)), 30)
3430:             lcValpag = TRANSFORM(valors * 100, "@L 999999999999999")
3431:             lnValtot = lnValtot + valors
3432:             lcBarra  = ALLTRIM(CHRTRAN(barras, "/.-", "")) + REPLICATE("0", 44)
3433:             lcBarra  = SUBSTR(lcBarra, 1, 4) + SUBSTR(lcBarra, 33, 15) + SUBSTR(lcBarra, 5, 5) + SUBSTR(lcBarra, 11, 10) + SUBSTR(lcBarra, 22, 10)

*-- Linhas 3466 a 3484:
3466:             STRTOFILE(lcstrg, lcArq, 1)
3467: 
3468:             loc_oBO.RegistrarLinhaArquivo("C", nopers, lcstrg, titulos, lcChave)
3469:             SELECT (par_cCursor)
3470:         ENDSCAN
3471: 
3472:         lnSeq = lnSeq + 1
3473:         lnSeql = lnSeql + 1
3474:         lcSeql = TRANSFORM(lnSeql, "@L 999999")
3475:         lnQlote = lnQlote + 1
3476:         lcQlote = TRANSFORM(lnQlote, "@L 999999")
3477:         LOCAL lcValtotStr
3478:         lcValtotStr = TRANSFORM(lnValtot * 100, "@L 999999999999999999")
3479:         LOCAL lcTL001a003, lcTL004a007, lcTL008a008, lcTL009a017, lcTL018a023
3480:         LOCAL lcTL024a041, lcTL042a059, lcTL060a230, lcTL231a240
3481:         lcTL001a003 = par_cBanco
3482:         lcTL004a007 = lcLot
3483:         lcTL008a008 = "5"
3484:         lcTL009a017 = SPACE(9)

*-- Linhas 3669 a 3687:
3669: 
3670:         *-- Desmarca todos os grupos
3671:         IF USED("cursor_4c_Grupos")
3672:             SELECT cursor_4c_Grupos
3673:             REPLACE ALL marca WITH .F.
3674:             GO TOP
3675:             loc_oP1.grd_4c_Grupos.Refresh()
3676:         ENDIF
3677: 
3678:         *-- Limpa grid de dados
3679:         loc_oP2.grd_4c_Dados.RecordSource = ""
3680:         loc_oP2.grd_4c_Dados.Refresh()
3681: 
3682:         *-- Fecha cursores de resultado anterior
3683:         LOCAL loc_i
3684:         LOCAL loc_aCur(9)
3685:         loc_aCur(1) = "cursor_4c_Filtro"
3686:         loc_aCur(2) = "crFiltro2"
3687:         loc_aCur(3) = "crFiltro3"


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
                       " AND NAgencias != '' AND Convenios != ''" + ;
                       " ORDER BY NAgencias, Convenios"
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


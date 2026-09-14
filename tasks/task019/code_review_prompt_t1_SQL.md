# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPS, QTDS, LNCNT, DOPES, NUMES, CODCORS, CODTAMS, LNQTDS, LNQTDETIQS, NUMPS, EMPDNPS, CPROS, CIDCHAVES, QTDDIVS, X, CHKDESTS, AUTOS, OPPENVEL, DOPPS, VALUE, EMPDOPNUMS, SERVICOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'SEQDIVS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPS, QTDS, LNCNT, DOPES, NUMES, CODCORS, CODTAMS, LNQTDS, LNQTDETIQS, NUMPS, EMPDNPS, CPROS, CIDCHAVES, QTDDIVS, X, CHKDESTS, AUTOS, OPPENVEL, DOPPS, VALUE, EMPDOPNUMS, SERVICOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CITENS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPS, QTDS, LNCNT, DOPES, NUMES, CODCORS, CODTAMS, LNQTDS, LNQTDETIQS, NUMPS, EMPDNPS, CPROS, CIDCHAVES, QTDDIVS, X, CHKDESTS, AUTOS, OPPENVEL, DOPPS, VALUE, EMPDOPNUMS, SERVICOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPS, QTDS, LNCNT, DOPES, NUMES, CODCORS, CODTAMS, LNQTDS, LNQTDETIQS, NUMPS, EMPDNPS, CPROS, CIDCHAVES, QTDDIVS, X, CHKDESTS, AUTOS, OPPENVEL, DOPPS, VALUE, EMPDOPNUMS, SERVICOS

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
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  ControlSource = "Temporario.Qtds"
  ControlSource = "Temporario.nops"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  ControlSource = "Temp_DivOp.Nrped"
  ControlSource = "Temp_DivOp.Qtdade"
  ControlSource = "Temp_DivOp.QtdDiv"
  ControlSource = "Temp_DivOp.qtdetiqs"
  ControlSource = "Temp_DivOp.CodTams"
  ControlSource = "temporario.obss"
  ControlSource = "Temp_DivOp.Obss"
lcQryNensI = [Select * From SigCdNei]
lcQryNens  = [Select * From SigCdNec]
lcQryOpi   = [Select * From SigOpPic Where Nops = ?lnNumOp Order By Nops, Dopes, Numes, CodCors, CodTams ]
lcQryMFas  = [Select * From SigPdMvf]
		SELECT CrSigCdPam
		Select crSigCdOpd
		Select CrSigCdNei
		Create Cursor xNensi From Array aNensi
			.Column1.ControlSource="Alltrim( Temp_DivOP.Dopes ) + ' ' + Alltrim( Str(Temp_DivOp.Numes ))"
			.Column3.ControlSource="Temp_DivOp.Qtds"
			.Column4.ControlSource="Temp_DivOp.QtdDivs"
			.Column2.ControlSource="Temp_DivOp.qtdetiqs"
			.Column5.ControlSource="Temp_DivOp.CodCors"
			.Column6.ControlSource="Temp_DivOp.CodTams"
			.Column7.ControlSource="Temp_DivOp.Contas"
			.Column1.ControlSource="Alltrim(Temporario.dopes)+' '+Alltrim(Str(Temporario.numes,6))"
			.Column2.ControlSource="Temporario.Nops"
			.Column3.ControlSource="Temporario.Qtds"
			.Column4.ControlSource="Temporario.CodCors"
			.Column5.ControlSource="Temporario.CodTams"
			.Column6.ControlSource="Temporario.Contas"
			.Column7.ControlSource="Temporario.Pesos"
	Select Temp_DivOp	
		Select Temp_DivOp
			Select Temporario
Select Temporario
	Select crSigOpPic
Select CrSigOpPic
If Not ThisForm.poDataMgr.Update('CrSigCdNec')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdNec)')
If llTaOK And Not ThisForm.poDataMgr.Update('crSigCdNei')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdNei)')
If llTaOK And Not ThisForm.poDataMgr.Update('crSigOpPic')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigOpPic)')
If llTaOK And Not ThisForm.poDataMgr.Update('crSigPdMvf')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPdMvf)')
Select Temporario
Select xNensi
Select Temp_DivOp
lcQuery = [Select Nops From SigOpPic Where Numps = ?Numop Order By Nops Desc ]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalOpi') < 1)
Select LocalOpi
lcQuery = [Select * ] + ;
			[From SigPdMvf ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMfas') < 1)
	Select LocalMfas
		Insert Into CrSigCdNec ( Emps, Dopps, Numps, Datas, Usuars, Datars, Grupoos, Contaos, Grupods, Contads, CidChaves, EmpDnPs );
	Select CrSigCdOpd
	lcUpdate = [Update SigCdNec Set ChkSubn = ?pTru Where EmpDnPs = ']+thisform.cEmps + ThisForm.Divisaoop + Str(lnOp,10)+[']
	If (ThisForm.poDataMgr.SqlExecute(lcUpDate, '') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update SigCdNec)')
	Insert Into crSigCdNec ( Emps, Dopps, Numps, Datas, Usuars, Datars, Grupoos, Contaos, Grupods, Contads, CidChaves, EmpDnPs );
Select LocalMfas
		Insert Into crSigPdMvf From Memvar
		Select CrSigPdMvf
Select Temp_DivOp
				lcQuery = [Select Sum(qtds) as total from SigPrMtz where Cpros = ?Temp_DivOp.Cpros]
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigPrMtz') < 1)
				Select crSigPrMtz
			Insert Into crSigOpPic ( Emps, Dopps, Numps, Nops, Dopes, Numes, Dataps, Dataes, Qtds, ;
			Insert Into Temporario ( Dopes, Numes, Qtds, Obss, nops, SeqDivs, Cpros, CodCors, CodTams, EmpDs, ;
			Select LocalMfas
			Select LocalMFas
			Insert Into crSigPdMvf From Memvar
			Select CrSigOpPic
						lcQuery = [Select Sum(qtds) as total from SigPrMtz where Cpros = ?Temp_DivOp.Cpros]
						If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigPrMtz') < 1)
						Select crSigPrMtz
						Select Temp_DivOp
						Select CrSigOpPic
						Select Temp_DivOp
						Insert Into Temporario ( Dopes, Numes, Qtds, Obss, nops, SeqDivs, Cpros, CodCors, CodTams, Empds, ;
					Select CrSigOpPic
				Insert Into Temporario ( Dopes, Numes, Qtds, Obss, nops, SeqDivs, Cpros, CodCors, CodTams, Empds, ;
	Select Temp_DivOp
				lcQuery = [Select Sum(qtds) as total from SigPrMtz where Cpros = ?Temp_DivOp.Cpros]
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigPrMtz') < 1)
				Select crSigPrMtz
				Insert Into crSigOpPic ( Emps, Dopps, Numps, Nops, Dopes, Numes, Dataps, Dataes, Qtds, Obss, ;
				Insert Into Temporario ( Dopes, Numes, Qtds, Obss, nops, SeqDivs, Cpros, CodCors, CodTams, empds, ;
				Select LocalMfas
				Insert Into CrSigCdNec ( Emps, Dopps, Numps, Datas, Usuars, Datars, Grupoos, Contaos, Grupods, Contads, CidChaves, EmpDnPs );
				Select LocalMFas
				Insert Into crSigPdMvf From Memvar && Tiago - 12/01/2012 - Vianna - Estava antes dos 2 replace acima; inverti pois não estava gravando a quantidade divida na fase corretamente
				Select CrSigOpPic
			Select CrSigOpPic
				Insert Into Temporario ( Dopes, Numes, Qtds, Obss, nops, SeqDivs, Cpros, CodCors, CodTams, Empds, ;
	Select xNensi
		Select Nops, Sum(Qtds) as Qtds ;
		  From Temporario ;
		Select TempDiv
			Select LocalMfas
			Insert Into CrSigCdNec ( Emps, Dopps, Numps, Datas, Usuars, Datars, Grupoos, Contaos, Grupods, Contads, CidChaves, EmpDnPs );
			Select crSigPdMvf
			Append From Array Memvar
			Select xNensi
				Select crSigCdNei
				Append From Array Memvar
	Select Dopps From CrSigCdOpd Where ChkDests = 1 And Autos = 1 Into Cursor OppEnvel
	=Seek(CrSigCdPam.DivOps,'CrSigCdOpd','Dopps')
		=Seek(_DopEnvel,'CrSigCdOpd','Dopps')
		Select * From CrSigPdMvf Where Dopps = CrSigCdPam.DivOps And Nops <> ThisForm.Get_Op.Value Into Cursor Selecao
		Select Selecao
			Insert Into CrSigPdMvf From Memvar
		Select * From CrSigCdNei Where Dopps = CrSigCdPam.DivOps And Nops <> ThisForm.Get_Op.Value Into Cursor Selecao
		Select Selecao
			Insert Into CrSigCdNei From Memvar
	Select CrSigOpPic
	Create Cursor CrSigOpPic2 From Array xOPi
	Select Temp_DivOp
		Select LocalMFas
		lcUpdate = [Update SigPdMvf Set Qtds = ]+Str(LocalMfas.Qtds,12,3)+[ Where Cidchaves = ']+LocalMfas.Cidchaves+[']
		Select CrSigPdMvf
		Select CrSigOpPic
			Insert Into CrSigOpPic2 From Memvar
	Select CrSigOpPic
	Append From DBF('CrSigOpPic2')
Select Temp_DivOp
	Select Temporario
Select Temporario
Delete All
Select Temp_DivOp
Delete All
Select xNensi
Delete All
lcSql = [Select Dopps From SigCdOpd where ChkDests = 1 ]
=ThisForm.PodataMgr.SqlExecute(lcSql,'TmpOpp')
Select TmpOpp
	lcSql = [Select Nops,Numps From SigPdMvf Where EmpDnPs = ']+lcbusca+[']
	=ThisForm.PodataMgr.SqlExecute(lcSql,'TmpMfas')
	Select TmpMfas
		lcSql = [Select nops,NumPs From SigPdMvf Where Nops = ]+Str(pNop,10)+[ And Dopps = ']+TmpOpp.Dopps+[']
		=ThisForm.PodataMgr.SqlExecute(lcSql,'TmpMfas')
Select TmpOpi
Select TmpNens
	lcQuery = [Select Nops, Emps, Dopps, Numps, cIdChaves, Grupods ] + ;
				[From SigPdMvf ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMfas') < 1)
	Select LocalMfas
	lcQuery = [Select * From SigOpPic ]+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'Localopi') < 1)
	Select LocalOpi
	Select LocalOpi
		lcUpdate = [Update SigOpPic Set SeqDivs = ]+Str(_Citem)+[ Where CidChaves = ']+Localopi.CidChaves+[']
		If (ThisForm.poDataMgr.SqlExecute(lcUpdate,'') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigOpPic)')
		lcSql = [Select a.ContaOs, a.contaDs, b.Globalizas, b.Servicos From SigMvCab a, SigCdOpe b ]+;
		If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalEest') < 1
		Select LocalOpi
		Insert Into Temp_DivOp ( Dopes, Numes, Qtds, Dataes, Obss, SeqDivs, Cpros, CodCors, CodTams, Empds, Dpros, Notas, Contas, Citens, Pesos ) ;
	lcQuery = [Select a.*, b.Datas, c.SepPedras, c.GrComps From SigCdNei a, SigCdNec b, SigCdOpd c ]+;
	If ( ThisForm.poDataMgr.SqlExecute(lcQuery,'LocalNensi') < 1 )
	Select LocalNensi
	Select LocalNensi
		Select xNensi
		Append from array Memvar
	Select Temp_DivOp

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopdiv.prg) - TRECHOS RELEVANTES PARA PASS SQL (1547 linhas total):

*-- Linhas 55 a 114:
55: 
56:             *-- Validar DivOps em SigCdPam
57:             LOCAL loc_cSQL
58:             loc_cSQL = "SELECT DivOps FROM SigCdPam"
59:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PamDiv") > 0
60:                 SELECT cursor_4c_PamDiv
61:                 GO TOP
62:                 IF EMPTY(ALLTRIM(cursor_4c_PamDiv.DivOps))
63:                     USE IN cursor_4c_PamDiv
64:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o de Divis" + CHR(227) + ;
65:                              "o de Op n" + CHR(227) + "o Configurada nos par" + CHR(226) + ;
66:                              "metros do sistema...", "Configura" + CHR(231) + CHR(227) + "o")
67:                     loc_lSucesso = .F.
68:                 ENDIF
69:                 USE IN cursor_4c_PamDiv
70:             ENDIF
71: 
72:             *-- Definir Caption conforme operacao
73:             IF THIS.this_cOperacao = "R"
74:                 THIS.Caption = "Reinicia Industrializa" + CHR(231) + CHR(227) + "o"
75:             ELSE
76:                 THIS.Caption = "Separa Industrializa" + CHR(231) + CHR(227) + "o"
77:             ENDIF
78: 
79:             *-- Criar cursores de trabalho (privados desta sessao de dados)
80:             SET NULL ON
81:             CREATE CURSOR Temp_DivOp ;
82:                 (Qtds N(12,3), QtdEtiqs N(5,0), QtdDivs N(12,3), Dopes C(20), ;
83:                  Numes N(6,0), Dataes D, Obss M NULL, Nops N(10,0), SeqDivs N(3,0), ;
84:                  Cpros C(14), CodCors C(4), CodTams C(4), Empds C(3), Dpros C(65), ;
85:                  Notas C(6), Contas C(10), Citens N(10,0), Pesos N(12,3))
86:             CREATE CURSOR Temporario ;
87:                 (Qtds N(12,3), Dopes C(20), Numes N(6,0), Dataes D, Obss M NULL, ;
88:                  Nops N(10,0), SeqDivs N(3,0), Cpros C(14), CodCors C(4), CodTams C(4), ;
89:                  Empds C(3), Dpros C(65), Notas C(6), Contas C(10), Pesos N(9,3))
90:             INDEX ON Nops TAG Nops FOR Qtds > 0
91:             SET NULL OFF
92: 
93:             *-- Criar xNensi com estrutura identica a SigCdNei
94:             IF gnConnHandle > 0
95:                 IF SQLEXEC(gnConnHandle, "SELECT TOP 0 * FROM SigCdNei", ;
96:                            "cursor_4c_NensiStruct") > 0
97:                     DIMENSION loc_aNensiFields[1]
98:                     AFIELDS(loc_aNensiFields, "cursor_4c_NensiStruct")
99:                     CREATE CURSOR xNensi FROM ARRAY loc_aNensiFields
100:                     USE IN cursor_4c_NensiStruct
101:                 ENDIF
102:             ENDIF
103: 
104:             *-- Construir todos os controles UI
105:             THIS.ConfigurarControles()
106: 
107:             *-- Inicializar estado visual do form (Grade principal visivel)
108:             THIS.ConfigurarPaginaLista()
109: 
110:             *-- Propagar Caption para labels de titulo
111:             THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
112:             THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
113: 
114:             *-- BINDEVENT: Get_OP

*-- Linhas 418 a 590:
418:             .Height        = 94
419:             .SpecialEffect = 1
420:             .BorderColor   = RGB(100, 100, 100)
421:             .ControlSource = "Temp_DivOp.Obss"
422:             .Visible       = .T.
423:         ENDWITH
424: 
425:         *----------------------------------------------------------------------
426:         * EditBox fwmemo_obs: observacao das OPs geradas (Temporario.Obss)
427:         * Oculto inicialmente; exibido apos geracao em modo Divisao
428:         *----------------------------------------------------------------------
429:         THIS.AddObject("edt_4c_MemoObs", "EditBox")
430:         WITH THIS.edt_4c_MemoObs
431:             .Top           = 421
432:             .Left          = 11
433:             .Width         = 626
434:             .Height        = 94
435:             .SpecialEffect = 1
436:             .BorderColor   = RGB(36, 84, 155)
437:             .ControlSource = "Temporario.Obss"
438:             .Enabled       = .F.
439:             .Visible       = .F.
440:         ENDWITH
441:     ENDPROC
442: 
443:     *==========================================================================
444:     * ConfigurarGrade - Grade principal (Temp_DivOp)
445:     * 7 colunas: Pedido | Cliente | Cor | Tam | Qtd.Op | QtdDivs | Quantidade
446:     * Nota: Column2=QtdEtiqs, Column4=QtdDivs sao editaveis pelo usuario
447:     *==========================================================================
448:     PROTECTED PROCEDURE ConfigurarGrade()
449:         LOCAL loc_oGrd
450:         THIS.AddObject("grd_4c_Grade", "Grid")
451:         loc_oGrd = THIS.grd_4c_Grade
452:         WITH loc_oGrd
453:             .Top           = 121
454:             .Left          = 11
455:             .Width         = 626
456:             .Height        = 293
457:             .FontName      = "Arial"
458:             .FontSize      = 8
459:             .ColumnCount   = 7
460:             .DeleteMark    = .F.
461:             .GridLines     = 3
462:             .GridLineWidth = 1
463:             .GridLineColor = RGB(238, 238, 238)
464:             .HeaderHeight  = 17
465:             .RecordMark    = .F.
466:             .RowHeight     = 17
467:             .ScrollBars    = 2
468:             .ForeColor     = RGB(0, 0, 0)
469:             .BackColor     = RGB(255, 255, 255)
470:             .RecordSource  = "Temp_DivOp"
471:             .Visible       = .T.
472:         ENDWITH
473: 
474:         *-- Column1: Pedido (expressao Dopes + Numes - readonly)
475:         WITH loc_oGrd.Column1
476:             .Header1.Caption     = "Pedido"
477:             .Header1.Alignment   = 2
478:             .Header1.BackColor   = RGB(192, 192, 192)
479:             .Text1.ControlSource = "ALLTRIM(Temp_DivOp.Dopes)+' '+ALLTRIM(STR(Temp_DivOp.Numes,6))"
480:             .Text1.ReadOnly      = .T.
481:             .Text1.BorderStyle   = 0
482:             .Text1.Alignment     = 0
483:             .Text1.Margin        = 0
484:             .Width               = 160
485:             .Movable             = .F.
486:             .Resizable           = .F.
487:             .ReadOnly            = .T.
488:         ENDWITH
489: 
490:         *-- Column2: Qtd.Op (QtdEtiqs) - editavel para divisao por etiquetas
491:         WITH loc_oGrd.Column2
492:             .Header1.Caption     = "Qtd.Op"
493:             .Header1.Alignment   = 2
494:             .Header1.BackColor   = RGB(192, 192, 192)
495:             .Text1.ControlSource = "Temp_DivOp.QtdEtiqs"
496:             .Text1.BorderStyle   = 0
497:             .Text1.Alignment     = 1
498:             .Text1.Format        = "K"
499:             .Text1.InputMask     = "99999"
500:             .Text1.Margin        = 0
501:             .Width               = 85
502:             .ColumnOrder         = 6
503:             .Movable             = .F.
504:             .Resizable           = .F.
505:         ENDWITH
506: 
507:         *-- Column3: Quantidade (Qtds - readonly)
508:         WITH loc_oGrd.Column3
509:             .Header1.Caption     = "Quantidade"
510:             .Header1.Alignment   = 2
511:             .Text1.ControlSource = "Temp_DivOp.Qtds"
512:             .Text1.ReadOnly      = .T.
513:             .Text1.BorderStyle   = 0
514:             .Text1.Alignment     = 1
515:             .Text1.InputMask     = "999,999.999"
516:             .Text1.Margin        = 0
517:             .Width               = 102
518:             .ColumnOrder         = 5
519:             .Movable             = .F.
520:             .Resizable           = .F.
521:             .ReadOnly            = .T.
522:         ENDWITH
523: 
524:         *-- Column4: Divisao (QtdDivs) - editavel para informar quantidade a dividir
525:         WITH loc_oGrd.Column4
526:             .Header1.Caption     = "Divis" + CHR(227) + "o"
527:             .Header1.Alignment   = 2
528:             .Header1.BackColor   = RGB(192, 192, 192)
529:             .Text1.ControlSource = "Temp_DivOp.QtdDivs"
530:             .Text1.BorderStyle   = 0
531:             .Text1.Alignment     = 1
532:             .Text1.Format        = "K"
533:             .Text1.InputMask     = "999,999.999"
534:             .Text1.Margin        = 0
535:             .Width               = 85
536:             .ColumnOrder         = 7
537:             .Movable             = .F.
538:             .Resizable           = .F.
539:         ENDWITH
540: 
541:         *-- Column5: Cor (CodCors - readonly)
542:         WITH loc_oGrd.Column5
543:             .Header1.Caption     = "Cor"
544:             .Header1.Alignment   = 2
545:             .Text1.ControlSource = "Temp_DivOp.CodCors"
546:             .Text1.ReadOnly      = .T.
547:             .Text1.BorderStyle   = 0
548:             .Text1.Margin        = 0
549:             .Width               = 38
550:             .ColumnOrder         = 3
551:             .Movable             = .F.
552:             .Resizable           = .F.
553:             .ReadOnly            = .T.
554:         ENDWITH
555: 
556:         *-- Column6: Tam (CodTams - readonly)
557:         WITH loc_oGrd.Column6
558:             .Header1.Caption     = "Tam"
559:             .Header1.Alignment   = 2
560:             .Text1.ControlSource = "Temp_DivOp.CodTams"
561:             .Text1.ReadOnly      = .T.
562:             .Text1.BorderStyle   = 0
563:             .Text1.Margin        = 0
564:             .Width               = 38
565:             .ColumnOrder         = 4
566:             .Movable             = .F.
567:             .Resizable           = .F.
568:             .ReadOnly            = .T.
569:         ENDWITH
570: 
571:         *-- Column7: Cliente (Contas - readonly)
572:         WITH loc_oGrd.Column7
573:             .Header1.Caption     = "Cliente"
574:             .Header1.Alignment   = 2
575:             .Text1.ControlSource = "Temp_DivOp.Contas"
576:             .Text1.ReadOnly      = .T.
577:             .Text1.BorderStyle   = 0
578:             .Text1.Margin        = 0
579:             .Width               = 90
580:             .ColumnOrder         = 2
581:             .Movable             = .F.
582:             .Resizable           = .F.
583:             .ReadOnly            = .T.
584:         ENDWITH
585:     ENDPROC
586: 
587:     *==========================================================================
588:     * ConfigurarGrade2 - Grade resultado (Temporario - oculto ate geracao)
589:     * 7 colunas: O.P. | Pedido | Cliente | Cor | Tam | Quantidade | Peso
590:     *==========================================================================

*-- Linhas 600 a 748:
600:             .FontName      = "Arial"
601:             .FontSize      = 8
602:             .ColumnCount   = 7
603:             .DeleteMark    = .F.
604:             .RecordMark    = .F.
605:             .GridLineWidth = 1
606:             .GridLineColor = RGB(136, 189, 188)
607:             .HeaderHeight  = 17
608:             .RowHeight     = 17
609:             .ScrollBars    = 2
610:             .ForeColor     = RGB(0, 0, 0)
611:             .BackColor     = RGB(255, 255, 255)
612:             .RecordSource  = "Temporario"
613:             .ReadOnly      = .T.
614:             .Enabled       = .F.
615:             .Visible       = .F.
616:         ENDWITH
617: 
618:         *-- Column1: Pedido
619:         WITH loc_oGrd.Column1
620:             .Header1.Caption     = "Pedido"
621:             .Header1.Alignment   = 2
622:             .Header1.BackColor   = RGB(192, 192, 192)
623:             .Text1.ControlSource = "ALLTRIM(Temporario.Dopes)+' '+ALLTRIM(STR(Temporario.Numes,6))"
624:             .Text1.ReadOnly      = .T.
625:             .Text1.Alignment     = 0
626:             .Text1.BorderStyle   = 0
627:             .Text1.Margin        = 0
628:             .Text1.Enabled       = .F.
629:             .Width               = 205
630:             .ColumnOrder         = 2
631:             .Movable             = .F.
632:             .Resizable           = .F.
633:             .ReadOnly            = .T.
634:             .Enabled             = .F.
635:         ENDWITH
636: 
637:         *-- Column2: O.P. (Nops)
638:         WITH loc_oGrd.Column2
639:             .Header1.Caption     = "O.P."
640:             .Header1.Alignment   = 2
641:             .Header1.BackColor   = RGB(192, 192, 192)
642:             .Text1.ControlSource = "Temporario.Nops"
643:             .Text1.ReadOnly      = .T.
644:             .Text1.Alignment     = 1
645:             .Text1.BorderStyle   = 0
646:             .Text1.Format        = "K"
647:             .Text1.InputMask     = "9999999999"
648:             .Text1.Margin        = 0
649:             .Text1.Enabled       = .F.
650:             .Width               = 80
651:             .ColumnOrder         = 1
652:             .Movable             = .F.
653:             .Resizable           = .F.
654:             .ReadOnly            = .T.
655:             .Enabled             = .F.
656:         ENDWITH
657: 
658:         *-- Column3: Quantidade (Qtds)
659:         WITH loc_oGrd.Column3
660:             .Header1.Caption     = "Quantidade"
661:             .Header1.Alignment   = 2
662:             .Header1.BackColor   = RGB(192, 192, 192)
663:             .Text1.ControlSource = "Temporario.Qtds"
664:             .Text1.ReadOnly      = .T.
665:             .Text1.Alignment     = 1
666:             .Text1.BorderStyle   = 0
667:             .Text1.InputMask     = "999,999.999"
668:             .Text1.Margin        = 0
669:             .Text1.Enabled       = .F.
670:             .Width               = 80
671:             .ColumnOrder         = 6
672:             .Movable             = .F.
673:             .Resizable           = .F.
674:             .ReadOnly            = .T.
675:             .Enabled             = .F.
676:         ENDWITH
677: 
678:         *-- Column4: Cor
679:         WITH loc_oGrd.Column4
680:             .Header1.Caption     = "Cor"
681:             .Header1.Alignment   = 2
682:             .Text1.ControlSource = "Temporario.CodCors"
683:             .Text1.ReadOnly      = .T.
684:             .Text1.BorderStyle   = 0
685:             .Text1.Margin        = 0
686:             .Text1.Enabled       = .F.
687:             .Width               = 38
688:             .ColumnOrder         = 4
689:             .Movable             = .F.
690:             .Resizable           = .F.
691:             .ReadOnly            = .T.
692:             .Enabled             = .F.
693:         ENDWITH
694: 
695:         *-- Column5: Tam
696:         WITH loc_oGrd.Column5
697:             .Header1.Caption     = "Tam"
698:             .Header1.Alignment   = 2
699:             .Text1.ControlSource = "Temporario.CodTams"
700:             .Text1.ReadOnly      = .T.
701:             .Text1.BorderStyle   = 0
702:             .Text1.Margin        = 0
703:             .Text1.Enabled       = .F.
704:             .Width               = 24
705:             .ColumnOrder         = 5
706:             .Movable             = .F.
707:             .Resizable           = .F.
708:             .ReadOnly            = .T.
709:             .Enabled             = .F.
710:         ENDWITH
711: 
712:         *-- Column6: Cliente (Contas)
713:         WITH loc_oGrd.Column6
714:             .Header1.Caption     = "Cliente"
715:             .Header1.Alignment   = 2
716:             .Text1.ControlSource = "Temporario.Contas"
717:             .Text1.ReadOnly      = .T.
718:             .Text1.BorderStyle   = 0
719:             .Text1.Margin        = 0
720:             .Text1.Enabled       = .F.
721:             .Width               = 80
722:             .ColumnOrder         = 3
723:             .Movable             = .F.
724:             .Resizable           = .F.
725:             .ReadOnly            = .T.
726:             .Enabled             = .F.
727:         ENDWITH
728: 
729:         *-- Column7: Peso
730:         WITH loc_oGrd.Column7
731:             .Header1.Caption     = "Peso"
732:             .Header1.Alignment   = 2
733:             .Text1.ControlSource = "Temporario.Pesos"
734:             .Text1.ReadOnly      = .T.
735:             .Text1.BorderStyle   = 0
736:             .Text1.Margin        = 0
737:             .Text1.Enabled       = .F.
738:             .Width               = 75
739:             .Movable             = .F.
740:             .Resizable           = .F.
741:             .Enabled             = .F.
742:         ENDWITH
743:     ENDPROC
744: 
745:     *==========================================================================
746:     * ConfigurarPaginaLista - Define estado inicial do form operacional:
747:     * Grade principal visivel, Grade2 oculta, GrupoSalva ativo.
748:     * Chamado em InicializarForm e ao retornar do estado de revisao.

*-- Linhas 908 a 974:
908: 
909:         *-- Somar quantidades de Temp_DivOp para validacao
910:         IF USED("Temp_DivOp") AND RECCOUNT("Temp_DivOp") > 0
911:             SELECT SUM(Qtds) AS SQtds, SUM(QtdDivs) AS SQtdDivs, SUM(QtdEtiqs) AS SQtdEtiqs ;
912:                 FROM Temp_DivOp INTO CURSOR cursor_4c_SumTmpDiv
913:             SELECT cursor_4c_SumTmpDiv
914:             GO TOP
915:             loc_nQtds     = NVL(cursor_4c_SumTmpDiv.SQtds,     0)
916:             loc_nQtdDivs  = NVL(cursor_4c_SumTmpDiv.SQtdDivs,  0)
917:             loc_nQtdEtiqs = NVL(cursor_4c_SumTmpDiv.SQtdEtiqs, 0)
918:             USE IN cursor_4c_SumTmpDiv
919:         ENDIF
920: 
921:         ON KEY LABEL ENTER
922: 
923:         *-- Delegar para BO
924:         loc_lSucesso = .F.
925:         TRY
926:             loc_lSucesso = THIS.this_oBusinessObject.GerarNovaOP(;
927:                 THIS.this_cOperacao, loc_nOp, loc_nQtds, loc_nQtdDivs, loc_nQtdEtiqs)
928:         CATCH TO loc_oErro
929:             MsgErro(loc_oErro.Message, "Erro em GrupoSalvaClick")
930:         ENDTRY
931: 
932:         IF loc_lSucesso
933:             IF THIS.this_cOperacao = "D"
934:                 *-- Divisao: ir para estado de revisao (Grade2 + GrupoConf)
935:                 IF USED("Temp_DivOp")
936:                     SELECT Temp_DivOp
937:                     ZAP
938:                 ENDIF
939:                 SELECT Temporario
940:                 GO TOP
941:                 THIS.AlternarPagina(2)
942: 
943:                 IF !THIS.this_lAutomatico
944:                     THIS.grd_4c_Grade2.Column2.Text1.SetFocus()
945:                 ENDIF
946: 
947:             ELSE
948:                 *-- Reinicia: confirmar transacao automaticamente (sem revisao em Grade2)
949:                 LOCAL loc_lCommit
950:                 loc_lCommit = .F.
951:                 TRY
952:                     loc_lCommit = THIS.this_oBusinessObject.ConfirmarGravacao()
953:                 CATCH TO loc_oErro
954:                     MsgErro(loc_oErro.Message, "Erro ao confirmar Reinicia")
955:                 ENDTRY
956: 
957:                 IF loc_lCommit
958:                     IF USED("Temp_DivOp")
959:                         SELECT Temp_DivOp
960:                         ZAP
961:                     ENDIF
962:                     THIS.txt_4c_Op.Value      = " "
963:                     THIS.txt_4c_Produto.Value = " "
964:                     THIS.AlternarPagina(1)
965: 
966:                     IF !THIS.this_lAutomatico
967:                         THIS.txt_4c_Op.SetFocus()
968:                     ENDIF
969:                     THIS.Refresh()
970:                 ENDIF
971:             ENDIF
972:         ENDIF
973:     ENDPROC
974: 

*-- Linhas 997 a 1015:
997: 
998:         IF loc_lSucesso
999:             IF USED("Temporario")
1000:                 SELECT Temporario
1001:                 ZAP
1002:             ENDIF
1003:             THIS.txt_4c_Op.Value      = " "
1004:             THIS.txt_4c_Produto.Value = " "
1005:             THIS.AlternarPagina(1)
1006: 
1007:             IF !THIS.this_lAutomatico
1008:                 THIS.txt_4c_Op.SetFocus()
1009:             ENDIF
1010:             THIS.Refresh()
1011:         ENDIF
1012:     ENDPROC
1013: 
1014:     *==========================================================================
1015:     * GradeAfterRowColChange - Grade.AfterRowColChange

*-- Linhas 1237 a 1284:
1237:         THIS.txt_4c_Op.Value = ALLTRIM(STR(loc_nOp))
1238:         THIS.GetOpValid()
1239: 
1240:         SELECT Temp_DivOp
1241:         IF RECCOUNT() = 0
1242:             RETURN .F.
1243:         ENDIF
1244: 
1245:         *-- Distribuir QtdDivs conforme array
1246:         loc_llOk = .F.
1247:         FOR loc_nCnt = 1 TO ALEN(par_aNop, 1)
1248:             SELECT Temp_DivOp
1249:             GO TOP
1250:             LOCATE FOR Dopes   = par_aNop[loc_nCnt, 1] AND ;
1251:                        Numes   = par_aNop[loc_nCnt, 2] AND ;
1252:                        CodCors = par_aNop[loc_nCnt, 3] AND ;
1253:                        CodTams = par_aNop[loc_nCnt, 4]
1254:             IF !EOF()
1255:                 REPLACE QtdDivs WITH QtdDivs + par_aNop[loc_nCnt, 8]
1256:                 loc_llOk = .T.
1257:             ENDIF
1258:         ENDFOR
1259: 
1260:         IF !loc_llOk
1261:             RETURN .F.
1262:         ENDIF
1263: 
1264:         *-- Executar geracao
1265:         THIS.GrupoSalvaClick()
1266: 
1267:         *-- Capturar OPs geradas de volta no array
1268:         FOR loc_nCnt = 1 TO ALEN(par_aNop, 1)
1269:             SELECT Temporario
1270:             GO TOP
1271:             LOCATE FOR Dopes   = par_aNop[loc_nCnt, 1] AND ;
1272:                        Numes   = par_aNop[loc_nCnt, 2] AND ;
1273:                        CodCors = par_aNop[loc_nCnt, 3] AND ;
1274:                        CodTams = par_aNop[loc_nCnt, 4] AND ;
1275:                        Qtds    = par_aNop[loc_nCnt, 8]
1276:             IF !EOF()
1277:                 par_aNop[loc_nCnt, 7] = Temporario.Nops
1278:                 par_aNop[loc_nCnt, 9] = Temporario.Qtds
1279:             ENDIF
1280:         ENDFOR
1281: 
1282:         *-- Confirmar
1283:         THIS.GrupoConfClick()
1284: 

*-- Linhas 1351 a 1377:
1351:         ENDIF
1352: 
1353:         IF USED("Temp_DivOp")
1354:             SELECT Temp_DivOp
1355:             ZAP
1356:         ENDIF
1357:         IF USED("Temporario")
1358:             SELECT Temporario
1359:             ZAP
1360:         ENDIF
1361:         IF USED("xNensi")
1362:             SELECT xNensi
1363:             ZAP
1364:         ENDIF
1365: 
1366:         THIS.txt_4c_Op.Value      = " "
1367:         THIS.txt_4c_Produto.Value = " "
1368:         THIS.AlternarPagina(1)
1369:         THIS.txt_4c_Op.SetFocus()
1370:         THIS.Refresh()
1371:     ENDPROC
1372: 
1373:     *==========================================================================
1374:     * BtnBuscarClick - Override de FormBase.BtnBuscarClick
1375:     * Form OPERACIONAL: re-executa a validacao e carga da OP corrente.
1376:     * Permite ao usuario recarregar o grid caso os dados tenham sido
1377:     * alterados externamente sem precisar limpar e redigitar a OP.

*-- Linhas 1427 a 1453:
1427:         ENDIF
1428: 
1429:         IF USED("Temp_DivOp")
1430:             SELECT Temp_DivOp
1431:             ZAP
1432:         ENDIF
1433:         IF USED("Temporario")
1434:             SELECT Temporario
1435:             ZAP
1436:         ENDIF
1437:         IF USED("xNensi")
1438:             SELECT xNensi
1439:             ZAP
1440:         ENDIF
1441: 
1442:         THIS.txt_4c_Op.Value      = " "
1443:         THIS.txt_4c_Produto.Value = " "
1444:         THIS.AlternarPagina(1)
1445:         THIS.txt_4c_Op.SetFocus()
1446:         THIS.Refresh()
1447:     ENDPROC
1448: 
1449:     *==========================================================================
1450:     * FormParaBO - Transfere estado do form para propriedades do BO
1451:     * Form OPERACIONAL: propaga numero da OP, operacao e empresa corrente.
1452:     * Chamado antes de qualquer persistencia (GerarNovaOP/ConfirmarGravacao).
1453:     *==========================================================================

*-- Linhas 1487 a 1513:
1487:         THIS.txt_4c_Produto.Value = " "
1488: 
1489:         IF USED("Temp_DivOp")
1490:             SELECT Temp_DivOp
1491:             ZAP
1492:         ENDIF
1493:         IF USED("Temporario")
1494:             SELECT Temporario
1495:             ZAP
1496:         ENDIF
1497:         IF USED("xNensi")
1498:             SELECT xNensi
1499:             ZAP
1500:         ENDIF
1501: 
1502:         THIS.AlternarPagina(1)
1503:         THIS.Refresh()
1504:     ENDPROC
1505: 
1506:     *==========================================================================
1507:     * CarregarLista - Recarrega o grid principal para a OP corrente
1508:     * Form OPERACIONAL: se OP informada, re-executa GetOpValid para repopular
1509:     * Temp_DivOp e atualizar o grid; caso contrario, apenas limpa os cursores.
1510:     *==========================================================================
1511:     PROCEDURE CarregarLista()
1512:         IF !EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) AND VAL(THIS.txt_4c_Op.Value) > 0
1513:             THIS.GetOpValid()


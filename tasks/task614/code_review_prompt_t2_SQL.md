# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDQUERYS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TPCADS, GRUPOS, ESTOS, EMPS, SQTDS, CONTAS, EMPDOPNUMS, DISPS, CODCORS, CODTAMS, XBAIXA, DOPES, EMPDOPNOPS, CHKSUBN, NOPS, DATAS, TIPOOPS, COPERS, OPERS, CPROS, PRODUZIR, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ESTOQS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TPCADS, GRUPOS, ESTOS, EMPS, SQTDS, CONTAS, EMPDOPNUMS, DISPS, CODCORS, CODTAMS, XBAIXA, DOPES, EMPDOPNOPS, CHKSUBN, NOPS, DATAS, TIPOOPS, COPERS, OPERS, CPROS, PRODUZIR, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'OPERSOPE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TPCADS, GRUPOS, ESTOS, EMPS, SQTDS, CONTAS, EMPDOPNUMS, DISPS, CODCORS, CODTAMS, XBAIXA, DOPES, EMPDOPNOPS, CHKSUBN, NOPS, DATAS, TIPOOPS, COPERS, OPERS, CPROS, PRODUZIR, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'OPERSITN' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TPCADS, GRUPOS, ESTOS, EMPS, SQTDS, CONTAS, EMPDOPNUMS, DISPS, CODCORS, CODTAMS, XBAIXA, DOPES, EMPDOPNOPS, CHKSUBN, NOPS, DATAS, TIPOOPS, COPERS, OPERS, CPROS, PRODUZIR, CITENS

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
  ControlSource = "TmpCabec.Obs"
  ControlSource = "TmpItens.Obs"
Select TmpCabec
	.Column1.ControlSource = 'TmpCabec.Flag'
	.Column2.ControlSource = 'TmpCabec.Dopes'
	.Column3.ControlSource = 'TmpCabec.Numes'
	.Column4.ControlSource = 'TmpCabec.Datas'
	.Column5.ControlSource = 'Iif(IsNull(TmpCabec.Entregas), {}, TmpCabec.Entregas)'
	.Column6.ControlSource = 'TmpCabec.Peso'
	.Column7.ControlSource = 'TmpCabec.Contav'
	.Column8.ControlSource = 'TmpCabec.Conta'
	.Column9.ControlSource = 'Iif(Empty(TmpCabec.Obs ), " ", "*")'
	.Column10.ControlSource = 'TmpCabec.Notas'
ThisForm.getCliente.ControlSource = [TmpCabec.DConta]
	.Column1.ControlSource = 'TmpItens.Cpros'
	.Column6.ControlSource = 'TmpItens.CodCors'
	.Column7.ControlSource = 'TmpItens.CodTams'
	.Column2.ControlSource = 'TmpItens.Qtds'
	.Column3.ControlSource = 'TmpItens.Saldo'
	.Column4.ControlSource = 'TmpItens.Peso'
	.Column5.ControlSource = 'Iif(Empty(TmpItens.Obs ), " ", "*")'
	.Column8.ControlSource = 'TmpItens.Reffs'
Select TmpItens
Select TmpCabec
Select TmpItens
	Select TmpCabec
	Select TmpCabec
Select TmpCabec
lcQuery = [Select * From SigCdCeg Where TpCads <> 1]
If ThisForm.PodataMgr.SqlExecute(lcquery,'TmpCeg') < 1
Select CrSigTempd
Select TmpCeg
		Select CrSigTempd
	Select CrSigTempd
If !ThisForm.Podatamgr2.UpDate('CrSigTempd')
lcQuery = [Select a.*, b.CodObs as Priors From SigMvEst a, SigTempd b ]+;
		[Select a.*, b.CodObs as Priors From SigMvEst a, SigTempd b ] +;
If ThisForm.PodataMgr.SqlExecute(lcquery,'TmpEstoque') < 1
Select TmpEstoque
	Select TmpSaldo
	If Not Seek(TmpEstoque.Cpros + TmpEstoque.CodCors + TmpEstoque.CodTams)
		Insert Into TmpSaldo ( CPros, CodCors, CodTams, Saldo, Disps );
	Insert Into TmpSaldg ( Grupos, Estos, CPros, CodCors, CodTams, Saldo, Disps, Priors, Emps );
	lcQuery = [Select EmpDopNums, GrupoOs, ContaOs, Emps, Dopes, Numes ] + ;
			    [From SigMvCab ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempEest') < 1)
	Select TempEest
		Select TempEestI
				lcQuery = [Select * ] + ;
						    [From SigMvIts ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempEsti2') < 1)
				Select TempEsti2
					Select TmpSaldo
					If Not Seek(TempEestI.Cpros)
						Insert Into TmpSaldo (Cpros) Value (TempEestI.CPros)
					Select TmpSaldg
					If !Seek( TempEest.Emps + TempEest.GrupoOs + TempEest.ContaOs + TempEesti.Cpros )
						Insert Into TmpSaldg ( Emps, Grupos, Estos, Cpros, Priors )  ;
					Select TempEsti2
						Select TmpSaldo
						If Not Seek(TempEsti2.Cpros + TempEsti2.CodCors + TempEsti2.CodTams)
							Insert Into TmpSaldo (Cpros, CodCors, CodTams) ;
						Select TmpSaldg
						If !Seek( TempEest.Emps + TempEest.GrupoOs + TempEest.ContaOs + TempEsti2.Cpros + TempEsti2.CodCors + TempEsti2.CodTams )
							Insert Into TmpSaldg ( Emps, Grupos, Estos, Cpros, CodCors, CodTams, Priors ) Value ;
Select TmpItens
	Select TmpCabec
	Select TmpOper
	Select TmpItens
		If (TmpOper.ChkObs <> 1 and Not IsEmpty(TmpItens.Obs)) Or Not Seek(TmpItens.CPros + TmpItens.CodCors + TmpItens.CodTams, 'TmpSaldo') Or ;
			=Seek(TmpItens.CPros + TmpItens.CodCors + TmpItens.CodTams, 'TmpSaldo')
		Insert Into TmpFinal (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, Estoque, Produzir, Obsps, ;
Select TmpSaldo
		Select TmpSaldG
		=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
	lcSql = [Select a.Nops, a.Cpros, a.CodCors, a.CodTams, sum(a.Qtds) as Qtds From SigOpPic a, SigCdNec b ]+;
	=ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpOpi')
	Select TmpOpi
		Select TmpSaldo
		If Not Seek(TmpOpi.Cpros + TmpOpi.CodCors + TmpOpi.CodTams)
			Insert Into TmpSaldo ( CPros, CodCors, CodTams );
		Insert Into TmpFabr (Nops, Cpros, CodCors, CodTams, Qtds, Priors) Values ;
		lcSql = [Select GrupoDs From SigPdMvf Where Nops = ]+Str(TmpOpi.Nops,10)+[ Order by CidChaves Desc ]
		=ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpMfas')
		Select TmpMfas
		If Seek(TmpOpi.Cpros + TmpOpi.CodCors + TmpOpi.CodTams,'TmpFinal','Cpros')
	Select TmpSaldo
			Select TmpFabr
			=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
	Select Cpros, CodCors, CodTams, Linhas, Sum(Qtds) as Qtds, sum(Saldo) as Saldo, sum(Estoque) as Estoque,;
		sum(Produzir) as Produzir, sum(Fabrs) as Fabrs From TmpFinal ;
		lcSql = [Select a.cpros, a.qtds, b.Caixas, b.copers, b.opers, a.opers ]+;
				[From SigMvItn a, SigCdOpe b, SigMvCab c ]+;
		ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalEest')
		Select cpros, Sum(qtds*Iif(( Caixas=1 and copers=1) or (caixas<>1 and opers=1) Or (caixas<>1 and opers=3 and opers='E'),1,-1)) as Qtds ;
		From LocalEest Group by 1 Into cursor Vendas ReadWrite
		Select Vendas
	Select TmpFinalG
	Select Selecao
		lcSql = [Select QtMinFabs From SigCdPro Where Cpros = ']+Selecao.Cpros+[']
		ThisForm.PodataMgr.Sqlexecute(lcSql,'CrSigCdPro')
		If Used('Vendas') And Seek(m.Cpros,'Vendas','Cpros')
		Select TmpFinalG
Select TmpItens

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGl2.prg) - TRECHOS RELEVANTES PARA PASS SQL (1346 linhas total):

*-- Linhas 22 a 43:
22: *       TmpCabec/TmpItens. Nao ha esses botoes no SCX.
23: *   BtnSalvarClick / FormParaBO
24: *       nao ha gravacao de entidade por tela. A unica escrita do legado
25: *       (INSERT em SigTempD + montagem de TmpFinal/TmpFinalg) vive em
26: *       SigPrGl2BO.ExecutarProcessamento, acionada por BtnProcessarClick.
27: *   BOParaForm
28: *       todos os controles de dados sao ligados por ControlSource DIRETO
29: *       aos cursores (o proprio Init legado faz isso), entao o VFP cobre
30: *       as duas direcoes do transporte. O unico estado que ainda precisa
31: *       de transporte explicito e o da LINHA corrente para as properties
32: *       do BO - feito em SincronizarBOComLinhaCorrente().
33: *   AlternarPagina / CarregarLista / AjustarBotoesPorModo / HabilitarCampos
34: *       nao ha PageFrame (layout FLAT) nem modos INCLUIR/ALTERAR/
35: *       VISUALIZAR. A carga inicial e CarregarDados() (trecho final do
36: *       Init legado) e a unica troca de estado de botao do legado esta na
37: *       cauda do Processar.Click (ThisForm.Enabled = .f. e, com reserva
38: *       automatica, Processar.Enabled = .f.), ja reproduzida em
39: *       BtnProcessarClick().
40: *   LimparCampos
41: *       os campos sao espelho dos cursores; o dialogo fecha ao terminar e
42: *       nao volta a um estado "em branco".
43: *

*-- Linhas 274 a 309:
274:     * direta/teste sem o form pai que os popula), criamos versoes vazias com
275:     * a estrutura inferida dos campos ja referenciados em SigPrGl2BO
276:     * (CarregarDoCursor/ExecutarProcessamento) para a grade nao derrubar o
277:     * Init (regra CLAUDE.md #41 - ControlSource de cursor inexistente).
278:     *--------------------------------------------------------------------------
279:     PROTECTED PROCEDURE ConfigurarGrids()
280:         LOCAL loc_oGrid, loc_oErro
281: 
282:         TRY
283:             IF !USED("TmpCabec")
284:                 CREATE CURSOR TmpCabec (Flag L, Emps C(3), Dopes C(20), Numes N(6), ;
285:                     Datas D, Entregas D, Peso N(9,3), Contav C(10), Conta C(10), ;
286:                     DConta C(50), Obs M NULL, Notas C(6), GrupoOs C(10), ContaOs C(10), ;
287:                     GrupoDs C(10), ContaDs C(10), Jobs C(10))
288:                 INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
289:                 INDEX ON DTOS(Entregas) + Emps + Dopes + STR(Numes, 6) TAG Entrega
290:                 SET ORDER TO EmpDopNum
291:             ENDIF
292: 
293:             IF !USED("TmpItens")
294:                 CREATE CURSOR TmpItens (Emps C(3), Dopes C(20), Numes N(6), CPros C(14), ;
295:                     CodCors C(4), CodTams C(4), Linhas C(10), Citens N(10), Qtds N(10,3), ;
296:                     Saldo N(10,3), Peso N(9,3), Obs M NULL, Notas C(6), Dpros C(40), Reffs C(40))
297:                 INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
298:                 INDEX ON CPros TAG CPros
299:                 SET ORDER TO EmpDopNum
300:             ENDIF
301: 
302:             *-- Ordem inicial da grade de cabecalho (equivalente ao Init de
303:             *-- Thisform.cOrdConta do legado) + cor default dos headers
304:             THIS.this_oBusinessObject.DefinirOrdemConta("")
305: 
306:             *----------------------------------------------------------------
307:             * grd_4c_Operacoes (GradeOperacao) - Top=155, Left=5, W=789, H=156
308:             *----------------------------------------------------------------
309:             THIS.AddObject("grd_4c_Operacoes", "Grid")

*-- Linhas 329 a 387:
329:                 .HighlightBackColor = RGB(255, 255, 255)
330:                 .HighlightForeColor = RGB(15, 41, 104)
331:                 .HighlightStyle = 2
332:                 .DeleteMark   = .F.
333:                 .RecordMark   = .F.
334:                 .FontName     = "Verdana"
335:                 .FontSize     = 8
336:                 .RowHeight    = 17
337:                 .ColumnCount  = 10
338:                 .RecordSource = "TmpCabec"
339:             ENDWITH
340: 
341:             *-- Column1: Flag (logical) - ControlSource logico faz o VFP9
342:             *-- gerar sozinho o Check1 da coluna (mesmo padrao ja usado em
343:             *-- FormCLC.prg CarregarGridOperacoes/Column8.Agrupar - NAO
344:             *-- criar CheckBox por AddObject aqui, o proprio VFP substitui
345:             *-- o Text1 por Check1 quando o campo ligado e logico)
346:             *-- ControlSource transcrito LITERALMENTE do With ThisForm.
347:             *-- GradeOperacao do Init legado. Tres colunas NAO sao ligacao
348:             *-- direta a coluna do cursor e por isso eram alvo facil de
349:             *-- "simplificacao" na migracao:
350:             *--   Column5 (Entrega) : Iif(IsNull(...), {}, ...) - a coluna
351:             *--       Entregas aceita NULL; sem o guard a celula exibe .NULL.
352:             *--   Column8 (Cliente) : liga em TmpCabec.Conta (CODIGO da
353:             *--       conta). Quem exibe a DESCRICAO e o getCliente/
354:             *--       txt_4c_Cliente, ligado em TmpCabec.DConta - as duas
355:             *--       ligacoes sao diferentes DE PROPOSITO.
356:             *--   Column9 (Obs)     : coluna MARCADORA - mostra "*" quando ha
357:             *--       observacao e " " quando nao ha (Verdana 12 bold
358:             *--       centralizado). O texto em si vai no edt_4c_ObsOperacao.
359:             loc_oGrid.Column1.ControlSource  = "TmpCabec.Flag"
360:             loc_oGrid.Column1.Sparse         = .F.
361:             loc_oGrid.Column2.ControlSource  = "TmpCabec.Dopes"
362:             loc_oGrid.Column3.ControlSource  = "TmpCabec.Numes"
363:             loc_oGrid.Column4.ControlSource  = "TmpCabec.Datas"
364:             loc_oGrid.Column5.ControlSource  = "IIF(ISNULL(TmpCabec.Entregas), {}, TmpCabec.Entregas)"
365:             loc_oGrid.Column6.ControlSource  = "TmpCabec.Peso"
366:             loc_oGrid.Column7.ControlSource  = "TmpCabec.Contav"
367:             loc_oGrid.Column8.ControlSource  = "TmpCabec.Conta"
368:             loc_oGrid.Column9.ControlSource  = "IIF(EMPTY(TmpCabec.Obs), ' ', '*')"
369:             loc_oGrid.Column10.ControlSource = "TmpCabec.Notas"
370: 
371:             *-- Width + Header DEPOIS do ControlSource (RecordSource/
372:             *-- ControlSource resetam para o default 90/"Header1").
373:             *-- Larguras/Movable/Resizable/ReadOnly transcritos do SCX.
374:             loc_oGrid.Column1.Width           = 17
375:             loc_oGrid.Column1.ReadOnly        = .F.
376:             loc_oGrid.Column1.Header1.Caption = ""
377:             loc_oGrid.Column2.Width           = 156
378:             loc_oGrid.Column2.ReadOnly        = .T.
379:             loc_oGrid.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
380:             loc_oGrid.Column3.Width           = 70
381:             loc_oGrid.Column3.ReadOnly        = .T.
382:             loc_oGrid.Column3.Header1.Caption = "N" + CHR(250) + "mero"
383:             loc_oGrid.Column4.Width           = 70
384:             loc_oGrid.Column4.ReadOnly        = .T.
385:             loc_oGrid.Column4.Header1.Caption = "Emiss" + CHR(227) + "o"
386:             loc_oGrid.Column5.Width           = 70
387:             loc_oGrid.Column5.ReadOnly        = .T.

*-- Linhas 467 a 507:
467:                 .HighlightBackColor = RGB(255, 255, 255)
468:                 .HighlightForeColor = RGB(15, 41, 104)
469:                 .HighlightStyle = 2
470:                 .DeleteMark   = .F.
471:                 .RecordMark   = .F.
472:                 .FontName     = "Verdana"
473:                 .FontSize     = 8
474:                 *-- RowHeight DEPOIS da fonte (ver nota na grade de cabecalho)
475:                 .RowHeight    = 17
476:                 .ReadOnly     = .T.
477:                 .ColumnCount  = 8
478:                 .RecordSource = "TmpItens"
479:             ENDWITH
480: 
481:             *-- ControlSource transcrito do With ThisForm.GradeItens do Init
482:             *-- legado. Column1 liga em Cpros (CODIGO do produto, nao a
483:             *-- descricao Dpros) e Column5 e a coluna MARCADORA de
484:             *-- observacao (mesmo padrao da Column9 da grade de cabecalho)
485:             loc_oGrid.Column1.ControlSource = "TmpItens.Cpros"
486:             loc_oGrid.Column2.ControlSource = "TmpItens.Qtds"
487:             loc_oGrid.Column3.ControlSource = "TmpItens.Saldo"
488:             loc_oGrid.Column4.ControlSource = "TmpItens.Peso"
489:             loc_oGrid.Column5.ControlSource = "IIF(EMPTY(TmpItens.Obs), ' ', '*')"
490:             loc_oGrid.Column6.ControlSource = "TmpItens.CodCors"
491:             loc_oGrid.Column7.ControlSource = "TmpItens.CodTams"
492:             loc_oGrid.Column8.ControlSource = "TmpItens.Reffs"
493: 
494:             *-- Larguras do SCX. ColumnOrder tambem vem do SCX: a ordem
495:             *-- VISUAL do legado nao e a ordem de declaracao -
496:             *-- Produto, Ref. Fornecedor, Cor, Tam, Quantidade, Saldo,
497:             *-- Peso, Obs (Column1, 8, 6, 7, 2, 3, 4, 5)
498:             loc_oGrid.Column1.Width           = 120
499:             loc_oGrid.Column1.ReadOnly        = .T.
500:             loc_oGrid.Column1.Header1.Caption = "Produto"
501:             loc_oGrid.Column2.Width           = 90
502:             loc_oGrid.Column2.ReadOnly        = .T.
503:             loc_oGrid.Column2.Header1.Caption = "Quantidade"
504:             loc_oGrid.Column3.Width           = 118
505:             loc_oGrid.Column3.ReadOnly        = .T.
506:             loc_oGrid.Column3.Header1.Caption = "Saldo"
507:             loc_oGrid.Column4.Width           = 100

*-- Linhas 734 a 752:
734:                 .ForeColor     = RGB(90, 90, 90)
735:                 .BackColor     = RGB(255, 255, 255)
736:                 .TabIndex      = 4
737:                 .ControlSource = "TmpCabec.Obs"
738:                 *-- SCX: NullDisplay = " ". TmpCabec.Obs aceita NULL e sem
739:                 *-- isso a caixa exibe o literal .NULL. para o usuario
740:                 .NullDisplay   = " "
741:                 .Visible       = .T.
742:             ENDWITH
743: 
744:             *----------------------------------------------------------------
745:             * Label6 "Cliente :" - Top=317, Left=5, W=42, H=15
746:             *----------------------------------------------------------------
747:             THIS.AddObject("lbl_4c_Cliente", "Label")
748:             WITH THIS.lbl_4c_Cliente
749:                 .Top       = 317
750:                 .Left      = 5
751:                 .Width     = 42
752:                 .Height    = 15

*-- Linhas 780 a 798:
780:                 .BackColor     = RGB(255, 255, 255)
781:                 .SpecialEffect = 1
782:                 .TabIndex      = 3
783:                 .ControlSource = "TmpCabec.DConta"
784:                 .ReadOnly      = .T.
785:                 .TabStop       = .F.
786:                 .Visible       = .T.
787:             ENDWITH
788: 
789:             *----------------------------------------------------------------
790:             * Txt_ObsItens "Observacao do Item : " - Top=532, Left=5, W=146,
791:             * H=15. Classe label pura no legado (AutoSize=.T. sem WordWrap) -
792:             * regra CLAUDE.md #23: AutoSize=.T. e no-op em Label criado por
793:             * AddObject, entao fixamos Width/Height explicitos do SCX em vez
794:             * de confiar no AutoSize.
795:             *----------------------------------------------------------------
796:             THIS.AddObject("lbl_4c_ObsItens", "Label")
797:             WITH THIS.lbl_4c_ObsItens
798:                 .Top       = 532

*-- Linhas 828 a 864:
828:                 .ForeColor     = RGB(90, 90, 90)
829:                 .BackColor     = RGB(255, 255, 255)
830:                 .TabIndex      = 6
831:                 .ControlSource = "TmpItens.Obs"
832:                 *-- SCX: NullDisplay = " " (TmpItens.Obs aceita NULL)
833:                 .NullDisplay   = " "
834:                 .Visible       = .T.
835:             ENDWITH
836: 
837:         CATCH TO loc_oErro
838:             MsgErro(loc_oErro.Message + CHR(13) + ;
839:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
840:                     "Procedure: " + loc_oErro.Procedure, ;
841:                     "Erro em ConfigurarCampos")
842:         ENDTRY
843:     ENDPROC
844: 
845:     *--------------------------------------------------------------------------
846:     * FlagCheckKeyPress/FlagCheckMouseDown - Column1 (Flag) do grd_4c_Operacoes.
847:     * Mesmo padrao ja comprovado em FormCLC.prg (OpeGerACheckKeyPress/
848:     * OpeGerACheckMouseDown): o Check1 e gerado automaticamente pelo VFP9
849:     * quando o ControlSource e logico, e o clique do mouse ja alterna o
850:     * valor nativamente - KeyPress cobre Enter/Espaco, MouseDown so garante
851:     * o Refresh apos o clique.
852:     *--------------------------------------------------------------------------
853:     PROCEDURE FlagCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
854:         IF INLIST(par_nKeyCode, 13, 32) AND USED("TmpCabec") AND !EOF("TmpCabec")
855:             IF par_nKeyCode = 13
856:                 REPLACE Flag WITH .NOT. Flag IN TmpCabec
857:             ENDIF
858:             THIS.grd_4c_Operacoes.Refresh()
859:         ENDIF
860:     ENDPROC
861: 
862:     PROCEDURE FlagCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
863:         IF USED("TmpCabec") AND !EOF("TmpCabec")
864:             THIS.grd_4c_Operacoes.Refresh()

*-- Linhas 872 a 904:
872:     *--------------------------------------------------------------------------
873:     PROCEDURE Column2HeaderClick()
874:         IF UPPER(ORDER("TmpCabec")) != "EMPDOPNUM"
875:             SELECT TmpCabec
876:             SET ORDER TO EmpDopNum
877:             GO TOP
878:             THIS.this_oBusinessObject.this_cOrdConta = UPPER(ORDER("TmpCabec"))
879:             WITH THIS.grd_4c_Operacoes
880:                 .Column2.Header1.BackColor = RGB(220, 255, 220)
881:                 .Column5.Header1.BackColor = RGB(192, 192, 192)
882:                 .Refresh()
883:             ENDWITH
884:         ENDIF
885:     ENDPROC
886: 
887:     PROCEDURE Column5HeaderClick()
888:         IF UPPER(ORDER("TmpCabec")) != "ENTREGA"
889:             SELECT TmpCabec
890:             SET ORDER TO Entrega
891:             GO TOP
892:             THIS.this_oBusinessObject.this_cOrdConta = UPPER(ORDER("TmpCabec"))
893:             WITH THIS.grd_4c_Operacoes
894:                 .Column2.Header1.BackColor = RGB(192, 192, 192)
895:                 .Column5.Header1.BackColor = RGB(220, 255, 220)
896:                 .Refresh()
897:             ENDWITH
898:         ENDIF
899:     ENDPROC
900: 
901:     *--------------------------------------------------------------------------
902:     * mOrdemConta - Equivalente ao metodo legado chamado no Click/Activate do
903:     * PROPRIO form (comportamento.json). Reaplica a ordem corrente de
904:     * TmpCabec (via BO.DefinirOrdemConta) e, quando par_lTipo e .T., repinta

*-- Linhas 954 a 972:
954: 
955:         TRY
956:             IF USED("TmpItens") AND USED("TmpCabec")
957:                 SELECT TmpItens
958:                 SET ORDER TO EmpDopNum
959:                 SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
960:                 GO TOP
961:                 IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
962:                     THIS.grd_4c_Itens.Refresh()
963:                 ENDIF
964: 
965:                 *-- Espelha a nova linha corrente de TmpCabec nas properties
966:                 *-- do BO (equivalente de BOParaForm neste dialogo - ver
967:                 *-- SincronizarBOComLinhaCorrente). Nao altera a area de
968:                 *-- trabalho: o legado termina este handler com TmpItens
969:                 *-- selecionado.
970:                 THIS.SincronizarBOComLinhaCorrente()
971:             ENDIF
972: 

*-- Linhas 1192 a 1256:
1192:     * CarregarDados - Carga/sincronizacao inicial dos cursores de trabalho.
1193:     *
1194:     * Transcricao LITERAL do trecho final do PROCEDURE Init do legado, que
1195:     * roda depois de atribuir todos os ControlSource e e o que deixa a tela
1196:     * utilizavel na abertura:
1197:     *
1198:     *   Select TmpItens
1199:     *   Set Order To EmpDopNum
1200:     *   Set Key To TmpCabec.Emps + TmpCabec.Dopes + Str(TmpCabec.Numes, 6)
1201:     *   Go Top
1202:     *
1203:     *   Select TmpCabec
1204:     *   Go Top
1205:     *
1206:     *   ThisForm.Refresh
1207:     *
1208:     * Sem esta carga as duas grades abrem ligadas aos cursores mas SEM o
1209:     * filtro de itens aplicado e sem repintura - o sintoma seria "a grade de
1210:     * itens mostra itens de outra operacao" / "a tela nao traz dados".
1211:     *
1212:     * Duas observacoes sobre a ORDEM, que e do legado e foi preservada:
1213:     *  (a) SET KEY TO <expr> CONGELA o valor no momento do comando - nao
1214:     *      reavalia a expressao quando TmpCabec se move. Medido no VFP9
1215:     *      (2026-09-29, automation\ProbeGl2SetKey.prg): com TmpCabec na
1216:     *      linha 2 no instante do SET KEY, o "Select TmpCabec / Go Top"
1217:     *      seguinte leva o cabecalho para a linha 1 mas a grade de itens
1218:     *      CONTINUA filtrada pela linha 2; e mover TmpCabec depois, sem
1219:     *      refazer o SET KEY, nao muda o filtro. Ou seja, o filtro inicial
1220:     *      depende de onde o formulario PAI deixou TmpCabec. Isso e
1221:     *      comportamento do legado e foi mantido de proposito (PILAR 1):
1222:     *      quem realinha o filtro com a linha efetivamente selecionada e o
1223:     *      GradeOperacoesAfterRowColChange, na primeira troca de linha/
1224:     *      coluna da grade. "Corrigir" aqui divergiria da tela legada.
1225:     *  (b) a chave e POSICIONAL (Emps char(3) + Dopes char(20) + STR(Numes,6)
1226:     *      = 29 caracteres): NAO usar ALLTRIM nas partes, senao a chave
1227:     *      encurta, o SET KEY nunca casa e a grade de itens fica vazia SEM
1228:     *      erro nenhum (CLAUDE.md regra #42).
1229:     *--------------------------------------------------------------------------
1230:     PROCEDURE CarregarDados()
1231:         LOCAL loc_lSucesso, loc_oErro
1232:         loc_lSucesso = .F.
1233: 
1234:         TRY
1235:             IF USED("TmpItens") AND USED("TmpCabec")
1236:                 SELECT TmpItens
1237:                 SET ORDER TO EmpDopNum
1238:                 SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
1239:                 GO TOP
1240: 
1241:                 SELECT TmpCabec
1242:                 GO TOP
1243: 
1244:                 *-- Espelha a linha corrente de TmpCabec nas properties do BO
1245:                 *-- (ObterChavePrimaria/auditoria dependem delas)
1246:                 THIS.SincronizarBOComLinhaCorrente()
1247: 
1248:                 THIS.Refresh()
1249:                 loc_lSucesso = .T.
1250:             ENDIF
1251:         CATCH TO loc_oErro
1252:             MsgErro(loc_oErro.Message + CHR(13) + ;
1253:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1254:                     "Procedure: " + loc_oErro.Procedure, ;
1255:                     "Erro em CarregarDados")
1256:         ENDTRY

*-- Linhas 1265 a 1294:
1265:     * SIGPRGL2 nao tem o par FormParaBO/BOParaForm classico: TODOS os
1266:     * controles de dados (as 10 colunas da grade de cabecalho, as 8 da grade
1267:     * de itens, getCliente e as duas caixas de observacao) sao ligados por
1268:     * ControlSource DIRETO aos cursores TmpCabec/TmpItens, exatamente como no
1269:     * Init do legado - o proprio VFP faz as duas direcoes do transporte, e
1270:     * nao ha campo digitavel cujo valor precise ser empurrado para o BO.
1271:     *
1272:     * O que ainda precisa de transporte explicito e o ESTADO DE LINHA do BO:
1273:     * SigPrGl2BO.CarregarDoCursor mapeia a linha corrente de TmpCabec para as
1274:     * properties this_cEmps/this_cDopes/this_nNumes/... e e delas que
1275:     * ObterChavePrimaria() monta a chave EmpDopNum usada na auditoria. Sem
1276:     * esta chamada essas properties ficariam nos valores iniciais e a chave
1277:     * sairia em branco.
1278:     *
1279:     * Preserva a area de trabalho corrente: CarregarDoCursor faz SELECT no
1280:     * cursor de cabecalho, e os chamadores (CarregarDados e o
1281:     * AfterRowColChange da grade de operacoes) dependem de terminar com
1282:     * TmpItens/TmpCabec selecionado como o legado deixava.
1283:     *--------------------------------------------------------------------------
1284:     PROCEDURE SincronizarBOComLinhaCorrente()
1285:         LOCAL loc_lSucesso, loc_cAliasAnterior, loc_cCursor, loc_oErro
1286:         loc_lSucesso      = .F.
1287:         loc_cAliasAnterior = ALIAS()
1288: 
1289:         TRY
1290:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1291:                 loc_cCursor = THIS.this_oBusinessObject.this_cCursorCabecalho
1292:                 IF !EMPTY(loc_cCursor) AND USED(loc_cCursor) AND ;
1293:                         !EOF(loc_cCursor) AND !BOF(loc_cCursor)
1294:                     loc_lSucesso = THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)

*-- Linhas 1302 a 1320:
1302:         ENDTRY
1303: 
1304:         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1305:             SELECT (loc_cAliasAnterior)
1306:         ENDIF
1307: 
1308:         RETURN loc_lSucesso
1309:     ENDPROC
1310: 
1311:     *--------------------------------------------------------------------------
1312:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1313:     * (SIGPRGL2 nao possui containers flutuantes - sem filtros por nome)
1314:     *--------------------------------------------------------------------------
1315:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1316:         LOCAL loc_nI, loc_oControl
1317: 
1318:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1319:             loc_oControl = par_oContainer.Controls(loc_nI)
1320:             IF VARTYPE(loc_oControl) = "O"


### BO (C:\4c\projeto\app\classes\SigPrGl2BO.prg):
*==============================================================================
* SIGPRGL2BO.PRG
* Business Object do formulario Operacoes Selecionadas (SigPrGl2)
* Origem legado: SigPrGl2.SCX (form generico, aberto via DO FORM pelo
* formulario pai que lista as operacoes, com cursores TmpCabec/TmpItens
* ja populados na DataSession do chamador)
*==============================================================================

DEFINE CLASS SigPrGl2BO AS BusinessBase

    *-- Contexto recebido do formulario pai (equivalente as properties
    *-- customizadas ParentForm/Datasessionid/Reserva/Emphpdr/Automatico/
    *-- Numerodaop/Pordestino do SIGPRGL2.SCX legado)
    this_oParentForm      = .NULL.  && Referencia ao form pai (lista de operacoes)
    this_nDataSessionId   = 0       && DataSessionId do form pai (cursores TmpCabec/TmpItens vivem la)
    this_lReservaAuto     = .F.     && .T. quando a reserva de estoque e automatica
    this_nEmpHpdr         = 0       && Codigo do grupo/empresa padrao de geracao (Emphpdr)
    this_lAutomatico      = .F.     && .T. quando o processamento e automatico (sem interacao)
    this_cNumeroDaOp      = ""      && Numero da operacao de origem (Numerodaop)
    this_cPorDestino      = ""      && Destino da operacao (PorDestino)

    *-- Estado da grade de operacoes selecionaveis
    this_cOrdConta        = ""      && Ordem corrente da grade (EMPDOPNUM ou ENTREGA)

    *-- Resultado de ValidarSelecaoParaProcessamento(): quantidade de operacoes
    *-- marcadas (Flag) no cursor de cabecalho. Fonte UNICA da contagem - o form
    *-- le esta property para saber em QUAL ramo do Processar.Click legado a
    *-- validacao caiu (selecao vazia x Jobs diferentes), porque so o ramo da
    *-- selecao vazia devolvia o foco a Column1 da grade.
    this_nOperacoesMarcadas = 0

    *-- Nomes dos cursores de trabalho (populados pelo form pai antes de abrir este dialogo)
    this_cCursorCabecalho = "TmpCabec"  && Cabecalho das operacoes disponiveis para selecao
    this_cCursorItens     = "TmpItens"  && Itens da operacao corrente (filtrados por EmpDopNum)
    this_cCursorOperacoes = "TmpOper"   && Cursor auxiliar de operacoes (ChkObs/Reservas)

    *-- Campos do cabecalho da operacao corrente (mapeados de TmpCabec via CarregarDoCursor)
    this_lFlag     = .F.  && Operacao marcada para processamento
    this_cEmps     = ""   && Empresa da operacao
    this_cDopes    = ""   && Tipo de documento/operacao (Dopes)
    this_nNumes    = 0    && Numero da operacao
    this_dDatas    = {}   && Data de emissao
    this_dEntregas = {}   && Data de entrega
    this_nPeso     = 0    && Peso total da operacao
    this_cContav   = ""   && Codigo da conta (coluna Contav da grade)
    this_cConta    = ""   && Codigo da conta
    this_cDConta   = ""   && Descricao da conta (cliente/fornecedor)
    this_cObs      = ""   && Observacao do cabecalho
    this_cNotas    = ""   && Numero da nota
    this_cGrupoOs  = ""   && Grupo de origem
    this_cContaOs  = ""   && Conta de origem
    this_cGrupoDs  = ""   && Grupo de destino
    this_cContaDs  = ""   && Conta de destino
    this_cJobs     = ""   && Job da operacao

    *-- Resultado de ExecutarProcessamento(), consumido pelo form para decidir
    *-- qual tela filha abrir (SigPrGlx com fabricacao / SigPrGlp sem fabricacao)
    this_cCursorFinal      = "TmpFinal"   && Itens prontos para gerar OP
    this_cCursorFinalG     = "TmpFinalg"  && Itens agrupados (fabricacao)
    this_lPossuiFabricacao = .F.                    && .T. quando crSigCdPac.DopEsts exige geracao de OP de fabricacao

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * Este BO nao opera sobre uma unica tabela SQL Server: trabalha sobre
    * cursores temporarios ja preparados pelo formulario pai (TmpCabec/
    * TmpItens), por isso this_cTabela/this_cCampoChave ficam vazios.
    *
    * crSigCdPam/crSigCdPac sao cursores globais do Fortyus que o sistema
    * legado pre-carregava no login (GrupoEsts/ContaEsts/TransfRes e
    * DopEsts/GerPcps/nMeses, usados em ExecutarProcessamento). O sistema
    * novo nao faz esse pre-load, entao o BO os popula aqui - mesmo padrao
    * do ClienteBO (Erro118).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_nResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            IF USED("crSigCdPam")
                USE IN crSigCdPam
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_nResultado = SQLEXEC(gnConnHandle, "SELECT TOP 1 GrupoEsts, ContaEsts, TransfRes FROM SigCdPam", "cursor_4c_Pam_Temp")
                IF loc_nResultado > 0 AND USED("cursor_4c_Pam_Temp")
                    SELECT * FROM cursor_4c_Pam_Temp INTO CURSOR crSigCdPam READWRITE
                    USE IN cursor_4c_Pam_Temp
                ENDIF
            ENDIF
            IF !USED("crSigCdPam")
                CREATE CURSOR crSigCdPam (GrupoEsts C(10), ContaEsts C(10), TransfRes C(20))
                APPEND BLANK
            ENDIF

            IF USED("crSigCdPac")
                USE IN crSigCdPac
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_nResultado = SQLEXEC(gnConnHandle, "SELECT TOP 1 DopEsts, GerPcps, nMeses FROM SigCdPac", "cursor_4c_Pac_Temp")
                IF loc_nResultado > 0 AND USED("cursor_4c_Pac_Temp")
                    SELECT * FROM cursor_4c_Pac_Temp INTO CURSOR crSigCdPac READWRITE
                    USE IN cursor_4c_Pac_Temp
                ENDIF
            ENDIF
            IF !USED("crSigCdPac")
                CREATE CURSOR crSigCdPac (DopEsts C(20), GerPcps N(1,0), nMeses N(2,0))
                APPEND BLANK
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Nota de arquitetura (Fase 2/8): este BO nao grava um registro de
    * entidade unica (nao ha Inserir/Atualizar/ExecutarExclusao classicos) -
    * SigPrGl2 e um dialogo de selecao/processamento que opera sobre
    * cursores TmpCabec/TmpItens/TmpOper ja preparados pelo formulario pai
    * (equivalente ao AddCursor sem query do legado). CarregarDoCursor()
    * mapeia a linha corrente de TmpCabec para as properties this_ do
    * cabecalho; a gravacao real do legado (INSERT em SigTempD) fica em
    * ExecutarProcessamento(), que reproduz o Click do botao Processar e
    * monta os cursores TmpFinal/TmpFinalG que as telas SigPrGlx/SigPrGlp
    * usam para gerar as OPs. O comportamento herdado de BusinessBase para
    * Inserir()/Atualizar()/ExecutarExclusao() ja e o correto aqui.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia a linha corrente do cursor de cabecalho
    * (TmpCabec) para as properties this_ desta classe
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_lFlag     = Flag
            THIS.this_cEmps     = TratarNulo(Emps, "")
            THIS.this_cDopes    = TratarNulo(Dopes, "")
            THIS.this_nNumes    = TratarNulo(Numes, 0)
            THIS.this_dDatas    = TratarNulo(Datas, {})
            THIS.this_dEntregas = TratarNulo(Entregas, {})
            THIS.this_nPeso     = TratarNulo(Peso, 0)
            THIS.this_cContav   = TratarNulo(Contav, "")
            THIS.this_cConta    = TratarNulo(Conta, "")
            THIS.this_cDConta   = TratarNulo(DConta, "")
            THIS.this_cObs      = TratarNulo(Obs, "")
            THIS.this_cNotas    = TratarNulo(Notas, "")
            THIS.this_cGrupoOs  = TratarNulo(GrupoOs, "")
            THIS.this_cContaOs  = TratarNulo(ContaOs, "")
            THIS.this_cGrupoDs  = TratarNulo(GrupoDs, "")
            THIS.this_cContaDs  = TratarNulo(ContaDs, "")
            THIS.this_cJobs     = TratarNulo(Jobs, "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave EmpDopNum (Emps+Dopes+STR(Numes,6)) da
    * operacao corrente, montagem posicional identica a SigMvCab.EmpDopNums
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodasOperacoes - Equivalente aos botoes SelTudo/apaga do legado
    * (Replace All Flag With <valor> In TmpCabec)
    *--------------------------------------------------------------------------
    FUNCTION MarcarTodasOperacoes(par_lMarcar)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(THIS.this_cCursorCabecalho)
            SELECT (THIS.this_cCursorCabecalho)
            REPLACE ALL Flag WITH par_lMarcar
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * DefinirOrdemConta - Equivalente ao mOrdemConta do legado (so a parte de
    * cursor - a cor dos headers da grade fica no form). Aceita apenas as
    * ordens EMPDOPNUM/ENTREGA; qualquer outro valor cai no default EmpDopNum
    *--------------------------------------------------------------------------
    FUNCTION DefinirOrdemConta(par_cOrdem)
        LOCAL loc_lSucesso, loc_cOrdem
        loc_lSucesso = .F.
        loc_cOrdem   = UPPER(TratarNulo(par_cOrdem, ""))

        IF USED(THIS.this_cCursorCabecalho)
            SELECT (THIS.this_cCursorCabecalho)
            IF !EMPTY(loc_cOrdem) AND INLIST(loc_cOrdem, "ENTREGA", "EMPDOPNUM")
                SET ORDER TO (loc_cOrdem)
                THIS.this_cOrdConta = loc_cOrdem
            ELSE
                SET ORDER TO EmpDopNum
                THIS.this_cOrdConta = UPPER(ORDER(THIS.this_cCursorCabecalho))
            ENDIF
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarSelecaoParaProcessamento - Guarda inicial do Click do botao
    * Processar: exige ao menos 1 operacao marcada (Flag) e que todas as
    * marcadas pertencam ao MESMO Job (regra de negocio do legado)
    *--------------------------------------------------------------------------
    FUNCTION ValidarSelecaoParaProcessamento()
        LOCAL loc_lSucesso, loc_nContador, loc_cJob

        loc_lSucesso  = .T.
        loc_nContador = 0
        THIS.this_cMensagemErro      = ""
        THIS.this_nOperacoesMarcadas = 0

        IF !USED(THIS.this_cCursorCabecalho)
            THIS.this_cMensagemErro = "Cursor de opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorCabecalho)
        SET ORDER TO EmpDopNum
        GO TOP
        loc_cJob = Jobs
        SCAN FOR Flag
            loc_nContador = loc_nContador + 1
            IF loc_cJob != Jobs
                THIS.this_cMensagemErro = "N" + CHR(227) + "o " + CHR(233) + " permitido gerar OPs de opera" + CHR(231) + CHR(245) + "es com Jobs diferentes."
                loc_lSucesso = .F.
                EXIT
            ENDIF
        ENDSCAN

        THIS.this_nOperacoesMarcadas = loc_nContador

        IF loc_lSucesso AND loc_nContador = 0
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + "o Foi Selecionada!!!"
            loc_lSucesso = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarProcessamento - Replica o Click do botao "Processar" do legado
    * (SIGPRGL2.SCX): calcula o saldo em estoque disponivel para as
    * operacoes marcadas (Flag = .T.) em this_cCursorCabecalho/
    * this_cCursorItens, descontando o que ja esta reservado/fabricado, e
    * monta this_cCursorFinal (TmpFinal) - e, quando o parametro
    * de fabricacao esta configurado (crSigCdPac.DopEsts), tambem
    * this_cCursorFinalG (TmpFinalg) agrupado por produto -
    * prontos para as telas SigPrGlx (fabricacao) / SigPrGlp (sem
    * fabricacao) gerarem as OPs.
    *
    * Equivalencia com o legado: ThisForm.PodataMgr.SqlExecute(...) vira
    * SQLEXEC(gnConnHandle, ...); ThisForm.PodataMgr2.UpDate('CrSigTempd')
    * vira INSERT direto em SigTempD (linha a linha, na mesma transacao
    * manual que o commit/rollback do legado fazia); ThisForm.
    * poDataMgr.CursorQuery(...) vira SELECT ... INTO CURSOR equivalente;
    * _Empr vira go_4c_Sistema.cCodEmpresa (regra #Global Variables).
    *
    * A consulta de vendas (Selecao->Vendas, usada so quando
    * crSigCdPac.nMeses > 0) tinha no legado a coluna "opers" AMBIGUA -
    * vinda tanto de SigMvItn (char) quanto de SigCdOpe (numeric) sem
    * alias, o que so funcionava por coincidencia de resolucao do cliente
    * VFP. Aqui as duas vem explicitamente aliasadas (OpersOpe/OpersItn)
    * para no dar erro de tipo (numeric x char) na mesma expressao.
    *--------------------------------------------------------------------------
    FUNCTION ExecutarProcessamento()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_lManual, loc_oErro
        LOCAL loc_cCidQuerys, loc_cSQL, loc_nResultado
        LOCAL loc_cEdI, loc_cEdF, loc_cEdn, loc_nItn
        LOCAL loc_nProduzir, loc_nEstoque, loc_nXBaixa, loc_nSaldoBaixa
        LOCAL loc_dLimite, loc_lFlagCab

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        loc_lManual     = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
        THIS.this_cMensagemErro     = ""
        THIS.this_lPossuiFabricacao = .F.

        *-- 1) Preparando estoque disponivel: grava em SigTempD (staging) uma
        *-- linha por Grupo/Conta de estoque a considerar (TpCads <> 1) - ou,
        *-- na ausencia de qualquer um, a linha padrao de crSigCdPam
        TRY
            loc_cCidQuerys = fUniqueIds()

            loc_cSQL = "SELECT * FROM SigCdCeg WHERE TpCads <> 1"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCeg")
            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TmpCeg)"
                loc_lProsseguir = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lProsseguir = .F.
        ENDTRY

        IF loc_lProsseguir
            TRY
                IF RECCOUNT("cursor_4c_TmpCeg") > 0
                    SELECT cursor_4c_TmpCeg
                    SCAN
                        loc_cSQL = "INSERT INTO SigTempD (Grupos, Contas, CodObs, Emps, CidChaves, CidQuerys) VALUES (" + ;
                            EscaparSQL(cursor_4c_TmpCeg.Grupos) + ", " + ;
                            EscaparSQL(cursor_4c_TmpCeg.Contas) + ", " + ;
                            FormatarNumeroSQL(cursor_4c_TmpCeg.Priors, 0) + ", " + ;
                            EscaparSQL(cursor_4c_TmpCeg.Emps) + ", " + ;
                            EscaparSQL(fUniqueIds()) + ", " + ;
                            EscaparSQL(loc_cCidQuerys) + ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor reinicializar o processo. (SigTempD)"
                            loc_lProsseguir = .F.
                            EXIT
                        ENDIF
                    ENDSCAN
                ELSE
                    loc_cSQL = "INSERT INTO SigTempD (Grupos, Contas, CodObs, Emps, CidChaves, CidQuerys) VALUES (" + ;
                        EscaparSQL(crSigCdPam.GrupoEsts) + ", " + ;
                        EscaparSQL(crSigCdPam.ContaEsts) + ", " + ;
                        FormatarNumeroSQL(1, 0) + ", " + ;
                        EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                        EscaparSQL(fUniqueIds()) + ", " + ;
                        EscaparSQL(loc_cCidQuerys) + ")"
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        THIS.this_cMensagemErro = "Favor reinicializar o processo. (SigTempD)"
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lProsseguir = .F.
            ENDTRY
        ENDIF

        IF loc_lProsseguir
            IF loc_lManual
                = SQLCOMMIT(gnConnHandle)
            ENDIF
        ELSE
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
        ENDIF

        *-- 2) Estoque disponivel por Grupo/Estoque/Produto (equivalente ao
        *-- Union do legado, cruzando SigMvEst com o SigTempD recem-gravado)
        IF loc_lProsseguir
            TRY
                loc_cSQL = "SELECT a.*, b.CodObs AS Priors FROM SigMvEst a, SigTempD b " + ;
                    "WHERE a.Grupos = b.Grupos AND a.Estos = b.Contas AND a.Emps = b.Emps AND a.Sqtds > 0 " + ;
                    "UNION " + ;
                    "SELECT a.*, b.CodObs AS Priors FROM SigMvEst a, SigTempD b " + ;
                    "WHERE a.Grupos = b.Grupos AND b.Contas = '' AND a.Emps = b.Emps AND a.Sqtds > 0"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEstoque")
                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TmpEstoque)"
                    loc_lProsseguir = .F.
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lProsseguir = .F.
            ENDTRY
        ENDIF

        *-- Limpa o staging gravado no passo 1 (equivalente a fSqlApagarTmp)
        IF loc_lProsseguir
            TRY
                SQLEXEC(gnConnHandle, "DELETE FROM SigTempD WHERE CidQuerys = " + EscaparSQL(loc_cCidQuerys))
                IF loc_lManual
                    = SQLCOMMIT(gnConnHandle)
                ENDIF
            CATCH TO loc_oErro
                IF loc_lManual
                    = SQLROLLBACK(gnConnHandle)
                ENDIF
            ENDTRY
        ENDIF

        *-- 3) Monta TmpSaldo (saldo por produto/cor/tamanho) e TmpSaldg
        *-- (saldo por grupo/estoque/produto/cor/tamanho), varrendo TmpEstoque
        IF loc_lProsseguir
            IF USED("cursor_4c_TmpSaldo")
                USE IN cursor_4c_TmpSaldo
            ENDIF
            IF USED("cursor_4c_TmpSaldg")
                USE IN cursor_4c_TmpSaldg
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_TmpSaldo (CPros C(14), CodCors C(4), CodTams C(4), Saldo N(12,3), Disps N(12,3), Fabrs N(12,3), DispFs N(12,3))
            SET NULL OFF
            INDEX ON CPros + CodCors + CodTams TAG CPros

            SET NULL ON
            CREATE CURSOR cursor_4c_TmpSaldg (Emps C(3), Grupos C(10), Estos C(10), CPros C(14), CodCors C(4), CodTams C(4), Saldo N(12,3), Disps N(12,3), Priors N(2), Reservs N(12,3))
            SET NULL OFF
            INDEX ON CPros + CodCors + CodTams + STR(Priors,2) + Grupos + Estos + Emps TAG CPros
            INDEX ON Emps + Grupos + Estos + CPros + CodCors + CodTams TAG GruEstPro

            SELECT cursor_4c_TmpEstoque
            SCAN
                SELECT cursor_4c_TmpSaldo
                IF !SEEK(cursor_4c_TmpEstoque.Cpros + cursor_4c_TmpEstoque.CodCors + cursor_4c_TmpEstoque.CodTams)
                    INSERT INTO cursor_4c_TmpSaldo (CPros, CodCors, CodTams, Saldo, Disps) ;
                        VALUES (cursor_4c_TmpEstoque.CPros, cursor_4c_TmpEstoque.CodCors, cursor_4c_TmpEstoque.CodTams, 0, 0)
                ENDIF
                REPLACE Saldo WITH Saldo + cursor_4c_TmpEstoque.Sqtds, ;
                    Disps WITH Disps + cursor_4c_TmpEstoque.Sqtds IN cursor_4c_TmpSaldo

                INSERT INTO cursor_4c_TmpSaldg (Grupos, Estos, CPros, CodCors, CodTams, Saldo, Disps, Priors, Emps) ;
                    VALUES (cursor_4c_TmpEstoque.Grupos, cursor_4c_TmpEstoque.Estos, cursor_4c_TmpEstoque.CPros, cursor_4c_TmpEstoque.CodCors, ;
                        cursor_4c_TmpEstoque.CodTams, cursor_4c_TmpEstoque.SQtds, cursor_4c_TmpEstoque.SQtds, cursor_4c_TmpEstoque.Priors, cursor_4c_TmpEstoque.Emps)

                *-- INSERT INTO troca a area corrente - restaurar antes do ENDSCAN
                SELECT cursor_4c_TmpEstoque
            ENDSCAN
        ENDIF

        *-- 4) Reserva por transferencia em aberto (SigCdPam.TransfRes): abate
        *-- do saldo o que ja esta alocado em operacoes de transferencia em
        *-- aberto cuja operacao NAO controla estoque (SigCdOpe.Estoqs <> 1)
        IF loc_lProsseguir
            TRY
                loc_cSQL = "SELECT * FROM SigCdOpe WHERE Dopes = " + EscaparSQL(crSigCdPam.TransfRes)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpe")
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lProsseguir = .F.
            ENDTRY
        ENDIF

        IF loc_lProsseguir AND !EMPTY(crSigCdPam.TransfRes) AND USED("cursor_4c_SigCdOpe") AND !EOF("cursor_4c_SigCdOpe") AND cursor_4c_SigCdOpe.Estoqs <> 1
            loc_cEdI = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(crSigCdPam.TransfRes, 20) + STR(0, 6)
            loc_cEdF = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(crSigCdPam.TransfRes, 20) + STR(999999, 6)

            TRY
                loc_cSQL = "SELECT EmpDopNums, GrupoOs, ContaOs, Emps, Dopes, Numes FROM SigMvCab " + ;
                    "WHERE EmpDopNums BETWEEN " + EscaparSQL(loc_cEdI) + " AND " + EscaparSQL(loc_cEdF) + " " + ;
                    "ORDER BY EmpDopNums"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempEest")
                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TempEest)"
                    loc_lProsseguir = .F.
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lProsseguir = .F.
            ENDTRY

            IF loc_lProsseguir
                SELECT cursor_4c_TempEest
                SCAN
                    loc_cEdn = cursor_4c_TempEest.EmpDopNums

                    IF USED("cursor_4c_TempEestI")
                        USE IN cursor_4c_TempEestI
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT * FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(loc_cEdn), "cursor_4c_TempEestI")

                    IF USED("cursor_4c_TempEestI")
                        SELECT cursor_4c_TempEestI
                        SCAN FOR (Qtds - QtBaixas) > 0
                            loc_nItn = cursor_4c_TempEestI.CItens

                            IF USED("cursor_4c_TempEsti2")
                                USE IN cursor_4c_TempEsti2
                            ENDIF
                            loc_cSQL = "SELECT * FROM SigMvIts WHERE EmpDopNums = " + EscaparSQL(loc_cEdn) + " AND CItens = " + FormatarNumeroSQL(loc_nItn, 0)
                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempEsti2")

                            IF !USED("cursor_4c_TempEsti2") OR EOF("cursor_4c_TempEsti2")
                                SELECT cursor_4c_TmpSaldo
                                IF !SEEK(cursor_4c_TempEestI.Cpros)
                                    INSERT INTO cursor_4c_TmpSaldo (Cpros) VALUES (cursor_4c_TempEestI.CPros)
                                ENDIF
                                REPLACE Saldo WITH Saldo - (cursor_4c_TempEestI.Qtds - cursor_4c_TempEestI.QtBaixas), ;
                                    Disps WITH Disps - (cursor_4c_TempEestI.Qtds - cursor_4c_TempEestI.QtBaixas)

                                SELECT cursor_4c_TmpSaldg
                                SET ORDER TO GruEstPro
                                IF !SEEK(cursor_4c_TempEest.Emps + cursor_4c_TempEest.GrupoOs + cursor_4c_TempEest.ContaOs + cursor_4c_TempEestI.Cpros)
                                    INSERT INTO cursor_4c_TmpSaldg (Emps, Grupos, Estos, Cpros, Priors) ;
                                        VALUES (cursor_4c_TempEest.Emps, cursor_4c_TempEest.GrupoOs, cursor_4c_TempEest.ContaOs, cursor_4c_TempEestI.CPros, 99)
                                ENDIF
                                REPLACE Saldo WITH Saldo - (cursor_4c_TempEestI.Qtds - cursor_4c_TempEestI.QtBaixas), ;
                                    Disps WITH Disps - (cursor_4c_TempEestI.Qtds - cursor_4c_TempEestI.QtBaixas)
                            ELSE
                                SELECT cursor_4c_TempEsti2
                                SCAN
                                    loc_nSaldoBaixa = cursor_4c_TempEsti2.Qtds - cursor_4c_TempEsti2.QtBaixas

                                    SELECT cursor_4c_TmpSaldo
                                    IF !SEEK(cursor_4c_TempEsti2.Cpros + cursor_4c_TempEsti2.CodCors + cursor_4c_TempEsti2.CodTams)
                                        INSERT INTO cursor_4c_TmpSaldo (Cpros, CodCors, CodTams) ;
                                            VALUES (cursor_4c_TempEsti2.CPros, cursor_4c_TempEsti2.CodCors, cursor_4c_TempEsti2.CodTams)
                                    ENDIF
                                    REPLACE Saldo WITH Saldo - loc_nSaldoBaixa, Disps WITH Disps - loc_nSaldoBaixa

                                    SELECT cursor_4c_TmpSaldg
                                    SET ORDER TO GruEstPro
                                    IF !SEEK(cursor_4c_TempEest.Emps + cursor_4c_TempEest.GrupoOs + cursor_4c_TempEest.ContaOs + cursor_4c_TempEsti2.Cpros + cursor_4c_TempEsti2.CodCors + cursor_4c_TempEsti2.CodTams)
                                        INSERT INTO cursor_4c_TmpSaldg (Emps, Grupos, Estos, Cpros, CodCors, CodTams, Priors) ;
                                            VALUES (cursor_4c_TempEest.Emps, cursor_4c_TempEest.GrupoOs, cursor_4c_TempEest.ContaOs, ;
                                            cursor_4c_TempEsti2.CPros, cursor_4c_TempEsti2.CodCors, cursor_4c_TempEsti2.CodTams, 99)
                                    ENDIF
                                    REPLACE Saldo WITH Saldo - loc_nSaldoBaixa, Disps WITH Disps - loc_nSaldoBaixa

                                    *-- INSERT INTO troca a area corrente - restaurar antes do ENDSCAN
                                    SELECT cursor_4c_TempEsti2
                                ENDSCAN
                            ENDIF

                            *-- SQLEXEC/INSERT INTO trocam a area corrente - restaurar antes do ENDSCAN
                            SELECT cursor_4c_TempEestI
                        ENDSCAN
                    ENDIF

                    *-- SQLEXEC troca a area corrente - restaurar antes do ENDSCAN
                    SELECT cursor_4c_TempEest
                ENDSCAN
            ENDIF
        ENDIF

        *-- 5) Monta TmpFinal com os itens das operacoes marcadas, descontando
        *-- o estoque disponivel calculado acima
        IF loc_lProsseguir
            IF USED("TmpFinal")
                USE IN TmpFinal
            ENDIF
            CREATE CURSOR TmpFinal (Emps C(3), Dopes C(20), Numes N(6), CPros C(14), Qtds N(10,3), Peso N(9,3), ;
                Saldo N(10,3), Estoque N(10,3), Produzir N(10,3), Obs M NULL, Obsps M NULL, ;
                Datas D NULL, Entregas D NULL, CodCors C(4), CodTams C(4), Linhas C(10), ;
                Citens N(10), Reffs C(40), Notas C(6), Dpros C(40), GrupoDs C(10), ContaDs C(10), ;
                KeySelM L, Fabrs N(10,3), KeyPdes L, Jobs C(10))
            INDEX ON Cpros + CodCors + CodTams TAG Cpros

            SELECT (THIS.this_cCursorCabecalho)
            SET ORDER TO EmpDopNum

            SELECT (THIS.this_cCursorItens)
            SET KEY TO
            SET ORDER TO CPros
            SCAN
                SELECT (THIS.this_cCursorCabecalho)
                SEEK EVALUATE(THIS.this_cCursorItens + ".Emps") + EVALUATE(THIS.this_cCursorItens + ".Dopes") + STR(EVALUATE(THIS.this_cCursorItens + ".Numes"), 6)
                loc_lFlagCab = Flag

                *-- SCAN/LOOP dependem da area CORRENTE, nao da area em que o
                *-- SCAN foi aberto - restaurar this_cCursorItens ANTES do LOOP
                SELECT (THIS.this_cCursorItens)
                IF !loc_lFlagCab
                    LOOP
                ENDIF

                SELECT (THIS.this_cCursorOperacoes)
                SEEK EVALUATE(THIS.this_cCursorItens + ".Dopes")

                SELECT (THIS.this_cCursorItens)
                IF (Saldo > 0)
                    STORE 0 TO loc_nEstoque, loc_nProduzir

                    IF (EVALUATE(THIS.this_cCursorOperacoes + ".ChkObs") <> 1 AND !EMPTY(Obs)) OR ;
                            !SEEK(CPros + CodCors + CodTams, "cursor_4c_TmpSaldo") OR ;
                            EMPTY(crSigCdPam.TransfRes) OR (EVALUATE(THIS.this_cCursorOperacoes + ".Reservas") = 2 AND !THIS.this_lReservaAuto) OR ;
                            cursor_4c_TmpSaldo.Disps < 0
                        loc_nProduzir = Saldo
                    ELSE
                        = SEEK(CPros + CodCors + CodTams, "cursor_4c_TmpSaldo")
                        loc_nEstoque = cursor_4c_TmpSaldo.Disps
                        IF (cursor_4c_TmpSaldo.Disps >= Saldo)
                            REPLACE cursor_4c_TmpSaldo.Disps WITH cursor_4c_TmpSaldo.Disps - Saldo
                        ELSE
                            loc_nProduzir = Saldo - cursor_4c_TmpSaldo.Disps
                            REPLACE cursor_4c_TmpSaldo.Disps WITH 0
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_SigCdPro")
                        USE IN cursor_4c_SigCdPro
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPro WHERE Cpros = " + EscaparSQL(CPros), "cursor_4c_SigCdPro")

                    *-- SQLEXEC troca a area corrente - restaurar antes de ler os
                    *-- campos "soltos" (Emps/Dopes/Numes/...) abaixo, que se
                    *-- referem ao registro corrente de this_cCursorItens
                    SELECT (THIS.this_cCursorItens)

                    INSERT INTO TmpFinal (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, Estoque, Produzir, Obsps, ;
                            Obs, Datas, Entregas, CodCors, CodTams, Linhas, Citens, Reffs, Notas, ;
                            Dpros, GrupoDs, ContaDs, Jobs) ;
                        VALUES (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, Saldo - loc_nProduzir, ;
                            loc_nProduzir, TratarNulo(Obs, ""), TratarNulo(EVALUATE(THIS.this_cCursorCabecalho + ".Obs"), ""), ;
                            TratarNulo(EVALUATE(THIS.this_cCursorCabecalho + ".Datas"), {}), ;
                            TratarNulo(EVALUATE(THIS.this_cCursorCabecalho + ".Entregas"), {}), CodCors, CodTams, ;
                            Linhas, CItens, IIF(USED("cursor_4c_SigCdPro"), TratarNulo(cursor_4c_SigCdPro.Reffs, ""), ""), Notas, ;
                            Dpros, EVALUATE(THIS.this_cCursorCabecalho + ".Grupods"), EVALUATE(THIS.this_cCursorCabecalho + ".Contads"), ;
                            EVALUATE(THIS.this_cCursorCabecalho + ".Jobs"))

                    *-- INSERT INTO troca a area corrente - restaurar antes do ENDSCAN
                    SELECT (THIS.this_cCursorItens)
                ENDIF
            ENDSCAN
        ENDIF

        *-- 6) Distribui a baixa apurada em TmpSaldo pelos grupos/estoques de
        *-- TmpSaldg (mesmo produto/cor/tamanho), na ordem de prioridade
        IF loc_lProsseguir
            SELECT cursor_4c_TmpSaldo
            SCAN
                IF Saldo # Disps
                    loc_nXBaixa = Saldo - Disps
                    SELECT cursor_4c_TmpSaldg
                    SET ORDER TO Cpros
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    SCAN WHILE Cpros = cursor_4c_TmpSaldo.Cpros AND CodCors = cursor_4c_TmpSaldo.CodCors AND CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
                        IF cursor_4c_TmpSaldg.Disps >= loc_nXBaixa
                            REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldg.Disps - loc_nXBaixa
                            loc_nXBaixa = 0
                        ELSE
                            loc_nXBaixa = loc_nXBaixa - cursor_4c_TmpSaldg.Disps
                            REPLACE cursor_4c_TmpSaldg.Disps WITH 0
                        ENDIF
                    ENDSCAN

                    *-- o SCAN interno deixou cursor_4c_TmpSaldg selecionado -
                    *-- restaurar antes do ENDSCAN externo
                    SELECT cursor_4c_TmpSaldo
                ENDIF
            ENDSCAN
        ENDIF

        *-- 7) Quando o parametro de fabricacao esta configurado
        *-- (crSigCdPac.DopEsts), apura tambem o saldo ja alocado em OPs de
        *-- fabricacao em aberto e monta TmpFinalG (agrupado por produto/
        *-- cor/tamanho) para a tela de fabricacao
        IF loc_lProsseguir AND !EMPTY(crSigCdPac.DopEsts)
            THIS.this_lPossuiFabricacao = .T.

            IF USED("cursor_4c_TmpFabr")
                USE IN cursor_4c_TmpFabr
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_TmpFabr (Priors N(2), Nops N(10), Fases C(10), Cpros C(14), CodCors C(4), CodTams C(4), Qtds N(10,3), Disps N(12,3), Reservs N(12,3))
            SET NULL OFF
            INDEX ON Cpros + CodCors + CodTams + STR(Priors,2) + STR(Nops,10) TAG Cpros

            TRY
                loc_cSQL = "SELECT a.Nops, a.Cpros, a.CodCors, a.CodTams, SUM(a.Qtds) AS Qtds FROM SigOpPic a, SigCdNec b " + ;
                    "WHERE a.Dopes = " + EscaparSQL(crSigCdPac.DopEsts) + " AND a.EmpDopNops = b.EmpDnps AND b.Chksubn = " + FormatarNumeroSQL(0, 0) + " " + ;
                    "AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " GROUP BY a.Nops, a.Cpros, a.CodCors, a.CodTams"
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpi")
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lProsseguir = .F.
            ENDTRY

            IF loc_lProsseguir AND USED("cursor_4c_TmpOpi")
                SELECT cursor_4c_TmpOpi
                SCAN
                    SELECT cursor_4c_TmpSaldo
                    IF !SEEK(cursor_4c_TmpOpi.Cpros + cursor_4c_TmpOpi.CodCors + cursor_4c_TmpOpi.CodTams)
                        INSERT INTO cursor_4c_TmpSaldo (CPros, CodCors, CodTams) ;
                            VALUES (cursor_4c_TmpOpi.CPros, cursor_4c_TmpOpi.CodCors, cursor_4c_TmpOpi.CodTams)
                    ENDIF
                    REPLACE Fabrs WITH Fabrs + cursor_4c_TmpOpi.Qtds, DispFs WITH DispFs + cursor_4c_TmpOpi.Qtds

                    INSERT INTO cursor_4c_TmpFabr (Nops, Cpros, CodCors, CodTams, Qtds, Priors) ;
                        VALUES (cursor_4c_TmpOpi.Nops, cursor_4c_TmpOpi.Cpros, cursor_4c_TmpOpi.CodCors, cursor_4c_TmpOpi.CodTams, cursor_4c_TmpOpi.Qtds, 0)

                    IF USED("cursor_4c_TmpMfas")
                        USE IN cursor_4c_TmpMfas
                    ENDIF
                    loc_cSQL = "SELECT GrupoDs FROM SigPdMvf WHERE Nops = " + FormatarNumeroSQL(cursor_4c_TmpOpi.Nops, 0) + " ORDER BY CidChaves DESC"
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMfas")

                    IF USED("cursor_4c_TmpMfas")
                        SELECT cursor_4c_TmpMfas
                        GO TOP
                        IF !EOF("cursor_4c_TmpMfas")
                            REPLACE Fases WITH cursor_4c_TmpMfas.GrupoDs IN cursor_4c_TmpFabr
                        ENDIF
                    ENDIF

                    STORE 0 TO loc_nEstoque, loc_nProduzir

                    IF SEEK(cursor_4c_TmpOpi.Cpros + cursor_4c_TmpOpi.CodCors + cursor_4c_TmpOpi.CodTams, "TmpFinal", "Cpros")
                        IF cursor_4c_TmpSaldo.Fabrs >= TmpFinal.Produzir
                            loc_nEstoque  = TmpFinal.Produzir
                            loc_nProduzir = 0
                            REPLACE cursor_4c_TmpSaldo.Dispfs WITH cursor_4c_TmpSaldo.Dispfs - TmpFinal.Produzir IN cursor_4c_TmpSaldo
                        ELSE
                            loc_nEstoque  = cursor_4c_TmpSaldo.Fabrs
                            loc_nProduzir = TmpFinal.Produzir - cursor_4c_TmpSaldo.Fabrs
                            REPLACE Dispfs WITH 0 IN cursor_4c_TmpSaldo
                        ENDIF
                        REPLACE Produzir WITH loc_nProduzir, Fabrs WITH loc_nEstoque IN TmpFinal
                    ENDIF

                    *-- SQLEXEC/INSERT INTO trocam a area corrente - restaurar antes do ENDSCAN
                    SELECT cursor_4c_TmpOpi
                ENDSCAN

                SELECT cursor_4c_TmpSaldo
                SCAN
                    IF Fabrs # Dispfs
                        loc_nXBaixa = Fabrs - DispFs
                        SELECT cursor_4c_TmpFabr
                        SET ORDER TO Cpros
                        = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                        SCAN WHILE Cpros = cursor_4c_TmpSaldo.Cpros AND CodCors = cursor_4c_TmpSaldo.CodCors AND CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
                            IF (cursor_4c_TmpFabr.Qtds - cursor_4c_TmpFabr.Disps) >= loc_nXBaixa
                                REPLACE cursor_4c_TmpFabr.Disps WITH cursor_4c_TmpFabr.Disps + loc_nXBaixa IN cursor_4c_TmpFabr
                                loc_nXBaixa = 0
                            ELSE
                                loc_nXBaixa = loc_nXBaixa - (cursor_4c_TmpFabr.Qtds - cursor_4c_TmpFabr.Disps)
                                REPLACE cursor_4c_TmpFabr.Disps WITH Qtds IN cursor_4c_TmpFabr
                            ENDIF
                        ENDSCAN

                        *-- o SCAN interno deixou cursor_4c_TmpFabr selecionado -
                        *-- restaurar antes do ENDSCAN externo
                        SELECT cursor_4c_TmpSaldo
                    ENDIF
                ENDSCAN

                IF USED("TmpFinalg")
                    USE IN TmpFinalg
                ENDIF
                CREATE CURSOR TmpFinalg (Flag C(1), CPros C(14), CodCors C(4), CodTams C(4), Linhas C(10), Qtds N(10,3), ;
                    Saldo N(10,3), Estoque N(10,3), Produzir N(10,3), Fabrs N(10,3), Produzir2 N(10,3), ;
                    TotVenda N(10,3), QtdMins N(10,3), KeySelM L, KeySelMP L, UsuLibs C(10))
                INDEX ON Cpros + CodCors + CodTams TAG Cpros

                IF USED("cursor_4c_Selecao")
                    USE IN cursor_4c_Selecao
                ENDIF
                SELECT Cpros, CodCors, CodTams, Linhas, SUM(Qtds) AS Qtds, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, ;
                        SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs FROM TmpFinal ;
                    INTO CURSOR cursor_4c_Selecao GROUP BY Cpros, CodCors, CodTams, Linhas READWRITE

                IF crSigCdPac.nMeses > 0
                    loc_dLimite = GOMONTH(DATE(), -crSigCdPac.nmeses)

                    IF USED("cursor_4c_LocalEest")
                        USE IN cursor_4c_LocalEest
                    ENDIF
                    TRY
                        loc_cSQL = "SELECT a.cpros, a.qtds, b.Caixas, b.copers, b.opers AS OpersOpe, a.opers AS OpersItn " + ;
                            "FROM SigMvItn a, SigCdOpe b, SigMvCab c " + ;
                            "WHERE a.EmpDopNums = c.EmpDopNums AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " AND c.datas >= " + FormatarDataSQL(loc_dLimite) + " " + ;
                            "AND a.dopes = b.dopes AND b.tipoops IN (4,5)"
                        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEest")
                    CATCH TO loc_oErro
                        THIS.this_cMensagemErro = loc_oErro.Message
                    ENDTRY

                    IF USED("cursor_4c_LocalEest")
                        IF USED("cursor_4c_Vendas")
                            USE IN cursor_4c_Vendas
                        ENDIF
                        SELECT cpros, SUM(qtds * IIF((Caixas = 1 AND copers = 1) OR (caixas <> 1 AND OpersOpe = 1) OR (caixas <> 1 AND OpersOpe = 3 AND OpersItn = "E"), 1, -1)) AS Qtds ;
                            FROM cursor_4c_LocalEest GROUP BY 1 INTO CURSOR cursor_4c_Vendas READWRITE
                        SELECT cursor_4c_Vendas
                        INDEX ON cpros TAG Cpros
                    ENDIF
                ENDIF

                SELECT TmpFinalg
                SCATTER MEMVAR BLANK

                SELECT cursor_4c_Selecao
                SCAN
                    SCATTER MEMVAR
                    m.flag = "+"

                    IF USED("cursor_4c_SigCdProQtd")
                        USE IN cursor_4c_SigCdProQtd
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT QtMinFabs FROM SigCdPro WHERE Cpros = " + EscaparSQL(cursor_4c_Selecao.Cpros), "cursor_4c_SigCdProQtd")

                    m.QtdMins = 0
                    IF (crSigCdPac.GerPcps = 2 AND !THIS.this_lReservaAuto) OR (crSigCdPac.GerPcps <> 2 AND THIS.this_lReservaAuto)
                        IF USED("cursor_4c_SigCdProQtd") AND !EOF("cursor_4c_SigCdProQtd")
                            m.QtdMins = cursor_4c_SigCdProQtd.QtMinFabs
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_Vendas") AND SEEK(m.Cpros, "cursor_4c_Vendas", "Cpros")
                        m.TotVenda = cursor_4c_Vendas.Qtds
                    ELSE
                        m.TotVenda = 0
                    ENDIF

                    m.Produzir2 = IIF(m.QtdMins > 0 AND m.produzir > 0 AND m.Produzir < m.QtdMins, m.QtdMins - m.Produzir, 0)

                    SELECT TmpFinalg
                    APPEND BLANK
                    GATHER MEMVAR

                    *-- APPEND BLANK troca a area corrente - restaurar antes do ENDSCAN
                    SELECT cursor_4c_Selecao
                ENDSCAN
            ENDIF
        ENDIF

        IF loc_lProsseguir
            SELECT (THIS.this_cCursorItens)
            SET ORDER TO EmpDopNum
            SET KEY TO EVALUATE(THIS.this_cCursorCabecalho + ".Emps") + EVALUATE(THIS.this_cCursorCabecalho + ".Dopes") + STR(EVALUATE(THIS.this_cCursorCabecalho + ".Numes"), 6)
            GO TOP

            THIS.this_cCursorFinal  = "TmpFinal"
            THIS.this_cCursorFinalG = "TmpFinalg"
            loc_lSucesso = .T.
        ELSE
            IF EMPTY(THIS.this_cMensagemErro)
                THIS.this_cMensagemErro = "Favor reinicializar o processo."
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

